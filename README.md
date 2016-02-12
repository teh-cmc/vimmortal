# Vimmortal

The vim conf that makes you invincible!

## Install

First, install various dependencies:

```
sudo apt-get update
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    ruby-dev git cmake
```

Then, install `vim` from source:

```
sudo apt-get remove -y vim vim-runtime gvim vim-tiny vim-common vim-gui-common
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=/usr
make -j8
./src/vim --version
sudo make install
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
```

Finally, install `vimmortal`:

```
git clone git@github.com:teh-cmc/vimmortal.git
make -C vimmortal install
```

## Features

I'm too lazy to list all the features, have a look at the [vimrc](.vimrc) file.

## Help

Type `make`.
