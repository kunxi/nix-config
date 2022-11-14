# Nix locks down the python installation path, thus `pip install` will NOT
# work due the permission issue, see the [wiki](https://nixos.wiki/wiki/Python)
# for more details. The solution is to bootstrap a python shell and then
# use virutalenv for 2.x, and venv for 3.3+.

{ pkgs ? import <nixpkgs> {} }:
(pkgs.buildFHSUserEnv {
  name = "pipzone";
  targetPkgs = pkgs: (with pkgs; [
    python37
    python37Packages.pip
  ]);
  runScript = "bash";
}).env

