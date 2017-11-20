# Ubuntu Setup

## Essentials

``` bash
$ sudo apt-get install git vim build-essential libncurses-dev libgl1-mesa-dev openssh-server
```

### vim

``` bash
$ git clone https://github.com/mapleaph/vim
$ cp vim/vimrc ~/.vimrc
$ cd ../
$ rm -r vim/
```

## Zsh

### oh-my-zsh

``` bash
$ sudo apt-get install zsh
$ sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
$ chsh -s $(which zsh)
```

### zsh-syntax-highlighting plugin

``` bash
$ sudo apt-get install zsh-syntax-highlighting
$ echo "source/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
```

### powerling-status

#### pip

``` bash
$ sudo apt-get install python-pip python-dev
$ pip install --upgrade pip
```

#### powerline-status

``` bash
$ pip install --user powerline-status
# or
$ sudo pip install powerline-status
```

#### powerline-fonts

``` bash
$ git clone https://github.com/powerline/fonts.git --depth=1
$ cd fonts/
$ ./install.sh
```

#### Terminal/Terminator

Go to preferences, select **Source Code Pro for powerline Regular**.

 ## Spacemacs

### Install emacs (Requires emacs > 24.4)

``` bash
$ sudo apt-get install emacs
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

Change "Source Code Pro" to "Source Code Pro for Powerline" in ~/.spacemacs.

## pyenv

``` bash
$ curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer| bash
```

Before install python3, openssl library should be installed:

``` bash
$ sudo apt-get install libssl-dev
```

bz2, readline, sqlite3 libraries should also be installed:

``` bash
$ sudo apt-get install libbz2-dev libreadline-dev libsqlite3-dev
```

## Gnome Software Center

Use gnome software center to install applications like pycharm-community and vscode will cause "snapd status code 400" error.

Use snap command to install these applications with classic option.

``` bash
$ sudo snap install vscode --classic
```

## Terminal Color Theme

``` bash
$ sudo apt-get install dconf-cli
$ wget -O gogh https://git.io/vQgMr &&chmod +x gogh && ./gogh && rm gogh
```