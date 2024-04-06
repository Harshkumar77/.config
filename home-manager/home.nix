{ config, pkgs,  ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.stateVersion = "23.11";
  home.enableNixpkgsReleaseCheck = false;

  nixpkgs.config.allowUnfreePredicate = _: true;

  home.packages = [
    pkgs.hello

    # Terminal Goodness
    pkgs.zsh
    pkgs.tmux

    # ZSH plugins
    pkgs.oh-my-zsh
    pkgs.zsh-autosuggestions
    pkgs.zsh-fast-syntax-highlighting
    pkgs.zsh-vi-mode
    pkgs.zsh-fzf-tab
    pkgs.nix-zsh-completions



    # Command line utilites
    pkgs.clolcat
    pkgs.fzf 
    pkgs.eza 
    pkgs.fd 
    pkgs.xclip
    pkgs.xorg.xkill
    pkgs.yt-dlp
    pkgs.speedtest-cli
    pkgs.ripgrep
    pkgs.ripgrep-all
    pkgs.zip
    pkgs.unzip
    pkgs.xz
    pkgs.pandoc
    pkgs.texliveSmall
    pkgs.tree


    # Programming Languages
    ## C family
    pkgs.llvmPackages_12.clang-unwrapped
    pkgs.gcc9
    ## node
    pkgs.nodejs_20
    pkgs.nodejs_20.pkgs.pnpm
    pkgs.nodejs_20.pkgs.nodemon
    pkgs.nodejs_20.pkgs.serve
    pkgs.bun
    ## golang
    pkgs.go
    pkgs.air
    pkgs.go-migrate
    ## python
    (pkgs.python311.withPackages (py_pkg: [
      py_pkg.pip
    ]))

    # Devtools
    pkgs.neovim
    pkgs.gh
    pkgs.bruno


    # Productivity
    pkgs.taskwarrior # stuck at 2.6
    pkgs.timewarrior
    pkgs.tuxtype
    # pkgs.obsidian


    # Databases
    pkgs.dbeaver
    pkgs.pgadmin4-desktopmode
    pkgs.postgresql_12

    # WSL
    pkgs.wslu

  ];

    home.file = { };

  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
 
  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
