{
  host,
  inputs,
  pkgs,
  lib,

  ...
}:
{
  imports = [ host.system ];

  nixpkgs.overlays = [ (_: pkgs: import ../pkgs { inherit pkgs inputs; }) ];

  users.users = builtins.mapAttrs (_: user: user.user { inherit pkgs; }) host.profile.users;

  system.stateVersion = lib.mkDefault "26.05";
}
