#!/bin/bash
set -e

CODEGEN="./target/release/embedded-bitmap-fonts-codegen"
BITMAP_DIR="./fonts/tecate-bitmap-fonts/bitmap"
OUT_DIR="./src"

# Function to generate a font family
generate() {
    local dir="$1"
    local family="$2"
    local pattern="${3:-}"
    local exclude="${4:-}"
    
    echo "Generating $family..."
    
    args=(-i "$BITMAP_DIR/$dir" -o "$OUT_DIR" -f "$family")
    [ -n "$pattern" ] && args+=(-P "$pattern")
    [ -n "$exclude" ] && args+=(-X "$exclude")
    
    if $CODEGEN "${args[@]}" 2>&1; then
        echo "  OK: $family"
    else
        echo "  FAILED: $family"
    fi
}

# Generate each font family
# Format: generate <directory> <module_name> [include_pattern] [exclude_pattern]

generate "tamzen-font" "tamzen" "Tamzen" "Powerline"
generate "terminus-font-4.39" "terminus" "" ""
generate "spleen" "spleen" "" ""
generate "cherry" "cherry" "" ""
generate "gohufont" "gohufont" "" ""
generate "scientifica" "scientifica" "" ""
generate "tewi-font" "tewi" "" ""
generate "creep" "creep" "" ""
generate "unscii" "unscii" "" ""
generate "profont-x11" "profont" "" ""
generate "ctrld-font" "ctrld" "" ""
generate "envypn-font" "envypn" "" ""
generate "dina" "dina" "" ""
generate "proggy" "proggy" "" ""
generate "bitocra" "bitocra" "" ""
generate "artwiz" "artwiz" "" ""
generate "haxor" "haxor" "" ""
generate "orp-font" "orp" "" ""
generate "montecarlo" "montecarlo" "" ""
generate "zevv-peep" "peep" "" ""
generate "mplus" "mplus" "" ""
generate "ohsnap-1.8.0" "ohsnap" "" ""
generate "leggie" "leggie" "" ""
generate "tamsyn-font-1.11" "tamsyn" "" ""
generate "termsyn-1.8.7" "termsyn" "" ""
generate "kakwa" "kakwa" "" ""
generate "sq" "sq" "" ""

echo "Done!"
