{
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  security.rtkit.enable = true;

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  hardware.graphics.enable = true;
}
