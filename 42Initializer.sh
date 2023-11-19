#!/bin/bash

# ANSI color codes
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

BOLD_BLACK='\033[1;30m'
BOLD_RED='\033[1;31m'
BOLD_GREEN='\033[1;32m'
BOLD_YELLOW='\033[1;33m'
BOLD_BLUE='\033[1;34m'
BOLD_MAGENTA='\033[1;35m'
BOLD_CYAN='\033[1;36m'
BOLD_WHITE='\033[1;37m'

RESET='\033[0m'

###########################################
#           Install Functions             #
###########################################

function create_ssh_key() {
  echo -e "${BOLD_CYAN}Creating SSH Key...${RESET}"
  ssh-keygen -t rsa
}

# Function to install ohmyzsh
function install_ohmyzsh() {
  echo -e "${BOLD_CYAN}Installing ohmyzsh...${RESET}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# Function to install Homebrew
function install_homebrew() {
  echo -e "${BOLD_CYAN}Installing Homebrew...${RESET}"
  mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
  if [ $? -ne 0 ]; then
    return
  fi
  echo -e "export PATH=\$HOME/homebrew/bin:\$PATH" >> $HOME/.zshrc
  echo -e "${BOLD_YELLOW}Installation complete!${RESET}"

  echo -e "Do you want to restart the terminal to use the 'brew' command right now?"
  echo -e "${BOLD_RED}Note: If you don't restart the terminal, you won't be able to install Homebrew dependencies until you do.${RESET}"
  read -p "Restart the terminal? (y/n): " restart_choice

  if [ "$restart_choice" == "y" ]; then
    echo -e "You will need to re-execute the script."
    echo -e "Reloading..."
    exec zsh
  else
    echo -e "${BOLD_RED}If you change your mind, restart the terminal and run the script again.${RESET}"
  fi
}

# Function to install cmake with brew
function install_cmake() {
  echo -e "${BOLD_CYAN}Installing cmake with brew...${RESET}"
  brew install cmake
}

# Function to install glfw with brew
function install_glfw() {
  echo -e "${BOLD_CYAN}Installing glfw with brew...${RESET}"
  brew install glfw
}

# Function to install valgrind with brew
function install_valgrind() {
  echo -e "${BOLD_CYAN}Installing valgrind with brew...${RESET}"
  brew tap LouisBrunner/valgrind && brew install --HEAD LouisBrunner/valgrind/valgrind
}

function install_ccleaner42() {
  git clone https://github.com/ombhd/Cleaner_42
  if [ $? -eq 0 ]; then
    chmod +x Cleaner_42/CleanerInstaller.sh
    cd Cleaner_42
    ./CleanerInstaller.sh
    cd ..
  else
    echo "Error: Git clone failed. Exiting."
  fi
}

# Function to add alias for opening VSCode to .zshrc
function add_vscode_alias() {
  echo -e "${BOLD_CYAN}Adding VSCode alias to .zshrc...${RESET}"
  echo -e "alias code=\"open -a 'Visual Studio Code'\"" >> $HOME/.zshrc
}


###########################################
#             Print Function              #
###########################################

function printTitle() {
  echo -e "${BOLD_YELLOW} ---------------------------------------------------------"
  echo -e "|  _  _ ___    _____       _ _   _       _ _              |"
  echo -e "| | || |__ \  |_   _|     (_) | (_)     | (_)             |"
  echo -e "| | || |_ ) |   | |  _ __  _| |_ _  __ _| |_ _______ _ __ |"
  echo -e "| |__   _/ /    | | | '_ \| | __| |/ _\` | | |_  / _ \ '__||"
  echo -e "|    | |/ /_   _| |_| | | | | |_| | (_| | | |/ /  __/ |   |"
  echo -e "|    |_|____| |_____|_| |_|_|\__|_|\__,_|_|_/___\___|_|   |"
  echo -e "|                                                         |"
  echo -e " ---------------------------------------------------------${RESET}"
}

function printMenu() {
    printTitle
    echo -e "${BOLD_CYAN}Where would you like to install dependencies?"
    echo -e "Type the number corresponding to your choice:${RESET}"
    echo -e "  ${BOLD_GREEN}1 - [Home Directory]: $HOME${RESET}"
    echo -e "  ${BOLD_BLUE}2 - [Current Directory]: $PWD${RESET}"
    echo -e "${BOLD_YELLOW}It is typically recommended to install dependencies in ${BOLD_GREEN}[Home Directory]${RESET}"
}

function printEndMessage {
  echo -e "${BOLD_MAGENTA} ----------------------------------- "
  echo -e "|    FINISHED INITIALIZING SESSION    |"
  echo -e " ----------------------------------- ${RESET}"
}

function printGithubMessage() {
  printEndMessage
  echo -e "${BOLD_GREEN}***************************************************"
  echo -e "*                                                 *"
  echo -e "*    If you enjoyed using this script, don't      *"
  echo -e "*        forget to leave a ⭐️ on GitHub !         *"
  echo -e "*                                                 *"
  echo -e "*          https://github.com/Jalevesq            *"
  echo -e "*                                                 *"
  echo -e "***************************************************${RESET}"
}

function printDirectory() {
  local commands=""
  if [ $1 -eq 1 ] || [ $1 -eq 0 ]; then
    commands="Installing in ${BOLD_GREEN}[Home Directory]: $HOME${RESET}"
  elif [ $1 -eq 2 ]; then
    commands="Installing in ${BOLD_BLUE}[Current Directory]: $PWD${RESET}."
  else
    commands="[Error]"
  fi
  clear
  printTitle
  echo -e "$commands"
}

###########################################
#           Secondary Functions           #
###########################################

function handle_empty_variable() {
    echo -e "Error: $1 is not set in the environment."
    echo -e "Please refresh your terminal and execute the script again."
    echo -e "Exiting..."
    exit 1
}

function ask_install() {
  while true; do
    read -p "$(echo -e "${BOLD_CYAN}Do you want to ${RESET}${BOLD_MAGENTA}[$1]${BOLD_CYAN}? (y/n): ${RESET}")" response
    case $response in
      [Yy])
        return 0
        ;;
      [Nn])
        return 1
        ;;
      *)
        echo -e "${BOLD_RED}Invalid input. Please enter 'y' or 'n'.${RESET}"
        ;;
    esac
  done
}

