instalado awesomewm

sudo find / -name rc.lua
cp /etc/xdg/awesome/rc.lua

----
super shift c -> close focus window 
super enter -> open terminal
super r -> barrita para escribir nombre 
super s -> show keybindings
----

File System -> usr -> share -> backgrounds 

sudo apt install neovim
sudo apt install nitrogen compton  -- why?
sudo apt install suckless-tools pcmanfm
    sudo apt install git



dmenu_run


https://github.com/JaKooLit/Wallpaper-Bank
Download all the files
move them to Pictures
unzip them
rename to Wallpapers

----

sudo shutdown -h now # for shutting down the system now

alias for neovim

----
I want to install Ghostty and copy my config file, do not forget about that!

---
Improve config for awesome

---

Install necessary tools (and document the process) for using Github/Lab (thinking about ssh keys and similar)

Create list of AwesomeWM shortcuts

---
Configure
* [ ] Vim
* [ ] NeoVim

Install 
* [ ] fastfetch  
* [ ] Docker, 
* [ ] VSCode
* [ ] Rust
* [ ] R
* [ ] LaTex

----
 
TO install GHOSTTY:

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
update-alternatives --config x-terminal-emulator  # to check and select default terminal emulator

----
TMUX
sudo apt install tmux

----
NedFonts:         bash -c "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)"
RipGrep: sudo apt install ripgrep
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim


----
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"  # To check that is working
  495  ssh-add  ~/.ssh/id_ed25519
  496  ll
  497  clear
  498  git status
  499  nv .
  500  clear
  501  cat .ssh/id_ed25519
  502  nv .ssh/id_ed25519.pub
  503  clear
  504  ssh -T git@github.com

---
<!--
VSCode
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
-->


npm install --global yarn

----

sudo snap code --classic
sudo apt get install neofetch
sudo snap install typst
sudo snap install htop

----

tumuxifier


git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier

Add these lines to .bashrc or similar

```bash
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"
```

