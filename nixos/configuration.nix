{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Allow unfree packages:
  nixpkgs.config.allowUnfree = true;

  # flakes:
  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.stateVersion = "26.05";

  # boot:
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # uefi update in OS:
  services.fwupd.enable = true;

  # latest kernel & amd drivers:
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = ["amdgpu"];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.cpu.amd.updateMicrocode = true;
  # finger print:
  services.fprintd.enable = true;

  # network:
  networking.hostName = "thinkpad";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Moscow";

  # locale
  i18n.defaultLocale = "ru_RU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # pipewire:
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # user:
  users.users."admin" = {
    isNormalUser = true;
    description = "admin";
    extraGroups = ["networkmanager" "wheel" "video"];
  };
  # no paswd for sudo:
  security.sudo.wheelNeedsPassword = false;

  # fonts:
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
  ];

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Автологин в GNOME для пользователя admin (вход без пароля)
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "admin";

  # languages keymap:
  services.xserver.xkb = {
    layout = "us,ru";
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Системные пакеты
  environment.systemPackages = with pkgs; [
    zed-editor
    git
    curl
    obsidian

    # Инструменты для Zed (LSP-сервер и форматер)
    nixd
    alejandra
  ];

  # rebuild alias:
  programs.bash.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake $HOME/nix-config#";
  };
}
