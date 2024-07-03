{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    cargo
    rustc
    rustfmt
    sqlx-cli
  ];

  home.sessionVariables = {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };
}
