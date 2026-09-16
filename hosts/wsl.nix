{
  profile =
    { inputs, ... }:
    {
      modules = [ inputs.nixos-wsl.nixosModules.default ];
      users = {
        wsl = {
          user =
            { pkgs, ... }:
            {
              shell = pkgs.fish;
              isNormalUser = true;
              extraGroups = [
                "wheel"
                "podman"
              ];
            };

          home =
            { pkgs, lib, ... }:
            {
              home = {
                packages = with pkgs; [
                  bc
                  file
                  nix-index
                  spell
                  wl-clipboard
                  xdg-utils
                  man-pages
                ];
                stateVersion = "26.05";
              };

              xdg.portal.enable = lib.mkForce false;

              programs = {
                btop.enable = true;
                dircolors.enable = true;
                direnv.enable = true;
                fish.enable = true;
                fzf.enable = true;
                git = {
                  enable = true;
                  settings = {
                    user = {
                      email = "ahmed.aboeleyoun@trufla.com";
                      name = "Ahmed AbouEleyoun";
                    };
                  };
                };
                helix = {
                  enable = true;
                  default = true;
                };
                lazygit.enable = true;
                ripgrep.enable = true;
                yazi.enable = true;
                zk.enable = true;
              };
            };
        };
      };
      monitors = [ ];
    };

  system =
    { ... }:
    {
      wsl = {
        enable = true;
        defaultUser = "wsl";
      };

      boot.loader.systemd-boot.enable = false;

      nixpkgs.hostPlatform = "x86_64-linux";

      networking.useNetworkd = false;

      services = {
        smartd.enable = false;
      };

      virtualisation = {
        containers.registries.search = [ "docker.io" ];
        podman = {
          enable = true;
          dockerCompat = true;
          dockerSocket.enable = true;
          defaultNetwork.settings.dns_enabled = true;
        };
      };

      system.stateVersion = "26.05";
    };
}
