
let
  pkgs = (import <nixpkgs> {});
  inherit (builtins) readFile map length elemAt;
  inherit (pkgs.lib) pipe splitString filter stringLength tail zipListsWith toInt foldr;

  input = readFile ./input.txt;
in
{
  "Part1" =
    let
      initPoint = { x = 0; y = 0; };
      ops = {
        forward = d: { x, y }: { x = x + d; y = y; };
        down = d: { x, y }: { x = x; y = y + d; };
        up = d: { x, y }: { x = x; y = y - d; };
      };
    in
    pipe input [
      (splitString "\n")
      (map (line: splitString " " line))
      (filter (as: (length as) > 1))
      (map (as: { op = (elemAt as 0); d = (toInt (elemAt as 1)); }))
      (foldr ({ op, d }: agg: ops."${op}" d agg) initPoint)
      (final: { inherit (final) x y; answer = final.x * final.y; })
    ];
  "Part2" =
    let
      testInput = ''
      forward 5
      down 5
      forward 8
      up 3
      down 8
      forward 2
      '';
      initPoint = { x = 0; y = 0; a = 0; };
      ops = {
        forward = d: { x, y, a }: { inherit a; x = x + d; y = y + (a * d); };
        down = d: { x, y, a }: { inherit x y; a = a + d; };
        up = d: { x, y, a }: { inherit x y; a = a - d; };
      };
    in
      pipe input [
        (splitString "\n")
        (map (line: splitString " " line))
        (filter (tuple: (length tuple) > 1))
        (map (tuple: { op = (elemAt tuple 0); d = (toInt (elemAt tuple 1)); }))
        (foldr ({ op, d }: agg: ops."${op}" d agg) initPoint)
        ({ x, y, a }: { inherit a x y; answer = (x * y); })
      ];
}
