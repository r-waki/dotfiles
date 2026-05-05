{ ... }:
{
  home.username = "r-waki";
  home.homeDirectory = "/home/r-waki";
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings.user.name = "r-waki";
    settings.user.email = "r.wakeyii@gmail.com";
    signing.format = "openpgp";
  };

  imports = [
    ./dotfiles.nix
    ./packages.nix
  ];
}
