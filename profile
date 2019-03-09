# General aliases
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export PATH=$HOME/scripts:$HOME/.local/bin:$PATH

if [ "$(uname -n)" = "lifschitz" ]; then
  export BOOST_ROOT=$HOME/boost/include
  export LD_LIBRARY_PATH=/lifschitz/teichmann/bin:/lifschitz/teichmann/bin/lib64:$LD_LIBRARY_PATH
  export MKUR_DATA=/lifschitz/teichmann/Projects/m-kuramoto-sakaguchi/data
  export PYTHONPATH=/lifschitz/teichmann/Projects/m-kuramoto-sakaguchi/lib:$PYTHONPATH
fi

if [ -x "$(command -v gcc-7)" ]; then
  export CC=gcc-7
fi
if [ -x "$(command -v g++-7)" ]; then
  export CXX=g++-7
fi

case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
