let
  pkgs = (import <nixpkgs> {});
  inherit (pkgs.lib) pipe filterAttrs attrNames map mapAttrs;
  inherit (builtins) readDir;
  days = pipe ./days [
    readDir
    (filterAttrs (k: v: v == "directory"))
    (mapAttrs (key: value: (import (./. + "/days/${key}"))))
  ];
in
  days
