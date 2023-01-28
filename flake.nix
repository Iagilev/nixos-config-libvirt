{
  description = "Example NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  };

  outputs = inputs @ { self, nixpkgs }:
    let
      user = "vagrant";
    in 
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs user;
        }
      );
    };
}
