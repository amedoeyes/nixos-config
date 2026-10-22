{
  writeShellScriptBin,
  lib,
  fzf,
  xdg-terminal-exec,
}:
writeShellScriptBin "fzfmenu" ''
  exec 9>"$XDG_RUNTIME_DIR/fzfmenu.lock"
  flock -n 9 || exit
  ${lib.getExe xdg-terminal-exec} --app-id=fzfmenu sh -c "printf '\\e[5 q' && ${lib.getExe fzf} $FZF_DEFAULT_OPTS --margin 1 --separator='─' $* </proc/$$/fd/0 >/proc/$$/fd/1"
''
