{
  writeShellScriptBin,
  lib,
  fzf,
  termrun,
}:
writeShellScriptBin "fzfmenu" ''
  exec 9>"$XDG_RUNTIME_DIR/fzfmenu.lock"
  flock -n 9 || exit
  ${lib.getExe termrun} --class fzfmenu --redirect ${lib.getExe fzf} --margin 1 --separator='─' $@
''
