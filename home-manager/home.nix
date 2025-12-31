{ config, pkgs, inputs, ... }:

let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  home.username = "Ludo";
  home.homeDirectory = "/home/Ludo";
  home.stateVersion = "25.11";

  # --- DÉSACTIVATION STYLIX ---
  stylix.targets.anki.enable = false;
  stylix.targets.obsidian.enable = false;
  stylix.targets.spicetify.enable = false;
  stylix.targets.waybar.enable = false;

  # --- PACKAGES ---
  home.packages = with pkgs; [
    brave
    kitty
    kdePackages.dolphin
    rofi
    waybar
    dunst
    swww
    libnotify
    networkmanagerapplet
    pavucontrol
    grim
    slurp
    wl-clipboard
    font-awesome
    hyprpicker
    polkit_gnome
    direnv
  ];

  imports = [
    ./modules/hyprland/default.nix
    ./modules/packages/waybar.nix
    ./modules/packages/vscode.nix
    ./modules/packages/kitty.nix
    ./modules/packages/zsh.nix
    ./modules/packages/git.nix
  ];
}
