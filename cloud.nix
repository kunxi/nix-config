# A dedicate module for AWS in Epic Games
{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    terraform
    kubectrl
    kubernetes-helm
    awscli
    aws-sam-cli
    aws-iam-authenticator
    vault
  ];
}
