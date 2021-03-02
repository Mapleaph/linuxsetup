# Linux Setup

## Essentials

``` bash
# ubuntu
$ sudo apt install git vim automake autoconf exuberant-ctags cmake gcc g++ tmux build-essential libncurses-dev libgl1-mesa-dev isc-dhcp-server tftpd-hpa vsftpd libtool devmem2 qt5-default qtcreator libqt5serialport5-dev libvte-dev libgtk2.0-dev gnome-tweak-tool psensor fwupd snap telegram-desktop fcitx fcitx-pinyin libpam-fprintd axel busybox xclip minicom python3 python3-dev python3-pip python python-dev
## grub-customizer
$ sudo add-apt-repository ppa:danielrichter2007/grub-customizer
$ sudo apt update
$ sudo apt install grub-customizer
## variety wallpaper
$ sudo add-apt-repository ppa:peterlevi/ppa
$ sudo apt update
## For newer versions of Ubuntu, there is no need to add the PPA, just install from apt source
$ sudo apt install variety

# fedora
$ sudo yum install git vim tmux rpm-build ncurses-devel mesa-libGL-devel openssh-server redhat-rpm-config
```
### vsftpd
Edit file `/etc/vsftpd.conf`
``` bash
# uncomment these lines
write_enable=YES
# enable the following two lines will keep users in the chroot_list_file in the chroot_jail
# that is being kept in their own home directory
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd.chroot_list
# add these lines
user_sub_token=$USER
local_root=/home/$USER/ftp
```
Create new user called `ftpuser`
``` bash
sudo useradd -m ftpuser
sudo mkdir /home/ftpuser/ftp
sudo chown nobody:nogroup /home/ftpuser/ftp
# ftpuser should be read-only, otherwise
# "500 OOPS: vsftpd: refusing to run with writable root inside chroot ()"
# error will be prompt when connecting
sudo chmod -R a-w /home/ftpuser/
# Temperarily remove these two lines
#$ sudo mkdir /home/ftpuser/ftp/files
#$ sudo chown ftpuser:ftpuser /home/ftpuser/ftp/files
```
Create a new file `/etc/vsftpd.chroot_list`
``` bash
ftpuser
```
Restart service
``` bash
sudo systemctl restart vsftpd.service
# or
sudo service vsftpd restart
```
### tftpd-hpa

Check file `/etc/default/tftpd-hpa` 

```bash
# /etc/default/tftpd-hpa

TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/srv/tftp"
TFTP_ADDRESS=":69"
TFTP_OPTIONS="--secure"
```

Change default repository permission
``` bash
sudo chmod -R 777 /srv/tftp
```
The `TFTP_DIRECTORY` is `/var/lib/tftpboot` for older versions of Ubuntu.

Add `-c` to `TFTP_OPTIONS="--secure"` to enable file creation:

``` bash
TFTP_OPTIONS="--secure -c"
```
Restart service
``` bash
sudo systemctl restart tftpd-hpa.service
# or
sudo service tftpd-hpa restart
```
### vim

``` bash
git clone https://github.com/mapleaph/vim ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc; cd ~/.vim
git submodule update --init --recursive

# YouCompleteMe
cd bundle/YouCompleteMe
sudo apt install cmake ctags
./install.py --clang-completer
```

### tmux

```bash
git clone https://github.com/mapleaph/tmux
cp tmux/tmux.conf ~/.tmux.conf; rm -rf ./tmux/
```

### other packages

```bash
# ubuntu
sudo apt install tig progress screenfetch
# fedora
sudo yum install tig progress screenfetch
```

## zsh

### oh-my-zsh

``` bash
# ubuntu
sudo apt install zsh
# fedora
sudo yum install zsh util-linux-user

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### zsh-syntax-highlighting plugin

``` bash
# ubuntu
sudo apt install zsh-syntax-highlighting
# fedora
sudo yum install zsh-syntax-highlighting

echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
source ~/.zshrc
```

### powerline-status

#### pip

``` bash
sudo -H pip install -U pip
echo "export PATH=\"\$HOME/.local/bin/:\$PATH\"" >> ~/.zshrc
```

#### powerline-status

``` bash
pip install --user powerline-status
```

#### powerline-fonts

``` bash
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts/; ./install.sh; cd ../; rm -rf ./fonts
sed -i "s/robbyrussell/agnoster/g" ~/.zshrc
```

#### other packages

```bash
pip install --user howdoi magic-wormhole ici ydcv
```

#### Terminal/Terminator

Go to preferences, select **Source Code Pro for powerline Regular**.

## Spacemacs

### Install emacs (Requires emacs > 24.4)

``` bash
# ubuntu 18.04 install emacs27
sudo snap install emacs --beta --classic
# fedora
sudo yum install emacs

git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
```

### Edit .spacemacs to change repository url

``` bash
(defun dotspacemacs/user-init ()
  (setq configuration-layer--elpa-archives
      '(("melpa-cn" . "http://elpa.emacs-china.org/melpa/")
        ("org-cn"   . "http://elpa.emacs-china.org/org/")
        ("gnu-cn"   . "http://elpa.emacs-china.org/gnu/")))
)
```

### No such file or directory bind-map error

Edit .spacemacs file, try to change "dotspacemacs-elpa-timeout 5" to "30", then invoke emacs like this once.

``` bash
emacs --insecure
```

### Change font

Change "Source Code Pro" to "Source Code Pro for powerline" in ~/.spacemacs.

## pyenv

``` bash
# ubuntu
sudo apt install curl
# fedora
sudo yum install curl

curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
echo "export PATH=\"\$HOME/.pyenv/bin/:\$PATH\"" >> ~/.zshrc
echo "eval \"\$(pyenv init -)\"" >> ~/.zshrc
echo "eval \"\$(pyenv virtualenv-init -)\"" >> ~/.zshrc
```

Before install python3, openssl, bzip2, readline, sqlite3 libraries should be installed:

``` bash
# ubuntu
sudo apt install libssl-dev libbz2-dev libreadline-dev libsqlite3-dev
# fedora
sudo yum install openssl-devel bzip2-devel readline-devel sqlite-devel
```

## nodejs

### npm

```bash
# ubuntu
# add nodejs-legacy now for ubuntu16.04.4
sudo apt install npm nodejs-legacy
sudo npm install -g cnpm --registry=https://registry.npm.taobao.org
# fedora
sudo yum install npm
```

### packages

```bash
sudo cnpm install -g vtop rg
```

## Ubuntu Gnome Software Center

Use gnome software center to install applications like pycharm-community and vscode will cause "snapd status code 400" error.

Use snap command to install these applications with classic option.

``` bash
sudo snap install notion-snap typora snap-store-proxy clion cawbird
sudo snap install --classic p3x-onenote
sudo snap install --edge 1password
```

## Terminal Color Theme

``` bash
# ubuntu
sudo apt install dconf-cli

wget -O gogh https://git.io/vQgMr &&chmod +x gogh && ./gogh && rm gogh
```

