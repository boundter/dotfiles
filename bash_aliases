# Useful shortcuts
openpdf () {
  okular "$1" 2>/dev/null &
  disown
}

openpic () {
  gwenview $1 2>/dev/null &
  disown
}

opentxt () {
  kate $1 2>/dev/null &
  disown
}

alias pip3.6="python3.6 -m pip"
