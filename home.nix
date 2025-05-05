{ config, pkgs, ... }:

{
  home.username = "surtas";
  home.homeDirectory = "/home/surtas";

  home.stateVersion = "24.11";  # use a mesma versão do nixpkgs

  programs.home-manager.enable = true;

  # Lista de programas/pacotes instalados para o usuário
  home.packages = with pkgs; [
   neofetch
   kitty
   foot

   #Clipboard
   wl-clipboard
   cliphist

   #Eww
   jq
   
   #Hyprland ecosystem
   hyprpaper

   #Apps
   firefox

  ]; 


  #hyprland    
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor=,preferred,auto,1
    '';
    settings = {
     "$mod" = "SUPER";
     bind =
      [
        "$mod, RETURN, exec, foot"
        "$mod, Q, killactive"

        # Switching workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"


        # Copiar e colar
        "CTRL, C, pass, wl-copy --trim-newline"
        "CTRL, V, pass, wl-paste --no-newline"
      ];

      exec-once = [
        "foot"
        "eww open bar"
        "mako"
        "hyprpaper"
        "systemctl --user start hyprpolkitagent"
      ]; 
      general = {
        gaps_in = 0;
        gaps_out = 0;

        border_size = 5;

        "col.active_border" = "rgba(d65d0eff) rgba(98971aff) 45deg";
        "col.inactive_border" = "rgba(3c3836ff)";

        resize_on_border = true;

        allow_tearing = false;
        layout = "master";
      };

      decoration = {
        rounding = 0;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = false;
        };

        blur = {
          enabled = false;
        };
      };
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];
    };
   };

  services.hyprpaper = {
    enable = true;
    settings = {
     ipc       = "on";
     splash    = false;
     preload   = [ "/usr/share/wallpapers/wall0.png" ];
     wallpaper = [ "Virtual-1,/usr/share/wallpapers/wall0.png" ];
    }; 
  };

  #bar
  programs.eww = {
    enable    = true;             
    package   = pkgs.eww;         
    configDir = ./eww-config;
  };

  # notification daemon mako
  services.mako = {
   enable = true;
  };

  # fuzzel app launcher
  programs.fuzzel = {
   enable = true;
  };
  
}
