#!/usr/bin/env bash

# NOTE: This needs a rewrite ASAP!

# Some colors for better progress visualization.
NOTE="[\e[1;36mNOTE\e[0m]"
OK="[\e[1;32mOK\e[0m]"
ERROR="[\e[1;31mERROR\e[0m]"
# ATTENTION="[\e[1;33mATTENTION\e[0m]"
# WARNING="[\e[1;35mWARNING\e[0m]"
# ACTION="[\e[1;33mACTION\e[0m]"

WAIT="\e[1A\e[K"

# Path to the installation log.
LOG="INSTALL.log"

# TODO: This need to be updated.
# List of needed packages to be installed.
packages=(
  # texlive
  alacritty
  atuin
  bat
  bob
  bottom
  difftastic
  eza
  fastfetch
  fd
  figlet
  fish
  fzf
  ghcup-hs-bin
  github-cli
  glow
  jq
  pandoc-bin
  ripgrep
  starship
  stow
  tmux
  trash-cli
  usql
  xh
  yazi
  zoxide
)

# Show a progress bar to the user.
display_progress() {
  while ps | grep $1 &>/dev/null; do
    echo -n "."
    sleep 2
  done

  echo -en "Done!\n"

  sleep 2
}

ask_for_sudo() {
  # Ask for the administrator password upfront.
  sudo -v &>/dev/null

  # Update existing `sudo` time stamp
  # until this script has finished.
  #
  # https://gist.github.com/cowboy/3118588

  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done &>/dev/null &
}

# Tests if a package is already installed and if not found it will attempt to install it.
install_package() {
  if yay -Q "$1" &>>/dev/null; then
    echo -e "$OK - $1 is already installed."
  else
    echo -en "$NOTE - Now installing $1 ."

    yay -S --noconfirm --needed "$1" &>>"$LOG" &

    display_progress $!

    if yay -Q "$1" &>>/dev/null; then
      echo -e "$WAIT$OK - $1 was installed."
    else
      echo -e "$WAIT$ERROR - $1 install has failed, please check the log at $LOG."
      exit
    fi
  fi
}

clear

# Let the user know that we will use sudo.
echo -e "$NOTE - This script will run some commands that require sudo."
echo -e "$NOTE - You will be prompted to enter your password when needed."
echo -e "$NOTE - If you are worried about entering your password then you may want to review the content of the script."

sleep 1

# Expect user input to confirm and continua with the script or exit.
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to continue with the install [Y/n] ' REPLY

ask_for_sudo

if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
  echo -e "$NOTE - Setup starting..."
else
  echo -e "$NOTE - This script will now exit, no changes were made to your system."
  exit
fi

# Check for package manager (YAY).
if [ ! -f /sbin/yay ]; then
  echo -en "$NOTE - Configuring yay..."

  git clone https://aur.archlinux.org/yay.git &>>"$LOG"

  cd yay || exit

  makepkg -si --noconfirm &>>../"$LOG" &

  display_progress $!

  if [ -f /sbin/yay ]; then
    echo -e "$WAIT$OK - yay configured with success."
    cd ..

    echo -en "$NOTE - Updating yay database."

    yay -Suy --noconfirm &>>"$LOG" &

    display_progress $!

    echo -e "$WAIT$OK - yay database updated with success."
  else
    echo -e "$WAIT$ERROR - yay installation failed, please check the log at $LOG!"
    exit
  fi
fi

# Install all of the packages declared in the list above.
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the packages? [Y/n] ' REPLY

if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
  echo -e "$NOTE - Beggining installation, this may take a while..."

  for PACKAGE in "${packages[@]}"; do
    install_package "$PACKAGE"
  done
fi

# Link configuration files.
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to link the configuration files? [Y/n] ' REPLY

if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
  echo -e "$NOTE - Linking configuration files and fonts..."

  stow .

  echo -e "$NOTE - Refreshing font cache..."

  fc-cache -f

  if yay -Q bat &>>/dev/null; then
    echo -e "$NOTE - Updating 'bat' themes..."
    bat cache --build &>>/dev/null
  fi
fi

# Change the default shell to fish.
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to change the default shell to fish? [Y/n] ' REPLY

if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
  if [ "$SHELL" != "/usr/bin/fish" ]; then
    echo -e "$M_NOTE - Changing default shell to fish..."
    chsh -s "$(which fish)"
  else
    echo -e "$NOTE - Fish is already the default shell!"
  fi
fi

clear

echo -e "$NOTE - Installation was finished with success!"
echo -e "$NOTE - You may close and reopen your terminal for changes to take full effect!"

sleep 1
