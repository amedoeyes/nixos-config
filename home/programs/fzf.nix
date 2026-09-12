{
  lib,
  config,
  ...
}:
let
  cfg = config.programs.fzf;
in
{
  config.programs.fzf = lib.mkIf cfg.enable {
    historyWidget.command = "";
    defaultOptions = [
      "--no-info"
      "--no-separator"
      "--pointer ''"
      "--prompt ' '"
      "--scrollbar '█'"
      "--reverse"
      "--highlight-line"
      "--preview-border left"
    ];
    colors = with config.theme.colors; {
      "fg" = "#${c10.hex}";
      "fg+" = "#${c10.hex}:regular";
      "bg" = "#${c00.hex}";
      "bg+" = "#${c01.hex}";
      "hl" = "#${c10.hex}";
      "hl+" = "#${c10.hex}";
      "gutter" = "#${c00.hex}";
      "query" = "#${c10.hex}:regular";
      "disabled" = "#${c04.hex}";
      "info" = "#${c04.hex}";
      "border" = "#${c04.hex}";
      "label" = "#${c10.hex}";
      "prompt" = "#${c06.hex}";
      "pointer" = "#${c10.hex}";
      "marker" = "#${c10.hex}";
      "spinner" = "#${c04.hex}";
      "header" = "#${c10.hex}";
    };
  };
}
