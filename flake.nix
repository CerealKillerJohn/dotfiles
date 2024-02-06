{
  inputs = {
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    iynaix = {
      url = "github:iynaix/dotfiles";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    nixpkgs = {
      url = "github:Nixos/nixpkgs/nixos-unstable";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }:

  {
    nixosConfigurations = let
      user = "jwrhine";
      mkHost = host:
        nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";

          specialArgs = {
            inherit (nixpkgs) lib;
            inherit inputs nixpkgs system user host;
          };

          modules = [
	        inputs.home-manager.nixosModules.home-manager
	        inputs.impermanence.nixosModules.impermanence
            inputs.sops-nix.nixosModules.sops
            ./modules/nixos
#            ./overlays
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {inherit host inputs user;};
                users.${user} = {
                  imports = [
                    inputs.nixvim.homeManagerModules.nixvim
                    # common home-manager configuration
                    ./home-manager/home.nix
                    # host specific home-manager configuration
                    ./hosts/${host}/home.nix
                    # modules for home-manager
                    ./modules/home-manager
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
      # rebuild with `nixos-rebuild switch --flake .#amd`
      amd = mkHost "amd";
      # rebuild with `nixos-rebuild switch --flake .#desktop`
      desktop = mkHost "desktop";
      # rebuild with `nixos-rebuild switch --flake .#latitude`
      latitude = mkHost "latitude";
    };

      };
    }
