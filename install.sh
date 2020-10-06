#!/usr/bin/env bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# homebrew
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew bundle

# vim
rm ~/.vim
ln -s ${BASEDIR}/vim/ ~/.vim

# bash
rm ~/.bash_profile
ln -s ${BASEDIR}/bash_profile ~/.bash_profile

if [ -z $(grep "/usr/local/bin/bash" "/etc/shells") ]; then
  sudo sh -c 'echo "/usr/local/bin/bash" >> /etc/shells'
  sudo chsh -s /usr/local/bin/bash
  chsh -s /usr/local/bin/bash
fi
