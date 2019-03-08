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

alias pages="docker run --rm -v ${PWD}:/srv/jekyll -p 4000:4000 boundter/github-pages jekyll serve"

alias flask_docker="docker run --rm -v ${PWD}:/app -p 80:80 tiangolo/uwsgi-nginx-flask"

alias flask_test="docker run --rm -t -v ${PWD}:/app boundter/flask-pytest"

check_py () {
  echo "==== flake8 ===="
  flake8 --ignore=D103 --exclude=__init__.py $1
  echo "==== pyflakes ===="
  pyflakes $1
  echo "==== pylint ===="
  pylint --disable=C0111,E0401 $1
}

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
