#!/usr/bin/env sh


install_essential() {
    apt update && \
        apt install git vim tmux build-essential libncurses-dev libgl1-mesa-dev openssh-server libtool libssl-dev libvte-dev automake autoconf `check-language-support -l zh-hans` `check-language-support -l en` zsh zsh-syntax-highlighting python-pip python-dev python3-pip python3-dev curl libbz2-dev libreadline-dev libsqlite3-dev
    pip install -U pip
    pip3 install -U pip3
}

install_ohmyzsh() {
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    exit
    chsh -s $(which zsh)
    echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
}

install_nvidia() {
    apt-add-repository ppa:graphics-drivers/ppa
    ubuntu-drivers autoinstall
}

install_essential
install_ohmyzsh
