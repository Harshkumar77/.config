eval "$(zoxide init zsh)"   # For Zsh
alias cd='z'
alias l='fd --hidden --max-depth 1'

zi

# File Manager
echo -n "File Manager (y/n): "
read choice
choice=${choice:l}  # lowercase conversion
if [[ "$choice" == "y" || "$choice" == "yes" ]]; then
    thunar "$(pwd)" &
    echo "Opened $(pwd) in Thunar."
else
    echo "Cancelled."
fi


rmf() {
	fzf -m --header="Select files to delete" | while IFS= read -r file; do
	    rm -- "$file"
	done
}

alias extract_urls='xidel -e "//a/@href'
