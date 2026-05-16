{ buildUBoot, fetchFromGitHub, armTrustedFirmwareAllwinnerH616, defconfig, ... }:

let
  version = "v2025.10";
  src = fetchFromGitHub {
    owner = "u-boot";
    repo = "u-boot";
    rev = "${version}";
    hash = "sha256-9y21xYwJ/ATFikCRuhalKjAhpRHmOZv6a7GDkLhbon4=";
  };
in
buildUBoot {
  inherit defconfig src version;
  extraMeta.platforms = [ "aarch64-linux" ];
  env.BL31 = "${armTrustedFirmwareAllwinnerH616}/bl31.bin";
  filesToInstall = [ "u-boot-sunxi-with-spl.bin" ];
  extraPatches = [ ./sunxi_fdt.patch ]; # TODO: latest u-boot doesn't need this patch anymore
}
