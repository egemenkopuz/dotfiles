git clone https://github.com/egemenkopuz/dotfiles.git $HOME/dotfiles

ln -sf $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -sf $HOME/dotfiles/zsh/.zshenv $HOME/.zshenv
ln -sf $HOME/dotfiles/antigen/.antigenrc $HOME/.antigenrc
ln -sf $HOME/dotfiles/p10k/.p10k.zsh $HOME/.p10k.zsh
ln -sf $HOME/dotfiles/git/.gitconfig $HOME/.gitconfig
ln -sf $HOME/dotfiles/tmux/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/nvim $HOME/.config/
