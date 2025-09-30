# Dotfiles

My dotfiles for NeoVim, Tmux.

## 🗑️ Clean

```bash
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim ~/.config/tmux/tmux.conf
```

## 🛠 Install

==> Clone the repository:

```bash
git clone --depth 1 https://github.com/denesbeck/dotfiles.git ~/.config
```

### 👻 Ghostty

==> Install [Ghostty](https://ghostty.org/): `brew install --cask ghostty`
==> Add the config below for Ghostty (macOS path: `$HOME/Library/Application\ Support/com.mitchellh.ghostty/config`):

```
background-opacity = 0.7
background-blur = 15
theme = Catppuccin Frappe
```

==> Reload config

### 🚀 NeoVim and Tmux

==> Install via HomeBrew [neovim](https://github.com/neovim/neovim)\
==> Install via HomeBrew [tmux](https://github.com/tmux/tmux)\

### 📦 Tmux Plugin Manager

==> Install [tpm](https://github.com/tmux-plugins/tpm)\
==> Manually install (recommended) the [catppuccin for tmux](https://github.com/catppuccin/tmux) plugin\
==> Install Tmux plugins (prefix + I) or reload the configuration: `tmux source ~/.config/tmux/tmux.conf`\

### 😯 Oh My Zsh

==> Install [oh-my-zsh](https://ohmyz.sh/)

## 🛠️ Tools & Plugins (HomeBrew)

### ⚡ General

bash\
[bat](https://github.com/sharkdp/bat)\
[bottom](https://github.com/ClementTsang/bottom)\
[eza](https://eza.rocks/)\
[fzf](https://github.com/junegunn/fzf)\
[httpie](https://httpie.io/)\
[jq](https://github.com/jqlang/jq)\
[lazygit](https://github.com/jesseduffield/lazygit)\
[nvm](https://github.com/nvm-sh/nvm)\
[pyenv](https://github.com/pyenv/pyenv)\
[ripgrep](https://github.com/BurntSushi/ripgrep)\
wget

### 🔌 Oh My Zsh Plugins

[z](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/z)\
[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)\
[zsh-bat](https://github.com/fdellwing/zsh-bat)\
[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)\
[zsh-you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use)

## 🧙🏻‍♂️ Aliases

```zsh
alias vi=nvim
alias g="ghostty"
alias ll="eza -lg --icons --git -h"
alias lla="eza -lg --icons --git -h -a"
alias cat=bat
alias lg=lazygit
alias gem="git commit --allow-empty -m"
alias update="brew update && brew upgrade && brew cleanup"
alias a=ansible
alias tf=terraform
alias k=kubectl
alias d=docker
alias dc="docker-compose"
```
