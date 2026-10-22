{
  writeShellScriptBin,
  lib,
  fzfmenu,
  dex,
  xdg-terminal-exec,
}:
writeShellScriptBin "launcher" ''
  desktop_dirs=()
  IFS=':' read -ra dirs <<<"$XDG_DATA_DIRS"
  for dir in "''${dirs[@]}"; do
    if [[ -d "$dir" ]]; then
      desktop_dirs+=("$dir/applications")
    fi
  done

  declare -A names execs
  max_len=0
  while read -r file; do
    while IFS= read -r line; do
      case "$line" in
      Name=*)
        name="''${line#Name=}"
        names["$file"]="$name"
        if ((''${#name} > max_len)); then
          max_len=''${#name}
        fi
        ;;
      Exec=*)
        execs["$file"]="''${line#Exec=}"
        ;;
      esac
      if [[ -n "''${names["$file"]}" && -n "''${execs["$file"]}" ]]; then
        break
      fi
    done <"$file"
  done < <(find -L "''${desktop_dirs[@]}" -type f -name '*.desktop')

  entries=()
  for file in "''${!names[@]}"; do
    if [[ -n ''${execs["$file"]} ]]; then
      entries+=("$(printf "%-*s\t%s\t%s\n" "$max_len" "''${names[$file]}" "''${execs[$file]}" "$file")")
    fi
  done

  entry=$(printf "%s\n" "''${entries[@]}" | sort -t$'\t' -k1,1 -f -u | ${lib.getExe fzfmenu} -d '\\t' --with-nth=1..2 | cut -f3)

  [[ -n "$entry" ]] && ${lib.getExe dex} --term ${lib.getExe xdg-terminal-exec} "$entry"
''
