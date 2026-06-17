# Set up Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"  # You can change this to your preferred theme

# Enable plugins
plugins=(git) # Consider adding useful plugins
source $ZSH/oh-my-zsh.sh

# # NVM (Node Version Manager)
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load nvm bash completion

# pipx (for Python executables)
export PATH="$PATH:$HOME/.local/bin"  # Add pipx binaries to PATH

# golang - add binaries
export PATH="$PATH:$HOME/go/bin"

# env variables
set -a
source ~/.env
set +a

# Enable Bash completion (if needed for certain commands)
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"

# Functions
set_java_17() {
  export JAVA_HOME="$(brew --prefix openjdk@17)/libexec/openjdk.jdk/Contents/Home"
}

# Dotfiles
dotfiles() {
  /usr/bin/git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}
# compdef dotfiles=git
# alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
compdef dotfiles=git
dotfiles config --local status.showUntrackedFiles no
dotfiles config --local core.excludesFile "$HOME/.config/dotfiles-ignore"
