{
  description = "Flake of JackSkelt"; # Inspired by librephoenix

  outputs = { self, nixpkgs, stylix, hyprland-plugins, home-manager, ... }@inputs:

  let
    systemSettings = {
      system = "x86_64-linux";
      hostname = "maieutics";
      profile = "notebook";
      timezone = "America/Sao_Paulo";
      locale = "pt_BR.UTF-8";
    };

    userSettings = rec {
      username = "jackskelt";
      name = "JackSkelt";
      email = "contact@jackskelt.me";
      term = "kitty";
      theme = "atelier-cave";
      browser = "floorp";
      font = "Azaret Mono";
      fontPkg = pkgs.azeret-mono;
      editor = "hx";
      spawnEditor = editor;
    };

    pkgs = import nixpkgs {
      system = systemSettings.system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    };

    lib = nixpkgs.lib;

  in {
    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ (./. + "/profiles/${systemSettings.profile}/home.nix") ];
        extraSpecialArgs = {
          inherit pkgs;
          inherit systemSettings;
          inherit userSettings;
          inherit (inputs) stylix;
          inherit (inputs) hyprland-plugins;
        };
      };
    };

    nixosConfigurations = {
      system = lib.nixosSystem {
        system = systemSettings.system;
        modules = [ (./. + "/profiles/${systemSettings.profile}/default.nix") ];
        specialArgs = {
          inherit pkgs;
          inherit systemSettings;
          inherit userSettings;  
          inherit (inputs) stylix;
        };
      };
    };
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix/release-23.11";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      flake = false;
    };
  };
}
