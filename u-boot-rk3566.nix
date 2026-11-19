# modified from https://github.com/nabam/nixos-rockchip/blob/main/pkgs/uboot-rockchip.nix

{ buildUBoot, fetchFromGitHub, defconfig, spi ? true, ... }:

let
  version = "v2026.10";
  src = fetchFromGitHub {
    owner = "u-boot";
    repo = "u-boot";
    rev = "${version}";
    hash = "sha256-BXIpyAY+uKSohrdG4BxAo0zq4CYmh2z9rFw1jA7Yu8s=";
  };
  rkbin = fetchFromGitHub {
    owner = "rockchip-linux";
    repo = "rkbin";
    rev = "3e288fe814e059dd06833495f845cab04ac20a5c";
    hash = "sha256-CgGTTGsR0ptrCffYw6A1iujOeQHvVEywqtiqTnxsZjw=";
  };
in
buildUBoot {
  inherit defconfig src version;
  extraMeta.platforms = [ "aarch64-linux" ];
  filesToInstall =
    if spi then
      [
        "u-boot-rockchip.bin"
        "u-boot-rockchip-spi.bin"
      ]
    else
      [ "u-boot-rockchip.bin" ];
  env = {
    BL31 = (rkbin + "/bin/rk35/rk3568_bl31_v1.46.elf");
    ROCKCHIP_TPL = (rkbin + "/bin/rk35/rk3566_ddr_1056MHz_v1.26.bin");
  };
}
