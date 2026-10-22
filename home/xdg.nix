{ pkgs, config, ... }:
{
  xdg = {
    enable = true;
    portal.enable = true;
    mimeApps.enable = true;
    terminal-exec.enable = true;
    userDirs = {
      enable = true;
      setSessionVariables = true;
      desktop = null;
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/media";
      publicShare = null;
      templates = null;
      videos = "${config.home.homeDirectory}/media";
    };
  };

  home = {
    preferXdgDirectories = true;
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
