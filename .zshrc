# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# To customize prompt, run `p10k configure` or edit p10k.zsh.
[[ ! -f ~/.zsh/p10k/p10k.zsh ]] || source ~/.zsh/p10k/p10k.zsh

# read the zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=2'

if which exa ; then
    alias ls='exa --group-directories-first'
else;
    alias ls='ls --color=auto'
fi

alias ll='ls -l'
alias lla='ls -la'

alias grep='grep --color=auto'

alias vim='nvim'

alias g='git'
alias ga='git add'
alias gd='git diff'
alias gs='git status'
alias gc='git commit'
alias gco='git checkout'
alias gp='git push'
alias ..='cd ..'



