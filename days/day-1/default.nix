let
  pkgs = (import <nixpkgs> {});
  inherit (builtins) readFile map length;
  inherit (pkgs.lib)
  pipe splitString filter stringLength tail zipListsWith toInt;

  tripleZip = xs: zipListsWith (z: y: z + y) (zipListsWith (x: y: x + y) xs (tail xs)) (tail (tail xs));
in
{
  "Part1" = pipe ./input.txt [
    readFile
    (splitString "\n")
    (filter (x: stringLength x > 0))
    (map toInt)
    (xs: zipListsWith (x: y: y - x) xs (tail xs))
    (filter (x: x > 0))
    (length)
  ];
  "Part2" = pipe ./input.txt [
    readFile
    (splitString "\n")
    (filter (x: stringLength x > 0))
    (map toInt)
    tripleZip
    (xs: zipListsWith (x: y: y - x) xs (tail xs))
    (filter (x: x > 0))
    (length)
  ];
}
