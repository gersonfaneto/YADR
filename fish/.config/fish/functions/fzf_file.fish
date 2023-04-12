# Uses 'fzf' and 'rg' to search for files on the current
# working directory and open them on the '$EDITOR'.
function fzf_file
  set -l fzf_flags --preview="bat --theme=TwoDark --style=numbers --color=always --line-range :500 {}"

  rg --files --hidden --glob "!.git/*" | fzf $fzf_flags | read line

  if test $line
    commandline "$EDITOR $line"
    commandline -f execute
  end

  commandline -f repaint
end
