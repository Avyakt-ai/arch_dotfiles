neofetch
#####---------- EXPORTS ----------###
export BROWSER="google-chrome-stable"
export EDITOR="vim"
export VISUAL="vim"
#export MYVIMRC="$HOME/.config/vim/.vimrc"
#export VIMINIT="source $MYVIMRC"
export LESSHISTFILE=-
export PATH="$PATH:$HOME/.local/scripts/:$HOME/.local/bin/:$HOME/.local/scripts/dmenu/:$HOME/.cargo/bin"
export CDPATH=".:$HOME/.config/:$HOME/.local/:$HOME/.local/share/:$HOME/.local/programs"
precmd() { print "" }
autoload -Uz compinit
setopt PROMPT_SUBST
compinit
zstyle ':completion:*' menu select

#####--------------PLUGINS--------------------------###
#source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh



###------------------- PROMPT -----------------------###

function parse_git_dirty {
  STATUS="$(git status 2> /dev/null)"
  if [[ $? -ne 0 ]]; then printf ""; return; else printf " ["; fi
  if echo ${STATUS} | grep -c "renamed:"         &> /dev/null; then printf " >"; else printf ""; fi
  if echo ${STATUS} | grep -c "branch is ahead:" &> /dev/null; then printf " !"; else printf ""; fi
  if echo ${STATUS} | grep -c "new file::"       &> /dev/null; then printf " +"; else printf ""; fi
  if echo ${STATUS} | grep -c "Untracked files:" &> /dev/null; then printf " ?"; else printf ""; fi
  if echo ${STATUS} | grep -c "modified:"        &> /dev/null; then printf " *"; else printf ""; fi
  if echo ${STATUS} | grep -c "deleted:"         &> /dev/null; then printf " -"; else printf ""; fi
  printf " ] "
}

parse_git_branch() {
  # Long form
  git rev-parse --abbrev-ref HEAD 2> /dev/null
 # Short form
  # git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -e 's/.*\/\(.*\)/\1/'
}

NEWLINE=$'\n'
PROMPT='%F{033} %F{015}%~${NEWLINE}%F{006}$(parse_git_branch)%F{003}$(parse_git_dirty)%F{033}ᐅ%F{015} '
RPROMPT='%F{015}%t'

alias ls="ls --color=auto"
alias la="ls -A"
alias ll="ls -l"
alias ..='cd ..'
alias ...='cd ../..'
alias gst='git status'
alias gco='git checkout'
alias gbranch='git branch'
alias gadd='git add .'
alias gcm='git commit -m'
alias dvm='~/./dvm_login.exp'
alias back='cd /home/avi/my/dvm/'
# alias cd="cd | la"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
