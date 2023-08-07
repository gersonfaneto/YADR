function tmux_sessionizer
  set -l targeted_directories "$HOME/Developer" "$HOME/Developer/GitHub" "$HOME"
  set search_flags -mindepth 1 -maxdepth 1 -type d -not -path '*/.*'

  set selected (find $targeted_directories $search_flags | fzf --prompt='Sessionizer: ')

  set is_attached (tmux list-sessions | grep attached | wc --lines)

  if test -z $selected
    commandline -f repaint
    return 0
  end

  set selected_name (basename $selected | tr . _)

  set is_session (tmux list-sessions | grep $selected_name | wc --lines)

  if test $is_session -eq 0
    tmux new-session -s $selected_name -c $selected &>>/dev/null
    commandline -f repaint
    return 0
  end

  if test $is_attached -eq 0
    tmux attach-session -t $selected_name &>>/dev/null
    commandline -f repaint
    return 0
  end
end
