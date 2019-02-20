export ZSH=/root/.oh-my-zsh
export LC_ALL="en_US.UTF-8"

ZSH_THEME="ys"
plugins=(git encode64 urltools osx autojump kubectl completion zsh zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

bindkey "[C" forward-word
bindkey "[D" backward-word

alias kc='kubectl'
alias kcs='kubectl -n kube-system'

# Golang envs
export GOROOT=/usr/local/go
export GOPATH=${HOME}/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

