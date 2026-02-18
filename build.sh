#!/bin/bash

mkdir -p build-src/.cache/

echo "Setting pygame environment variable..."
export PYGAME_HIDE_SUPPORT_PROMPT=1

REBUILD=true

if [ -f build-src/bark ] && [ -f build-src/.cache/bark ]; then
    if cmp -s "bark" "build-src/.cache/bark"; then
        echo "Cached build is the same. Skipping..."
        REBUILD=false
    fi
fi

if [ "$REBUILD" = true ]; then
    echo "Building..."
    cp bark build-src/.cache/ # Cache the most recent version
    
    pyinstaller --log-level FATAL --paths "$PYTHONPATH" --onefile bark
    
    echo "Moving executable..."
    mv dist/bark build-src/
    
    echo "Cleaning up..."
    rm -rf dist/ build/ bark.spec
    echo -e "Done! Check \033[1mbuild-src/\033[0m for your executable"
else
    echo "Nothing to do."
fi
