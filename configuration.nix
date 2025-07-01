# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  # Enable the KDE Plasma Environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Enable udev rules for ZSA keyboards
  hardware.keyboard.zsa.enable = true;

  # Enable virtualization
  virtualisation.libvirtd.enable = true;
  boot.kernelModules = ["kvm" "kvm_amd"];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.brainov = {
    isNormalUser = true;
    description = "BrainovTechnologies";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "docker" ];
    packages = with pkgs; [
    
    ];
  };  

  users.users.vinicius = {
    isNormalUser = true;
    description = "vinicius";
    hashedPassword = "$6$u1gZQV0rLLU1Pn/I$vizpp/b6vXgwHMQT5cShMmPtOISTMNyC2czGRPfyH1.qs7FqWzZi0tT4kLVz6Ej9.hk7zAc2q1/QfeSU8w/D/1";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "docker" "libvirtd" ];
    packages = with pkgs; [
    
    ];
  };


  # Install firefox.
  programs.firefox.enable = true;

  # Enable dconf
  programs.dconf.enable = true;

  # Activate and enable zoxide
  programs.zoxide.enable = true;

  # Enable adb
  programs.adb.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  programs.bash.shellAliases = {
    cd = "z";
    cat = "bat";
    nrs = "sudo nixos-rebuild switch --flake .#nixos";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    flutter
    nerd-fonts.lilex
    cargo
    python313
    python313Packages.pip
    nodejs_20 
    ripgrep
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator
    lazygit
    android-studio
    clang
    cmake
    ninja
    pkg-config
    bat
    vscode
    fvm
    wget
    unzip
    dotnet-sdk
    jetbrains.rider
    jetbrains.webstorm
    jetbrains.datagrip
    google-chrome
    spotify
  ];

  system.userActivationScripts = {
    stdio = {
      text = ''
	rm -f ~/Android/Sdk/platform-tools/adb
	ln -s /run/current-system/sw/bin/adb ~/Android/Sdk/platform-tools/adb
      '';
      deps = [
      ];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
