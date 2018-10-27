#!/bin/bash

#---Author: Anthony Rodriguez
#---Created Date: 10/04/2018
#---Project Tag: linux, utility, bash
#---Purpose:
#   The purpose of this script is to setup the current machine
#   with preferences, including the following:
#    - Adding mrmachine user to sudoer file
#    - package management maintenance
#    - change default shell to zsh
#    - implement oh-my-zsh shell custom preferences
#--->

# Defining variables
#user=$(whoami)
#PASSWD=123456
#ROOTPASSWD=987654

# Adding new sudoer
#useradd $USER
#passwd $PASSWD
#su root; echo "$ROOTPASSWD" && sudo echo "${user}" ALL=(ALL)       ALL' | sudo tee -a ~/Desktop/sample_sudoer_file.txt


# Update and upgrade package lists
apt-get update && apt-get upgrade && apt-get check && apt-get -f install

# Install packages and clean up unused packages 
#apt-get install curl git hub 
#apt-get autoclean && apt-get autoremove

# Add zsh to /etc/shells
command -v zsh | sudo tee -a /etc/shells

# User chsh to set the shell to zsh
sudo chsh -s "$(command -v zsh)" "${USER}"

# Change working directory to home directory and install oh-my-zsh from github
cd; sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"; echo "exit"

# execute git clone of mrmachine3/preferences
cd; git clone https://github.com/mrmachine3/preferences.git

# check if original .zshrc file exists and save copy of dotfile by appending .orig to filename
file1=".zshrc"
if [ -e "$file1" ]
then
    echo "$file1 found!" && mv ~/.zshrc ~/.zshrc.orig && cp ~/preferences/.zshrc_master ~/.zshrc
else
    echo "$file1 not found" && cp ~/preferences/.zshrc_master ~/.zshrc
fi

# check if original .bashrc file exists and save a copy of dotfile by appending .orig to filename
file2=".bashrc"
if [ -e "$file2" ]
then 
    echo "$file2 found!" && mv ~/.bashrc ~/.bashrc.orig && cp ~/preferences/.zshrc_master ~/.zshrc
else
    echo "$file2 not found" && cp ~/preferences/.zshrc_master ~/.zshrc

# move theme file to .oh-my-zsh themes folder
cd ~/preferences; cp ./linux_machinemode.zsh-theme ~/oh-my-zsh/themes/machinemode.zsh-theme
cd; source ./.zshrc

#TO DO LIST
# MOVE OR CREATE SYMLINK TO MACHINEMODE-THEME FILE (FROM PREFERENCES GIT REPOSITORY) INTO THE THEMES FOLDER OF OH-MY-ZSH DIRECTORY
# MOVE OR CREATE SYMLINK TO .ZSHRC FILE FROM PREFERENCES GIT REPOSITORY
# ADD WIFI REBOOTER COMMANDS
# 
