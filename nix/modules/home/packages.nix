{ pkgs, lib, ... }:
let
  # Check if we're on a platform that supports certain packages
  inherit (pkgs.stdenv) isDarwin isLinux;
  isX86Linux = pkgs.stdenv.hostPlatform.system == "x86_64-linux";
in
{
  home.packages =
    with pkgs;
    [
      curl
      tmux
      git
      tig
      fd
      fzf
      vscode
      neovim
      gcc
      zsh
      github-copilot-cli
    ];
}
