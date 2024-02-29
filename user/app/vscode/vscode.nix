{ pkgs, ...}:

{
   # home.sessionVariables.NIXOS_OZONE_WL = "1"; # Wayland

   programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer
      jnoortheen.nix-ide
      tamasfe.even-better-toml
      usernamehw.errorlens
      mkhl.direnv
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        publisher = "miguelsolorio";
        name = "min-theme";
        version = "1.5.0";
        sha256 = "sha256-DF/9OlWmjmnZNRBs2hk0qEWN38RcgacdVl9e75N8ZMY=";
      }
      {
        publisher = "miguelsolorio";
        name = "symbols";
        version = "0.0.16";
        sha256 = "sha256-LGCeqleDGWveJ7KPYd6+ArynEpET4xrhvI2H4NPuCtQ=";
      }
    ];
    keybindings = [
      {
        key = "ctrl+q";
        command = "workbench.action.openView";
      }
      {
        key = "ctrl+q";
        command = "-workbench.action.quit";
      }
    ];
    userSettings = {
      "workbench.colorTheme" = "Min Dark";
      "workbench.iconTheme" = "symbols";
      "symbols.hidesExplorerArrows" = false;
      "editor.fontFamily" = "Azeret";
      "editor.fontSize" = 14;
      "editor.lineHeight" = 1.8;
      "editor.rulers" = [ 80 120 ];
      "workbench.startupEditor" = "newUntitledFile";
      "editor.renderLineHighlight" = "gutter";
      "workbench.editor.labelFormat" = "short";
      "explorer.compactFolders" = false;
      "editor.semanticHighlighting.enabled" = false;
      "breadcrumbs.enabled" = false;
      "workbench.activityBar.location" = "hidden";
      "editor.minimap.enabled" = false;
      "editor.scrollbar.vertical" = "hidden";
      "editor.scrollbar.horizontal" = "hidden";
      "workbench.statusBar.visible" = false;
      "window.menuBarVisibility" = "toggle";
      "window.zoomLevel" = 1;
      "explorer.fileNesting.enabled" = true;
      "explorer.fileNesting.patterns" = {
        "package.json" = ".eslint*, prettier*, tsconfig*, vite*, pnpm-lock*, package-lock*, bun.lockb";
        "tailwind.config*" = "tailwind.config*, postcss.config*";
        ".env.local" = ".env*";
        ".env" = ".env*";
      };
    };
  };
}
