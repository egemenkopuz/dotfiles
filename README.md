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
    <a href="">
        <img alt="GitHub Actions Workflow Status" src="https://img.shields.io/github/actions/workflow/status/egemenkopuz/dotfiles/ansible-lint.yml?branch=dev&style=for-the-badge&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41&label=ansible-lint" />
    </a>
</div>

# Installation

The following command clones the repository into .config in home directory.

```zsh
git clone --depth 1 https://github.com/egemenkopuz/dotfiles.git ${HOME}/.config
cd ${HOME}/.config
```

You can run the following command to use ansible to install the necessary packages.

```zsh
ansible-playbook -K setup.ansible.yml --extra-vars "git_user_name='your_name' git_user_email='your_email'"
```

If you would like to install inside a container, you can use the following commands.

```zsh
docker build -t "dev-env:latest" .
docker run --name dev-env -d -it dev-env
docker exec -it dev-env zsh
```
