# create directory for init.vim if it doesn't exist

$nvimDir = "$env:USERPROFILE\AppData\Local\nvim"

if (-not (Test-Path $nvimDir)) {
    New-Item -ItemType Directory -Path $nvimDir
}

# create symbolic link to init.vim

$initVim = "$nvimDir\init.vim"
$colorVim = "$nvimDir\colors"

if (-not (Test-Path $initVim)) {
    New-Item -ItemType SymbolicLink -Path $initVim  -Value $PSScriptRoot\nvim\init.vim
    New-Item -ItemType SymbolicLink -Path $colorVim -Value $PSScriptRoot\nvim\colors
}
