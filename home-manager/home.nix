{ config, pkgs,  ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";


  home.stateVersion = "23.11";
  home.enableNixpkgsReleaseCheck = false;

  nixpkgs.config.allowUnfreePredicate = _: true;

  home.packages = with pkgs; [
    hello

    # Terminal Goodness
    zsh
    tmux

    # ZSH plugins
    oh-my-zsh
    zsh-autosuggestions
    zsh-fast-syntax-highlighting
    zsh-vi-mode
    zsh-fzf-tab
    nix-zsh-completions

    alacritty-theme

    # Command line utilites
    clolcat
    figlet
    toilet
    fzf 
    eza 
    fd 
    xclip
    xorg.xkill
    yt-dlp
    ffmpeg_5-full
    speedtest-cli
    ripgrep
    ripgrep-all
    zip
    unzip
    rar
    p7zip
    # unrar
    xz
    tree
    util-linux
    gnumake
    glow
    bat
    cheat
    # libfaketime
    # glibc

    # pandoc
    pandoc
    texliveSmall
    imagemagickBig

    # reading
    speedread
    poppler_utils
    pdfgrep


    # Programming Languages
    ## C family
    llvmPackages_12.clang-unwrapped
    gcc9
    ## node
    nodejs_20
    nodejs_20.pkgs.pnpm
    nodejs_20.pkgs.nodemon
    # nodejs_20.pkgs.tsx 
    # Nix doesn't have it yet
    nodejs_20.pkgs.serve
    nodejs_20.pkgs.degit
    bun
    ## golang
    go
    air
    go-migrate
    ## python
    (python311.withPackages (py_pkg: [
      py_pkg.pip
    ]))
    ## Haskell
    ghc

    # Devtools
    neovim
    gh
    bruno
    jq


    # Productivity
    taskwarrior # stuck at 2.6
    tasksh
    # timewarrior
    tuxtype
    # obsidian


    # Databases
    dbeaver-bin
    pgadmin4-desktopmode
    postgresql_12
    sqlite

    # AI
    # ollama

    # Conditionally add WSL specific packages
    # based on the environment
      # (if builtins.getEnv "WSL_DISTRO_NAME" != "" || builtins.getEnv "WSLENV" != ""
      # then [ 
    #     wslu
    #   ]
    #   else [
    #     mpv
    #     dbeaver
    #   ]
    # )

    wslu



  ];

    home.file = { };

  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
 
  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
