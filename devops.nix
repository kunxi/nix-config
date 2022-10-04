{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    awscli
    aws-sam-cli
    aws-iam-authenticator

    kubectl
    kubectx
    kubernetes-helm
    skaffold
    tilt

    terraform
    vault
  ];
}

