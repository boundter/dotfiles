# General aliases
export BOOST_ROOT=$HOME/boost/boost_1_61_0
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -d "$HOME/bin" ] ; then
  export PATH=$HOME/bin:$PATH                                                                                 
fi

if [ "$(uname -n)" = "tolkien" ]; then
  export PATH=$PATH:/usr/local/cuda
fi

if [ "$(uname -n)" = "lifschitz" ]; then
  export LD_LIBRARY_PATH=/lifschitz/teichmann/bin:$LD_LIBRARY_PATH
fi

if [ "$(uname)" = "Darwin" ]; then
  export CXX=g++-mp-7
  export CC=gcc-mp-7
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  # Make pip packages easily accessible
  export PATH=$PATH:/opt/local/bin:/opt/local/Library/Frameworks/Python.framework/Versions/3.6/bin;
  # Always keep two cores free of OMP
  export OMP_NUM_THREADS=$(expr $(sysctl -n hw.ncpu) - 2)
fi

if [ -x "$(command -v gcc-7)" ]; then
  export CC=gcc-7
fi
if [ -x "$(command -v g++-7)" ]; then
  export CXX=g++-7
fi

# Always keep two cores free of OMP
if [ "$(command -v grep)" ] && ! [ "$(uname)" = "Darwin" ]; then
  export OMP_NUM_THREADS=$(expr $(grep -c ^processor /proc/cpuinfo) - 2)
fi

case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
