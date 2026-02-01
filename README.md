# Nothing Phone 2 Kernel Builder

[![Build Kernel](https://github.com/MiguVT/NP2_Kernel/actions/workflows/build.yml/badge.svg)](https://github.com/MiguVT/NP2_Kernel/actions/workflows/build.yml)
[![Android 12+](https://img.shields.io/badge/Android-12+-green?logo=android)](https://developer.android.com/about/versions/12)
[![Kernel 5.10](https://img.shields.io/badge/Kernel-5.10-blue)](https://www.kernel.org/)
[![WildKSU](https://img.shields.io/badge/WildKSU-3.0.0-orange)](https://github.com/WildKernels/Wild_KSU)

Automated GitHub Actions workflow that builds a custom kernel for **Nothing Phone 2 (Pong)** based on [Meteoric Kernel Cleaned](https://github.com/MiguVT/kernel_nothing_sm8475_cleaned), a fork based on [Meteoric Kernel](https://github.com/HELLBOY017/kernel_nothing_sm8475) but without the manual modification, allowing us to integrate [WildKSU](https://github.com/WildKernels/Wild_KSU) root solution and SUSFS root hiding baked right in.

---

## ✨ Features

- **WildKSU 3.0.0** — Modern root solution with app-level control (KernelSU fork)
- **SUSFS v2.0.0+** — Advanced root hiding for banking apps, games, etc.
- **Signed boot images** — GKI-certified with proper AVB signing
- **AnyKernel3 flashable zip** — Easy installation via custom recovery
- **Build caching** — Subsequent builds complete in 3-5 minutes
- **Fully configurable** — Toggle features on/off via workflow inputs

## 📱 Device Info

| Property | Value |
|----------|-------|
| Device | Nothing Phone 2 |
| Codename | Pong |
| Platform | SM8475 (Snapdragon 8+ Gen 1) |
| Android | 12 (GKI) |
| Kernel | 5.10.x |
| Defconfig | `vendor/meteoric_defconfig` |

---

## 🚀 Quick Start

### Option 1: Use Pre-built Releases
Check the [Releases](../../releases) page for ready-to-flash builds.

### Option 2: Build It Yourself

1. **Fork this repository**

2. **Go to Actions tab** → Select "Build Nothing Phone 2 Kernel"

3. **Click "Run workflow"** and configure:
   - `kernel_branch`: Source branch (default: `clean`)
   - `os_patch_level`: Security patch date, e.g., `2025-12`
   - `enable_kernelsu`: Toggle WildKSU (default: ✅)
   - `enable_susfs`: Toggle SUSFS hiding (default: ✅)
   - `build_type`: `release` or `debug`

4. **Wait ~30 minutes** for the build to complete

5. **Download artifacts** from the completed workflow run

---

## 📦 Build Outputs

After a successful build, you'll get these artifacts:

| Artifact | Description | Use Case |
|----------|-------------|----------|
| `*-AnyKernel3` | Flashable zip package | Flash via TWRP/OrangeFox |
| `*-boot.img` | Signed boot image (raw) | Fastboot flash |
| `*-boot-gz.img` | Signed boot image (gzip) | Alternative compression |
| `*-boot-lz4.img` | Signed boot image (lz4) | Fastest boot time |
| `*-kernel-images` | Raw Image files | Custom integrations |
| `*-build-info` | Build metadata | Version tracking |

---

## 📲 Flashing Instructions

> ⚠️ **WARNING: Read This First!**
> - Your **bootloader must be unlocked** — this voids your warranty
> - **Back up your data** before proceeding — things can go wrong
> - Make sure you have a working stock boot image to recover

### Method 1: AnyKernel3 (Recommended)

```bash
# Boot into recovery (TWRP, OrangeFox, etc.)
# Flash the AnyKernel3 zip
# Reboot and enjoy!
```

### Method 2: Fastboot

```bash
# Reboot to bootloader
adb reboot bootloader

# Flash the boot image (use the variant that matches your needs)
fastboot flash boot boot.img

# Reboot
fastboot reboot
```

### After Flashing

1. Install [KernelSU Manager](https://github.com/tiann/KernelSU/releases) app
2. Open the app — it should show "Working" status
3. Grant root to your apps as needed
4. (Optional) Configure SUSFS via the KernelSU Manager

---

## ⚙️ Configuration Options

### Workflow Inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `kernel_branch` | string | `clean` | Kernel source branch to build |
| `os_patch_level` | string | `2025-12` | Android security patch level (YYYY-MM) |
| `ksu_version` | string | _(latest)_ | Specific WildKSU version/commit |
| `enable_kernelsu` | boolean | `true` | Include WildKSU in build |
| `enable_susfs` | boolean | `true` | Include SUSFS root hiding |
| `build_type` | choice | `release` | Build optimization level |

### SUSFS Features Enabled

The build includes these SUSFS modules (for `gki-android12-5.10`):

- `CONFIG_KSU_SUSFS` — Core SUSFS functionality
- `CONFIG_KSU_SUSFS_SUS_PATH` — Hide suspicious paths
- `CONFIG_KSU_SUSFS_SUS_MOUNT` — Hide mount points
- `CONFIG_KSU_SUSFS_TRY_UMOUNT` — Attempt unmounting
- `CONFIG_KSU_SUSFS_SUS_KSTAT` — Spoof file stats
- `CONFIG_KSU_SUSFS_SPOOF_UNAME` — Spoof kernel version
- `CONFIG_KSU_SUSFS_ENABLE_LOG` — Debug logging

---

## 🔧 Customization

### Using a Custom Signing Key

For production use, you can provide your own boot signing key:

1. Go to **Settings** → **Secrets and variables** → **Actions**
2. Create a new secret named `BOOT_SIGN_KEY`
3. Paste your RSA 2048 private key in PEM format

If not provided, the build uses AOSP test keys (fine for personal use).

### Adding Custom Config Options

Edit the defconfig or modify the "Configure Kernel" step in the workflow to add your own kernel options.

---

## 🐛 Troubleshooting

### Build fails at defconfig step
- Check that `pong_defconfig` exists in the kernel source
- Verify the kernel branch is correct

### WildKSU not working after flash
- Ensure you're using the correct boot image for your slot
- Try flashing via AnyKernel3 instead of fastboot
- Check the KernelSU Manager app for detailed status

### SUSFS not hiding root
- Some apps use advanced detection — check SUSFS logs
- Ensure `CONFIG_KSU_SUSFS=y` is in the build summary
- Update to latest SUSFS userspace tools

### Device bootloops
- Boot to fastboot: hold Volume Down + Power
- Flash your backup boot image: `fastboot flash boot stock_boot.img`
- Report the issue with build logs

---

## 📚 Resources

- [WildKSU](https://github.com/WildKernels/Wild_KSU) — Root solution (KernelSU-Next fork with better susfs support)
- [KSU-Next](https://kernelsu-next.github.io/webpage/) — The base KernelSU-Next project
- [SUSFS](https://gitlab.com/simonpunk/susfs4ksu) — Root hiding patches
- [AnyKernel3](https://github.com/osm0sis/AnyKernel3) — Flashable zip creator
- [Nothing Phone 2 XDA](https://forum.xda-developers.com/f/nothing-phone-2.12767/) — Community support

---

## 🙏 Credits

- **WildKernels Team** — For WildKSU root solution
- **simonpunk** — For SUSFS root hiding
- **osm0sis** — For AnyKernel3
- **Nothing** — For making a great phone
- **Google** — For GKI and Android

---

## ⚖️ Disclaimer

This is an unofficial community project. Use at your own risk.

- Unlocking your bootloader **voids your warranty**
- Flashing custom kernels can **brick your device**
- We are **not responsible** for any damage to your device
- Always keep a backup of your stock boot image

---

<p align="center">
  <i>Made with ☕ by the community, for the community</i>
</p>
