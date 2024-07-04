<h1 align="center"> $ dotfiles </h1>

<div align="center">
    <a href="https://github.com/egemenkopuz/dotfiles/pulse">
        <img alt="last-commit" src="https://img.shields.io/github/last-commit/egemenkopuz/dotfiles?style=for-the-badge&labelColor=3b3b3b"/>
    </a>
    <a href="https://github.com/egemenkopuz/dotfiles/commits/main">
        <img alt="commit-freq" src="https://img.shields.io/github/commit-activity/m/egemenkopuz/dotfiles?style=for-the-badge&labelColor=3b3b3b"/>
    </a>
    <a href="https://github.com/egemenkopuz/dotfiles/stargazers">
        <img alt="star-count" src="https://img.shields.io/github/stars/egemenkopuz/dotfiles?style=for-the-badge&labelColor=3b3b3b"/>
    </a>
    <a href="https://github.com/egemenkopuz/dotfiles/issues">
        <img alt="issue-count" src="https://img.shields.io/github/issues/egemenkopuz/dotfiles?style=for-the-badge&labelColor=3b3b3b"/>
    </a>
    <a href="https://github.com/egemenkopuz/dotfiles">
        <img alt="repo-size" src="https://img.shields.io/github/repo-size/egemenkopuz/dotfiles?style=for-the-badge&labelColor=3b3b3b"/>
    </a>
    <a href="https://github.com/egemenkopuz/dotfiles/actions/workflows/ansible-lint.yml">
        <img alt="ansible-lint" src="https://img.shields.io/github/actions/workflow/status/egemenkopuz/dotfiles/ansible-lint.yml?label=ansible-lint&style=for-the-badge&labelColor=3b3b3b">
    </a>
</div>

# Installation

> \[!IMPORTANT\]
> Currently, only Debian based systems (ex: Ubuntu) are supported. Arch and MacOS are not fully tested, and thus not supported. Support for these systems will be added soon.

## Interactively

You can run the [setup-dotfiles](./scripts//setup-dotfiles.sh) script to setup the dotfiles Interactively.

```zsh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/egemenkopuz/dotfiles/master/scripts/setup-dotfiles.sh)"
```

## Manually

> \[!IMPORTANT\]
> You need to have `git` and `ansible` installed on your system.

The following command clones the repository into .config in home directory.

```zsh
git clone --depth 1 --recursive https://github.com/egemenkopuz/dotfiles.git ${HOME}/.config
cd ${HOME}/.config
```

You can run the following command to use ansible to install the necessary packages.

```zsh
ansible-playbook -K setup.ansible.yml
```

If you would like to use with a docker container, you can run the following commands.

```zsh
docker build -t "dev-env:latest" .
docker run --name dev-env -d -it dev-env
docker exec -it dev-env zsh
```

# Packages

> \[!NOTE\]
> If the system has already installed a package and its version matches the default version, the setup script will skip the installation of that package.

Below is the full list of packages that are installed by the setup script together with their default versions and installation methods.

| Package                                                 | Default Config Version | Debian Supp.               |  Arch Supp.  |        MacOS Supp.         | amd64 Supp.        | arm64 Supp.        |
| :------------------------------------------------------ | :--------------------: | :------------------------- | :----------: | :------------------------: | ------------------ | ------------------ |
| [ansible](https://github.com/ansible/ansible)           |        `latest`        | `via apt`                  | `via pacman` |         `via brew`         | :heavy_check_mark: | :heavy_check_mark: |
| [python](https://www.python.org)                        |        `latest`        | `via apt`                  |    `wip`     |         `via brew`         | :heavy_check_mark: | :heavy_check_mark: |
| [nodejs](https://nodejs.org/en)                         |        `latest`        | `binary`                   |    `wip`     |          `binary`          | :heavy_check_mark: | :heavy_check_mark: |
| [zsh](https://www.zsh.org)                              |        `latest`        | `via apt`                  |    `wip`     |         `built-in`         | :heavy_check_mark: | :heavy_check_mark: |
| [tmux](https://github.com/tmux/tmux)                    |        `latest`        | `via apt`                  |    `wip`     |         `via brew`         | :heavy_check_mark: | :heavy_check_mark: |
| [neovim](https://github.com/neovim/neovim)              |        `stable`        | `binary or compile source` |    `wip`     | `binary or compile source` | :heavy_check_mark: | :heavy_check_mark: |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch) |        `latest`        | `binary or compile source` |    `wip`     |          `binary`          | :heavy_check_mark: | :heavy_check_mark: |
| [ripgrep](https://github.com/BurntSushi/ripgrep)        |        `latest`        | `binary`                   |    `wip`     |          `binary`          | :heavy_check_mark: | :heavy_check_mark: |
| [fzf](https://github.com/junegunn/fzf)                  |        `latest`        | `binary`                   |    `wip`     |          `binary`          | :heavy_check_mark: | :heavy_check_mark: |
| [fd](https://github.com/sharkdp/fd)                     |        `latest`        | `binary`                   |    `wip`     |          `binary`          | :heavy_check_mark: | :heavy_check_mark: |
| [bat](https://github.com/sharkdp/bat)                   |        `latest`        | `binary`                   |    `wip`     |         `via brew`         | :heavy_check_mark: | :heavy_check_mark: |
| [eza](https://github.com/eza-community/eza)             |        `latest`        | `binary`                   |    `wip`     |         `via brew`         | :heavy_check_mark: | :heavy_check_mark: |
| [lazygit](https://github.com/jesseduffield/lazygit)     |        `latest`        | `binary`                   |    `wip`     |          `binary`          | :heavy_check_mark: | :heavy_check_mark: |
| [procs](https://github.com/dalance/procs)               |        `latest`        | `binary`                   |    `wip`     |            :x:             | :heavy_check_mark: | :x:                |
| [delta](https://github.com/dandavison/delta)            |        `latest`        | `binary`                   |    `wip`     |          `binary`          | :heavy_check_mark: | :heavy_check_mark: |
| [btop](https://github.com/aristocratos/btop)            |        `latest`        | `binary`                   |    `wip`     |            :x:             | :heavy_check_mark: | :x:                |
| [zoxide](https://github.com/ajeetdsouza/zoxide)         |        `latest`        | `binary`                   |    `wip`     |          `binary`          | :heavy_check_mark: | :heavy_check_mark: |
| [lf](https://github.com/gokcehan/lf)                    |        `latest`        | `binary`                   |    `wip`     |          `binary`          | :heavy_check_mark: | :heavy_check_mark: |
