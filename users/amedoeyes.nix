{
  user =
    { pkgs, ... }:
    {
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };

  home =
    let
      gpgKey = "0xB6B6382BFC9F2BC4";
      gpgKeygrip = "4A76EBB0C2CEEE55FBB4F9DAD44D37F38784E5A1";
    in
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      xdg.configFile."pam-gnupg".text = ''
        ${config.xdg.dataHome}/gnupg
        ${gpgKeygrip}
      '';

      accounts = {
        email = {
          accounts = {
            personal = {
              primary = true;
              address = "amedoeyes@gmail.com";
              realName = "Ahmed AbouEleyoun";
              passwordCommand = "${lib.getExe pkgs.pass} passwords/email/personal";
              flavor = "gmail.com";
              gpg = {
                key = gpgKey;
                signByDefault = true;
              };
              mbsync = {
                enable = true;
                create = "both";
                remove = "both";
                expunge = "both";
              };
              aerc = {
                enable = true;
                extraAccounts = {
                  check-mail = "60s";
                  check-mail-cmd = "${lib.getExe pkgs.isync} personal";
                  check-mail-timeout = "60s";
                };
              };
            };
            professional = {
              address = "ahmed.m.aboueleyoun@gmail.com";
              realName = "Ahmed AbouEleyoun";
              passwordCommand = "${lib.getExe pkgs.pass} passwords/email/professional";
              flavor = "gmail.com";
              gpg = {
                key = gpgKey;
                signByDefault = true;
              };
              mbsync = {
                enable = true;
                create = "both";
                remove = "both";
                expunge = "both";
              };
              aerc = {
                enable = true;
                extraAccounts = {
                  check-mail = "60s";
                  check-mail-cmd = "${lib.getExe pkgs.isync} professional";
                  check-mail-timeout = "60s";
                };
              };
            };
          };
        };
      };

      home.packages = with pkgs; [
        bc
        file
        mprisctl
        nix-index
        ripdrag
        screenrecord
        screenshot
        spell
        wl-clipboard-rs
        xdg-utils
        man-pages
      ];

      programs = {
        aerc.enable = true;
        beets.enable = true;
        btop.enable = true;
        dircolors.enable = true;
        direnv.enable = true;
        fish.enable = true;
        foot = {
          enable = true;
          default = true;
        };
        fzf.enable = true;
        git = {
          enable = true;
          settings = {
            user = {
              email = "amedoeyes@gmail.com";
              name = "Ahmed AbouEleyoun";
            };
          };
          signing = {
            key = gpgKey;
            signByDefault = true;
          };
        };
        gpg.enable = true;
        helix = {
          enable = true;
          default = true;
        };
        imv.enable = true;
        lazygit = {
          enable = true;
          settings = {
            git = {
              overrideGpg = true;
            };
          };
        };
        mbsync.enable = true;
        mpv = {
          enable = true;
          config = {
            hwdec = "vaapi";
            gpu-api = "opengl";
          };
        };
        newsboat = {
          enable = true;
          urls = [
            { url = "https://lwn.net/headlines/newrss"; }
            { url = "https://lobste.rs/rss"; }
            { url = "https://nixos.org/blog/announcements-rss.xml"; }
          ];
        };
        password-store = {
          enable = true;
          settings = {
            PASSWORD_STORE_KEY = gpgKey;
          };
        };
        qutebrowser.enable = true;
        ripgrep.enable = true;
        rmpc.enable = true;
        swaylock.enable = true;
        waybar.enable = true;
        yazi = {
          enable = true;
          default = true;
          picker = true;
        };
        zathura.enable = true;
        zk.enable = true;
      };

      services = {
        batsignal.enable = true;
        cliphist.enable = true;
        gpg-agent = {
          enable = true;
          enableSshSupport = true;
          sshKeys = [ "42E2EEB2C6DE503C9795501A4138990BDC1731C4" ];
          extraConfig = ''
            allow-preset-passphrase
            default-cache-ttl 31536000
            max-cache-ttl 31536000
          '';
        };
        mako.enable = true;
        swayidle.enable = true;
        mpdscribble = {
          endpoints = {
            "last.fm" = {
              username = "amedoeyes";
              passwordFile = "${config.xdg.dataHome}/secrets/lastfm_password";
            };
          };
        };
      };

      wayland.windowManager.sway.enable = true;
    };
}
