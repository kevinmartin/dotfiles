#!/usr/bin/env bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

name=
email=

function ensure_identity {
  if [[ -z "$name" ]]; then read -p 'Full Name: ' name; fi
  if [[ -z "$email" ]]; then read -p 'Email: ' email; fi
}

# homebrew
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew bundle

# git
rm -f ~/.gitconfig
ln -s ${BASEDIR}/gitconfig ~/.gitconfig

if [ ! -f ~/.gitconfig.local ]; then
  ensure_identity
  git config -f ~/.gitconfig.local user.name "$name"
  git config -f ~/.gitconfig.local user.email "$email"
fi

# ssh
if [[ ! -f ~/.ssh/id_rsa ]]; then
  ensure_identity

  # Generate SSH key.
  ssh-keygen -t rsa -b 4096 -C "$email"

  # Start ssh-agent
  eval "$(ssh-agent -s)"

  # Add the SSH private key
  ssh-add -K ~/.ssh/id_rsa

  echo "Would you like to add the SSH key to Github?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) cat ~/.ssh/id_rsa.pub | pbcopy; echo "Key copied to clipboard. Opening Github settings..."; sleep 2; open https://github.com/settings/ssh/new; break;;
      No ) break;;
    esac
  done
fi

# gpg
if [[ -z "$(gpg --list-secret-keys)" ]]; then
  ensure_identity
  cat >/tmp/gpg_key_settings <<EOF
Key-Type: default
Key-Length: 4096
Subkey-Type: default
Subkey-Length: 4096
Name-Real: $name
Name-Email: $email
Expire-Date: 2y
EOF

  # Generate GPG key.
  gpg --batch --gen-key /tmp/gpg_key_settings
  rm /tmp/gpg_key_settings

  key=$(gpg --list-keys | grep '^pub ' -A1 | tail -n1 | awk '{ print $1 }')
  echo "Added key $key."

  echo "Would you like to add another identity or email address to the key?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) gpg --edit-key $key adduid; break;;
      No ) break;;
    esac
  done

  echo "Would you like to add the GPG key to Github?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) gpg --armor --export $key | pbcopy; echo "Key copied to clipboard. Opening Github settings..."; sleep 2; open https://github.com/settings/gpg/new; break;;
      No ) break;;
    esac
  done

  # Link the config.
  rm -f ~/.gnupg/gpg.conf
  ln -s ${BASEDIR}/gnupg/gpg.conf ~/.gnupg/gpg.conf

  # Check to see if GPG Agent is running. If not, start it.
  if [[ -f "~/.gnupg/.gpg-agent-info" && -n "$(pgrep gpg-agent)" ]]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
  else
    eval $(eval $(gpg-agent --daemon))
  fi

  # Restart gpg-agent to take new config into effect.
  gpg-connect-agent reloadagent /bye

  # Setup Git to Sign Commits.
  git config -f ~/.gitconfig.local user.signingkey $key
fi

# vim
rm -f ~/.vim
ln -s ${BASEDIR}/vim/ ~/.vim

# bash
rm -f ~/.bash_profile
ln -s ${BASEDIR}/bash_profile ~/.bash_profile

if [ -z $(grep "/usr/local/bin/bash" "/etc/shells") ]; then
  sudo sh -c 'echo "/usr/local/bin/bash" >> /etc/shells'
  sudo chsh -s /usr/local/bin/bash
  chsh -s /usr/local/bin/bash
fi

# .macos settings
./.macos
