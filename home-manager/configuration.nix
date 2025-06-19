# sudo nixos-rebuild switch
{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
    <home-manager/nixos>
  ];

  wsl.enable = true;
  wsl.defaultUser = "brook";

  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  environment.systemPackages = with pkgs; [
    home-manager
    vim
	
	
	wget
    neovim

	gcc
	git
	gnumake
	unzip
  rar
	ripgrep-all
	xclip 
	
    zsh
	fd
	fzf

  ];

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs; # only for NixOS 24.05
  };

  users.users.brook.isNormalUser = true;
#  home-manager.users.brook =
#    { pkgs, ... }:
#    {
#      home.packages = with pkgs; [
#        nodejs_23
#        hello
#
#        wslu
#        sqlite
#      ];
#      programs.bash.enable = true;
#      # The state version is required and should stay at the version you
#      # originally installed.
#      home.stateVersion = "24.11";
#    };
}
