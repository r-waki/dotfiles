[CmdletBinding()]
param(
    [switch]$Force,
    [string]$HomePath = [Environment]::GetFolderPath("UserProfile"),
    [string]$DocumentsPath = [Environment]::GetFolderPath("MyDocuments"),
    [string]$LocalAppDataPath = $env:LOCALAPPDATA
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$setupScript = Join-Path $repoRoot "scripts\setup-windows.ps1"

if (-not (Test-Path -LiteralPath $setupScript)) {
    throw "setup-windows.ps1 was not found: $setupScript"
}

& $setupScript `
    -Force:$Force.IsPresent `
    -HomePath $HomePath `
    -DocumentsPath $DocumentsPath `
    -LocalAppDataPath $LocalAppDataPath
