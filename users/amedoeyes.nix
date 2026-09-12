{
  user =
    { pkgs, ... }:
    {
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };

  home =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      accounts = {
        email = {
          accounts =
            let
              pass = pkgs.pass.withExtensions (_: with pkgs.passExtensions; [ pass-meta ]);
            in
            {
              "ahmed@eyoun.net" = rec {
                primary = true;
                address = "ahmed@eyoun.net";
                userName = "ahmed@eyoun.net";
                realName = "Ahmed AbouEleyoun";
                passwordCommand = "${lib.getExe pass} passwords/personal/eyoun.net";
                imap = {
                  host = "mail.eyoun.net";
                  port = 993;
                  tls.enable = true;
                };
                smtp = {
                  host = "mail.eyoun.net";
                  port = 587;
                  tls.enable = true;
                  tls.useStartTls = true;
                };
                gpg = {
                  key = "0xBE4B8ED05504D252";
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
                    check-mail-cmd = "${lib.getExe pkgs.isync} ${address}";
                    check-mail-timeout = "60s";
                  };
                };
              };
              "amedoeyes@gmail.com" = rec {
                primary = false;
                address = "amedoeyes@gmail.com";
                realName = "Ahmed AbouEleyoun";
                passwordCommand = "${lib.getExe pass} meta passwords/personal/google.com/amedoeyes email_password";
                flavor = "gmail.com";
                gpg = {
                  key = "0xBE4B8ED05504D252";
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
                    check-mail-cmd = "${lib.getExe pkgs.isync} ${address}";
                    check-mail-timeout = "60s";
                  };
                };
              };
              "ahmed.m.aboueleyoun@gmail.com" = rec {
                address = "ahmed.m.aboueleyoun@gmail.com";
                realName = "Ahmed AbouEleyoun";
                passwordCommand = "${lib.getExe pass} meta passwords/professional/google.com email_password";
                flavor = "gmail.com";
                gpg = {
                  key = "0xBE4B8ED05504D252";
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
                    check-mail-cmd = "${lib.getExe pkgs.isync} ${address}";
                    check-mail-timeout = "60s";
                  };
                };
              };
              "postmaster@eyoun.net" = rec {
                primary = false;
                address = "postmaster@eyoun.net";
                userName = "postmaster@eyoun.net";
                realName = "";
                passwordCommand = "${lib.getExe pass} passwords/personal/eyoun.net";
                imap = {
                  host = "mail.eyoun.net";
                  port = 993;
                  tls.enable = true;
                };
                smtp = {
                  host = "mail.eyoun.net";
                  port = 587;
                  tls.enable = true;
                  tls.useStartTls = true;
                };
                gpg = {
                  key = "0xBE4B8ED05504D252";
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
                    check-mail-cmd = "${lib.getExe pkgs.isync} ${address}";
                    check-mail-timeout = "60s";
                  };
                };
              };
              "spam@eyoun.net" = rec {
                primary = false;
                address = "spam@eyoun.net";
                userName = "spam@eyoun.net";
                realName = "";
                passwordCommand = "${lib.getExe pass} passwords/personal/eyoun.net";
                imap = {
                  host = "mail.eyoun.net";
                  port = 993;
                  tls.enable = true;
                };
                smtp = {
                  host = "mail.eyoun.net";
                  port = 587;
                  tls.enable = true;
                  tls.useStartTls = true;
                };
                gpg = {
                  key = "0xBE4B8ED05504D252";
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
                    check-mail-cmd = "${lib.getExe pkgs.isync} ${address}";
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
        fzfmenu
        man-pages
        mprisctl
        nix-index
        ripdrag
        screenrecord
        screenshot
        spell
        wl-clipboard-rs
        xdg-utils
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
              email = "ahmed@eyoun.net";
              name = "Ahmed AbouEleyoun";
            };
          };
          signing = {
            key = "0xBE4B8ED05504D252";
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
            PASSWORD_STORE_KEY = "0xBE4B8ED05504D252";
          };
        };
        qutebrowser.enable = true;
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
          sshKeys = [ "854FFB39BA8E860C2AF77006410E69C81455868E" ];
          pam = {
            enable = true;
            keys = [
              "22BC4AC18F8D0A116FC1E9CBBA709D38031A9817"
              "854FFB39BA8E860C2AF77006410E69C81455868E"
            ];
          };
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
