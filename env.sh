#!/bin/bash

# add ./bin to the path
[[ -z "$BASH_SOURCE" ]] && SCRIPT="$0" || SCRIPT="$BASH_SOURCE"
SCRIPTPATH="$(cd "$(dirname "$SCRIPT")" ; pwd)"
[[ ":$PATH:" != *"$SCRIPTPATH/bin"* ]] && export PATH="${PATH:+${PATH}:}$SCRIPTPATH/bin"

SOURCE=master.tex

if [[ "$1" == "init" ]]; then
	make show
	watch-for-edits --file "$SOURCE" --command "make 2>&1 all > /dev/null" &
fi
