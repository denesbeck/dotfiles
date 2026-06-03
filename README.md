# Dotfiles

My dotfiles for NeoVim, Tmux.

<img width="800" height="460" alt="image" src="https://github.com/user-attachments/assets/24e12387-2526-4683-931d-b6cbf75d0bed" />
<img width="800" height="460" alt="Screenshot 2025-11-08 at 17 02 23" src="https://github.com/user-attachments/assets/051ac660-7282-4393-9b7b-600ac7c65680" />
<img width="800" height="460" alt="Screenshot 2025-11-08 at 15 45 28" src="https://github.com/user-attachments/assets/c076e996-ed92-4ef5-867b-8b4eacc11cf9" />

## 🛠 Install using Ansible

1. Ensure [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible) is installed.
2. Download the [init.yml](./init.yml) file.
3. Run the playbook: `ansible-playbook path/to/your/init.yml`
4. When first running Tmux, press `C-w + I` to install plugins using `tpm`. NeoVim will install everything automatically on first run.

## 🛠 Manual Install

### 🗑️ Clean

```bash
rm -rf ~/.config/.git ~/.config/.gitignore ~/.config/README.md ~/.config/init.yml ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim ~/.config/tmux/tmux.conf ~/.tmux
```

### 💾 Clone

A. Clone the repository, if `~/.config` dir doesn't exist:

```bash
git clone --depth 1 https://github.com/denesbeck/dotfiles.git ~/.config
```

B. Sync the repo, if `~/.config` dir already exists. Navigate to `~/.config` dir and run the following:

```bash
git init
git remote add origin https://github.com/denesbeck/dotfiles.git
git fetch origin
git checkout -b main --track origin/main
```

### 👻 Ghostty

1. Install [Ghostty](https://ghostty.org/): `brew install --cask ghostty`
2. Add the config below for Ghostty (macOS path: `$HOME/Library/Application\ Support/com.mitchellh.ghostty/config`):

```
background-opacity = 0.7
background-blur = 15
theme = Catppuccin Frappe
```

3. Reload config

### 🚀 NeoVim and Tmux

1. Install via HomeBrew [neovim](https://github.com/neovim/neovim)
2. Install via HomeBrew [tmux](https://github.com/tmux/tmux)

### 📦 Tmux Plugin Manager

1. Install [tpm](https://github.com/tmux-plugins/tpm)
2. Manually install (recommended) the [catppuccin for tmux](https://github.com/catppuccin/tmux) plugin
3. Install Tmux plugins (prefix + I) or reload the configuration: `tmux source ~/.config/tmux/tmux.conf`

### 😯 Oh My Zsh

1. Install [oh-my-zsh](https://ohmyz.sh/)

## 🛠️ Tools & Plugins (HomeBrew)

### ⚡ General

- bash
- [bat](https://github.com/sharkdp/bat)
- [bottom](https://github.com/ClementTsang/bottom)
- curl
- [eza](https://eza.rocks/)
- [fzf](https://github.com/junegunn/fzf)
- [httpie](https://httpie.io/)
- [httpstat](https://github.com/reorx/httpstat)
- [jq](https://github.com/jqlang/jq)
- [lazydocker](https://github.com/jesseduffield/lazydocker)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [lazyssh](https://github.com/Adembc/lazyssh)
- [nvm](https://github.com/nvm-sh/nvm)
- [opencode](https://github.com/sst/opencode)
- [pyenv](https://github.com/pyenv/pyenv)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [tree-sitter](https://tree-sitter.github.io/tree-sitter/)
- [tree-sitter-cli](https://tree-sitter.github.io/tree-sitter/cli/index.html)
- wget
- [yq](https://github.com/mikefarah/yq)

### 🔌 Oh My Zsh Plugins

- [z](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/z)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-bat](https://github.com/fdellwing/zsh-bat)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use)

## 🧙🏻‍♂️ Aliases

```bash
alias vi=nvim
alias g="ghostty"
alias ll="eza -lg --icons --git -h"
alias lla="eza -lg --icons --git -h -a"
alias cat=bat
alias ld=lazydocker
alias lg=lazygit
alias lssh=lazyssh
alias oc=opencode
alias gem="git commit --allow-empty -m"
alias update="brew update && brew upgrade && brew cleanup"
alias a=ansible
alias tf=terraform
alias k=kubectl
alias d=docker
alias dc="docker-compose"
```
