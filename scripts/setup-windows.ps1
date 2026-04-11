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
$homeDir = $HomePath
$documentsDir = $DocumentsPath
$localAppData = $LocalAppDataPath
$backupSuffix = Get-Date -Format "yyyyMMddHHmmss"

if ([string]::IsNullOrWhiteSpace($homeDir)) {
    throw "HomePath must not be empty."
}

if ([string]::IsNullOrWhiteSpace($documentsDir)) {
    throw "DocumentsPath must not be empty."
}

if ([string]::IsNullOrWhiteSpace($localAppData)) {
    throw "LocalAppDataPath must not be empty."
}

function Resolve-NormalizedPath {
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    return [System.IO.Path]::GetFullPath((Resolve-Path -LiteralPath $Path).Path)
}

function Ensure-ParentDirectory {
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    $parent = Split-Path -Parent $Path
    if (-not [string]::IsNullOrWhiteSpace($parent) -and -not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }
}

function Move-ExistingItem {
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    $backupPath = "$Path.backup-$backupSuffix"
    Move-Item -LiteralPath $Path -Destination $backupPath
    Write-Host "Moved existing item to $backupPath"
}

function Install-Link {
    param(
        [Parameter(Mandatory)]
        [string]$SourcePath,

        [Parameter(Mandatory)]
        [string]$TargetPath
    )

    if (-not (Test-Path -LiteralPath $SourcePath)) {
        throw "Source path does not exist: $SourcePath"
    }

    Ensure-ParentDirectory -Path $TargetPath

    $sourceItem = Get-Item -LiteralPath $SourcePath -Force
    $sourceResolved = Resolve-NormalizedPath -Path $SourcePath

    if (Test-Path -LiteralPath $TargetPath) {
        $targetItem = Get-Item -LiteralPath $TargetPath -Force
        $targetResolved = Resolve-NormalizedPath -Path $TargetPath

        if ($targetResolved -eq $sourceResolved) {
            Write-Host "Already linked: $TargetPath"
            return
        }

        if ($Force) {
            Remove-Item -LiteralPath $TargetPath -Force -Recurse
        }
        else {
            Move-ExistingItem -Path $TargetPath
        }
    }

    $itemType = if ($sourceItem.PSIsContainer) { "Junction" } else { "SymbolicLink" }
    New-Item -ItemType $itemType -Path $TargetPath -Target $SourcePath | Out-Null
    Write-Host "Linked $TargetPath -> $SourcePath"
}

$mappings = @(
    @{ Source = ".gitconfig"; Target = ".gitconfig" },
    @{ Source = ".gitignore_global"; Target = ".gitignore_global" },
    @{ Source = ".vimrc"; Target = ".vimrc" },
    @{ Source = ".tmux.conf"; Target = ".tmux.conf" },
    @{ Source = ".config\wezterm"; Target = ".config\wezterm" },
    @{ Source = ".config\whkdrc"; Target = ".config\whkdrc" },
    @{ Source = ".config\exercism"; Target = ".config\exercism" },
    @{ Source = ".config\yarn"; Target = ".config\yarn" },
    @{ Source = ".config\powershell\user_profile.ps1"; Target = "Documents\PowerShell\Microsoft.PowerShell_profile.ps1" },
    @{ Source = ".config\powershell\user_profile.ps1"; Target = "Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" },
    @{ Source = ".config\nvim"; Target = "AppData\Local\nvim" },
    @{ Source = ".config\scoop\config.json"; Target = "scoop\config\config.json" }
)

foreach ($mapping in $mappings) {
    $sourcePath = Join-Path $repoRoot $mapping.Source
    $targetPath = Join-Path $homeDir $mapping.Target

    if ($mapping.Target.StartsWith("Documents\")) {
        $targetPath = Join-Path $documentsDir $mapping.Target.Substring("Documents\".Length)
    }
    elseif ($mapping.Target.StartsWith("AppData\Local\")) {
        $targetPath = Join-Path $localAppData $mapping.Target.Substring("AppData\Local\".Length)
    }

    Install-Link -SourcePath $sourcePath -TargetPath $targetPath
}
