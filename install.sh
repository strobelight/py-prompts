#!/bin/bash

ROOT_DIR=$HOME/.py-prompts
rm -rf $ROOT_DIR

rc_add() {
  name=$1
  echo -e ".bashrc detected. updating \033[1;33mPATH\033[0m variable and exporting it through $HOME/$name"
  echo -e "export PATH=$PATH:$(pwd)/.py-prompts" >> $HOME/$name
  echo -e "\033[1;33mpy-prompts\033[0m is now installed on your machine."
}

if [ -d themes ]; then
    echo -e "Copy themes to $ROOT_DIR/themes"
    mkdir -p $ROOT_DIR
    cp -R themes $ROOT_DIR
else
    echo -e "Cloning repository: \033[1;33mhttps://github.com/arpitbbhayani/py-prompts\033[0m at $HOME/.bashrc"
    git clone https://github.com/arpitbbhayani/py-prompts $ROOT_DIR 2> /dev/null
fi

if [ -f $HOME/.bashrc ]; then
  grep -q ".py-prompts" $HOME/.bashrc
  if [ $? -ne 0 ]; then
    rc_add .bashrc
  else
    echo -e "\033[0;34mpy-prompts is already installed.\033[0m"
  fi
elif [ -f $HOME/.zshrc ]; then
  grep -q ".py-prompts" $HOME/.zshrc
  if [ $? -ne 0 ]; then
    rc_add .zshrc
  else
    echo -e "\033[0;34mpy-prompts is already installed.\033[0m"
  fi
else
  echo ""
  echo -e "\033[0;31mCould not detect your rc file. kindly add the following line in your rc file.\033[0m"
  echo ""
  echo -e "\033[0;34mexport PATH=$PATH:$HOME/.py-prompts\033[0m"
fi
