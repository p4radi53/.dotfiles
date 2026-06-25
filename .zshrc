# Uncomment to start profiling
# zmodload zsh/zprof


# Setup completion system
setopt EXTENDED_GLOB

autoload -Uz compinit
if [[ -n "$HOME/.zcompdump"(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Enable starship
eval "$(starship init zsh)"


# Executables
export PATH="$PATH:$HOME/.local/bin" # pipx
export PATH="$PATH:$HOME/go/bin" # golang

# Load env variables
set -a
[ -f ~/.env ] && source ~/.env
set +a

# Aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias ll="ls -laG"

# Functions
set_java_17() {
  export JAVA_HOME="$(brew --prefix openjdk@17)/libexec/openjdk.jdk/Contents/Home"
}

# For Java installation use Coursier
# For Python installation use UV

# Dotfiles
dotfiles() {
  /usr/bin/git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}
compdef dotfiles=git

lazydotfiles() {
  lazygit --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}

# ZSH plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
# Dotfiles - run once!
# dotfiles config --local status.showUntrackedFiles no
# dotfiles config --local core.excludesFile "$HOME/.config/dotfiles-ignore"

# Tmux on startup
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default -c /some/path
fi

grep_failed() {
  databricks jobs get-run-output "$1" | jq -r '.logs' | rg -m 1 -A 5 FAILED
}
# Uncomment to start profiling
# zprof
