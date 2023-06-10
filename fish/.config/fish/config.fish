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

if type -q exa
  alias ls "exa --icons --color=always --group-directories-first"
  alias la "exa --all --icons --color=always --group-directories-first"
  alias ll "exa --icons --color=always --long --header --group-directories-first"
  alias lla "exa --all --long --icons --color=always --header --group-directories-first"
  alias tree "exa --all --tree --icons --color=always --group-directories-first"
end

if type -q tmux
  alias tl "tmux list-sessions"
  alias ta "tmux attach-session"
  alias tn "tmux new-session -s (basename (pwd)) -d"
  alias tk "tmux kill-session"
end

if type -q neofetch
  alias nf "neofetch"
end

if type -q bat
  alias bat "bat --theme=gruvbox-dark"
end

if type -q git
  alias g git
end

if type -q vim
  alias v vim
end

if type -q nvim
  alias nv nvim
end

if type -q trash
  alias rm trash
end

if type -q python
  alias py python
else
  alias py python3
end

if type -q tldr
  alias tldr "tldr --theme base16"
end

if type -q wezterm
  alias icat "wezterm imgcat --width 100"
end

if test -d ~/.asdf
  source ~/.asdf/asdf.fish
end

if test -d "$HOME/.local/bin/"
  export PATH="$PATH:$HOME/.local/bin/"
end

if asdf where golang > /dev/null 2>&1
  export PATH="$PATH:$(asdf where golang)/packages/bin"
end

if asdf where rust > /dev/null 2>&1
  export PATH="$PATH:$(asdf where rust)/bin"
end

if test -d "$HOME/.dotnet/tools"
  export PATH="$PATH:$HOME/.dotnet/tools"
end

if type -q fzf
  export FZF_DEFAULT_OPTS="--layout=reverse --height=50% --border=rounded \
  --prompt='Search: ' --info=inline --multi --tabstop=2 --color=dark"
end

if type -q bat
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
end

if type -q starship
  starship init fish | source
end

if type -q zoxide
  zoxide init fish | source
end

if status is-interactive  
  and not set -q TMUX
    if not tmux has-session -t Home 2>/dev/null
      tmux new-session -s Home -d 2>/dev/null
    end
end

function hop -d "Create a new directory and set it as the CWD"
  command mkdir $argv
    if test $status = 0
        switch $argv[(count $argv)]
          case '-*'
          case '*'
            cd $argv[(count $argv)]
            return
        end
    end
end


function bak --argument filename -d "Function for creating a backup for a given file."
    cp $filename $filename.bak
end

function todo -d "Display the contents of a TODO.md file on the current directory."
  ls --oneline --no-icons | grep TODO.md | read line

  if test $line 
    and type -q glow
    command glow $line
  else if test -f ~/Desktop/TODO.md
    and type -q glow
    command glow ~/Desktop/TODO.md
  end
end

