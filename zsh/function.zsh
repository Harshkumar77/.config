config-sync-wsl () {
	win_username="$(cmd.exe /c echo %username% |  tr -d '\r' )"

	# Alacritty
	echo $win_username
	cp "/mnt/c/Users/$win_username/AppData/Roaming/alacritty/alacritty.toml" "$HOME/.config/alacritty/" -r
	
	# Komorebic
	cp "/mnt/c/Users/$win_username/komorebi.json" "$HOME/.config/komorebic/" 
	cp "/mnt/c/Users/$win_username/komorebi.bar.json" "$HOME/.config/komorebic/" 
	cp "/mnt/c/Users/$win_username/.config/whkdrc" "$HOME/.config/komorebic/whkdrc" 
}

