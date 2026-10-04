{ pkgs, ... }: {
  home.username = "admin";
  home.homeDirectory = "/home/admin";
  xdg.userDirs.enable = true;

  programs.git.enable = true;


  # shell:
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    initExtra = builtins.readFile ./configs/zsh/.zshrc;
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

  # scripts:
  home.file.".local/bin" = {
    source = ./configs/scripts;
    recursive = true;
    executable = true;
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
    htop
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
    jetbrains.rider
    bruno
    nekoray


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
}
