{
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachSystem flake-utils.lib.allSystems (system:
    let systems = flake-utils.lib.system; in {
      packages = (let pkgs = if system == systems.riscv64-linux then nixpkgs.legacyPackages.${system} else nixpkgs.legacyPackages.${system}.pkgsCross.riscv64; in {
        # write these starting at sector 16 or 256
        ubootMangoPiMQPro = pkgs.callPackage ./u-boot-d1.nix { defconfig = "mangopi_mq_pro_defconfig"; };
        # remaining risc-v images are untested
        ubootDongshanPiNezhaSTU = pkgs.callPackage ./u-boot-d1.nix { defconfig = "dongshan_nezha_stu_defconfig"; };
        ubootLicheeRV86Panel = pkgs.callPackage ./u-boot-d1.nix { defconfig = "lichee_rv_86_panel_defconfig"; };
        ubootLicheeRVDock = pkgs.callPackage ./u-boot-d1.nix { defconfig = "lichee_rv_dock_defconfig"; };
        ubootNezha = pkgs.callPackage ./u-boot-d1.nix { defconfig = "nezha_defconfig"; };
        # ubootDevTermR01 = pkgs.callPackage ./u-boot-d1.nix { defconfig = "devterm_r_01_defconfig"; }; # broken; dts missing and upstream kernel dts doesn't work out of the box in old u-boot source
      }) // (let pkgs = if system == systems.aarch64-linux then nixpkgs.legacyPackages.${system} else nixpkgs.legacyPackages.${system}.pkgsCross.aarch64-multiplatform; in {
        # write these starting at sector 16
        ubootOrangePiZero3 = pkgs.callPackage ./u-boot-h616.nix { defconfig = "orangepi_zero3_defconfig"; };
        # write these starting at sector 64
        ubootRadxaCM3IO = pkgs.callPackage ./u-boot-rk3566.nix { defconfig = "radxa-cm3-io-rk3566_defconfig"; spi = false; };
      });
    }
  );
}
