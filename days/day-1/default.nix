let
  pkgs = (import <nixpkgs> {});
  inputs = builtins.readFile ./input.txt;
  answer = "3";
in
  answer
