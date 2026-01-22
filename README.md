# embedded-bitmap-fonts

A comprehensive collection of bitmap fonts for `no_std` environments, designed for use with the [`embedded-graphics`](https://crates.io/crates/embedded-graphics) crate.

## Features

- **24 font families** with 118+ font variants
- **Pixel-doubling support** - Scale fonts 2x, 3x, or more with zero additional flash cost
- **No-std compatible** - Works on embedded systems without an allocator
- **Feature flags** - Include only the fonts you need to minimize binary size

## Usage

Add to your `Cargo.toml`:

```toml
[dependencies]
embedded-bitmap-fonts = { version = "0.1", features = ["terminus"] }
```

Draw text:

```rust
use embedded_bitmap_fonts::{TextStyle, terminus::FONT_8x16};
use embedded_graphics::{pixelcolor::BinaryColor, prelude::*, text::Text};

let style = TextStyle::new(&FONT_8x16, BinaryColor::On);
Text::new("Hello!", Point::zero(), style).draw(&mut display)?;
```

### Pixel Doubling

Scale fonts without additional memory cost:

```rust
use embedded_bitmap_fonts::terminus::FONT_8x16;

// Original 8x16 font
let small = &FONT_8x16;

// Pixel-doubled 16x32 font (same bitmap data!)
let large = FONT_8x16.pixel_double();

// Triple size 24x48
let huge = FONT_8x16.pixel_triple();

// Custom multiplier
let custom = FONT_8x16.pixel_multiply(4);
```

## Available Fonts

Enable fonts using feature flags:

```toml
# Single font
embedded-bitmap-fonts = { version = "0.1", features = ["terminus"] }

# Multiple fonts
embedded-bitmap-fonts = { version = "0.1", features = ["terminus", "tamzen", "cherry"] }

# All fonts (not recommended for embedded - large binary size)
embedded-bitmap-fonts = { version = "0.1", features = ["all-fonts"] }
```

| Feature | Variants | Sizes | Description |
|---------|----------|-------|-------------|
| `artwiz` | 12 | 5x10 - 11x12 | Artistic bitmap fonts (drift, lime, cure, etc.) |
| `cherry` | 6 | 6x10 - 7x13 | Clean small fonts with bold variants |
| `creep` | 1 | 7x12 | Minimal monospace font |
| `ctrld` | 6 | 6x10 - 8x16 | Fixed-width programming fonts |
| `dina` | 4 | 6x10 - 8x16 | Popular programming font |
| `dylex` | 9 | 6x10 - 14x14 | Multiple sizes with bold/oblique |
| `envypn` | 2 | 7x13, 7x15 | Clean programming font |
| `gohufont` | 4 | 6x11, 8x14 | Popular terminal font with unicode |
| `gomme` | 1 | 10x20 | Single clean font |
| `haxor` | 6 | 6x11 - 9x21 | Hacker-style fonts |
| `jmk` | 13 | 5x10 - 12x24 | Large neep font collection |
| `kakwa` | 2 | 6x12 | Simple fonts with bold |
| `knxt` | 1 | 9x20 | Single tall font |
| `lokaltog` | 3 | 6x10 - 11x11 | Fixed fonts with symbols |
| `mplus` | 10 | 6x13 - 11x14 | Japanese M+ bitmap fonts |
| `orp` | 2 | 6x12 | Clean fonts with bold |
| `peep` | 3 | 7x14 - 10x20 | Zevv peep fonts |
| `phallus` | 2 | 10x12, 10x15 | Lemon fonts |
| `progsole` | 1 | 6x9 | Compact programming font |
| `scientifica` | 2 | 5x12 | Minimal scientific font |
| `tamzen` | 14 | 5x9 - 10x20 | Popular terminal font (default) |
| `terminus` | 18 | 6x12 - 16x32 | Highly readable terminal font |
| `trisk` | 2 | 8x13, 8x14 | Triskweline fonts |
| `xbmicons` | 1 | 9x12 | Icon font |

## Font Generation

Fonts are generated from BDF (Bitmap Distribution Format) files using a custom codegen tool.

### Prerequisites

```bash
# Clone the repository
git clone https://github.com/ecklf/embedded-bitmap-fonts
cd embedded-bitmap-fonts

# Build the codegen tool
cargo build --release -p embedded-bitmap-fonts-codegen
```

### Regenerate All Fonts

```bash
./generate_all.sh
```

### Generate a Single Font

```bash
./target/release/embedded-bitmap-fonts-codegen \
  -i ./fonts/bitmap/terminus \
  -o ./src \
  -f terminus
```

### Codegen Options

```
-i, --input <PATH>     Input directory containing BDF files
-o, --output <PATH>    Output directory for generated Rust files
-f, --family <NAME>    Font family name (used for module name)
-P, --pattern <PAT>    Include only files matching pattern
-X, --exclude <PAT>    Exclude files matching pattern
```

### Adding New Fonts

1. Add BDF files to `fonts/bitmap/<family_name>/`
2. Add entry to `generate_all.sh`
3. Add feature flag to `Cargo.toml`
4. Add module to `src/lib.rs`
5. Run `./generate_all.sh`

## Font Sources

Fonts are sourced from the [Tecate/bitmap-fonts](https://github.com/Tecate/bitmap-fonts) collection. See `fonts/TECATE_README.md` for the original documentation.

## License

This crate is licensed under Apache-2.0. Individual fonts may have their own licenses - check the original font sources for details.
