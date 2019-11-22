#!/bin/bash

# 'All_installed' is used to determine whether or not all everything is installed/
# setup
all_installed="true"
yellow=$'\033[1;33m'
green=$'\033[0;32m'
cyan=$'\033[0;36m'
red=$'\033[1;31m'
nc=$'\033[0m'



# --------- #
# FUNCTIONS #
# --------- #
# TODO: Work on this function, which will be used to used to move .zshrc or
# .bash_profile to the home directory. Two parts of this code will call this function.
add_shell() {
    echo "add shell"
}



# ----------- #
# PREPERATION #
# ----------- #
# Changes the active directory to that of where the executed script is located
cd "$(dirname $0)"

# Sets up file and variables used to tell if particular options have already
# been setup, such as .zshrc and the terminal profile
if [[ ! -f .setup-status.txt ]]; then
    echo "_ZSH_ALIASES=false
_TERM_PROFILE=false" > .setup-status.txt
fi

# Makes the variables in '.setup-status.txt' available to this script
. .setup-status.txt
zsh_aliases=$_ZSH_ALIASES
term_profile=$_TERM_PROFILE

# Since it takes a little to check if something is installed with brew, checking once
# and storing the results in variables makes it easier and takes less time...
if hash brew &>/dev/null; then
    echo -ne "Checking if 'zsh' and 'vim' have been installed..."
    
    if [[ $(brew list zsh &>/dev/null; echo $?) = 0 ]]; then
        brew_zshell="true"
    else
        brew_zshell="false"
    fi
    
    if [[ $(brew list vim &>/dev/null; echo $?) = 0 ]]; then
        brew_vim="true"
    else
        brew_vim="false"
    fi

else
    brew_zshell="false"
    brew_vim="false"
fi



# ---- #
# MAIN #
# ---- #
echo -e "\rWelcome to the 'Mac Terminal Style & Config Setup'\r\n"

while true; do
    # Detects if Command Line Tools are installed
    if [[ $(xcode-select -p &>/dev/null; echo $?) = 0 ]]; then
        echo "1. Install Command Line Tools (must be installed before you can install" \
            "Homebrew) ${green}(Already installed)${nc}"
    else
        echo "1. Install Command Line Tools (must be installed before you can install" \
            "Homebrew) ${red}(Not Installed)${nc}"
    fi
    
    # Checks if Homebrew, zsh, and vim are installed
    if ! hash brew &>/dev/null; then
        echo "2. Install Homebrew (must be installed before installing zsh" \
            "or vim) ${red}(Not installed)${nc}"
        echo "3. Install zsh via Homebrew ${red}(Not installed)${nc}"
        echo "4. Install vim via Homebrew ${red}(Not installed)${nc}"
    else
        echo "2. Install Homebrew (must be installed before installing zsh" \
            "or vim) ${green}(Already installed)${nc}"
        if [[ $brew_vim = "true" ]]; then
            echo "3. Install vim via Homebrew ${green}(Already installed)${nc}"
        else
            echo "3. Install vim via Homebrew ${red}(Not installed)${nc}"
        fi

        if [[ $brew_zshell = "true" ]]; then
            echo "4. Install zsh via Homebrew ${green}(Already installed)${nc}"
        else
            echo "4. Install zsh via Homebrew ${red}(Not installed)${nc}"
        fi
    fi
    
    # Checks if oh my zsh was installed
    if [[ -d ~/.oh-my-zsh/ ]]; then
        echo "5. Install oh my zsh (recommended to install zsh via Homebrew" \
            "first) ${green}(Already installed)${nc}"
    else
        echo "5. Install oh my zsh (recommended to install zsh via Homebrew" \
            "first) ${red}(Not installed)${nc}"
    fi

    # Uses data saved in '.setup-status.txt' to tell if my custome aliases were
    # added to '.zshrc' 
    if [[ $zsh_aliases = "true" ]]; then
        echo "6. Add custom alias to '.zshrc' ${green}(Already added)${nc}"
    else
        echo "6. Add custom alias to '.zshrc' ${red}(Not added)${nc}"
    fi
    
    # Uses data saved in '.setup-status.txt' to tell if the terminal profile
    # has been added
    if [[ $term_profile = "true" ]]; then
        echo "7. Add the Terminal Profile ${green}(Already added)${nc}"
    else
        echo "7. Add the Terminal Profile ${red}(Not added)${nc}"
    fi

    echo "8. Stop and exit script"
    read option
    case $option in
        1)
            clear
            echo "1"
            clear
            ;;
        2)
            clear
            echo "2"
            clear
            ;;
        3)
            clear
            echo "3"
            clear
            ;;
        4)
            clear
            echo "4"
            clear
            ;;
        5)
            clear
            echo "5"
            clear
            ;;
        6)
            clear
            echo "6"
            clear
            ;;
        7)
            clear
            echo "7"
            clear
            ;;
        8)
            echo -e "\nExiting..."
            exit 0
            ;;
        *)
            clear
            echo "${red}Invalid input: '$option' is not a valid option${nc}" >&2
            continue
            ;;
    esac
done