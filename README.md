# dotfiles
#### bash, vim dotfiles, and other stuff

1. Clone repo into home directory
2. Link home dir `~/.vimrc` to the repo's `.vimrc`:
```
  ln -s ~/dotfiles/.vimrc ~/.vimrc
```
3. Link home dir `~/.bash_profile` to the repo's `.bash_profile`:
```
  ln -s ~/dotfiles/.bash_profile ~/.bash_profile`
```
4. Link vimscripts:
```
  ln -s ~/dotfiles/.vim/bundle/* ~/.vim/bundle/*
```
*Note*: ln -s [original_file] [link]