function pwd_is_not_home() {
    printMenu
    while [ 1 ]; do
      read -p "$(echo -e "Enter ${BOLD_GREEN}1${RESET} or ${BOLD_BLUE}2${RESET}: ")" directory_choice
      if [[ $directory_choice == "1" ]]; then
          cd "$HOME" || { echo -e "Error: Home directory not found. Exiting."; exit 1; }
          echo -e "Installing in ${BOLD_GREEN}[Home Directory]: $HOME${RESET}"
          return 1
      elif [[ $directory_choice == "2" ]]; then
          echo -e "Installing in ${BOLD_BLUE}[Current Directory]: $PWD${RESET}."
          return 2
      else
          clear
          printMenu
          echo -e "${BOLD_RED}Invalid choice.${RESET}"
      fi
    done
}

###########################################
#            Primary Functions            #
###########################################

function install_all() {

  functions_to_install=(
    create_ssh_key
    install_ohmyzsh
    install_homebrew
    install_cmake
    install_glfw
    install_valgrind
    add_vscode_alias
    install_ccleaner42
  )
  for func in "${functions_to_install[@]}"; do
    program_name=$(echo "$func" | tr '_' ' ')
    if ask_install "$program_name"; then
      $func
      echo -e ${BOLD_GREEN}"--- Finished Installing $program_name ---${RESET}"
    fi
  done
  printGithubMessage
}

function ask_directory() {
  clear
  if [ -z "$PWD" ]; then
    handle_empty_variable "PWD"
  elif [ -z "$HOME" ]; then
    handle_empty_variable "HOME"
  fi

  if [ "$PWD" != "$HOME" ]; then
    pwd_is_not_home
    return $?
  fi
  return 0
}


function main() {
  ask_directory
  printDirectory $?
  install_all
  cd $HOME
}

main