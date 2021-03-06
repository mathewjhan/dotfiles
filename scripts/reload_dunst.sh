#!/usr/bin/env bash
#
# Script to set colors generated by 'wal'
# https://github.com/dylanaraps/wal
 # Source generated colors.
. "${HOME}/.cache/wal/colors.sh"

 reload_dunst() {
    pkill dunst
    dunst \
    -font "Noto Sans 9" \
	-frame_width 3 \
        -lb "${color0}" \
        -nb "${color0}" \
        -cb "${color0}" \
        -lf "${color7}" \
        -bf "${color7}" \
        -cf "${color7}" \
        -nf "${color7}" \
        -lfr "${color1}" \
        -nfr "${color1}" \
        -cfr "${color1}" &
}

reload_dunst
