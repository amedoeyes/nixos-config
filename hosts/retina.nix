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
            width = 1920;
            height = 1080;
          };
          position = {
            x = 0;
            y = 0;
          };
        }
        {
          name = "HDMI-A-1";
          resolution = null;
          position = {
            x = 1920;
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
            "ahci"
            "nvme"
            "usb_storage"
            "uas"
            "sd_mod"
          ];
        };
        kernelModules = [ "kvm-intel" ];
        kernelPackages = pkgs.linuxPackages_zen;
      };

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/a5f1c8f3-ec37-4074-81c1-6d35e2304cb0";
          fsType = "ext4";
          options = [ "noatime" ];
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/1D2A-E8C2";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };
      };

      zramSwap.enable = true;

      nixpkgs = {
        hostPlatform = "x86_64-linux";
        config.allowUnfree = true;
      };

      hardware = {
        enableRedistributableFirmware = true;
        cpu.intel.updateMicrocode = true;
        bluetooth.enable = true;
        graphics = {
          enable = true;
          enable32Bit = true;
          extraPackages = with pkgs; [ intel-media-driver ];
        };
        nvidia = {
          open = true;
          modesetting.enable = true;
          powerManagement.enable = true;
          prime = {
            offload = {
              enable = true;
              enableOffloadCmd = true;
            };
            intelBusId = "PCI:0@0:2:0";
            nvidiaBusId = "PCI:1@0:0:0";
          };
        };
      };

      environment.pathsToLink = [
        "/share/applications"
        "/share/xdg-desktop-portal"
      ];

      networking = {
        hostName = "retina";
        wireless.enable = true;
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
          };
        };
        xserver.videoDrivers = [
          "modesetting"
          "nvidia"
        ];
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

      environment.systemPackages = with pkgs; [
        prismlauncher
        r2modman
        vesktop
      ];

      programs = {
        steam = {
          enable = true;
          extraCompatPackages = with pkgs; [ proton-ge-bin ];
        };
        gamemode.enable = true;
      };

      system.stateVersion = "26.05";
    };
}
