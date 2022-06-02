# { lib, stdenv, yad, xsel}:

with import <nixpkgs> {} ;
stdenv.mkDerivation rec {
  pname = "middlefix";
  version = "2022-04-07";

  src = /home/lennart/Documents/middlefix ;

  buildInputs = [
    yad
    xsel
    makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/bin $out/idk
    cp $src/middlefix.sh $out/idk/middlefix
    chmod +x $out/idk/middlefix

    makeWrapper $out/idk/middlefix $out/bin/middlefix \
      --set PATH ${lib.makeBinPath [ yad xsel ]}


    cat << EOF > ${pname}.desktop
    [Desktop Entry]
    Name=Permanently clear the primary clibboard
    Categories=Application;System
    Exec=$out/bin/middlefix
    Terminal=false
    Type=Application
    X-GNOME-AutoRestart=true
    X-GNOME-Autostart-enabled=true
    EOF

    mkdir -p $out/share/applications
    mkdir -p $out/etc/xdg/autostart
    cp ${pname}.desktop $out/share/applications/${pname}.desktop
    cp ${pname}.desktop $out/etc/xdg/autostart/${pname}.desktop
  '';

  meta = with lib; {
    platforms = platforms.linux;
    maintainers = with maintainers; [ zebreus ];
  };
}
