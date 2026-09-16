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

  nix = {
    settings = {
      use-xdg-base-directories = lib.mkDefault true;
      experimental-features = lib.mkDefault [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
    };
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };
  };

  time.timeZone = lib.mkDefault "Africa/Cairo";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  boot = {
    loader = {
      efi.canTouchEfiVariables = lib.mkDefault true;
      systemd-boot = {
        enable = lib.mkDefault true;
        configurationLimit = lib.mkDefault 5;
      };
    };
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    tmp = {
      cleanOnBoot = lib.mkDefault true;
      useTmpfs = lib.mkDefault true;
    };
  };

  networking = {
    useNetworkd = lib.mkDefault true;
    firewall.enable = lib.mkDefault true;
    nameservers = lib.mkDefault [ "9.9.9.9" ];
    wireless = {
      secretsFile = lib.mkDefault "/etc/nixos/wifi-passwords";
      networks = {
        eyes = lib.mkDefault {
          pskRaw = "ext:eyes_psk";
        };
        Iris = lib.mkDefault {
          hidden = true;
          pskRaw = "ext:iris_psk";
        };
        Fairy_Tale = lib.mkDefault {
          hidden = true;
          pskRaw = "ext:Fairy_Tale_psk";
        };
        TRUFLA_STAFF = lib.mkDefault {
          pskRaw = "ext:trufla_staff_psk";
        };
      };
    };
  };

  programs = {
    fish.enable = lib.mkDefault true;
  };

  services = {
    getty.extraArgs = lib.mkDefault [ "--noissue" ];
    openssh.enable = lib.mkDefault true;
    smartd.enable = lib.mkDefault true;
    udisks2.enable = lib.mkDefault true;
  };

  documentation = {
    man.cache.enable = lib.mkDefault true;
    dev.enable = lib.mkDefault true;
  };
}
