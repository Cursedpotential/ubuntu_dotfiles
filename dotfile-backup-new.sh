#!/bin/bash


# check to see is git command line installed in this machine
IS_GIT_AVAILABLE="$(git --version)"
if [[ $IS_GIT_AVAILABLE == *"version"* ]]; then
  echo "Git is Available"
else
  echo "Git is not installed"
  exit 1
fi


# copy Vs-Code files
rsync -hvr $HOME/.config/Code/User/*.json .config/Code/User/
# copy snippets folder
rsync -hvr $HOME/.config/Code/User/snippets .config/Code/User/
# copy list of extensions that currently installed
code --list-extensions | xargs -L 1 echo code --install-extension > vscode.extensions

# copy other dot files 
rsync -hvr $HOME/{.*rc,.profile} .
#cp  $HOME/.config{}
rsync -hvr $HOME/.config/fish .config/
rsync -hvr $HOME/.config/neofetch/neofetch.conf .config/neofetch/
rsync -hvr $HOME/.config/nvim/init.vim .config/nvim/




# Check git status
gs="$(git status | grep -i "modified")"
# echo "${gs}"

# If there is a new change
if [[ $gs == *"modified"* ]]; then
  echo "push"
fi


# push to Github
git add -A;
git commit -m "New backup `date +'%Y-%m-%d %H:%M:%S'`";
git push origin main
