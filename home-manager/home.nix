{ pkgs, inputs, ... }: {
  home.username = "admin";
  home.homeDirectory = "/home/admin";

  # Directory config:
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

# Git:
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "zh4kkk";
        email = "metisasz9@gmail.com";
      };
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

# Zsh:
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
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

# Configs:
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

# Customization:
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 20;
  };
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

# Electron:
  home.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };


  # Software:
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
    ncpamixer


    yazi
    fd
    ripgrep
    fzf
    file
    jq
    trash-cli
    unar
    p7zip


    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    zed-editor
    jetbrains.rider
    bruno
    onlyoffice-desktopeditors
    obsidian


    dotnetCorePackages.sdk_10_0
    nodejs
    gcc
    gnumake
    cmake
    ninja
    lazydocker
    nixd
    alejandra
  ];

  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
