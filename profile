# General aliases
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export PATH=$HOME/scripts:$HOME/.local/bin:$PATH

export LD_LIBRARY_PATH=$HOME/.local:$LD_LIBRARY_PATH

if [ -x "$(command -v gcc-7)" ]; then
  export CC=gcc-7
fi
if [ -x "$(command -v g++-7)" ]; then
  export CXX=g++-7
fi
if [ -x "$(command -v gcc-9)" ]; then
  export CC=gcc-9
fi
if [ -x "$(command -v g++-9)" ]; then
  export CXX=g++-9
fi

case "$-" in *i*) if [ -r $HOME/.bashrc ]; then . $HOME/.bashrc; fi;; esac
