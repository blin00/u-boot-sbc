{ buildUBoot, fetchFromGitHub, armTrustedFirmwareAllwinnerH616, defconfig, ... }:

let
  version = "v2026.10";
  src = fetchFromGitHub {
    owner = "u-boot";
    repo = "u-boot";
    rev = "${version}";
    hash = "sha256-BXIpyAY+uKSohrdG4BxAo0zq4CYmh2z9rFw1jA7Yu8s=";
  };
in
buildUBoot {
  inherit defconfig src version;
  extraPatches = [ ./sunxi_rng.patch ];
  extraMeta.platforms = [ "aarch64-linux" ];
  env.BL31 = "${armTrustedFirmwareAllwinnerH616}/bl31.bin";
  filesToInstall = [ "u-boot-sunxi-with-spl.bin" ];
}
