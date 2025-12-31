{ pkgs-unstable, ... }:
{
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
}