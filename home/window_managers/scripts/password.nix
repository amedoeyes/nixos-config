{
  writeShellScriptBin,
  lib,
  fzfmenu,
  findutils,
  pass,
}:
writeShellScriptBin "password" ''
  result=$(${lib.getExe findutils} "$PASSWORD_STORE_DIR/" -type f -name '*.gpg' -printf '%P\n' | ${lib.getExe fzfmenu})
  [[ -n "$result" ]] && ${lib.getExe pass} "''${result%.gpg}" -c
''
