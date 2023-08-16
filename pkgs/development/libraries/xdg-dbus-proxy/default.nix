{ stdenv
, lib
, fetchurl
, meson
, ninja
, pkg-config
, libxslt
, docbook-xsl-nons
, docbook_xml_dtd_43
, dbus
, glib
}:

stdenv.mkDerivation rec {
  pname = "xdg-dbus-proxy";
  version = "0.1.5";

  src = fetchurl {
    url = "https://github.com/flatpak/xdg-dbus-proxy/releases/download/${version}/${pname}-${version}.tar.xz";
    sha256 = "sha256-Bh3Pr4oGUOX9nVQy3+iL2nSeoNB53BNjBL/s+84GYfs=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    libxslt
    docbook-xsl-nons
    docbook_xml_dtd_43
  ];

  buildInputs = [
    glib
  ];

  nativeCheckInputs = [
    dbus
  ];

  # dbus[2345]: Failed to start message bus: Failed to open "/etc/dbus-1/session.conf": No such file or directory
  doCheck = false;

  meta = with lib; {
    description = "DBus proxy for Flatpak and others";
    homepage = "https://github.com/flatpak/xdg-dbus-proxy";
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ jtojnar ];
    platforms = platforms.linux;
    mainProgram = "xdg-dbus-proxy";
  };
}
