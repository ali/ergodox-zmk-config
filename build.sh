#!/bin/bash
# Local ZMK firmware build using Docker
# Usage: ./build.sh [board] [shield]
#   ./build.sh                    # builds dongle (default)
#   ./build.sh raytac_mdbt50q_rx slicemk_ergodox_dongle

set -e

BOARD="${1:-raytac_mdbt50q_rx}"
SHIELD="${2:-slicemk_ergodox_dongle}"
ZMK_REPO="https://github.com/ali/zmk.git"
ZMK_BRANCH="${ZMK_BRANCH:-main}"  # or feat/battery-reporting

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$SCRIPT_DIR/.build"
ZMK_DIR="$BUILD_DIR/zmk"
OUTPUT_DIR="$SCRIPT_DIR/output"

echo "Building: board=$BOARD shield=$SHIELD"

# Clone ZMK if needed
if [ ! -d "$ZMK_DIR" ]; then
    echo "Cloning SliceMK ZMK fork..."
    mkdir -p "$BUILD_DIR"
    git clone --depth 1 -b "$ZMK_BRANCH" "$ZMK_REPO" "$ZMK_DIR"
fi

mkdir -p "$OUTPUT_DIR"

# Run build in Docker
docker run --rm \
    -v "$ZMK_DIR:/workspaces/zmk:cached" \
    -v "$SCRIPT_DIR/config:/workspaces/zmk-config:cached" \
    -v "$OUTPUT_DIR:/output" \
    -w /workspaces/zmk \
    zmkfirmware/zmk-dev-arm:stable \
    bash -c "
        west init -l app/ 2>/dev/null || true
        west update
        west build -s app -b $BOARD -- \
            -DSHIELD=$SHIELD \
            -DZMK_CONFIG=/workspaces/zmk-config
        cp build/zephyr/zmk.uf2 /output/${SHIELD}-${BOARD}-zmk.uf2
        echo 'Built: /output/${SHIELD}-${BOARD}-zmk.uf2'
    "

echo "Done! Firmware at: $OUTPUT_DIR/${SHIELD}-${BOARD}-zmk.uf2"
