{ inputs, pkgs-unstable, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    # On passe les arguments (inputs, pkgs-unstable) à home.nix
    extraSpecialArgs = {
      inherit inputs pkgs-unstable;
    };

    # On pointe vers ton fichier de configuration utilisateur
    users.Ludo = import ../home-manager/home.nix;
  };
}