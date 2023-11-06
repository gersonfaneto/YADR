if type -q bat
  export BAT_THEME="Catppuccin-Mocha"
end

if type -q tmux
  ln -sf $HOME/.config/tmux/themes/Catppuccin-Mocha.conf $HOME/.config/tmux/theme.conf
end

if type -q fzf
  export FZF_DEFAULT_OPTS="--layout=reverse --height=50% --border=rounded \
    --prompt='Search: ' --info=inline --multi --tabstop=2 --color=dark \
    --color=bg+:-1,bg:-1,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
end

export COLORSCHEME="Catppuccin-Mocha"
