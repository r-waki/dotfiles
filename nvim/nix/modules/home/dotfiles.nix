{ ... }:
{
  home.file.".bashrc".source = ../../../bash/.bashrc;
  home.file.".zshrc".source = ../../../zsh/.zshrc;
  home.file.".tmux.conf".source = ../../../tmux/.tmux.conf;

  xdg.configFile."nvim".source = ../../../nvim;
  xdg.configFile."nvim".recursive = true;
}
