# kevinmartin dotfiles

This repository helps me set up and maintain my Mac. It takes the effort out of installing manually.

## What does it do?

This repository will install Homebrew (if not already installed), common Homebrew recipes (ie. awscli and terraform), and symlink configuration files where needed for common tools I use (ie. bash and vim).

## Instructions

1. Open Terminal
2. Clone this repository and `cd` into it.
  ```sh
  $ git clone https://github.com/kevinmartin/dotfiles.git ~/Development/kevinmartin/dotfiles && cd $_
  ```
3. Install by running the `./install.sh` script.

### Quicklook Plugins

Some Quicklook plugins require some extra setup due to recent security measures in macOS.

For each plugin that returns an error, you may need to run:
```sh
$ xattr -cr ~/Library/QuickLook/[plugin name].qlgenerator
$ qlmanage -r
$ qlmanage -r cache
```

Then relaunch Finder (Option + Right-Click Finder > Relaunch).

### iTerm2 Airline Font

Once iTerm2 and Homebrew recipes are installed, change the font in iTerm2 to take advantage of the Powerline fonts.

> Profiles > Text > Font > Meslo

## Updating

Pull down the latest changes and re-run `./install.sh` from the repository directory. All commands in the install script _should_ be idempotent.
