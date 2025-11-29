{ config, pkgs, pkgs-unstable, inputs, ... }:

{
  home-manager.backupFileExtension = "hm-backup";
  home-manager.users.Ludo = {
    imports = [
    ];
 
    home.username = "Ludo";
    home.homeDirectory = "/home/Ludo";
    home.stateVersion = "25.05";

    # Gerer les dotfiles de maniere declarative
    xdg.configFile = {
      "hypr".source = ./config/hypr;
      "kitty".source = ./config/kitty;
      "wofi".source = ./config/wofi;
      # "hyprpanel".soucre = ./config/hyprpanel;
      # "hypr".source = inputs.hyprland-dots + "/hypr";
      # "kitty".source = inputs.hyprland-dots + "/kitty";
      # "wofi".source = inputs.hyprland-dots + "/wofi";
      # "hyprpanel".source = inputs.hyprland-dots + "/hyprpanel";
    };

    home.packages = with pkgs; [
      brave
      kitty

      # ---- Indispansable hyprlande
      waybar
      wofi
      swww
      dunst
      libnotify

      # ---- Outils systeme utiles
      networkmanagerapplet
      pavucontrol
      grim
      slurp
      wl-clipboard

      # ---------------------------
      nerd-fonts.jetbrains-mono
      font-awesome
    ];


    programs.vscode = {
      enable = true;
      package = pkgs-unstable.vscode;
      profiles.default = {
        extensions = with pkgs-unstable.vscode-extensions; [
          rust-lang.rust-analyzer
          ms-python.python
          github.copilot
          jnoortheen.nix-ide
        ];
        userSettings = {
          "editor.fontFamily" = "'JetBrains Mono', 'monospace'";
          "window.zoomLevel" = 1;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nil";
          "nix.serverSettings" = {
            "nil" = {
              "formatting" = { "command" = [ "nixfmt" ]; };
            };
          };
        };
      };
    };

    programs.git = {
      enable = true;
      userName = "Ludofr3";
      userEmail = "ludovic.de-chavagnac@epitech.eu";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };

    programs.zsh = {
      enable = true;
      oh-my-zsh = { 
        enable = true;
        theme = "robbyrussell";
      };
      shellAliases = {
         update = "curl -sSL https://rawgithubusercontent.com/Ludfr3/nixos-dotfiles/main/install.sh | nix-shell -p git --run \"sh -s --laptop\"";
      };
      
      initExtra = ''
         config-push() {
           if [ -z "$1" ]; then
             echo "Erreur : Vous devez fournir un message de commit."
             return 1
           fi
           cd /etc/nixos
           command git add .
           command git commit -m "$1"
           command git push
           echo "Configuration pousse vers Github !"
         }
         '';
      };
  };
}
