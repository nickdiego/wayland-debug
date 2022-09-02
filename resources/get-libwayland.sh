#!/bin/bash
# This script clones/pulls and builds libwayland in debug mode. It can be run from any directory. If
# anything goes wrong, feel free to rm -Rf resources/wayland and run again.

# Put bash into unofficial safe mode
set -euo pipefail

# Move into the directory where this script is located
cd "$( dirname "${BASH_SOURCE[0]}" )"

# If our last attempt resulted in an incomplete build, wipe it and start over
if test ! -d wayland/build/src/libwayland-client.so
then
    rm -Rf wayland/
fi

# Get the latest libwayland and move into the wayland directory
if ! test -d wayland
then
    git clone https://gitlab.freedesktop.org/wayland/wayland.git
fi

cd wayland
git reset --hard origin/main
git pull

# Apply patches
git apply ../libwayland-patches/*.patch

if ! test -d build
then
    echo "Running meson…"
    meson --buildtype=debug -Dtests=false -Ddocumentation=false -Ddtd_validation=false build
fi

echo "Building…"
ninja -C build

echo "Done"