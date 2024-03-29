if test -d "$HOME/.local/bin/"
  if not contains $HOME/.local/bin/ $PATH
    export PATH="$PATH:$HOME/.local/bin/"
  end
end

if test -d "$HOME/.local/scripts/"
  if not contains $HOME/.local/scripts/ $PATH
    export PATH="$PATH:$HOME/.local/scripts/"
  end
end

if test -d "/usr/local/lib/"
  if not contains /usr/local/lib $LD_LIBRARY_PATH
    export LD_LIBRARY_PATH="/usr/local/lib/:$LD_LIBRARY_PATH"
  end
end

if type -q nvim
  export MANROFFOPT='-c'
  export MANPAGER="nvim +Man!"
end

if type -q google-chrome-stable
  export CHROME_EXECUTABLE="google-chrome-stable"
end
