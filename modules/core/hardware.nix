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
  services.fwupd.enable = true;

  hardware.graphics.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.page-cluster" = 0;
  };
}
