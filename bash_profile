export EDITOR=vim
export GPG_TTY=$(tty)

eval "$(/opt/homebrew/bin/brew shellenv)"

# Aliases.
alias t="tree -aF --dirsfirst -I '.git|node_modules|vendor|.next|out'"

# NVM (should be sourced before bash completion).
export NVM_DIR="$HOME/.nvm"
NVM_BREW_PREFIX=$(brew --prefix nvm)
[ -s "$NVM_BREW_PREFIX/nvm.sh" ] && \. $NVM_BREW_PREFIX/nvm.sh # This loads nvm from Homebrew.

# Bash Completion.
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
complete -C /usr/local/bin/terraform terraform
