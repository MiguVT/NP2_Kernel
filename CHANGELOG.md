# Changelog
> Updates not listed here are because there wasn't changes on the workflow, only updated upstream.

## v3.0.3 - The ReSukiSU move (April.2 2026)

#### LineageOS Kernel
Name: LineageOS-ReSukiSU-Pong.zip
Linux 5.10.246 · Android 13 GKI

#### Arter97 Kernel
Name: Arter97-ReSukiSU-Pong.zip
Linux 5.10 · Android 12 GKI

### New

- Moved to [ReSukiSU](https://github.com/ReSukiSU/ReSukiSU)
- Maintain vanilla SuSFS config, Modules should manage it themselves.

### Variants

- **ReSukiSU-SUSFS** - WildKSU + SUSFS hiding
- **ReSukiSU** - WildKSU only, no hiding

## v3.0.0 - Complete Rewrite (March.1 2026)

Linux 5.10.246 · Android 13 GKI

### New

- Rewrote the build system from scratch (clean GitHub Actions workflow, proper GKI config fragments)
- WildKSU v3.0.0 with latest SuSFS and upstream KSU fixes
- SUSFS v2.0.0+ for root/module hiding (banking apps, SafetyNet, Play Integrity)
- Enabled Thin LTO for better performance
- Build now warns if critical configs are wrong

### Fixed

- Fixed config fragment ordering to match official LineageOS BoardConfig

### Variants

- **WKSU-SUSFS** - WildKSU + SUSFS hiding
- **WKSU** - WildKSU only, no hiding
