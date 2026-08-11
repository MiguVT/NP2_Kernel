# NP² Kernel
![NP²_Kernel](https://socialify.git.ci/MiguVT/NP2_Kernel/image?custom_description=Simple+workflow+for+build+ANY+kernel+with+ReSukiSU+%2B+SuSFS&description=1&font=Inter&forks=1&issues=1&language=1&name=1&owner=1&pattern=Circuit+Board&pulls=1&stargazers=1&theme=Auto)

The official source for this repository is the [GitHub repo](https://github.com/MiguVT/NP2_Kernel) and the Mirror hosted on [MiGit](https://git.miguvt.com/MiguVT/NP2_Kernel) (Forgejo).

The [Releases](https://github.com/MiguVT/NP2_Kernel/releases) include builds compatible with the Nothing Phone 2, including the following kernels:
- **LineageOS's kernel** - Recommended for LineageOS or similar custom ROMs.
> Im currently working to give Nothing official kernel support and also arter97's kernel, Pull Requests are welcome

## Features

- **[ReSukiSU](https://github.com/ReSukiSU/ReSukiSU)**: Kernel-level root (SukiSU-Ultra fork).
- **[SUSFS](https://gitlab.com/simonpunk/susfs4ksu)**: Hide root from banking apps, games, and safety checks.
- **[BaseBandGuard](https://github.com/vc-teahouse/Baseband-guard)**: Prevents apps and modules from modifying critical files.
- ~~**KPM Support**: Enabled via [KernelPatch by SukiSU-Ultra](https://github.com/SukiSU-Ultra/SukiSU_KernelPatch_patch).~~ *(Dropped by ReSukiSU)*

## Install

1. Download the desired Kernel zip from [Releases](https://github.com/MiguVT/NP2_Kernel/releases).
2. Boot into recovery (TWRP / OrangeFox).
3. Flash the zip and reboot.
4. (Optional but recommended) Install [ReSukiSU Manager](https://resukisu.github.io/guide/install.html#Get-manager) to manage root.

> **Warning:** Backup your stock boot image first. Bootloader must be unlocked. Use at your own risk.

## Build it yourself

1. Fork this repo.
2. Go to **Actions** $\rightarrow$ **Build NP2 Kernel** $\rightarrow$ **Run workflow**.
3. Download the zip from the completed run.

## Credits

- [ReSukiSU maintainers & contributors](https://github.com/ReSukiSU/ReSukiSU)
- [simonpunk](https://gitlab.com/simonpunk/susfs4ksu) (SUSFS)
- [osm0sis](https://github.com/osm0sis) (AnyKernel3)
- [vc-teahouse & contributors](https://github.com/vc-teahouse/Baseband-guard) (BaseBandGuard)
