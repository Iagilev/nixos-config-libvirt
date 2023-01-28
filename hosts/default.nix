#
{ lib, inputs, nixpkgs, user,  ... }:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.AllowUnfree = true;
  };
  lib = nixpkgs.lib;
in {
  nixbox = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user;
    };
    modules = [
      ./nixbox
      ./configuration.nix
    ];
  };
}