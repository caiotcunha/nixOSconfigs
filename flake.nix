{
  description = "my flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";    
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            inputs.hyprland.nixosModules.default
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                users.surtas = ./home.nix;
              };
            }
          ];
        };
      };
    };
}
