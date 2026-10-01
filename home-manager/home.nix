{
  config,
  pkgs,
  ...
}: {
  home.username = "admin";
  home.homeDirectory = "/home/admin";
  programs.home-manager.enable = true;
  home.stateVersion = "26.05";
}
