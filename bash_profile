export EDITOR=vim
export GPG_TTY=$(tty)

BREW_PREFIX=$(brew --prefix nvm)

# Aliases.
alias t="tree -aF --dirsfirst -I '.git|node_modules|vendor|.next|out'"

# NVM (should be sourced before bash completion).
export NVM_DIR="$HOME/.nvm"
[ -s "$BREW_PREFIX/nvm.sh" ] && \. $BREW_PREFIX/nvm.sh # This loads nvm from Homebrew.

# Bash Completion.
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
complete -C /usr/local/bin/terraform terraform
