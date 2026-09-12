{
  writeShellScriptBin,
  lib,
  fzf,
  terminal ? "$TERMINAL",
  terminalOptions ? [ "$TERMINAL_CLASS_OPTION=fzfmenu" ],
  fzfOptions ? [ ],
}:
writeShellScriptBin "fzfmenu" ''
  exec 9>"$XDG_RUNTIME_DIR/fzfmenu.lock"
  flock -n 9 || exit
  ${terminal} ${lib.strings.concatStringsSep " " terminalOptions} sh -c "printf '\\e[5 q' && ${lib.getExe fzf} $FZF_DEFAULT_OPTS --margin 1 --separator='─' ${lib.strings.concatStringsSep " " fzfOptions} $* </proc/$$/fd/0 >/proc/$$/fd/1"
''
