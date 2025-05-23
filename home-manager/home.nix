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
  jq

	python312Packages.pip

	spotdl
	ffmpeg_6-full
  imagemagickBig

	speedread

	gh
	starship
  eza

  lazygit

  yt-dlp

  mermaid-cli

  tldr
  bat
  bat-extras.batman

  ripgrep
  poppler_utils

  vifm

  taskwarrior3
  taskwarrior-tui
  vit
  buku
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
