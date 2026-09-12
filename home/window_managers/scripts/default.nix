pkgs: {
  control = {
    mpris = pkgs.callPackage ./control/mpris.nix { };
    audio = pkgs.callPackage ./control/audio.nix { };
    brightness = pkgs.callPackage ./control/brightness.nix { };
  };
  clipboard = pkgs.callPackage ./clipboard.nix { };
  launcher = pkgs.callPackage ./launcher.nix { };
  otp = pkgs.callPackage ./otp.nix { };
  password = pkgs.callPackage ./password.nix { };
}
