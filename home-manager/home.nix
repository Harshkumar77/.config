# home-manager switch

{ config, pkgs, ... }:

{

  # Let Home Manager install and manage itself.

  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the

  # paths it should manage.

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


  ];

  programs = {
    zsh = {
      enable = true;
    };
  };

}
