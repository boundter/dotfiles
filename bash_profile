# General aliases
alias datasci="docker run -it -v $PWD:/workplace -p 8888:8888 -e \
DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro boundter:data-science"

#######
# C++ #
#######

# Create a new .cpp file with a corresponding header
function new_cpp_with_header(){
  echo "#include \"$1.h\"" > $1.cpp
  python ~/Projects/Scripts/header.py $1 > $1.h
}

##########
# Docker #
##########

# Open data-science notebook docker at directory
datasci-notebook () {
  docker run -it -v $1:/home/eteichma/work -p 8888:8888 -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro data_science:base
}

# Open data-science terminal docker at directory
datasci-term () {
  docker run -it -v $1:/home/eteichma/work -p 8888:8888 -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro data_science:base bash
}

######################
# Applications (Job) #
######################

# Create a new application with templates for the CV and so on
create_new_application () {
  mkdir $1
  cd $1
  cp ~/Templates/Bewerbungen/* .
  touch timeline.txt
}

# Generates a new application as one compact pdf and all the parts for
# themselves.
# -l generate letter
# -e in english
# -t generate title page
# -m generate motivation
# -c compile all into one pdf
generate_application () {
  LETTER=false
  ENGLISH=false
  TITLE=false
  COMPILATION=false
  MOTIVATION=false
  PIC=false
  FILES=""
  while getopts "letcmp" o; do
    case "${o}" in
      l) LETTER=true;;
      e) ENGLISH=true;;
      t) TITLE=true;;
      c) COMPILATION=true;;
      m) MOTIVATION=true;;
      p) PIC=true;;
    esac
  done
  if [ $LETTER = true ]; then
    latexmk --pdf contact.tex
    latexmk -c contact.tex
    FILES="$FILES contact.pdf"
  fi
  if [ $TITLE = true ]; then
    latexmk --pdf title.tex
    latexmk -c title.tex
    FILES="$FILES title.pdf"
  fi
  if [ $ENGLISH = true ]; then
    if [ $PIC = true ]; then
      latexmk --pdf ../CV/cv_eng_pic.tex
      latexmk -c ../CV/cv_eng_pic.tex
      FILES="$FILES cv_eng_pic.pdf"
    else
      latexmk --pdf ../CV/cv_eng.tex
      latexmk -c ../CV/cv_eng.tex
      FILES="$FILES cv_eng.pdf"
    fi
  else
    if [ $PIC = true ]; then
      latexmk --pdf ../CV/cv_pic.tex
      latexmk -c ../CV/cv_pic.tex
      FILES="$FILES cv_pic.pdf"
    else
      latexmk --pdf ../CV/cv.tex
      latexmk -c ../CV/cv.tex
      FILES="$FILES cv.pdf"
    fi
  fi
  if [ $MOTIVATION = true ]; then
    latexmk --pdf motivation.tex
    latexmk -c motivation.tex
    FILES="$FILES motivation.pdf"
  fi
  if [ $ENGLISH = true ]; then
    FILES="$FILES ../references/references_eng.pdf"
  else
    FILES="$FILES ../references/references.pdf"
  fi
  if [ $COMPILATION = true ]; then
    pdftk $FILES output bewerbung_`basename $PWD`.pdf
  fi
  OPTIND=1
}

###############
# Linux stuff #
###############

# Useful shortcuts
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

alias pip3.6="python3.6 -m pip"
fi

#############
# Mac Stuff #
#############

# Include the platform specific bash_aliases
if [ "$(uname)" = "Darwin" ]; then
  . ~/.bashrc;
  
  # Function to show the current directory in the title of the terminal
  function tab_title {
   echo -n -e "\033]0;${PWD##*/}\007"
  };

  PROMPT_COMMAND="tab_title ; $PROMPT_COMMAND";

  # Set macports python as standard
  # alias python="/opt/local/bin/python3.6"

  # Make pip packages easily accessible
  export PATH=$PATH:/opt/local/bin:/opt/local/Library/Frameworks/Python.framework/Versions/3.6/bin;

  # Shortcut to Textwrangler
  function tw () {
    touch $1;
    open -a /Applications/TextWrangler.app $1
  };
fi

