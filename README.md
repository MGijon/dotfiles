# dotfiles

Dotfiles for configuring my mac easily.

***

## Table of contents

- [dotfiles](#dotfiles)
	- [Table of contents](#table-of-contents)
	- [Installation](#installation)
	- [Shell dotfiles](#shell-dotfiles)
	- [Git dotfiles](#git-dotfiles)
	- [Custom commands](#custom-commands)
	- [Other apps dotfiles](#other-apps-dotfiles)
	- [Shell scripts](#shell-scripts)
	- [Python scripts](#python-scripts)
	- [Ubuntu Setup](#ubuntu-setup)
	- [Shortcuts](#shortcuts)
		- [AwesomeWM](#awesomewm)
		- [Terminal](#terminal)
		- [Vim](#vim)
		- [NVim](#nvim)

***
<a name="#-installation"></a>
## Installation

```bash
bash <(curl -s https://raw.githubusercontent.com/MGijon/dotfiles/main/main.sh)
```

Detects the OS automatically and runs the appropriate script:
- **macOS** → `macos-setup.sh` (Homebrew-based)
- **Ubuntu/Debian** → `ubuntu-setup.sh` (apt-based)

***
<a name="#-shell-dotfiles)"></a>
## Shell dotfiles

***
<a name="#-git-dotfiles"></a>
## Git dotfiles

***
<a name="#-custom-commands"></a>
## Custom commands

***
<a name="#other-apps-dotfiles"></a>
## Other apps dotfiles

***
<a name="#shell-scripts"></a>
## Shell scripts

***
<a name="#python-scripts"></a>
## Python scripts

| Script | Usage | Description |
| :----- | :---- | :---------- |
| `rename.py` | `python3 rename.py -d <path> -p <pattern>` | Renames all files in a directory using a base pattern and consecutive indexes (e.g. `photo1.jpg`, `photo2.jpg`). Files are processed in alphabetical order and extensions are preserved. |

***
<a name="#shortcuts"></a>
## Shortcuts

<a name="#awesomewm"></a>
### AwesomeWM

The **Super key** (`modkey` in AwesomeWM) defaults to the **Windows / Command key** (`Mod4`). To change it, edit `~/.config/awesome/rc.lua`:

```lua
-- Change Mod4 (Super/Win) to Mod1 (Alt) if preferred
local modkey = "Mod4"
```

Common values:
- `"Mod4"` — Windows / Command key (default)
- `"Mod1"` — Alt key

| Shortcut | Description |
| :------: | :---------- |
| `Super + Enter` | Open terminal |
| `Super + Shift + C` | Close focused window |
| `Super + R` | Open run prompt |
| `Super + S` | Show keybindings |
| `Super + J` | Focus next window |
| `Super + K` | Focus previous window |
| `Super + H` | Shrink master width |
| `Super + L` | Grow master width |
| `Super + Space` | Switch layout |
| `Super + Shift + Space` | Switch layout (reverse) |
| `Super + F` | Toggle fullscreen |
| `Super + M` | Toggle maximize |
| `Super + N` | Minimize window |
| `Super + 1-9` | Switch to tag (workspace) |
| `Super + Shift + 1-9` | Move window to tag |
| `Super + Shift + Q` | Quit AwesomeWM |
| `Super + Ctrl + R` | Reload AwesomeWM config |

<a name="#terminal"></a>
### Terminal

<a name="#vim"></a>
### Vim

| Plugin | What is for? |
| :----: | :----------- |
| [Vundle](https://github.com/VundleVim/Vundle.vim) | Plugin manager for Vim |
| [NERDTree](https://github.com/preservim/nerdtree) | File system explorer for Vim |
| [Lightline](https://github.com/itchyny/lightline.vim) | Statusline plugin for Vim |
| [Vim-Gitgutter](airblade/vim-gitgutter) | Shows a git diff in the gutter |
| [Vim-Wiki](vimwiki/vimwiki) | Personal Wiki for Vim |
| [SimplyFold](tmhedberg/SimpylFold) | Python code folding |
| [Vim-Commentary](tpope/vim-commentary) | Comment stuff out |
| [Vim-Fugitive](https://github.com/tpope/vim-fugitive) | Git wrapper |

| Commands | Plugging? | Description |
| :------: | :-------: | :---------- |
| :PluginList | Vundle | List all plugins installed |
| :PluginInstall | Vundle | Install all plugins |
| :PluginUpdate | Vundle | Update all plugins |
| :PluginClean | Vundle | Remove plugins not in the list |

| Shortcut | Plugging? | Description |
| :------: | :-------: | :---------- |
| gcc | Vim-Commentary | Comment line |
| gc | Vim-Commentary | Comment visual selection |
| <leader>cc | Vim-Commentary | Comment line |
| <leader>c | Vim-Commentary | Comment visual selection |

<a name="#nvim"></a>
### NVim

| Commands | Plugging? | Description |
| :------: | :-------: | :---------- |

| Shortcut | Plugging? | Description |
| :------: | :-------: | :---------- |

***
<a name="#ubuntu-setup"></a>
## Ubuntu Setup

Run `setup.sh` after a fresh Ubuntu install to restore the environment automatically.

| Step | What it does |
|------|-------------|
| 1 | `apt update && upgrade` |
| 2 | Core packages: git, curl, ripgrep, tmux, neovim, nitrogen, compton, suckless-tools, pcmanfm |
| 3 | AwesomeWM + copies default `rc.lua` to `~/.config/awesome/` |
| 4 | Ghostty (via the mkasberg installer), sets as default terminal, copies config from dotfiles |
| 5 | Nerd Fonts (via the officialrajdeepsingh installer) |
| 6 | NvChad — clones the starter into `~/.config/nvim` |
| 7 | tmuxifier — clones repo, adds required lines to `.bashrc` |
| 8 | Snap packages: VSCode, typst, htop |
| 9 | fastfetch (via PPA) |
| 10 | Rust (via rustup) |
| 11 | Node.js (LTS) + Yarn |
| 12 | Docker (official repo) + adds user to the docker group |
| 13 | R (`r-base`) |
| 14 | LaTeX (`texlive-full`) |
| 15 | SSH key (ed25519) — generates, adds to agent, prints public key, prompts to add to GitHub |
| 16 | Copies `.gitconfig` and `.gitignore_global` from dotfiles |
| 17 | Wallpapers reminder (optionally opens the Wallpaper-Bank page) |

***

<!--
awesome:
Install:
Search config: 

TMux reference: https://www.youtube.com/watch?v=SRtvt3MxWrM
Ghostty reference: https://www.youtube.com/watch?v=jWuQxU4bDeU
https://ghostty.org/docs/config/keybind/reference
-->

