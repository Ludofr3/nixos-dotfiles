{ pkgs, ... }:

let
  # Définition des chemins vers tes scripts (basé sur tes fichiers uploadés)
  scriptsDir = "/home/Ludo/.config/hypr/scripts";
  userScriptsDir = "/home/Ludo/.config/hypr/UserScripts";
in
{
  # Désactive explicitement Stylix pour ce module au cas où
  stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    
    # SYSTEMD: Waybar doit démarrer avec la session graphique
    systemd.enable = true;

    # CONFIGURATION (Basée sur [TOP] Chrysanthemum d'Axel-Denis)
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;
        height = 36; # Hauteur ajustée pour le style
        spacing = 5;
        fixed-center = true;
        ipc = true;
        
        margin-top = 0;
        margin-left = 5;
        margin-right = 5;

        modules-left = [
          "clock#time"
          "mpris"
          "tray"
          # "custom/swaync" # Décommente si tu utilises SwayNotificationCenter
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "pulseaudio"
          "backlight"
          "battery"
          "network"
          "custom/power"
        ];

        # --- MODULES DEFINITIONS ---

        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = true;
          format = "{icon}";
          show-special = false;
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          persistent-workspaces = {
            "*" = 5;
          };
          format-icons = {
            active = "";
            default = "";
          };
        };

        "clock#time" = {
          format = " {:%H:%M}";
          format-alt = " {:%H:%M   %Y, %d %B, %A}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{:%V}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };

        "mpris" = {
          interval = 10;
          format = "{player_icon} ";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          on-click-middle = "playerctl play-pause";
          on-click = "playerctl previous";
          on-click-right = "playerctl next";
          scroll-step = 5.0;
          tooltip = true;
          tooltip-format = "{status_icon} {dynamic}";
          player-icons = {
            chromium = "";
            default = "";
            firefox = "";
            spotify = "";
          };
          status-icons = {
            paused = "󰐎";
            playing = "";
            stopped = "";
          };
          max-length = 30;
        };

        "tray" = {
          icon-size = 20;
          spacing = 10;
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} 󰂰 {volume}%";
          format-muted = "󰖁";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" "󰕾" ""];
          };
          scroll-step = 5.0;
          on-click = "${scriptsDir}/Volume.sh --toggle";
          on-click-right = "pavucontrol -t 3";
          on-scroll-up = "${scriptsDir}/Volume.sh --inc";
          on-scroll-down = "${scriptsDir}/Volume.sh --dec";
        };

        "backlight" = {
          interval = 2;
          align = 0;
          rotate = 0;
          format = "{icon}";
          format-icons = ["" "" "" "󰃝" "󰃞" "󰃟" "󰃠"];
          tooltip-format = "backlight {percent}%";
          on-scroll-up = "${scriptsDir}/Brightness.sh --inc";
          on-scroll-down = "${scriptsDir}/Brightness.sh --dec";
          smooth-scrolling-threshold = 1;
        };

        "battery" = {
          interval = 60;
          align = 0;
          rotate = 0;
          full-at = 100;
          design-capacity = false;
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-full = "{icon} Full";
          format-alt = "{icon} {time}";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format-time = "{H}h {M}min";
          tooltip = true;
        };

        "network" = {
          format = "{ifname}";
          format-wifi = "{icon}";
          format-ethernet = "󰌘";
          format-disconnected = "󰌙";
          tooltip-format = "{ipaddr}  {bandwidthUpBits}  {bandwidthDownBits}";
          tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          on-click-right = "${scriptsDir}/WaybarScripts.sh --nmtui";
        };

        "custom/power" = {
          format = " ⏻ ";
          on-click = "wlogout"; # Utilise wlogout direct ou le script si tu l'as
          tooltip = true;
          tooltip-format = "Power Menu";
        };
      };
    };

    # CSS STYLE (Basé sur [Black & White] Monochrome.css d'Axel-Denis)
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-weight: bold;
        min-height: 0;
        font-size: 97%;
        font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
      }

      window#waybar {
        background-color: transparent;
        padding: 0px;
        border: 0px;
      }

      tooltip {
        color: white;
        background: #1e1e2e;
        opacity: 0.8;
        border-radius: 10px;
        border-width: 2px;
        border-style: solid;
        border-color: white;
      }

      tooltip label {
        color: #cdd6f4;
      }

      /*-----module groups----*/
      .modules-right {
        background-color: black;
        color: white;
        border-bottom: 1px solid white;
        border-radius: 10px;
        padding: 2px 4px;
        margin-left: 10px;
      }

      .modules-center {
        background-color: black;
        color: white;
        border-bottom: 1px solid white;
        border-radius: 10px;
        padding: 2px 4px;
      }

      .modules-left {
        background-color: black;
        color: white;
        border-bottom: 1px solid white;
        border-radius: 10px;
        padding: 2px 4px;
        margin-right: 10px;
      }

      /*-----modules indv----*/
      #taskbar button,
      #workspaces button {
        color: dimgrey;
        box-shadow: none;
        text-shadow: none;
        padding: 0px;
        border-radius: 9px;
        padding-left: 4px;
        padding-right: 4px;
        transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #taskbar button:hover,
      #workspaces button:hover {
        color: white;
        background-color: #7f849c;
        padding-left: 2px;
        padding-right: 2px;
        transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #taskbar button.active,
      #workspaces button.active {
        color: white;
        padding-left: 8px;
        padding-right: 8px;
        transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button.persistent {
        border-radius: 10px;
      }

      #backlight,
      #battery,
      #clock,
      #mpris,
      #network,
      #pulseaudio,
      #tray,
      #custom-power {
        padding-top: 4px;
        padding-bottom: 4px;
        padding-right: 6px;
        padding-left: 6px;
      }

      #pulseaudio.muted {
        color: #cc3436;
      }

      @keyframes blink {
        to {
          color: #000000;
        }
      }

      #battery.critical:not(.charging) {
        color: #f53c3c;
        animation-name: blink;
        animation-duration: 3.0s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
    '';
  };
}