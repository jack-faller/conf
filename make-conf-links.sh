ln -s ~/.config/x/.xinitrc  ~/.xinitrc
echo "using sway? (y/n)"
read sway
if [ $sway = "y" ]; then
		echo "linking ~/.config/zsh/zshrc_sway"
		ln -s ~/.config/zsh/zshrc_sway  ~/.zshrc
else
		echo "linking ~/.config/zsh/.zshrc"
		ln -s ~/.config/zsh/.zshrc  ~/.zshrc
fi
ln -s ~/.config/tmux/tmux.conf  ~/.tmux.conf 
ln -s ~/.config/ssh_conf  ~/.ssh/config