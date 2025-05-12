config-sync-wsl () {
	win_username="$(cmd.exe /c echo %username% |  tr -d '\r' )"

	# Alacritty
	# echo $win_username
	cp "$HOME/.config/alacritty/alacritty.toml" "/mnt/c/Users/$win_username/AppData/Roaming/alacritty/alacritty.toml" -r
	
	# Komorebic
	cp "$HOME/.config/komorebic/komorebi.json" "/mnt/c/Users/$win_username/komorebi.json" 
	cp "$HOME/.config/komorebic/komorebi.bar.json" "/mnt/c/Users/$win_username/komorebi.bar.json"  
	cp "$HOME/.config/komorebic/whkdrc" "/mnt/c/Users/$win_username/.config/whkdrc"  

	# Obsidian Vim
	cp "$HOME/.config/.obsidian.vimrc" "/mnt/c/notes/more/.obsidian.vimrc" 
	
}

