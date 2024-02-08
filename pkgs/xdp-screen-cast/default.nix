{ lib
, python3
, fetchgit
, gst_all_1
, pipewire
, gobject-introspection
}: python3.pkgs.buildPythonPackage rec {
  pname = "xdp-screen-cast";
  version = "1251885934cf9e1ce0078f889d937a1d1c8947c8";
  src = fetchgit {
    url = "https://gitlab.gnome.org/snippets/19.git";
    rev = version;
    hash = "sha256-d14WJgttn2FCbIUqj/l634E8gZTkeoMnc5zP0PzZV6c=";
  };
  patches = [
    ./fix.patch # https://github.com/taoky/scripts/blob/5ddebe425e5703427015ce4da52a66048776fc40/bin/xdp-screen-cast
  ];

  nativeBuildInputs = buildInputs;
  buildInputs = [
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    pipewire
    gobject-introspection
  ];
  propagatedBuildInputs = with python3.pkgs; [
    pygobject3
    gst-python
    dbus-python
  ];

  makeWrapperArgs = [
    "--set GI_TYPELIB_PATH $GI_TYPELIB_PATH"
    "--set GST_PLUGIN_SYSTEM_PATH_1_0 $GST_PLUGIN_SYSTEM_PATH_1_0"
  ];

  format = "other";
  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp ${pname}.py $out/bin/${pname}
    chmod +x $out/bin/${pname}

    runHook postInstall
  '';

}
