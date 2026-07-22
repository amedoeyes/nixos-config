{ pkgs, config, ... }:
{
  xdg = {
    enable = true;
    portal.enable = true;
    mimeApps.enable = true;
    userDirs = {
      enable = true;
      setSessionVariables = true;
      desktop = null;
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/media/music";
      pictures = "${config.home.homeDirectory}/media";
      publicShare = null;
      templates = null;
      videos = "${config.home.homeDirectory}/media";
    };
  };

  home = {
    preferXdgDirectories = true;
    packages = [
      (pkgs.writeShellScriptBin "x-terminal-emulator" "exec $TERMINAL $@")
      (pkgs.writeShellScriptBin "xdg-terminal-exec" "exec $TERMINAL $@")
    ];
    sessionVariables = {
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      DOCKER_CONFIG = "${config.xdg.configHome}/docker";
      ELM_HOME = "${config.xdg.dataHome}/elm";
      GOPATH = "${config.xdg.dataHome}/go";
      LESSHISTFILE = "${config.xdg.stateHome}/less/history";
      NODE_REPL_HISTORY = "${config.xdg.stateHome}/node_repl_history";
    };
  };

  accounts = {
    email.maildirBasePath = "${config.xdg.dataHome}/mail";
  };
}
