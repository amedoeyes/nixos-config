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

      environment.pathsToLink = [
        "/share/applications"
        "/share/xdg-desktop-portal"
      ];

      networking = {
        hostName = "iris";
        wireless.enable = true;
      };

      systemd = {
        network = {
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

      services = {
        libinput.enable = true;
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

      system.stateVersion = "26.05";
    };
}
