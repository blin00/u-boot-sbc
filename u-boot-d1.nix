{ lib, buildUBoot, fetchFromGitHub, opensbi, defconfig, ... }: buildUBoot {
  src = fetchFromGitHub {
    owner = "smaeul";
    repo = "u-boot";
    rev = "2e89b706f5c956a70c989cd31665f1429e9a0b48"; # currently the latest commit on d1-wip branch
    hash = "sha256-POjP3PPuluYNTWWo5EUFWT0K3zYFWBFviPOGIhnejCA=";
  };
  version = "2024.01-rc1";
  extraPatches = [ ./sun20i_fix.patch ./sun20i_disable_watchdog.patch ];
  inherit defconfig;
  env.OPENSBI = "${opensbi}/share/opensbi/lp64/generic/firmware/fw_dynamic.bin";
  extraMeta.platforms = [ "riscv64-linux" ];
  filesToInstall = [ "u-boot-sunxi-with-spl.bin" ];
}
