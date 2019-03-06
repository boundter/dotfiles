# General aliases
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -d "$HOME/bin" ] ; then
  export PATH=$HOME/bin/scripts:$HOME/bin:$PATH
fi

if [ "$(uname -n)" = "tolkien" ]; then
  export PATH=$PATH:/usr/local/cuda
  export PATH=$HOME/.local/bin:$PATH
  export BOOST_ROOT=$HOME/boost/boost_1_66_0/include
  export LC_ALL="en_US.UTF-8"
  export LD_LIBRARY_PATH=/home/eteichma/bin:$LD_LIBRARY_PATH
  export MKUR_DATA=/home/eteichma/Projects/physics/m-kuramoto-sakaguchi/data
  export PYTHONPATH=/home/eteichma/Projects/physics/m-kuramoto-sakaguchi/lib:$PYTHONPATH
fi

if [ "$(uname -n)" = "lifschitz" ]; then
  export BOOST_ROOT=$HOME/boost/include
  export LD_LIBRARY_PATH=/lifschitz/teichmann/bin:/lifschitz/teichmann/bin/lib64:$LD_LIBRARY_PATH
  export MKUR_DATA=/lifschitz/teichmann/Projects/m-kuramoto-sakaguchi/data
  export PYTHONPATH=/lifschitz/teichmann/Projects/m-kuramoto-sakaguchi/lib:$PYTHONPATH
fi

if [ "$(uname)" = "Darwin" ]; then
  export BOOST_ROOT=$HOME/boost/include
  export CXX=g++-mp-7
  export CC=gcc-mp-7
  export PATH=/opt/local/bin:/opt/local/sbin:/$HOME/Library/Python/3.6/bin:$PATH
  # Make pip packages easily accessible
  export PATH=/opt/local/bin:/opt/local/Library/Frameworks/Python.framework/Versions/3.6/bin:$PATH;
  # Always keep two cores free of OMP
  export OMP_NUM_THREADS=$(expr $(sysctl -n hw.ncpu) - 2)
  # Projects
  export MKUR_DATA=~/Projects/m-kuramoto-sakaguchi/data
  export XMKUR_DATA=~/Projects/extended_m_kuramoto_sakaguchi/data
  export PYTHONPATH=$PYTHONPATH:~/Projects/m-kuramoto-sakaguchi/lib:~/Projects/extended_m_kuramoto_sakaguchi/lib
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
