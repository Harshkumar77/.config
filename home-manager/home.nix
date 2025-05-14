# home-manager switch

{ config, pkgs, ... }:

{

  programs.home-manager.enable = true;

  home.username = "brook";

  home.homeDirectory = "/home/brook";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
	nixfmt-rfc-style
	wsl-open
	sqlite

	python312Packages.pip

	spotdl
	ffmpeg_6-full

	speedread

	gh
	starship

  lazygit

  tldr
  bat
  bat-extras.batman

  ripgrep
  poppler_utils


	
	
	
  ];

  programs = {
    zsh = {
      enable = false;
    };
  };
  
  programs.starship = {
    enable = false;
  };
}
