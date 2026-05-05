{ config, ... }:
{
  home.file.".bashrc".source = ../../../bash/.bashrc;
  home.file.".bash_aliases".source = ../../../bash/.bash_aliases;
  home.file.".zshrc".source = ../../../zsh/.zshrc;
  home.file.".tmux.conf".source = ../../../tmux/.tmux.conf;
  home.file.".copilot/skills".source = 
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/copilot/skills";
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
}
