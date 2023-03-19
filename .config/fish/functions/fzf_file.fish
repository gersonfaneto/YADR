function fzf_file
  set -l fzf_flags --preview="batcat --theme=TwoDark --style=numbers --color=always --line-range :500 {}"

  rg --files --hidden --glob "!.git/*" | fzf $fzf_flags | read line

  if test $line
    commandline "$EDITOR $line"
    commandline -f execute
  end

  commandline -f repaint
end