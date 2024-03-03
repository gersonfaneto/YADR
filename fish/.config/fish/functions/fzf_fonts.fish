function fzf_fonts
  set -l fonts_config $HOME/.config/kitty/extras/fonts.conf

  set -l available_fonts (cat $fonts_config | grep '^# font_family' | sed 's/^# font_family\s*//g')

  set -l current_font (cat $fonts_config | grep '^font_family' | sed 's/^font_family\s*//g')

  set -l selected_font (
  for font in $available_fonts;
    echo $font
  end | fzf
  )

  if test $selected_font
    set -l current_font_line (cat $fonts_config | grep -n $current_font | awk -F ':' '{print $1}')
    set -l selected_font_line (cat $fonts_config | grep -n $selected_font | awk -F ':' '{print $1}')

    sed -i "$selected_font_line s/^# //" $fonts_config
    sed -i "$current_font_line s/^/# /" $fonts_config

    killall -SIGUSR1 kitty
  end

  commandline -f repaint
end
