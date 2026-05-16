# modified from https://github.com/nabam/nixos-rockchip/blob/main/pkgs/uboot-rockchip.nix

{ buildUBoot, fetchFromGitHub, defconfig, spi ? true, ... }:

let
  version = "v2026.04";
  src = fetchFromGitHub {
    owner = "u-boot";
    repo = "u-boot";
    rev = "${version}";
    hash = "sha256-LobC22bYpHVGZd5G8IugfcmHacVaHH0aNe3zQG7LJv0=";
  };
  rkbin = fetchFromGitHub {
    owner = "rockchip-linux";
    repo = "rkbin";
    rev = "74213af1e952c4683d2e35952507133b61394862";
    hash = "sha256-gNCZwJd9pjisk6vmvtRNyGSBFfAYOADTa5Nd6Zk+qEk=";
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
    BL31 = (rkbin + "/bin/rk35/rk3568_bl31_v1.45.elf");
    ROCKCHIP_TPL = (rkbin + "/bin/rk35/rk3566_ddr_1056MHz_v1.23.bin");
  };
}
