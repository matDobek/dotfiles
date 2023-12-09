# --------------------
# OS Specific :: Linux
# --------------------

alias j='z'
alias open='xdg-open'
#alias aws--login='aws-vault exec -d 8h -n fresha-developer --backend=file'
alias ssh--login='eval $(ssh-agent -s) && ssh-add ~/.ssh/id_ed25519'
alias friday--camera-setup='sudo modprobe v4l2loopback'
alias friday--camera='gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0'
alias timestamp='date +%s'

# --------------------
# OS Specific :: MacOS
# --------------------

alias remove--ds-store='sudo find ./ -depth -name ".DS_Store" -exec rm {} \;'

# --------------------
# Misc
# --------------------

alias sudo='sudo ' # make aliases work with sudo - if the last character of the alias value is a space or tab character, the the next phrase is also checked as alias expansion

alias ..='cd ..'
alias dot='j dotfiles'
alias scr='j scripts'

alias reload--scripts='ln -sf ~/MEGA/main/projects/_ongoing/scripts/* ~/.local/bin/'
alias reload--bash='source ~/.bash_profile'
alias reload--x='xrdb ~/.Xresources'

alias top='top -o cpu'
alias topx='bashtop'
alias vim='nvim'
alias gpg='LANG=en gpg'

# for human format use -h, instead of -m
alias size--all='du -ms $(ls -A) | sort -n | tail -n 21'
alias size--rec='du -m | sort -n | tail -n 20'

# NixOS
# alias nix--conf='vim /etc/nixos/configuration.nix'
# alias nix--conf-hardware='vim /etc/nixos/hardware-configuration.nix'
# alias nix--search='nix-env -qaP --description'
# alias nix--list-installed='nix-env -q --installed'
# alias nix--shell='nix-shell --pure'

# Arch
alias friday--packages--install='paru -S '
alias friday--packages--update='paru -Syyu' # double yy to also refresh mirror list
alias friday--packages--update--aur--only='paru -Syu'
alias friday--packages--update-query='paru -Qua'
alias friday--packages--cleanup='paru --clean'
alias friday--packages--cleanup--cache='paru -Scc'
alias friday--packages--remove='paru -R '
alias system--devices="lsblk --all"

alias friday--reboot='reboot'
alias friday--shutdown='shutdown now'
alias friday--hibernate='systemctl hibernate'
alias friday--suspend='systemctl suspend'

alias mount--usb='mount /dev/disk/by-label/MD /media/usb'
alias umount--usb='umount /media/usb'

alias c='xclip -selection clipboard'
alias v='xclip -o -selection clipboard'

alias arr='youtube-dl --extract-audio --audio-format mp3 '

alias nice--json='python -m json.tool'

# --------------------
# LaTeX
# --------------------

alias tex--cleanup='latexmk -c '
alias tex--follow='latexmk -pdf -pvc -file-line-error -interaction=nonstopmode'
alias tex--preview='open -a preview'

# --------------------
# Makefile
# --------------------

alias mb="make build"
alias mr="make run"

# --------------------
# Tmux
# --------------------

alias tmux='TERM=screen-256color-bce tmux'

alias tmux--dot='tmux a -t "dot" || tmux new-session -s "dot" "tmux source-file ~/.tmux_sessions/dotfiles"'
alias tmux--gov='tmux a -t "gov" || tmux new-session -s "gov" "tmux source-file ~/.tmux_sessions/gov"'
alias tmux--wrk='tmux new-session -s "wrk" "tmux source-file ~/.tmux_sessions/gorepl "'
alias tmux--go='tmux new-session -s "go" "tmux source-file ~/.tmux_sessions/go"'
alias tmux--reorder='tmux move-window -r'

# --------------------
# Docker
# --------------------

alias dp='docker system prune'
alias dri='docker image rm $(docker image ls --all --quiet)'

# --------------------
# Rails
# --------------------

alias rs="rails s"
alias rc="rails c"
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"

# --------------------
# Elixir
# --------------------
alias e--format='mix format'
alias e--check-format='mix format --check-formatted --dry-run'
alias e--check-credo='mix credo --strict'
alias e--check-compile='mix compile --warnings-as-errors --force'
alias e--check='e--check-format && e--check-credo && e--check-compile'


# --------------------
# Git
# --------------------

alias gg='lazygit'
alias gb='git branch'
alias gbd='git branch | grep -v "\(master\|production\|beta\)" | xargs git branch -d'
alias gbD='git branch | grep -v "\(master\|production\|beta\)" | xargs git branch -D'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcof='git checkout $(git branch | fzf)'
alias gd='git diff'
alias gdc='git diff --cached'
alias gs='git status'
#alias gpp='git pull --rebase; git push'
alias gpp='git pull; git push'
alias gppc='git pull; git push; ctags -R --languages=Rust,ruby --exclude=.git --exclude=log .'

alias gpr='open "https://github.com/matDobek/`basename $(git rev-parse --show-toplevel)`/compare/master...`git rev-parse --abbrev-ref HEAD`?expand=1"'
alias gprw='open "https://github.com/COMPANY/`basename $(git rev-parse --show-toplevel)`/compare/master...`git rev-parse --abbrev-ref HEAD`?expand=1"'

alias gitignore_rust="curl -L -s https://www.gitignore.io/api/rust > .gitignore && printf 'tags\n.DS_Store' >> .gitignore"

alias glsm='git ls-files -m'
alias gcop="git ls-files -m | fzf | pbcopy"
