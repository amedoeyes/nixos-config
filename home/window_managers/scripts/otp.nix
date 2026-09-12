{
  writeShellScriptBin,
  lib,
  fzfmenu,
  findutils,
  pass,
  passExtensions,
}:
let
  pass' = pass.withExtensions (_: with passExtensions; [ pass-otp ]);
in
writeShellScriptBin "password" ''
  result=$(${lib.getExe findutils} "$PASSWORD_STORE_DIR/" -type f -name '*.gpg' -printf '%P\n' | ${lib.getExe fzfmenu})
  [[ -n "$result" ]] && ${lib.getExe pass'} otp "''${result%.gpg}" -c
''
