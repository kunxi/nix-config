{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.ipython
    python3Packages.black
    python3Packages.flake8
    python3Packages.cookiecutter

    # python, using conda
    # First time use:
    # $ conda-shell
    # $ conda-install
    # Normal use:
    # $ conda-shell
    # $ conda install ipython numpy
    conda
  ];
}
