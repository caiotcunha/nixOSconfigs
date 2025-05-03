{ config, pkgs,inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.surtas = {
    isNormalUser = true;
    description = "surtas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
   inputs.hyprland.packages.${pkgs.system}.hyprland
   qt5.qtwayland
   qt6.qtwayland
  ];  
  
  # Habilita o serviço de display manager
  services.greetd.enable = true;
  services.greetd.settings.default_session = {
    command = "Hyprland";
    user = "surtas";
  };

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };
  # Hyprland e ecosystem
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  #Thunar
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
   thunar-archive-plugin
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
   xdg-desktop-portal-gtk
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  
  # Enable virtualization
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.dragAndDrop = true;

  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [ mesa ];
  services.xserver.videoDrivers = [ "vmware" ];

  environment.sessionVariables = {
   TERM = "xterm";
   QT_QPA_PLATFORM = "wayland";
   XDG_CURRENT_DESKTOP = "hyprland";
   NIXOS_OZONE_WL=1;
  };

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11"; # Did you read the comment?
  
}
