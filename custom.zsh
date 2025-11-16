eval "$(zoxide init zsh)"   # For Zsh
alias cd='z'
alias ls='fd --hidden --max-depth'
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


