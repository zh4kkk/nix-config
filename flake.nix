{
  description = "nix-config";

  inputs = {
    # NixOS version:
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # home-manager version:
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # hardware-configuration:
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # zen-browser:
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: {
    # formatter:
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    # NixOS configuration:
    nixosConfigurations = {
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen5
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {inherit inputs;};
            home-manager.users.admin = import ./home-manager/home.nix;
          }
        ];
      };
    };
  };
}
