#!/bin/bash

repo_path="." 

neovim_config_path="$HOME/.config/nvim"

# シンボリックリンクを作成
if [ ! -e "$neovim_config_path" ]; then
  echo "$repo_path -> $neovim_config_path"
  ln -s "$(readlink -f $repo_path)" "$neovim_config_path"
else
  echo "$neovim_config_path already exsits!"
fi

if [ ! -e "$HOME/.tmux.conf" ]; then
  echo "$repo_path/.tmux.conf -> $HOME/.tmux.conf"
  ln -s "$(readlink -f $repo_path/.tmux.conf)" "$HOME/.tmux.conf"
else
  echo "$HOME/.tmux.conf already exsits!"
fi

