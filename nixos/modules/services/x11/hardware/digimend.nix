{
  config,
  lib,
  pkgs,
  ...
}:
let

  cfg = config.services.xserver.digimend;

  pkg = config.boot.kernelPackages.digimend;

in

{

  options = {

    services.xserver.digimend = {

      enable = lib.mkEnableOption "the digimend drivers for Huion/XP-Pen/etc. tablets";

    };

  };

  config = lib.mkIf cfg.enable {

    # digimend drivers use xsetwacom and wacom X11 drivers
    services.xserver.wacom.enable = true;

    boot.extraModulePackages = [ pkg ];

    environment.etc."X11/xorg.conf.d/50-digimend.conf".source =
      "${pkg}/usr/share/X11/xorg.conf.d/50-digimend.conf";

  };

}
