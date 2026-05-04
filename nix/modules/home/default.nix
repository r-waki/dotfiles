{ ... }:
{
  home.username = "r-waki";
  home.homeDirectory = "/home/r-waki";
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "r-waki";
    userEmail = "r.wakeyii@gmail.com";
  };

  imports = [
    ./dotfiles.nix
    ./packages.nix
  ];
}
