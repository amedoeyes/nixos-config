{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.vifm;
in
{
  options.programs.vifm = {
    default = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    picker = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      mimeApps.defaultApplications."inode/directory" = lib.mkIf cfg.default "vifm.desktop";

      portal = lib.mkIf cfg.picker {
        extraPortals = [ pkgs.xdg-desktop-portal-termfilechooser ];
        config.common."org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
      };

      configFile = {
        "xdg-desktop-portal-termfilechooser/config" = lib.mkIf cfg.picker {
          text =
            let
              deps = pkgs.symlinkJoin {
                name = "picker-dependencies";
                paths = with pkgs; [
                  vifm
                  bashInteractive
                  coreutils
                  gnused
                ];
              };
            in
            ''
              [filechooser]
              env=PATH='${deps}/bin'
              env=TERMCMD='${lib.getExe pkgs.${config.home.sessionVariables.TERMINAL}} --app-id=filepicker'
              cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/vifm-wrapper.sh
            '';
        };

        "vifm/colors/eyes.vifm".text = with config.theme.colors; ''
          highlight clear
          highlight Win          ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight AuxWin       ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight OtherWin     ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight Border       ctermfg=${c04.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c04.hex} guibg=#${c00.hex} gui=none
          highlight TabLine      ctermfg=${c06.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c06.hex} guibg=#${c00.hex} gui=none
          highlight TabLineSel   ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=bold guifg=#${c10.hex} guibg=#${c00.hex} gui=bold
          highlight TopLine      ctermfg=${c06.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c06.hex} guibg=#${c00.hex} gui=none
          highlight TopLineSel   ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=bold guifg=#${c10.hex} guibg=#${c00.hex} gui=bold
          highlight CmdLine      ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight ErrorMsg     ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight StatusLine   ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight JobLine      ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight WildBox      ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight WildMenu     ctermfg=${c10.ansi} ctermbg=${c01.ansi} cterm=none guifg=#${c10.hex} guibg=#${c01.hex} gui=none
          highlight SuggestBox   ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight CurrLine     ctermfg=${c10.ansi} ctermbg=${c01.ansi} cterm=none guifg=#${c10.hex} guibg=#${c01.hex} gui=none
          highlight OtherLine    ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight OddLine      ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight LineNr       ctermfg=${c04.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c04.hex} guibg=#${c00.hex} gui=none
          highlight Selected     ctermfg=${c10.ansi} ctermbg=${c02.ansi} cterm=none guifg=#${c10.hex} guibg=#${c02.hex} gui=none
          highlight Directory    ctermfg=${c09.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c09.hex} guibg=#${c00.hex} gui=none
          highlight Link         ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight BrokenLink   ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight HardLink     ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight Socket       ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight Device       ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight Executable   ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight Fifo         ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight CmpMismatch  ctermfg=${c06.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c06.hex} guibg=#${c00.hex} gui=none
          highlight CmpUnmatched ctermfg=${c06.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c06.hex} guibg=#${c00.hex} gui=none
          highlight CmpBlank     ctermfg=${c04.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c04.hex} guibg=#${c00.hex} gui=none
          highlight User1        ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User2        ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User3        ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User4        ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User5        ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User6        ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User7        ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User8        ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User9        ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User10       ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User11       ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User12       ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User13       ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User14       ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User15       ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User16       ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User17       ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User18       ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User19       ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
          highlight User20       ctermfg=${c10.ansi} ctermbg=${c00.ansi} cterm=none guifg=#${c10.hex} guibg=#${c00.hex} gui=none
        '';
      };
    };

    programs = {
      qutebrowser.settings.fileselect = lib.mkIf cfg.picker {
        handler = "external";
        folder.command = [
          config.home.sessionVariables.TERMINAL
          "--app-id=filepicker"
          "vifm"
          "-c only"
          "--choose-dir={}"
        ];
        single_file.command = [
          config.home.sessionVariables.TERMINAL
          "--app-id=filepicker"
          "vifm"
          "-c only"
          "--choose-files={}"
        ];
        multiple_files.command = [
          config.home.sessionVariables.TERMINAL
          "--app-id=filepicker"
          "vifm"
          "-c only"
          "--choose-files={}"
        ];
      };

      vifm = {
        extraConfig =
          let
            options = ''
              let &vicmd="sh -c '[ \"$0\" = -f ] && exec \"$EDITOR\" \"$1\" || exec \"$EDITOR\" \"$0\" \"$@\"'"

              set confirm=permdelete
              set dotdirs=""
              set dotfiles
              set fillchars=vborder:"│",hborder:"─",millersep:"│"
              set history=100
              set ignorecase
              set incsearch
              set mouse="a"
              set nofollowlinks
              set nohlsearch
              set nols
              set nowrap
              set scrolloff=4
              set sizefmt=units:iec,precision:2,nospace
              set smartcase
              set sortnumbers
              set suggestoptions=normal,visual,view,otherpane,keys,marks,registers
              set syscalls
              set tablabel="%t "
              set tabprefix=""
              set tabsuffix=""
              set timefmt="%Y-%m-%d %H:%M"
              set trashdir="%r/$XDG_DATA_HOME/Trash/"
              set tuioptions=puv
              set undolevels=100
              set vifminfo=dhistory,chistory,state,tabs,shistory,ehistory,phistory,fhistory,dirstack,registers,bookmarks,bmarks,mchistory
              set vimhelp
              set wildmenu
              set wildstyle=popup

              view
              colorscheme eyes
            '';

            marks = ''
              mark t /tmp/
              mark n /etc/nixos/
              mark h ~/
              mark c ~/.config/
              mark l ~/.local/
            '';

            keybinds = ''
              nnoremap K <C-g>
              nnoremap s :sort<cr>
              nnoremap w :vsplit | view<cr>
              nnoremap yd :!echo -n %d | ${lib.getExe' pkgs.wl-clipboard-rs "wl-copy"} %i && echo -n %d | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} -p %i<cr>
              nnoremap yf :!echo -n %c:p | ${lib.getExe' pkgs.wl-clipboard-rs "wl-copy"} %i && echo -n %c:p | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} -p %i<cr>
              nnoremap q :quit<cr>
            '';

            filetype = ''
              filetype * ${lib.getExe' pkgs.xdg-utils "xdg-open"} &
            '';

            fileviewer =
              with pkgs;
              with lib;
              ''
                fileviewer */,.*/ ${getExe tree} -L1 -a --noreport %c

                fileviewer *.tar ${getExe gnutar} -tf %c
                fileviewer *.tar.bz2,*.tbz2 ${getExe gnutar} -tjf %c
                fileviewer *.tar.xz,*.txz ${getExe gnutar} -tJf %c
                fileviewer *.tar.zst,*.tzst ${getExe gnutar} -t --zstd -f %c
                fileviewer *.tgz,*.tar.gz ${getExe gnutar} -tzf %c
                fileviewer *.zip,*.jar,*.war,*.ear,*.oxt ${getExe unzip} -l %f
                fileviewer *.7z ${getExe p7zip} l %c

                fileviewer <application/pdf> ${getExe' poppler-utils "pdftoppm"} -singlefile -png %c 2>/dev/null | ${getExe chafa} --relative on -s %pwx%ph %pd %N
                fileviewer <application/octet-stream>,<application/x-executable> ${getExe file} %c

                fileviewer <application/*> ${getExe' coreutils "cat"} %c
                fileviewer <audio/*> ${getExe' ffmpeg "ffprobe"} -hide_banner -pretty %c 2>&1
                fileviewer <image/*> ${getExe chafa} --relative on --animate off -s %pwx%ph %c %pd %N
                fileviewer <text/*> ${getExe' coreutils "cat"} %c
                fileviewer <video/*> ${getExe ffmpeg} -loglevel quiet -i %c -frames:v 1 -ss 0.1 -f image2pipe -vcodec png - | ${getExe chafa} --relative on -s %pwx%ph %pd %N

                fileviewer * ${getExe file} %c
              '';
          in
          lib.mkMerge [
            options
            marks
            keybinds
            filetype
            fileviewer
          ];
      };
    };
  };
}
