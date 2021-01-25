{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    minizinc
    gecode
    or-tools
  ];

  home.file = {
    "minizinc" = {
      source = ./solvers;
      target = ".minizinc/solvers";
      recursive = true;
    };
  };
}