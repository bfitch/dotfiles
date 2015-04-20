# dotfiles
#### bash, vim dotfiles, and other stuff

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
