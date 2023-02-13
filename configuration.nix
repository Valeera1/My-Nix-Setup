# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  #Nonfree
  nixpkgs.config.allowUnfree = true; 

  #Bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices =  ["nodev"];
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
   
   #Hostname
   networking.hostName = "nixos";
  
   #Network
   networking.networkmanager.enable = true;  


  #Language
    i18n.defaultLocale = "es_AR.UTF-8";
     console = {
     font = "Lat2-Terminus16";
     useXkbConfig = true; # use xkbOptions in tty.
   };


  #Wayland > Xorg, but i need this to configure
  services.xserver.enable = true;

  #NVIDIA(For me)
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  #Enviroment
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  

  #Layout
  services.xserver.layout = "latam";


  #Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  #Acount
   users.users.thalene = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; 
   };


  #Fundamental Packages, yes, Go evil and use Emacs 
   environment.systemPackages = with pkgs; [
    firefox 
    git 
    pfetch
    emacs
    discord
   ];

  #Shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;   
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read
}
