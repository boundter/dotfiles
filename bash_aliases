alias ll="ls -l"

############
# Projects #
############

alias daafi_dev="docker run \
                 --rm -it \
                 -p 5000:5000 \
                 -e 'FLASK_ENV=development' \
                 -v ~/Projects/DAAFi:/app daafi sh"

alias daafi_web_dev="docker run \
                     --rm \
                     -p 5000:5000 \
                     -e 'FLASK_ENV=development' \
                     -v ~/Projects/DAAFi:/app daafi"

alias daafi="docker run \
               --rm -d \
               -p 5000:5000 daafi"


###############
# Linux stuff #
###############

if [ "$(uname)" = "Linux" ]; then

  openpdf () {
    okular "$1" 2>/dev/null &
    disown
  };

  openpic () {
    gwenview $1 2>/dev/null &
    disown
  };

  opentxt () {
    kate $1 2>/dev/null &
    disown
  };

  alias backup="$HOME/Projects/scripts/backup.sh"

  check_py () {
    echo "==== flake8 ===="
    flake8 $1
    echo "==== pyflakes ===="
    pyflakes $1
    echo "==== pylint ===="
    pylint $1
  }

  alias mover="python3 ~/Projects/scripts/mover.py"
  alias checker="python3 ~/Projects/scripts/check_tag_integrity.py"
fi

#############
# Mac Stuff #
#############

# Include the platform specific bash_aliases
if [ "$(uname)" = "Darwin" ]; then

  # Shortcut to Textwrangler
  function tw () {
    touch $1;
    open -a /Applications/TextWrangler.app $1
  };

  # Set macports vim as standard
  alias vim="/opt/local/bin/vim"

  # Set macports gcc as standard g++ compiler
  alias g++=g++-mp-7
fi


#################
# Host-specific #
#################


if [ "$(uname -n)" = "lifschitz" ]; then
  alias typora=~/bin/Typora-linux-x64/Typora
fi
