{ config, pkgs, ... }:

{
  home.username = "volcano";
  home.homeDirectory = "/home/volcano";

  home.stateVersion = "23.11";

	
  home.enableNixpkgsReleaseCheck = false;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.hello

    # Terminal Goodness
    pkgs.clolcat
    pkgs.zsh
    pkgs.tmux

    # ZSH plugins
    pkgs.oh-my-zsh
    pkgs.zsh-autosuggestions
    pkgs.zsh-fast-syntax-highlighting

    # Command line utilites
    pkgs.fzf 
    pkgs.eza 
    pkgs.fd 
    pkgs.xclip
    pkgs.yt-dlp

    # Programming Languages
    pkgs.llvmPackages_12.clang-unwrapped
    pkgs.nodejs_20
    pkgs.go

    # Devtools
    pkgs.neovim
    pkgs.unzip
    pkgs.gh
    pkgs.bruno

    # Productivity
    pkgs.taskwarrior
    pkgs.timewarrior
    pkgs.tuxtype

  ];

    home.file = { };

  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
 
  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
