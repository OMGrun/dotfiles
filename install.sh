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

if command -v apt &>/dev/null; then
    sudo apt update
    sudo apt install -y build-essential git curl ripgrep fd-find neovim tmux
    sudo ln -sf "$(which fdfind)" /usr/local/bin/fd 2>/dev/null || true
    sudo apt install -y nodejs npm
fi

echo "Done, open nvim and wait for lazy to install everything."
