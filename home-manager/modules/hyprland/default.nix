{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # On dit à Hyprland de charger tes fichiers de configuration
    extraConfig = ''
      source = ~/.config/hypr/conf/hyprland.conf
      source = ~/.config/hypr/conf/hyprpaper.conf
      source = ~/.config/hypr/conf/monitors.conf
    '';
  };

  # On demande à Home-Manager de placer tes fichiers au bon endroit
  xdg.configFile."hypr/conf/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/conf/hyprlock.conf".source = ./hyprlock.conf;
  xdg.configFile."hypr/conf/hyprpaper.conf".source = ./hyprpaper.conf;
  xdg.configFile."hypr/conf/input.conf".source = ./input.conf;
  xdg.configFile."hypr/conf/keybinds.conf".source = ./keybinds.conf;
  xdg.configFile."hypr/conf/monitors.conf".source = ./monitors.conf;
  xdg.configFile."hypr/conf/scratchpads.conf".source = ./scratchpads.conf;
  xdg.configFile."hypr/conf/style.conf".source = ./style.conf;
}
