{
  stdenvNoCC,
  sources,
  bash,
  autoPatchelfHook,
  ...
}:
stdenvNoCC.mkDerivation rec {
  inherit (sources.ttyescape) pname version src;
  nativeBuildInputs = [
    autoPatchelfHook
  ];

  postInstall = ''
    sed -i "s@#!/bin/sh@${bash}/bin/bash@g" $out/bin/togglevt.sh
    sed -i "s@/usr/bin/togglevt.sh@$out/bin/togglevt.sh@g" $out/etc/hkdm/config.d/ttyescape.toml
  '';
  installPhase = ''
    runHook preInstall
    _install() {
      install -Dm755 ${src}/togglevt.sh $out/bin/togglevt.sh
      install -Dm755 ${src}/ttyescape-hkdm.toml $out/etc/hkdm/config.d/ttyescape.toml
    }
    _install
    runHook postInstall
  '';
}
