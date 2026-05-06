{
  description = "My Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" ];
    in {
      homeConfigurations = builtins.listToAttrs (map (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        { name = "r-waki@${system}";
          value = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./nix/modules/home ];
          };
        }
      ) systems);
    };
}

