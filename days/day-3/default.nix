let
  pkgs = (import <nixpkgs> {});
  inherit (builtins) readFile map length elemAt;
  inherit (pkgs.lib)
    filter
    foldl
    pipe
    splitString
    stringToCharacters
    toInt
    zipListsWith
    ;

  input = pipe ./input.txt [
    (readFile)
    (splitString "\n")
    (filter (str: str != ""))
    (map stringToCharacters)
    (map (map toInt))
  ];

  count = length input;

  oneCounts = pipe input [
      (foldl (agg: next: zipListsWith (x: y: x + y) next agg) init)
    ];

  init = [ 0 0 0 0 0 0 0 0 0 0 0 0 0 ];
in
  {
    inherit count oneCounts;
  }
