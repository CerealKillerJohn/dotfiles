{
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    nixpkgs.url = "github:nixos/nixpkgs/a136def4f7256146b32e3625e53dcdf7464165f9";
    # nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    # optional, not necessary for the module
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: {
    nixosConfigurations = let
      lib = nixpkgs.lib;
      mkHost = host: users:
        nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";

          specialArgs = {
            inherit inputs lib nixpkgs system host users;
          };

          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.impermanence.nixosModules.impermanence
            inputs.sops-nix.nixosModules.sops
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {inherit host users;};
                users = lib.listToAttrs (map (user: {
                    name = user;
                    value = {
                      imports = [
                        inputs.nixvim.homeManagerModules.nixvim
                        # common home-manager configuration
                        ./home-manager/home.nix
                        # host specific home-manager configuration
                        # ./hosts/${host}/home.nix
                      ];

                      home = {
                        username = user;
                        homeDirectory = "/home/${user}";
                        # do not change this value
                        stateVersion = "23.11";
                      };

                      # Let Home Manager install and manage itself.
                      programs.home-manager.enable = true;
                    };
                  })
                  users);
              };
            }
            # common configuration
            ./configuration.nix
            # host specific configuration
            ./hosts/${host}/configuration.nix
            # host specific hardware configuration
            ./hosts/${host}/hardware-configuration.nix
          ];
        };
    in {
      # update with `nix flake update`
      # rebuild with `nixos-rebuild switch --flake .#latitude`
      latitude = mkHost "latitude" ["jwrhine"];
      # update with `nix flake update`
      # rebuild with `nixos-rebuild switch --flake .#desktop`
      desktop = mkHost "desktop" ["jwrhine" "user1"];
    };
  };
}
