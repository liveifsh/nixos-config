{
  description = "Livefish NixOS configuration!!11!";

  inputs = {
    stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager_stable = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "stable";
    };
    home-manager_unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "unstable";
    };
    agenix.url = "github:ryantm/agenix";
    sddm-stray.url = "github:Bqrry4/sddm-stray";
    prismlauncher-cracked.url = "github:Diegiwg/PrismLauncher-Cracked";
    compose2nix = {
      url = "github:aksiksi/compose2nix";
      inputs.nixpkgs.follows = "stable";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    npc = {
      url = "github:samestep/npc";
      inputs.nixpkgs.follows = "stable";
    };
  };

  outputs = { 
    self, stable, unstable, 
    home-manager_stable, 
    home-manager_unstable, 
    agenix,
    sddm-stray, 
    prismlauncher-cracked,
    compose2nix,
    chaotic,
    npc,
    ... 
  }@inputs: {
    nixosConfigurations.livefish-laptop = stable.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = with inputs; [
        ./livefish-laptop/configuration.nix
        chaotic.nixosModules.default 
                 
        home-manager_stable.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
	        home-manager.users.livefish = import ./livefish-laptop/home.nix;
	      }	
        agenix.nixosModules.default
      ];
    };

#    nixosConfigurations.livefish-nix = stable.lib.nixosSystem {
#      system = "x86_64-linux";
#      specialArgs = { inherit inputs; };
#      modules = [
#        ./livefish-nix/configuration.nix
#
#        home-manager_stable.nixosModules.home-manager
#        {
#          home-manager.useGlobalPkgs = true;
#          home-manager.useUserPackages = true;
#	        home-manager.users.livefish = import ./livefish-nix/home.nix;
#	      }	
#
#        agenix.nixosModules.default
#      ];
#    };
  };
}
