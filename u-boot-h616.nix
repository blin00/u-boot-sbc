{ buildUBoot, fetchFromGitHub, armTrustedFirmwareAllwinnerH616, defconfig, ... }:

let
  version = "v2026.04";
  src = fetchFromGitHub {
    owner = "u-boot";
    repo = "u-boot";
    rev = "${version}";
    hash = "sha256-LobC22bYpHVGZd5G8IugfcmHacVaHH0aNe3zQG7LJv0=";
  };
in
buildUBoot {
  inherit defconfig src version;
  extraMeta.platforms = [ "aarch64-linux" ];
  env.BL31 = "${armTrustedFirmwareAllwinnerH616}/bl31.bin";
  filesToInstall = [ "u-boot-sunxi-with-spl.bin" ];
}
