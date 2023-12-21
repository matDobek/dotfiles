# --------------------
# Custom variables
# --------------------

# --------------------
# Colors
# --------------------

COLOR_NO_COLOR="\[\e[0m\]"
COLOR_RED="\[\e[31m\]"
COLOR_GREEN="\[\e[32m\]"
COLOR_YELLOW="\[\e[33m\]"
COLOR_BLUE="\[\e[34m\]"
COLOR_MAGENTA="\[\e[35m\]"
COLOR_CYAN="\[\e[36m\]"
COLOR_GREY="\[\e[37m\]"

COLOR__PWD=${COLOR_MAGENTA}
COLOR__PROMPT=${COLOR_MAGENTA}
COLOR__GIT_BRANCH=${COLOR_GREEN}
COLOR__GIT_DIRTY=${COLOR_RED}
COLOR__AWS=${COLOR_BLUE}
COLOR__NIX_SHELL=${COLOR_BLUE}

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

prompt_symbol="λ:"

current_dir() {
  pwd | awk -F\/ '{print $(NF-1),$(NF)}' | sed 's/ /\//'
}

nix_shell() {
  if [[ ! -z $IN_NIX_SHELL ]]; then
    echo ${name:-nix-shell}
  fi
}

git_branch() {
  git branch 2> /dev/null | grep "\*" | awk '{print " "$2""}'
}

git_dirty_flag() {
  git status 2> /dev/null | grep -c : | awk '{if ($1 > 0) print "[+-]"}'
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
  prompt="\n${COLOR__PWD}$(current_dir) ${COLOR__AWS} $(aws_time_left) ${COLOR__NIX_SHELL} $(nix_shell) ${COLOR__GIT_BRANCH} $(git_branch) ${COLOR__GIT_DIRTY} $(git_dirty_flag)"

  PS1="${prompt}\n${COLOR__PROMPT}${prompt_symbol} ${COLOR_NO_COLOR}"
}

PROMPT_COMMAND=prompt_func

# --------------------
# Path
# --------------------

PATH=$PATH:/bin:/usr/bin:/home/cr0xd/.local/bin
PATH=$HOME/.local/bin:$PATH

export PATH=$PATH

# --------------------
# 3rd porty scripts
# --------------------

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# --------------------
# OS Specyfic :: Arch
# --------------------

# asdf
. /opt/asdf-vm/asdf.sh

# autojump
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# --------------------
# Erlang
# --------------------
export ERL_AFLAGS="-kernel shell_history enabled"

# --------------------
# Rust
# --------------------
source "$(asdf where rust)/env"

# --------------------
# OS Specyfic :: Mac
# --------------------

# autojump
#[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# asdf
#. /usr/local/opt/asdf/libexec/asdf.sh

# --------------------
# OS Specyfic :: Nix
# --------------------

# autojump
# source "$(nix-store --query --references "$(which autojump)" | grep autojump)/share/autojump/autojump.bash"
#
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/cr0xd/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/cr0xd/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/cr0xd/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/cr0xd/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
