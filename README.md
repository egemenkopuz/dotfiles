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

---

<img src="https://raw.githubusercontent.com/egemenkopuz/egemenkopuz.github.io/master/static/images/ss_split.png">

<div align="center">
<span> (outdated - 20.07.2023) more images </span>
 <a href="https://raw.githubusercontent.com/egemenkopuz/egemenkopuz.github.io/master/static/images/ss_alpha.png">1</a>
 <a href="https://raw.githubusercontent.com/egemenkopuz/egemenkopuz.github.io/master/static/images/ss_lazygit.png">2</a>
 <a href="https://raw.githubusercontent.com/egemenkopuz/egemenkopuz.github.io/master/static/images/ss_telescope.png">3</a>
 <a href="https://raw.githubusercontent.com/egemenkopuz/egemenkopuz.github.io/master/static/images/ss_cmd.png">4</a>
 <a href="https://raw.githubusercontent.com/egemenkopuz/egemenkopuz.github.io/master/static/images/ss_zen.png">5</a>
</div>

# My setup

- editor: neovim >= v0.8
- shell: zsh
- terminal: wezterm
- font: JetBrainsMono Nerd Font
- tools:
  - [antigen](https://github.com/zsh-users/antigen) - zsh plugin manager
  - [p10k](https://github.com/romkatv/powerlevel10k) - zsh theme
  - [lazygit](https://github.com/jesseduffield/lazygit) - git workflow
  - [git-delta](https://github.com/dandavison/delta) - many cool features for git
  - [lazydocker](https://github.com/jesseduffield/lazydocker) - docker workflow
  - [tmux](https://github.com/tmux/tmux) - terminal multiplexer
  - [ripgrep](https://github.com/BurntSushi/ripgrep) - must-have search tool
  - [fzf](https://github.com/junegunn/fzf) - must-have search tool
  - [zoxide](https://github.com/ajeetdsouza/zoxide) - smarter _cd_
  - [exa](https://github.com/ogham/exa) - better _ls_
  - [fd](https://github.com/sharkdp/fd) - better _find_
  - [bat](https://github.com/sharkdp/bat) - better _cat_
  - [duf](https://github.com/muesli/duf) - better _df_
  - [procs](https://github.com/dalance/procs) - better _ps_
  - [tre](https://github.com/dduan/tre) - better _tree_

# Install

The following command clones the repository into .config in home directory and installs all the requirements.

```zsh
$ git clone --depth 1 https://github.com/egemenkopuz/dotfiles.git ${HOME}/.config
$ cd ${HOME}/.config
$ make all
```

**Notice:** to be able to copy and paste properly within WSL, follow [this guide](https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl) -- make sure to create a symlink from windows-side; other method did not work out for me.

## Dev environment on a Docker container

Follow [these instructions](https://docs.docker.com/storage/volumes/) to specificy volumes. Otherwise, you would not be able to reach your projects.

```zsh
$ git clone --depth 1 https://github.com/egemenkopuz/dotfiles.git
$ cd dotfiles
$ docker build -t "dev-env:latest" .
$ docker run --name dev-env -d -it dev-env
```

Accessing the container

```zsh
$ docker exec -it dev-env zsh
```

# Next

- debug setup, DAP, requires finetuning
- task runner plugin, overseer, requires extensive configuration for python and cpp
