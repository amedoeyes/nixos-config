{
  profile =
    { ... }:
    {
      modules = [ ];
      users = {
        amedoeyes = import ../users/amedoeyes.nix;
      };
      monitors = [
        {
          name = "eDP-1";
          resolution = {
            width = 1600;
            height = 900;
          };
          position = {
            x = 0;
            y = 0;
          };
        }
        {
          name = "DP-2";
          resolution = null;
          position = {
            x = 1600;
            y = 0;
          };
        }
      ];
    };

  system =
    { pkgs, ... }:
    {
      boot = {
        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "ehci_pci"
            "ahci"
            "usb_storage"
            "sd_mod"
            "rtsx_pci_sdmmc"
          ];
        };
        kernelModules = [ "kvm-intel" ];
        loader = {
          efi.canTouchEfiVariables = true;
          systemd-boot = {
            enable = true;
            configurationLimit = 5;
          };
        };
        kernelPackages = pkgs.linuxPackages_latest;
        tmp = {
          cleanOnBoot = true;
          useTmpfs = true;
        };
      };

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/44609ad0-b915-4032-9076-8c06371a28f1";
          fsType = "ext4";
          options = [ "noatime" ];
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/6724-5D23";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };
      };

      zramSwap.enable = true;

      nixpkgs.hostPlatform = "x86_64-linux";

      hardware = {
        enableRedistributableFirmware = true;
        cpu.intel.updateMicrocode = true;
        bluetooth.enable = true;
        graphics = {
          enable = true;
          extraPackages = with pkgs; [ intel-media-driver ];
        };
      };

      nix = {
        settings = {
          use-xdg-base-directories = true;
          experimental-features = [
            "nix-command"
            "flakes"
            "pipe-operators"
          ];
        };
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
      };

      environment.pathsToLink = [
        "/share/applications"
        "/share/xdg-desktop-portal"
      ];

      networking = {
        hostName = "iris";
        useNetworkd = true;
        firewall.enable = true;
        nameservers = [ "9.9.9.9" ];
        wireless = {
          enable = true;
          userControlled = true;
          secretsFile = "/etc/nixos/wifi-passwords";
          networks = {
            "eyes" = {
              pskRaw = "ext:eyes_psk";
            };
            "Iris" = {
              hidden = true;
              pskRaw = "ext:iris_psk";
            };
            "Fairy_Tale" = {
              hidden = true;
              pskRaw = "ext:Fairy_Tale_psk";
            };
            "TRUFLA_STAFF" = {
              pskRaw = "ext:trufla_staff_psk";
            };
          };
        };
      };

      systemd = {
        network = {
          enable = true;
          networks = {
            "20-wired" = {
              matchConfig.Name = "enp0s25";
              networkConfig.DHCP = "yes";
              dhcpV4Config.RouteMetric = 100;
              ipv6AcceptRAConfig.RouteMetric = 100;
            };
            "25-wireless" = {
              matchConfig.Name = "wlp3s0";
              networkConfig = {
                DHCP = "yes";
                IgnoreCarrierLoss = "3s";
              };
              dhcpV4Config.RouteMetric = 600;
              ipv6AcceptRAConfig.RouteMetric = 600;
            };
          };
        };
      };

      time.timeZone = "Africa/Cairo";

      i18n.defaultLocale = "en_US.UTF-8";

      services = {
        getty.extraArgs = [ "--noissue" ];
        libinput.enable = true;
        openssh.enable = true;
        pipewire = {
          enable = true;
          pulse.enable = true;
        };
        tlp = {
          enable = true;
          settings = {
            CPU_SCALING_GOVERNOR_ON_AC = "performance";
            CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
            CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
            CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
            PLATFORM_PROFILE_ON_AC = "balance_performance";
            PLATFORM_PROFILE_ON_BAT = "balance_power";
            START_CHARGE_THRESH_BAT0 = 75;
            STOP_CHARGE_THRESH_BAT0 = 80;
            START_CHARGE_THRESH_BAT1 = 75;
            STOP_CHARGE_THRESH_BAT1 = 80;
          };
        };
        udisks2.enable = true;
      };

      security = {
        polkit.enable = true;
        pam.services = {
          swaylock = { };
          login.gnupg = {
            enable = true;
            noAutostart = true;
            storeOnly = true;
          };
        };
      };

      programs = {
        fish.enable = true;
      };

      documentation = {
        man.cache.enable = true;
        dev.enable = true;
      };
    };
}
