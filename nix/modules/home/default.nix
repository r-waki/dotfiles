{ pkgs, ... }:
let
  homeDir = if pkgs.stdenv.isDarwin then "/Users/r-waki"
            else if pkgs.stdenv.isLinux then "/home/r-waki"
            else throw "Unsupported platform";
in
{
  home.username = "r-waki";
  home.homeDirectory = homeDir;
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings.user.name = "r-waki";
    settings.user.email = "r.wakeyii@gmail.com";
    signing.format = "openpgp";
    settings.alias.new-branch = "branch -b";
    settings.alias.unstage = "reset -q HEAD --";
  };

  imports = [
    ./dotfiles.nix
    ./packages.nix
  ];
}
