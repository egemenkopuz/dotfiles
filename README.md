<h1 align="center"> $ dotfiles </h1>

<div align="center">
    <a href="https://github.com/egemenkopuz/dotfiles/pulse">
      <img alt="Last commit" src="https://img.shields.io/github/last-commit/egemenkopuz/dotfiles?style=for-the-badge&color=F5E0DC&&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/egemenkopuz/dotfiles/stargazers">
      <img alt="Stars" src="https://img.shields.io/github/stars/egemenkopuz/dotfiles?style=for-the-badge&color=F5E0DC&&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/egemenkopuz/dotfiles/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/egemenkopuz/dotfiles?style=for-the-badge&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/egemenkopuz/dotfiles">
      <img alt="Size" src="https://img.shields.io/github/repo-size/egemenkopuz/dotfiles?color=F5E0DC&label=SIZE&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41" />
    </a>
</div>

______________________________________________________________________

# My setup

- editor: neovim nightly
- shell: zsh
- terminal: alacritty
- font: JetBrainsMono Nerd Font

# requirements

- ansible

# Install

The following command clones the repository into .config in home directory and runs the bootstrap playbook.

```zsh
$ git clone --depth 1 https://github.com/egemenkopuz/dotfiles.git ${HOME}/.config
$ cd ${HOME}/.config
$ ansible-playbook -K bootstrap.yml
```
