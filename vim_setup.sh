#!/bin/bash

echo '---------------------------- vim installation'
sudo apt update -y
sudo apt upgrade -y

sudo apt remove vim vim-runtime gvim -y

sudo apt install -y libncurses5-dev \
                    libncursesw5-dev \
		    libgnome2-dev \ 
		    libgnomeui-dev \
		    libgtk2.0-dev \
		    libatk1.0-dev \
		    libbonoboui2-dev \
		    libcairo2-dev \
		    libx11-dev \
		    libxpm-dev \
		    libxt-dev \
		    build-essential \
		    python-dev\
		    python3-dev \
		    ruby-dev \
		    lua5.1 \
		    liblua5.1-dev \
		    libperl-dev \
		    git \
		    wget \
		    ctags \
		    cscope \
		    npm

git clone https://github.com/vim/vim.git

cd ./vim

PYTHON2VER=$(python2 --version | awk '{print $2}' | awk -F. '{print $1"."$2}')
PYTHON3VER=$(python3 --version | awk '{print $2}' | awk -F. '{print $1"."$2}')

./configure --with-features=huge \
            --enable-multibyte \
	    --enable-pythoninterp=yes \
	    --with-python-config-dir=/usr/lib/python${PYTHON2VER}/config-x86_64-linux-gnu \
	    --enable-python3interp=yes \
	    --with-python3-config-dir=/usr/lib/python${PYTHON3VER}/config-${PYTHON3VER}m-x86_64-linux-gnu \
	    --enable-perlinterp=yes \
	    --enable-gui=gtk2 \
	    --enable-cscope \
	    --prefix=/usr/local \
	    --with-tlib=ncurses

make VIMRUNTIMEDIR=/usr/local/share/vim/vim81
sudo apt install checkinstall
sudo checkinstall
#spawn "sudo checkinstall"
#expect "Should I create a default set of package docs?  [y]:" {send "\n"}
#expect ">>" {send "\n"}
#expect "Enter a number to change any of them or press ENTER to continue:" {send "\n"}
#expect "Do you want me to list them?  [n]:" {send "\n"}
#expect "Should I exclude them from the package? (Saying yes is a good idea)  [y]:" {send "\n"}
#interact

sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vim vim /usr/local/bin/vim 1
sudo update-alternatives --set vim /usr/local/bin/vim

cd ../

if [ -e .vimrc ]; then
	cp -f .vimrc ~/
else
	echo 'You need .vimrc for installing plugins.'
	exit -1
fi

source ~/.vimrc

echo '---------------------------- Vundle and vim plugin installation'
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +VundleInstall +qall

echo '---------------------------- clang installation'
UBUNTU_VERSION=$(lsb_release -a 2>/dev/null | grep Release | awk '{print $2}')
CLANG_BINARY="clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-${UBUNTU_VERSION}"
wget http://releases.llvm.org/9.0.0/$CLANG_BINARY.tar.xz
xz -d $CLANG_BINARY.tar.xz
tar xf $CLANG_BINARY.tar

echo '---------------------------- YouCompleteMe installation'
DYN=$(vim --version | grep dyn | grep python | wc -l)
if [ $DYN != 2 ]; then
	echo "No python/dyn python3/dyn features in vim!"
	exit -1
fi
mkdir -p ~/ycm_temp/llvm_root_dir
cp -r $CLANG_BINARY/* ~/ycm_temp/llvm_root_dir
cd ~
mkdir ycm_build
cd ycm_build
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_temp/llvm_root_dir . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core
cd ~
mkdir regex_build
cd regex_build
cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/cregex
cmake --build . --target _regex
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --js-completer
