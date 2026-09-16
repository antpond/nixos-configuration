{ pkgs }:

pkgs.stdenvNoCC.mkDerivation {
  pname = "yellow-carp-dmcub-firmware";
  version = "20260810";

  src = pkgs.fetchurl {
    url = "https://gitlab.com/kernel-firmware/linux-firmware/-/archive/20260810/linux-firmware-20260810.tar.gz";
    hash = "sha256-t43QR131qrr+HlFdyYixfejF9a/OFlc0UydfX4VaLLI=";
  };

  dontBuild = true;

  installPhase = ''
    install -Dm444 \
      amdgpu/yellow_carp_dmcub.bin.zst \
      $out/lib/firmware/amdgpu/yellow_carp_dmcub.bin.zst
  '';
}
