{ lib, config, ... }:
let
  cfg = config.programs.beets;
in
{
  config.programs.beets = lib.mkIf cfg.enable {
    settings = {
      directory = config.xdg.userDirs.music;
      import = {
        move = true;
      };
      ui = {
        color = false;
      };
      plugins = [
        "badfiles"
        "edit"
        "embedart"
        "fetchart"
        "fromfilename"
        "info"
        "lyrics"
        "musicbrainz"
        "scrub"
        "zero"
      ];
      edit = {
        itemfields = [
          "title"
          "artist"
        ];
      };
      embedart = {
        remove_art_file = true;
      };
      fetchart = {
        maxwidth = 1500;
        cover_format = "jpeg";
      };
      lyrics = {
        synced = true;
        sources = [ "lrclib" ];
      };
      zero = {
        keep_fields = [
          "title"
          "albumartist"
          "artist"
          "album"
          "year"
          "track"
          "images"
          "art"
        ];
      };
    };
  };
}
