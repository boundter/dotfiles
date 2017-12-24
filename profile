# General aliases
export BOOST_ROOT=$HOME/boost/boost_1_61_0
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ "$(uname)" = "Darwin" ]; then
  export CXX=g++-mp-7
  export CC=gcc-mp-7
  # Make pip packages easily accessible
  export PATH=$PATH:/opt/local/bin:/opt/local/Library/Frameworks/Python.framework/Versions/3.6/bin;
fi

case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
