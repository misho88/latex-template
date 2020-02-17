#!/bin/bash

# add ./bin to the path
[[ -z "$BASH_SOURCE" ]] && SCRIPT="$0" || SCRIPT="$BASH_SOURCE"
SCRIPTPATH="$(cd "$(dirname "$SCRIPT")" ; pwd)"
[[ ":$PATH:" != *"$SCRIPTPATH/bin"* ]] && export PATH="${PATH:+${PATH}:}$SCRIPTPATH/bin"
