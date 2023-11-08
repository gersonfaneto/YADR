set fish_greeting ""

set -gx TERM xterm-256color
set -gx EDITOR nvim

alias ex exit
alias cl clear

alias sr "sudo reboot -h now"
alias sp "sudo poweroff"

alias sweep "echo yes | history clear > /dev/null"

alias rs reset
alias sc "source $HOME/.config/fish/config.fish && echo 'Reloaded!'"

alias cp "cp -i"
alias mv "mv -i"
alias rm "rm -i"

alias ..  "cd .."
alias ... "cd ../.."
alias .3  "cd ../../.."
alias .4  "cd ../../../.."
alias .5  "cd ../../../../.."

if not test -f $HOME/.config/fish/theme.fish
  ln -sf $HOME/.config/fish/themes/dark/Gruvbox-Material.fish $HOME/.config/fish/theme.fish
end

source $HOME/.config/fish/theme.fish

source $HOME/.config/fish/settings/alias.fish
source $HOME/.config/fish/settings/extras.fish
source $HOME/.config/fish/settings/exports.fish
source $HOME/.config/fish/settings/functions.fish
