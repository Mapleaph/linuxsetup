# Linux Setup

## Essentials

``` bash
# ubuntu
$ sudo apt-get install git vim tmux build-essential libncurses-dev libgl1-mesa-dev openssh-server isc-dhcp-server tftpd-hpa vsftpd ibus-sunpinyin libtool
## grub-customizer
$ sudo add-apt-repository ppa:danielrichter2007/grub-customizer
$ sudo apt-get update
$ sudo apt-get install grub-customizer
## variety wallpaper
$ sudo add-apt-repository ppa:peterlevi/ppa
$ sudo apt-get update
$ sudo apt-get install variety

# fedora
$ sudo yum install git vim tmux rpm-build ncurses-devel mesa-libGL-devel openssh-server redhat-rpm-config
```
### vsftpd
Edit file /etc/vsftpd.conf
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
Create new user called ftpuser
``` bash
$ sudo adduser ftpuser
$ sudo mkdir /home/ftpuser/ftp
$ sudo chown nobody:nogroup /home/ftpuser/ftp
# ftpuser should be read-only, otherwise
# "500 OOPS: vsftpd: refusing to run with writable root inside chroot ()"
# error will be prompt when connecting
$ sudo chmod -R a-w /home/ftpuser/
$ sudo mkdir /home/ftpuser/ftp/files
$ sudo chown ftpuser:ftpuser /home/ftpuser/ftp/files
```
Create a new file /etc/vsftpd.chroot_file
``` bash
ftpuser
```
Restart service
``` bash
$ sudo systemctl restart vsftpd.service
```
### tftpd-hpa
Change default repository permission
``` bash
$ sudo chmod -R 777 /var/lib/tftpboot
```
Edit file /etc/default/tftpd-hpa
``` bash
# add -c to enable file creation
TFTP_OPTIONS="--secure -c"
```
Restart service
``` bash
$ sudo systemctl restart tftpd-hpa.service
```
### vim

``` bash
$ git clone https://github.com/mapleaph/vim ~/.vim
$ ln -s ~/.vim/vimrc ~/.vimrc; cd ~/.vim
$ git submodule update --init --recursive

# YouCompleteMe
$ cd bundle/YouCompleteMe
$ sudo apt-get install cmake ctags
$ ./install.py --clang-completer
```

### tmux

```bash
$ git clone https://github.com/mapleaph/tmux
$ cp tmux/tmux.conf ~/.tmux.conf; rm -rf ./tmux/
```

### other packages

```bash
# ubuntu
$ sudo apt-get install tig progress screenfetch
# fedora
$ sudo yum install tig progress screenfetch
```

## zsh

### oh-my-zsh

``` bash
# ubuntu
$ sudo apt-get install zsh
# fedora
$ sudo yum install zsh util-linux-user

$ sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
$ exit
$ chsh -s $(which zsh)
```

### zsh-syntax-highlighting plugin

``` bash
# ubuntu
$ sudo apt-get install zsh-syntax-highlighting
# fedora
$ sudo yum install zsh-syntax-highlighting

$ echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
```

### powerline-status

#### pip

``` bash
# ubuntu
$ sudo apt-get install python-pip python-dev
# fedora
$ sudo yum install python-pip python-devel python3-devel

$ pip install --upgrade pip
$ echo "export PATH=\"\$HOME/.local/bin/:\$PATH\"" >> ~/.zshrc
```

#### powerline-status

``` bash
$ pip install --user powerline-status
```

#### powerline-fonts

``` bash
$ git clone https://github.com/powerline/fonts.git --depth=1
$ cd fonts/; ./install.sh; cd ../; rm -rf ./fonts
$ sed -i "s/robbyrussell/agnoster/g" ~/.zshrc
```

#### other packages

```bash
$ pip install --user howdoi magic-wormhole ici ydcv
```

#### Terminal/Terminator

Go to preferences, select **Source Code Pro for powerline Regular**.

## Spacemacs

### Install emacs (Requires emacs > 24.4)

``` bash
# ubuntu
$ sudo apt-get install emacs
# fedora
$ sudo yum install emacs

$ git clone https://github.com/syl20bnr/spacemacs~/.emacs.d
```

### Edit .spacemacs to change repository url

``` bash
(defun dotspacemacs/user-init ()
	(setq-default
		configuration-layer-elpa-archives
		(("melpa-cn" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
		("gnu-cn" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
		("org-cn" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))
)
```

### No such file or directory bind-map error

Edit .spacemacs file, try to change "dotspacemacs-elpa-timeout 5" to "30", then invoke emacs like this once.

``` bash
$ emacs --insecure
```

### Change font

Change "Source Code Pro" to "Source Code Pro for powerline" in ~/.spacemacs.

## pyenv

``` bash
# ubuntu
$ sudo apt-get install curl
# fedora
$ sudo yum install curl

$ curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
$ echo "export PATH=\"\$HOME/.pyenv/bin/:\$PATH\"" >> ~/.zshrc
$ echo "eval \"\$(pyenv init -)\"" >> ~/.zshrc
$ echo "eval \"\$(pyenv virtualenv-init -)\"" >> ~/.zshrc
```

Before install python3, openssl, bzip2, readline, sqlite3 libraries should be installed:

``` bash
# ubuntu
$ sudo apt-get install libssl-dev libbz2-dev libreadline-dev libsqlite3-dev
# fedora
$ sudo yum install openssl-devel bzip2-devel readline-devel sqlite-devel
```

## nodejs

### npm

```bash
# ubuntu
# add nodejs-legacy now for ubuntu16.04.4
$ sudo apt-get install npm nodejs-legacy
# fedora
$ sudo yum install npm
```

### packages

```bash
$ sudo npm install -g vtop rg
```

## Ubuntu Gnome Software Center

Use gnome software center to install applications like pycharm-community and vscode will cause "snapd status code 400" error.

Use snap command to install these applications with classic option.

``` bash
$ sudo snap install vscode --classic
```

## Terminal Color Theme

``` bash
# ubuntu
$ sudo apt-get install dconf-cli

$ wget -O gogh https://git.io/vQgMr &&chmod +x gogh && ./gogh && rm gogh
```

