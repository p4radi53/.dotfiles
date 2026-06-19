# Setup completion system
setopt EXTENDED_GLOB

autoload -Uz compinit
if [ -n "$HOME/.zcompdump"(#qN.mh+24) ]; then
  compinit
else
  compinit -C
fi

# Prompt theme: robbyrussell-style prompt, without Oh My Zsh

autoload -Uz vcs_info
setopt PROMPT_SUBST
zstyle ':vcs_info:git:*' formats ' %F{red}(%b%F{yellow}%u%c%F{red})%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '✗'
zstyle ':vcs_info:*' stagedstr '✗'
precmd() { vcs_info }
# Arrow turns red if last command failed, green if it succeeded
PROMPT='%(?:%F{green}➜:%F{red}➜) %F{cyan}%c%f${vcs_info_msg_0_} '


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

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Dotfiles - run once!
# dotfiles config --local status.showUntrackedFiles no
# dotfiles config --local core.excludesFile "$HOME/.config/dotfiles-ignore"
