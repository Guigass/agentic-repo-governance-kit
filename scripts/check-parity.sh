#!/usr/bin/env bash
# Usage: scripts/check-parity.sh
# Validates structural parity between the canonical en/ and the pt-BR/ directories.
# Checks: (1) same .md file set by NN- prefix; (2) same count of ## and ### headers
# per corresponding file; (3) consistent presence of gate phrases across each pair.
# Exits 0 on parity, 1 on divergence, printing the divergences.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EN_DIR="$ROOT/en"
PT_DIR="$ROOT/pt-BR"

EN_GATES=("Stop and wait" "Mandatory closing" "MANDATORY HUMAN GATE")
PT_GATES=("Pare e aguarde" "Encerramento obrigat" "GATE HUMANO OBRIGATORIO")

divergences=0
log_div() { echo "DIVERGENCE: $*"; divergences=$((divergences + 1)); }

[ -d "$EN_DIR" ] || { echo "ERROR: $EN_DIR not found"; exit 1; }
[ -d "$PT_DIR" ] || { echo "ERROR: $PT_DIR not found"; exit 1; }

en_prefixes=$(find "$EN_DIR" -maxdepth 1 -type f -name '[0-9][0-9]-*.md' -exec basename {} \; | sed -E 's/^([0-9]{2})-.*/\1/' | sort -u)
pt_prefixes=$(find "$PT_DIR" -maxdepth 1 -type f -name '[0-9][0-9]-*.md' -exec basename {} \; | sed -E 's/^([0-9]{2})-.*/\1/' | sort -u)

if [ "$en_prefixes" != "$pt_prefixes" ]; then
  log_div "file prefix sets differ between en/ and pt-BR/"
  echo "  en/    prefixes: $(echo "$en_prefixes" | tr '\n' ' ')"
  echo "  pt-BR/ prefixes: $(echo "$pt_prefixes" | tr '\n' ' ')"
fi

for prefix in $en_prefixes; do
  en_file=$(find "$EN_DIR" -maxdepth 1 -type f -name "${prefix}-*.md" | head -n1)
  pt_file=$(find "$PT_DIR" -maxdepth 1 -type f -name "${prefix}-*.md" | head -n1)
  if [ -z "$en_file" ] || [ -z "$pt_file" ]; then
    log_div "prefix ${prefix}: missing file on one side (en=${en_file:-none} pt-BR=${pt_file:-none})"
    continue
  fi

  en_h2=$(grep -c '^## ' "$en_file" || true)
  pt_h2=$(grep -c '^## ' "$pt_file" || true)
  en_h3=$(grep -c '^### ' "$en_file" || true)
  pt_h3=$(grep -c '^### ' "$pt_file" || true)

  [ "$en_h2" = "$pt_h2" ] || log_div "prefix ${prefix}: ## header count differs (en=${en_h2} pt-BR=${pt_h2})"
  [ "$en_h3" = "$pt_h3" ] || log_div "prefix ${prefix}: ### header count differs (en=${en_h3} pt-BR=${pt_h3})"

  en_has_gate=0
  for phrase in "${EN_GATES[@]}"; do
    if grep -qF "$phrase" "$en_file"; then en_has_gate=1; break; fi
  done
  pt_has_gate=0
  for phrase in "${PT_GATES[@]}"; do
    if grep -qF "$phrase" "$pt_file"; then pt_has_gate=1; break; fi
  done
  [ "$en_has_gate" = "$pt_has_gate" ] || log_div "prefix ${prefix}: gate phrase presence differs (en=${en_has_gate} pt-BR=${pt_has_gate})"
done

if [ "$divergences" -eq 0 ]; then
  echo "Parity OK: en/ and pt-BR/ are structurally aligned."
  exit 0
else
  echo "Parity check failed with ${divergences} divergence(s)."
  exit 1
fi
