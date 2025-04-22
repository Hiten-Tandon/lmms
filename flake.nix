{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      with import nixpkgs { inherit system; }; {
        devShells.default = mkShell {
          nativeBuildInputs = [ cmake gnumake libsForQt5.qttools pkg-config ];
          buildInputs = [
            carla
            alsa-lib
            fftwFloat
            fltk13
            fluidsynth
            lame
            libgig
            libjack2
            libpulseaudio
            libsamplerate
            libsndfile
            libsoundio
            libvorbis
            portaudio
            qt5Full
            libsForQt5.qtx11extras
            SDL
          ];
        };
        packages.default = stdenv.mkDerivation (rec {
          pname = "lmms";
          version = "1.2.2";

          src = fetchFromGitHub {
            owner = "Hiten-Tandon";
            repo = "lmms";
            sha256 = "006hwv1pbh3y5whsxkjk20hsbgwkzr4dawz43afq1gil69y7xpda";
            fetchSubmodules = true;
          };

          nativeBuildInputs = [ cmake libsForQt5.qttools pkg-config ];

          buildInputs = [
            carla
            alsa-lib
            fftwFloat
            fltk13
            fluidsynth
            lame
            libgig
            libjack2
            libpulseaudio
            libsamplerate
            libsndfile
            libsoundio
            libvorbis
            portaudio
            qt5Full
            libsForQt5.qtx11extras
            SDL
			libsForQt5.wrapQtAppsHook
          ];

          # patches = [
          #   (fetchpatch {
          #     url =
          #       "https://raw.githubusercontent.com/archlinux/svntogit-community/cf64acc45e3264c6923885867e2dbf8b7586a36b/trunk/lmms-carla-export.patch";
          #     sha256 = "sha256-wlSewo93DYBN2PvrcV58dC9kpoo9Y587eCeya5OX+j4=";
          #   })
          # ];

          cmakeFlags = [ "-DWANT_QT5=ON" ];

          meta = with lib; {
            description =
              "DAW similar to FL Studio (music production software)";
            mainProgram = "lmms";
            homepage = "https://lmms.io";
            license = licenses.gpl2Plus;
            platforms = [ "x86_64-linux" "i686-linux" ];
            maintainers = [ ];
          };
        });
        formatter = nixfmt-classic;
      });
}
