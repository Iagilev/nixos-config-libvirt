{
  description = "Example NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  };

  outputs = inputs @ { self, nixpkgs }:
      let
      findModules = dir:
        builtins.concatLists (builtins.attrValues (builtins.mapAttrs
          (name: type:
            if type == "regular" then [{
              name = builtins.elemAt (builtins.match "(.*)\\.nix" name) 0;
              value = dir + "/${name}";
            }] else if (builtins.readDir (dir + "/${name}"))
              ? "default.nix" then [{
              inherit name;
              value = dir + "/${name}";
            }] else
              findModules (dir + "/${name}"))
          (builtins.readDir dir)));

      pkgsFor = system:
        import inputs.nixpkgs {
          localSystem = { inherit system; };
          config = {
            allowUnfree = true;
            joypixels.acceptLicense = true;
          };
        };
      user = "vagrant";
    in
    {
      nixosProfiles = builtins.listToAttrs (findModules ./profiles);
      # nixosConfigurations = (
      #   import ./hosts {
      #     inherit (nixpkgs) lib;
      #     inherit inputs nixpkgs user;
      #   }
      # );
      nixosConfigurations = with nixpkgs.lib;
        let
          hosts = builtins.attrNames (builtins.readDir ./hosts);
          mkHosts = name:
            let
              system = "x86_64-linux";
              pkgs = pkgsFor system;
            in nixosSystem {
              inherit system;
              modules = [
                (import (./hosts + "/${name}"))
                { nixpkgs.pkgs = pkgs; }
              ];
              specialArgs = { inherit inputs user; };
            };
        in genAttrs hosts mkHosts;
    };
}
