{ config, pkgs, ... }:

{
  home.packages = with pkgs.python313Packages; [
    python
    ipython
    black
    cookiecutter
    ruff
    pip
    nox  # test accros versions
    setuptools
    yamllint
  ];
}

# if we want to use conda
# First time use:
# $ conda-shell
# $ conda-install
# Normal use:
# $ conda-shell
# $ conda install ipython numpy
# conda