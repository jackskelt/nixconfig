{ pkgs, ... }:
let fuzzmoji = 
  pkgs.writeScriptBin "fuzzmoji" (builtins.readFile ./fuzzmoji);
in
{
  home.file."share/fuzzmoji/emoji-list".source = ./emoji-list;
  
  home.packages = with pkgs; [
    fuzzmoji
  ];
}
