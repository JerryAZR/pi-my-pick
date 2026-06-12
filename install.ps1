#Requires -Version 5.1
<#
.SYNOPSIS
    Installs Jerry's commonly-used pi extensions.
.DESCRIPTION
    One-shot installer for personal pi extensions. Safe to re-run;
    pi will skip already-installed packages.
#>

$ErrorActionPreference = "Stop"

$extensions = @(
    "npm:@jerryan/pi-pyvenv"
    "npm:@thinkscape/pi-status"
    "npm:@jerryan/pi-hashline-edit"
    "npm:@jerryan/pi-subagent-lite"
    "npm:@jerryan/pi-sanity"
)

# Verify pi is on PATH
$pi = Get-Command "pi" -ErrorAction SilentlyContinue
if (-not $pi) {
    Write-Error "pi CLI not found on PATH. Install it first: https://pi.dev"
    exit 1
}

Write-Host "Installing pi extensions..." -ForegroundColor Cyan
foreach ($ext in $extensions) {
    Write-Host "  -> $ext" -ForegroundColor DarkGray
    & pi install $ext
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Failed to install $ext (exit $LASTEXITCODE)"
    }
}

Write-Host "`nDone! Installed extensions:" -ForegroundColor Green
& pi list
