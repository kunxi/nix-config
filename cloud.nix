# A dedicate module for AWS in Epic Games
{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    terraform
    kubernetes
    kubernetes-helm
    awscli
    # aws-sam-cli: FIXME
    aws-iam-authenticator
  ];
}
