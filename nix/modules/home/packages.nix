{ pkgs, ... }:
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
      ripgrep
      zsh
      starship
      github-copilot-cli
    ];
}
