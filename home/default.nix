{ host, inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit (host.profile) monitors;
      inherit inputs;
    };
    users = builtins.mapAttrs (username: user: {
      imports = [
        ./modules
        ./programs
        ./services
        ./window_managers
        ./cursor.nix
        ./fonts.nix
        ./shell.nix
        ./xdg.nix
        user.home
      ];

      home = {
        inherit username;
        homeDirectory = "/home/${username}";
      };
    }) host.profile.users;
  };
}
