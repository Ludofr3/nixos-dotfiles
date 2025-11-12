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
      "hypr".source = inputs.hyprland-dots + "/hypr";
      "kitty".source = inputs.hyprland-dots + "/kitty";
      "wofi".source = inputs.hyprland-dots + "/wofi";
      "hyprpanel".source = inputs.hyprland-dots + "/hyprpanel";
    };

    home.packages = with pkgs; [
      brave
      kitty
      # Paquet VSCode personnalise
      (let
        # Definir vos extensions ici
        my-vscode-extensions = with pkgs-unstable.vscode-extensions; [
          rust-lang.rust-analyzer
          ms-python.python
          github.copilot
        ];

        # Construire le paquet
        my-vscode-with-extensions = (pkgs-unstable.vscode-with-extensions.override {
          vscodeExtensions = my-vscode-extensions;
          vscode = pkgs-unstable.vscode;
        });
      in my-vscode-with-extensions)
    ];

    programs.git = {
      enable = true;
      userName = "Ludofr3";
      userEmail = "ludovic.de-chavagnac@epitech.eu";
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
