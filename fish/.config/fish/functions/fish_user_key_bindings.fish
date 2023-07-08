function fish_user_key_bindings
  bind \cj fzf_directory
  bind \cf fzf_file
  bind \cr fzf_history
  bind \ct fzf_theme

  bind \ca tmux_attach
  bind \ck tmux_kill

  bind ! history_previous_command
  bind '$' history_previous_command_arguments

  # fish_vi_key_bindings --no-erase insert
end
