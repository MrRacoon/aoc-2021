
let
  pkgs = (import <nixpkgs> {});
  inherit (builtins) readFile map length elemAt;
  inherit (pkgs.lib) pipe splitString filter stringLength tail zipListsWith toInt foldl;

  input = readFile ./input.txt;
in
{
  "Part1" =
    let
      initPoint = { x = 0; y = 0; };
      ops = {
        down = { x, y }: d: { x = x; y = y + d; };
        up = { x, y }: d: { x = x; y = y - d; };
        forward = { x, y }: d: { x = x + d; y = y; };
      };
    in
    pipe input [
      (splitString "\n")
      (map (line: splitString " " line))
      (filter (as: (length as) > 1))
      (map (as: { op = (elemAt as 0); d = (toInt (elemAt as 1)); }))
      (foldl (agg: { op, d }: ops."${op}" agg d) initPoint)
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
        down = { x, y, a }: d: {
          inherit x y;
          a = a + d;
        };
        up = { x, y, a }: d: {
          inherit x y;
          a = a - d;
        };
        forward = { x, y, a }: d: {
          inherit a;
          x = x + d;
          y = y + (a * d);
        };
      };
    in
      pipe input [
        (splitString "\n")
        (map (line: splitString " " line))
        (filter (tuple: (length tuple) > 1))
        (map (tuple: { op = (elemAt tuple 0); d = (toInt (elemAt tuple 1)); }))
        (foldl (agg: { op, d }: ops."${op}" agg d) initPoint)
        (final: { inherit (final) x y; answer = final.x * final.y; })
      ];
}
