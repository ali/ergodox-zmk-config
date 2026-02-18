{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    zmk-nix = {
      url = "github:lilyinstarlight/zmk-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, zmk-nix }: let
    forAllSystems = nixpkgs.lib.genAttrs (nixpkgs.lib.attrNames zmk-nix.packages);

    # Only include ZMK-relevant source files
    src = nixpkgs.lib.sourceFilesBySuffices self [
      ".board" ".cmake" ".conf" ".defconfig" ".dts" ".dtsi"
      ".json" ".keymap" ".overlay" ".shield" ".yml" "_defconfig"
    ];

    zephyrDepsHash = "sha256-WSuUx+0JL3N4Vv5nwANjTJBJYfTXVSDvP5w8aQ+t0Ds=";
  in {
    packages = forAllSystems (system: let
      builders = zmk-nix.legacyPackages.${system};
    in rec {
      default = firmware;

      # Green dongle (202205 keyboard) — primary target
      firmware = builders.buildKeyboard {
        name = "zmk-dongle-green";
        inherit src zephyrDepsHash;
        board = "raytac_mdbt50q_rx_green";
        shield = "slicemk_ergodox_dongle";
      };

      # Non-green dongle (202108 solar keyboard)
      firmware-solar = builders.buildKeyboard {
        name = "zmk-dongle";
        inherit src;
        board = "raytac_mdbt50q_rx";
        shield = "slicemk_ergodox_dongle";
        # Same west manifest = same deps, reuse from primary build
        westDeps = firmware.westDeps;
        zephyrDepsHash = "";
      };

      update = zmk-nix.packages.${system}.update;
    });

    devShells = forAllSystems (system: {
      default = zmk-nix.devShells.${system}.default;
    });
  };
}
