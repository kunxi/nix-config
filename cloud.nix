# A dedicate module for AWS in Epic Games
{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    terraform
    kubernetes-helm
    aws-sam-cli
    aws-iam-authenticator
  ];
}
