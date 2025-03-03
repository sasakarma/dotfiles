#!/bin/bash

repo_path="." 

neovim_config_path="$HOME/.config/nvim"

# シンボリックリンクを作成
mkdir -p "$neovim_config_path"
if [ ! -e "$neovim_config_path/init.lua" ]; then
  echo "$repo_path/init.lua -> $neovim_config_path/init.lua"
  ln -s "$(readlink -f $repo_path/init.lua)" "$neovim_config_path/init.lua"
else
  echo "$neovim_config_path/init.lua already exsits!"
fi

if [ ! -e "$HOME/.tmux.conf" ]; then
  echo "$repo_path/.tmux.conf -> $HOME/.tmux.conf"
  ln -s "$(readlink -f $repo_path/.tmux.conf)" "$HOME/.tmux.conf"
else
  echo "$HOME/.tmux.conf already exsits!"
fi

