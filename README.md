# My dot configuration files

## Requirements
You can install the required softwares via 

```shell
aurman -S xmonad xmonad-contrib trayer albert fcitx blueberry
```


## Get the configuration files 
```shell
    git clone ... ~/.config/dotfiles/ 
```



```shell

if [ -f ${HOME}/.Xdefaults ]; then 
    rm -f ${HOME}/.Xdefaults
fi 
ln -sv ${HOME}/.config/dotfiles/xdefault ${HOME}/.Xdefaults

if [ -f ~/.xbindkeysrc ]; then 
    rm -f ~/.xbindkeysrc
fi 
ln -sv ~/.config/dotfiles/keybindings ~/.xbindkeysrc

if [ -d ~/.xmonad/ ]; then 
    if [ -f ~/.xmonad/xmonad.hs ]; then 
        rm -rf ~/.xmonad/xmonad.hs
    fi 
else 
    mkdir ~/.xmonad
fi 
ln -sv ~/.config/dotfiles/xmonad.hs ~/.xmonad/xmonad.hs

if [ -f ~/.xmobarrc ]; then 
    rm -rf ~/.xmobarrc
fi 
ln -sv ~/.config/dotfiles/xmobarrc ~/.xmobarrc


```
