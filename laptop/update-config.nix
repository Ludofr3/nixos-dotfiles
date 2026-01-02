{ config, pkgs, lib, ... }:

let
  repoUrl = "https://github.com/Ludofr3/nixos-dotfiles.git";
  configDir = "/etc/nixos";

  updateScript = pkgs.writeShellScriptBin "update-nixos-config" ''
    set -e
    echo "Update Nixos configuration on Github"

    if [ ! -d ${configDir} ]; then
      echo "Error: The repo ${configDir} doesn't exist."
      exit 1
    fi

    cd ${configDir}

    if ! git rev-parse --git-dir > /dev/null 2>&1; then
      echo "Initialisation of the repo git..."
      git init
      git remote add origin ${repoUrl}
      git fetch origin
      if git show-ref --verify --quiet refs/remotes/origin/main; then
        git branch main origin/main
        git checkout main
      elif git show-ref --verify --quiet refs/remotes/origin/master; then
        git branch master origin/master
        git checkout master
      else
        git checkout -b main
      fi
    fi

    git add .

    if git diff-index --quiet HEAD --; then
      echo "Any change detected"
      exit 0
    fi

    commit_message="Update Nixos configuration - $(date "+%Y-%m-%d %H:%M:%S")"
    git commit -m "$commit_message"
    git push -u origin HEAD
    echo "✓ Success of the configuration update"
  '';
in {
  options.services.autoUpdateConfig.enable = lib.mkEnableOption "Automatically update NixOS config to GitHub after nixos-rebuild";

  config = {
    environment.systemPackages = [ updateScript ];

    # Hook qui s’exécute après un switch, si activé
    system.activationScripts.autoUpdateConfig = lib.mkIf config.services.autoUpdateConfig.enable {
      text = ''
        echo "Auto-update of NixOS config enabled. Running update-nixos-config..."
        ${updateScript}/bin/update-nixos-config
      '';
    };
  };
}
