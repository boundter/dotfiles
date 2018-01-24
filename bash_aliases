alias ll=ls -l

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

