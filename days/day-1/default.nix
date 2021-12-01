let
  pkgs = (import <nixpkgs> {});
  inherit (builtins) readFile map length;
  inherit (pkgs.lib)
  pipe splitString filter stringLength tail zipListsWith toInt;
in
  pipe ./input.txt [
    readFile
    (splitString "\n")
    (filter (x: stringLength x > 0))
    (map toInt)
    (xs: zipListsWith (x: y: y - x) xs (tail xs))
    (filter (x: x > 0))
    (length)
  ]
