{ pkgs, ... }: {
  home.username = "admin";
  home.homeDirectory = "/home/admin";

  xdg.userDirs = {
      enable = true;
      createDirectories = true;

      download = "$HOME/Downloads";
      documents = "$HOME/Documents";
      pictures = "$HOME/Pictures";

      desktop = "$HOME";
      templates = null;
      publicShare = null;
      music = null;
      videos = null;
    };

  programs.git = {
      enable = true;
      userName = "zh4kkk";
      userEmail = "metisasz9@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
      programs.ssh = {
        enable = true;
        matchBlocks = {
          "github.com" = {
            hostname = "ssh.github.com";
            port = 443;
            user = "git";
          };
        };
      };


  # shell:
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    initContent = builtins.readFile ./configs/zsh/.zshrc;
  };
  programs.starship.enable = true;

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  services.udiskie.enable = true;
  services.cliphist.enable = true;


  # config:
  xdg.configFile = {
    "sway".source = ./configs/sway;
    "waybar".source = ./configs/waybar;
    "kitty".source = ./configs/kitty;
    "fuzzel".source = ./configs/fuzzel;
    "mako".source = ./configs/mako;
    "kanshi".source = ./configs/kanshi;
    "yazi".source = ./configs/yazi;
    "zed".source = ./configs/zed;
  };


  home.packages = with pkgs; [
    waybar
    kitty
    fuzzel
    mako
    libnotify
    kanshi
    polkit_gnome
    grim
    slurp
    wl-clipboard
    xdg-utils
    btop
    fastfetch
    bluetuith


    yazi
    fd
    ripgrep
    fzf
    file
    jq
    trash-cli
    unar
    p7zip


    firefox
    zed-editor
    # jetbrains.rider
    bruno
    clash-verge-rev
    onlyoffice-desktopeditors


    dotnetCorePackages.sdk_8_0
    nodejs
    pnpm
    gcc
    gnumake
    cmake
    ninja
  ];

  home.stateVersion = "26.05";
  programs.home-manager.enable = true;


    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 22;
    };
}
