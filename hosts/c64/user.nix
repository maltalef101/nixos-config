{ config, pkgs, inputs, ... }

{
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "emacs";
    PAGER = "less";
    TERMINAL = "alacritty";
    BROWSER = "firefox";
  };
}
