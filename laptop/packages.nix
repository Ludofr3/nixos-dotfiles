{ config, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    cargo
    nodejs_23
  ];
}
