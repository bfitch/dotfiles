# dotfiles
They're good enough®

#### Setup symlinks

- Clone repo into home directory
- Link home dir `~/.vimrc` to the repo's `.vimrc`:
```
  ln -s ~/dotfiles/.vimrc ~/.vimrc
```
- Link home dir `~/.bash_profile` to the repo's `.bash_profile`:
```
  ln -s ~/dotfiles/.bash_profile ~/.bash_profile`
```
- Link vimscripts:
```
  ln -s ~/dotfiles/.vim/bundle/* ~/.vim/bundle/*
```
*Note*: ln -s [original_file] [link]

#### Install Bash Completion
```
  brew install bash-completion
```

#### Setup Vundle
- If not already installed: `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
- Launch vim and run `:PluginInstall`
