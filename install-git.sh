gitinstall() {
  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e
 
  printf "${BLUE}Installing Git...${NORMAL}\n"
  if [ ! -f ~/.gitconfig ]; then
    curl -s https://raw.githubusercontent.com/jig/myubuntu/master/gitconfig/.gitconfig > ~/.gitconfig
  fi
  
  sudo apt-get -y install software-properties-common
  sudo add-apt-repository -y ppa:git-core/ppa
  sudo apt-get -y update
  curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
  sudo apt-get -y install git git-lfs subversion
  git lfs install
}

# Check if reboot is needed
gitinstall
