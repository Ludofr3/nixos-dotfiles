{ pkgs, ... }:

{
  stylix.enable = true;
  stylix.autoEnable = true; # Active Stylix pour tout ce qu'il trouve (Waybar, Kitty, etc.)

  # Assure-toi que wallpaper.png est bien dans le dossier /etc/nixos/nixos/
  stylix.image = ./girl_city.jpg;
  
  stylix.polarity = "dark";
  
  # XNM1 utilise souvent Catppuccin, essayons celui-ci pour un look "cool" immédiat
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

  stylix.targets.gnome.enable = false;
  
  stylix.opacity = {
    applications = 1.0;
    terminal = 0.85; # Un peu plus transparent pour le style
    desktop = 1.0;
    popups = 0.8;
  };

  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.inter;
      name = "Inter";
    };
    sizes = {
      terminal = 12;
      applications = 11;
    };
  };
}
