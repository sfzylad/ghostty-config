#!/usr/bin/env bash

readonly dynamic_theme_file="$HOME/.config/ghostty/dynamic-config"
readonly default_theme=Adventure
readonly alternate_theme="Apple System Colors Light"

set_theme() {
	echo "theme = $1" >"$dynamic_theme_file"
	killall -SIGUSR2 ghostty # reset (in Linux)
}

if ! current_theme=$(awk -F ' = ' '/^theme =/ {print $2}' "$dynamic_theme_file" 2>/dev/null); then
	echo "Dynamic theme file not found; creating with alternate theme."
	set_theme "$alternate_theme"
	exit 0
fi

if [ "$current_theme" == "$default_theme" ]; then
	set_theme "$alternate_theme"
else
	set_theme "$default_theme"
fi

