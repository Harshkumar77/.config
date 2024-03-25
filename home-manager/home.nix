{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "volcano";
  home.homeDirectory = "/home/volcano";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

	
  home.enableNixpkgsReleaseCheck = false;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # Terminal Goodness
    pkgs.hello
    pkgs.clolcat
    pkgs.zsh
    pkgs.tmux
    pkgs.fzf 
    pkgs.eza 
    pkgs.fd 
    pkgs.xclip
    pkgs.yt-dlp
    pkgs.oh-my-zsh
    pkgs.zsh-autosuggestions
    pkgs.zsh-fast-syntax-highlighting

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

  ];

    home.file = {

  };

  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
 
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
