# PowerShell equivalent of check-parity.sh
# Usage: scripts/check-parity.ps1
# Validates structural parity between the canonical en/ and the pt-BR/ directories.
# Checks: (1) same .md file set by NN- prefix; (2) same count of ## and ### headers
# per corresponding file; (3) consistent presence of gate phrases across each pair.
# Exits 0 on parity, 1 on divergence, printing the divergences.

$ErrorActionPreference = 'Stop'

$Root = Resolve-Path (Join-Path $PSScriptRoot '..')
$EnDir = Join-Path $Root 'en'
$PtDir = Join-Path $Root 'pt-BR'

$EnGates = @('Stop and wait', 'Mandatory closing', 'MANDATORY HUMAN GATE')
$PtGates = @('Pare e aguarde', 'Encerramento obrigat', 'GATE HUMANO OBRIGATORIO')

$divergences = 0
function Log-Div($msg) {
    Write-Output "DIVERGENCE: $msg"
    $script:divergences += 1
}

if (-not (Test-Path $EnDir)) { Write-Output "ERROR: $EnDir not found"; exit 1 }
if (-not (Test-Path $PtDir)) { Write-Output "ERROR: $PtDir not found"; exit 1 }

function Get-Prefixes($dir) {
    $list = @()
    Get-ChildItem -Path $dir -Filter '*.md' -File | ForEach-Object {
        if ($_.BaseName -match '^(\d{2})-') { $list += $matches[1] }
    }
    $list | Sort-Object -Unique
}

$enPrefixes = @(Get-Prefixes $EnDir)
$ptPrefixes = @(Get-Prefixes $PtDir)

$onlyEn = @($enPrefixes | Where-Object { $_ -notin $ptPrefixes })
$onlyPt = @($ptPrefixes | Where-Object { $_ -notin $enPrefixes })
if ($onlyEn.Count -gt 0 -or $onlyPt.Count -gt 0) {
    Log-Div 'file prefix sets differ between en/ and pt-BR/'
    Write-Output "  en/    prefixes: $($enPrefixes -join ' ')"
    Write-Output "  pt-BR/ prefixes: $($ptPrefixes -join ' ')"
}

function Count-Headers($file, $pattern) {
    (Get-Content -LiteralPath $file -Encoding UTF8 | Select-String -Pattern $pattern).Count
}

function Has-Gate($file, $phrases) {
    $content = Get-Content -LiteralPath $file -Raw -Encoding UTF8
    foreach ($p in $phrases) { if ($content -like "*$p*") { return 1 } }
    return 0
}

foreach ($prefix in $enPrefixes) {
    $enFile = Get-ChildItem -Path $EnDir -Filter "$prefix-*.md" -File | Select-Object -First 1
    $ptFile = Get-ChildItem -Path $PtDir -Filter "$prefix-*.md" -File | Select-Object -First 1
    if (-not $enFile -or -not $ptFile) {
        Log-Div "prefix ${prefix}: missing file on one side"
        continue
    }

    $enH2 = Count-Headers $enFile.FullName '^## '
    $ptH2 = Count-Headers $ptFile.FullName '^## '
    $enH3 = Count-Headers $enFile.FullName '^### '
    $ptH3 = Count-Headers $ptFile.FullName '^### '

    if ($enH2 -ne $ptH2) { Log-Div "prefix ${prefix}: ## header count differs (en=$enH2 pt-BR=$ptH2)" }
    if ($enH3 -ne $ptH3) { Log-Div "prefix ${prefix}: ### header count differs (en=$enH3 pt-BR=$ptH3)" }

    $enGate = Has-Gate $enFile.FullName $EnGates
    $ptGate = Has-Gate $ptFile.FullName $PtGates
    if ($enGate -ne $ptGate) { Log-Div "prefix ${prefix}: gate phrase presence differs (en=$enGate pt-BR=$ptGate)" }
}

if ($divergences -eq 0) {
    Write-Output 'Parity OK: en/ and pt-BR/ are structurally aligned.'
    exit 0
} else {
    Write-Output "Parity check failed with $divergences divergence(s)."
    exit 1
}
