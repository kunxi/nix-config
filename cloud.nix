# A dedicate module for AWS in Epic Games
{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    terraform
    helm
    aws-sam-cli
    aws-iam-authenticator
  ];
}
