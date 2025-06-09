{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    awscli2
    aws-sam-cli
    aws-iam-authenticator
    cf-terraforming
    fastly

    docker
    docker-compose

    kubectl
    kubectx
    kubelogin-oidc
    kubernetes-helm

    grizzly  # grafana cmdline

    terraform
    vault
  ];
}

