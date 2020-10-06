# Bash Completion.
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
complete -C /usr/local/bin/terraform terraform

# NVM.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Aliases.
alias t="tree -aF --dirsfirst -I '.git|node_modules|vendor|.next|out'"
