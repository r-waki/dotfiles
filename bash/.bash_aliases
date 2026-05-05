
if [ -x ~/.nix-profile/bin/home-manager ]; then
    alias hms = "home-manager switch --flake ~/dotfiles";
