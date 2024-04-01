{ pkgs, ... }:

{
  home.packages = [ pkgs.helix ];

  programs.helix.enable = true;
  
  programs.helix.settings = {
    theme = "gruvbox_dark_hard";
    editor = {
      line-number = "relative";
      mouse = false;
      bufferline = "multiple";
      shell = ["fish" "-c"];
    };

    keys.normal = {
      esc = [ "collapse_selection" "keep_primary_selection"];
      "`" = "switch_to_uppercase";
      "´" = "switch_to_lowercase";
    };

    editor.cursor-shape = {
      insert = "bar";
    };

    editor.lsp = {
      display-inlay-hints = true;
    };

    editor.file-picker = {
      git-ignore = true;
    };
  };  
}
