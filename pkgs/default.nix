{ pkgs, inputs }:
{
  cmus-cover = pkgs.callPackage ./cmus-cover.nix { };
  spell = pkgs.callPackage ./spell.nix { };
  fzfmenu = pkgs.callPackage ./fzfmenu.nix { };
  mprisctl = inputs.mprisctl.packages.${pkgs.stdenv.hostPlatform.system}.default;
  screenrecord = pkgs.callPackage ./screenrecord.nix { };
  screenshot = pkgs.callPackage ./screenshot.nix { };
  passExtensions = pkgs.passExtensions // {
    pass-meta = pkgs.callPackage ./pass-meta.nix { };
  };
}
