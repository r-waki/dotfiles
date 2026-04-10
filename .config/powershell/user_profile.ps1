# Alias
Set-Alias ll ls
Set-Alias grep findstr
Set-Alias g git

#------------------------------------------------
# Git Command Alias
#------------------------------------------------
function gc() {
    git commit
}

function ga() {
    git add
}

function gs() {
    git status
}

function gpsh() {
    git push
}

function gb() {
    git branch
}

#------------------------------------------------
# Docker Command Alias
#------------------------------------------------
Set-Alias d docker

function dimg() {
    docker image
}

function dp() {
    docker ps
}

#------------------------------------------------
# Function Name: which
# Return the command program path.
#------------------------------------------------
function which ($command) {
    Get-Command -Name $command -ErrorAciton SilentlyContinue |
      Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
} 

