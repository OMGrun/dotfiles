#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

ln -sfn "$PWD/tmux/.tmux.conf" ~/.tmux.conf
ln -sfn "$PWD/tmux/.tmux"        ~/.tmux
ln -sfn "$PWD/shell/.zshrc"       ~/.zshrc
ln -sfn "$PWD/bash/.bash_profile" ~/.bash_profile

mkdir -p ~/.config
for app in nvim ghostty aerospace; do
  ln -sfn "$PWD/config/$app" ~/.config/"$app"
done

echo "Done! Symlinks created."
