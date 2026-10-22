{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mprisctl = {
      url = "git+https://git.eyoun.net/ahmed/mprisctl.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    {
      nixosConfigurations =
        builtins.readDir ./hosts
        |> builtins.attrNames
        |> builtins.filter (path: path != "default.nix" && nixpkgs.lib.hasSuffix ".nix" path)
        |> map (
          path:
          let
            host = import ./hosts/${path};
          in
          {
            inherit (host) system;
            name = nixpkgs.lib.removeSuffix ".nix" path;
            profile = host.profile { inherit inputs; };
          }
        )
        |> map (host: {
          ${host.name} = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs host; };
            modules = host.profile.modules ++ [
              ./hosts
              ./home
            ];
          };
        })
        |> nixpkgs.lib.mergeAttrsList;
    };
}
