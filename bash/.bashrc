# --------------------
# Custom variables
# --------------------

# --------------------
# Colors
# --------------------

COLOR_FG_RESET="\033[39m"
COLOR_BG_RESET="\033[49m"

COLOR_FG_BLACK="\033[30m"
COLOR_BG_BLACK="\033[40m"

COLOR_FG_RED="\033[31m"
COLOR_BG_RED="\033[41m"

COLOR_FG_GREEN="\033[32m"
COLOR_BG_GREEN="\033[42m"

COLOR_FG_YELLOW="\033[33m"
COLOR_BG_YELLOW="\033[43m"

COLOR_FG_BLUE="\033[34m"
COLOR_BG_BLUE="\033[44m"

COLOR_FG_MAGENTA="\033[35m"
COLOR_BG_MAGENTA="\033[45m"

COLOR_FG_CYAN="\033[36m"
COLOR_BG_CYAN="\033[46m"

COLOR_FG_GREY="\033[37m"
COLOR_BG_GREY="\033[47m"

# --------------------
# Aliases && Secrets
# --------------------

source ~/.bash_aliases
source ~/.bash_secrets

# --------------------
# History
# --------------------

export HISTCONTROL=ignoredups
export HISTFILESIZE=3000
export HISTIGNORE="ls:cd:..:...:exit"

# --------------------
# Global
# --------------------

export EDITOR=nvim

# Input stuff
bind "set show-all-if-ambiguous On" # show list automatically, without double tab

# Add completion to source and .
complete -F _command source
complete -F _command .

# --------------------
# Prompts
# --------------------

current_dir() {
  pwd | awk -F\/ '{print $(NF-1),$(NF)}' | sed 's/ /\//'
}

nix_shell() {
  if [[ ! -z $IN_NIX_SHELL ]]; then
    echo ${name:-nix-shell}
  fi
}

is_git_repository() {
  git status 1> /dev/null 2> /dev/null; echo $?
}

git_branch() {
  git branch 2> /dev/null | grep "\*" | awk '{print " "$2""}'
}

git_modified_files() {
  git status 2> /dev/null | grep -c :
}

aws_time_left() {
  if test -z ${AWS_SESSION_EXPIRATION}; then
    return
  fi

  aws_session_expiration=$(date -d $AWS_SESSION_EXPIRATION "+%s")
  current_time=$(date +%s)

  sec_left=$((aws_session_expiration - current_time))
  hours_left=$(( sec_left / 3600 ))
  min_left=$(( (sec_left/60) - (hours_left*60) ))

  if (( sec_left > 0 )); then
    echo "aws ⌛${hours_left}h ${min_left}m"
  else
    echo "aws ⌛EXPIRED"
  fi
}

prompt_func() {
  separator=$'\ue0c6 '
  separator2=$'\ue0c7 '

  prompt="\n"
  prompt+="${COLOR_BG_BLACK}${COLOR_FG_CYAN}${separator2}"
  prompt+="${COLOR_FG_RESET}${COLOR_BG_CYAN} $(current_dir) "
  prompt+="${COLOR_FG_CYAN}${COLOR_BG_BLACK}${separator}"

  if (( $(is_git_repository) == 0)) ; then
    prompt+="${COLOR_BG_BLACK}${COLOR_FG_CYAN}${separator2}"
    prompt+="${COLOR_FG_RESET}${COLOR_BG_CYAN} $(git_branch) "

    if (( $(git_modified_files) > 0 )); then
      prompt+="${COLOR_FG_RESET}${COLOR_BG_CYAN}[*] "
    fi

    prompt+="${COLOR_FG_CYAN}${COLOR_BG_BLACK}${separator}"
  fi

  if [ "${AWS_SESSION_EXPIRATION}" != "" ]; then
    prompt+="${COLOR__AWS} $(aws_time_left) "
  fi

  prompt+="${COLOR_FG_RESET}${COLOR_BG_RESET}"
  prompt+="\n> "

  PS1=${prompt}
}

PROMPT_COMMAND=prompt_func

# --------------------
# Path
# --------------------

PATH=$PATH:/bin:/usr/bin:/home/cr0xd/.local/bin
PATH=$HOME/.local/bin:$PATH

export PATH=$PATH

# --------------------
# Erlang
# --------------------
export ERL_AFLAGS="-kernel shell_history enabled"

# --------------------
# Rust
# --------------------
source $HOME/.cargo/env

# --------------------
# cuda
# --------------------
export CUDA_HOME=/opt/cuda
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
. "$HOME/.cargo/env"

# --------------------
# Additional
# --------------------

eval "$(/usr/bin/mise activate bash)"

# autojump
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

export DISPLAY=:0
export XDG_SESSION_TYPE=x11

# --------------------
# ssh-agent (systemd user socket)
# --------------------
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/cr0xd/.lmstudio/bin"
