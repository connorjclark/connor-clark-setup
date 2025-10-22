# Meta
######

# A function to document and list custom shell functions and aliases.
#
# Usage:
#   help <command> "<description>"  - Add or update documentation for a command.
#   help                            - List all documented commands.
declare -A _DOC_HELPERS
function help() {
  # --- Add or update documentation ---
  if [[ $# -gt 1 ]]; then
    local cmd="$1"
    shift
    local description="$*"
    
    # Store the command and description
    _DOC_HELPERS["$cmd"]="$description"
    return 0
  fi

  # --- List all documentation ---
  if [[ $# -eq 0 ]]; then
    echo "Connor's helpers\n"

    # zsh native way to loop over keys in alphabetical order
    # (o) = order/sort, (k) = keys
    for cmd in "${(ok@)_DOC_HELPERS[@]}"; do
      printf "  \033[1m%-15s\033[0m - %s\n" "$cmd" "${_DOC_HELPERS[$cmd]}"
    done

    return 0
  fi

  # --- Handle invalid arguments ---
  echo "Error: Invalid usage."
  echo "Usage to add: help <command> \"<description>\""
  echo "Usage to list: help"
  return 1
}

echo "Run 'help' to list available aliases and functions."

export CONNOR_BASH_FILE=`echo "$0"`
alias connorbash="cat $CONNOR_BASH_FILE"

# Keybindings
#############

bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

# Program stuff
###############

export LESSOPEN="| highlight --out-format=ansi %s"

# Git
#####

help gitc "git checkout"
alias gitc="git checkout"

help gitm "git checkout main"
alias gitcm="git checkout main"

help gitp "Push current brain to origin"
gitp () {
  git push -u origin `git rev-parse --abbrev-ref HEAD`
}

# Lighthouse
############

help lhexample "Run Lighthouse on example.com and open a report"
alias lhexample="node lighthouse-cli https://www.example.com --view"

# Utilities
###########

help runx "Run something x times. ex: runx 3 echo hi"
function runx() {
  for ((n=0;n<$1;n++))
    do ${*:2}
  done
}

help latest_file "Print the most recently modified file. ex: latest_file; latest_file some_dir"
latest_file () {
  # 1. Perform a single glob operation with qualifiers:
  #    ${@:-.}/* -> Look in all args, or '.' if no args given
  #    (ND.om[1]) -> Apply qualifiers to the glob:
  #      N: (N)ullglob - return empty if no files match (don't error).
  #      D: (D)otfiles - include hidden files.
  #      .: (.) - Match plain files only (not directories).
  #      om: (o)rder by (m)odification time (newest first).
  #      [1]: Subscript flag - pick only the *first* item from the sorted list.
  local latest_file=(${@:-.}/*(ND.om[1]))

  # 2. Check if the 'latest_file' array is empty (which 'N' allows)
  if [[ ${#latest_file} -eq 0 ]]; then
    echo "latest_file: No files found in: ${@:-.}" >&2
    return 1
  fi

  # 3. Print the single file that was found.
  print -r -- ${latest_file:A}
}

prettyjson_s() {
  echo "$1" | python -m json.tool
}

prettyjson_f() {
  python -m json.tool "$1"
}

prettyjson_w() {
  curl "$1" | python -m json.tool
}
