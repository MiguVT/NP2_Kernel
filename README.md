# NP² Kernel
![NP²_Kernel](https://socialify.git.ci/MiguVT/NP2_Kernel/image?custom_description=Simple+workflow+for+build+ANY+kernel+with+BakaSU+%2B+SUSFS&description=1&font=Inter&forks=1&issues=1&language=1&name=1&owner=1&pattern=Circuit+Board&pulls=1&stargazers=1&theme=Auto)

The official source for this repository is the [GitHub repo](https://github.com/MiguVT/NP2_Kernel) and the Mirror hosted on [MiGit](https://git.miguvt.com/MiguVT/NP2_Kernel) (Forgejo).

The [Releases](https://github.com/MiguVT/NP2_Kernel/releases) include builds compatible with the Nothing Phone 2, including the following kernels:
- **LineageOS's kernel** - Recommended for LineageOS or similar custom ROMs.
> Im currently working to give Nothing official kernel support, Pull Requests are welcome

## Features

- **[BakaSU](https://github.com/Baka-SU/BakaSU)**: Kernel-level root.
- **[SUSFS](https://gitlab.com/simonpunk/susfs4ksu)**: Hide root from banking apps, games, and safety checks.
- **[BaseBandGuard](https://github.com/vc-teahouse/Baseband-guard)**: Prevents apps and modules from modifying critical files.
- ~~**KPM Support**: Enabled via [KernelPatch by SukiSU-Ultra](https://github.com/SukiSU-Ultra/SukiSU_KernelPatch_patch).~~ *(Dropped by BakaSU)*

## Install

::: tip
We assume you already have basic firmware flashing skills and bricking recovery knowledge, so this section of the documentation will not be overly detailed.
:::

### Get Manager

::: tip Still Work in Progress...
Because BakaSU's manager have too much things to do,so BakaSU will not be released on GitHub Release. However, you can obtain the manager currently under development via [`nightly.link`](https://nightly.link/Baka-SU/BakaSU/workflows/build-manager/main/Manager-release.zip) or [`GitHub Action`](https://github.com/Baka-SU/BakaSU/actions/workflows/build-manager.yml?query=branch:main).

(Nightly.link allows downloading files without logging into a GitHub account.)
:::

::: warning
Except for the _main_ branch, all other branches are testing branches. Unless requested, please do not provide any feedback when working with these branches.
:::

### Install

1. Download the desired Kernel zip from [Releases](https://github.com/MiguVT/NP2_Kernel/releases).
2. Boot into recovery (TWRP / OrangeFox).
3. Flash the zip and reboot.
4. (Optional but recommended) Install [BakaSU Manager](#get-manager) to manage root.

> **Warning:** Backup your stock boot image first. Bootloader must be unlocked. Use at your own risk.

BakaSU provides the following two installation methods:

### LKM Installation

::: tip
This part has been moved to [this page](https://bakasu.org/guide/install/gki#lkm).
:::

### GKI2/GKI1/Non-GKI Kernel (AnyKernel3) Installation

Although the BakaSU Manager has a built-in AnyKernel3 installation method, this option will not be displayed if the Manager does not have ROOT access. You may need to perform the following steps to enable it

1. Flash AnyKernel3 after LKM installation to grant root.
2. Using `magiskboot` to manual patch boot.img.

#### Patch boot.img manually

::: info Note
This part picked from [KernelSU official Documentation](https://kernelsu.org)
:::

1. [magiskboot](https://github.com/topjohnwu/Magisk/releases)
2. [magiskboot_build](https://github.com/ookiineko/magiskboot_build/releases/tag/last-ci)

The official build of `magiskboot` can only run on Android devices, if you want to run it on PC, you can try the second option.

##### Preparation

1. Get your device's stock boot.img. You can get it from your device manufacturers. You may need [payload-dumper-go](https://github.com/ssut/payload-dumper-go).
2. Unpack the AnyKernel3 package and get the `Image` file, which is the kernel file of BakaSU.

##### Using magiskboot on Android devices

1. Download latest Magisk from [GitHub Releases](https://github.com/topjohnwu/Magisk/releases).
2. Rename `Magisk-*(version).apk` to `Magisk-*.zip` and unzip it.
3. Push `Magisk-*/lib/arm64-v8a/libmagiskboot.so` to your device by ADB: `adb push Magisk-*/lib/arm64-v8a/libmagiskboot.so /data/local/tmp/magiskboot`
4. Push stock boot.img and Image in AnyKernel3 to your device.
5. Enter ADB shell and run `cd /data/local/tmp/` directory, then `chmod +x magiskboot`
6. Enter ADB shell and run `cd /data/local/tmp/` directory, execute `./magiskboot unpack boot.img` to unpack `boot.img`, you will get a `kernel` file, this is your stock kernel.
7. Replace `kernel` with `Image` by running the command: `mv -f Image kernel`.
8. Execute `./magiskboot repack boot.img` to repack boot image, and you will get a `new-boot.img` file, flash this file to device by fastboot.

##### Using magiskboot on Windows/macOS/Linux PC

1. Download the corresponding `magiskboot` binary for your OS from [magiskboot_build](https://github.com/ookiineko/magiskboot_build/releases/tag/last-ci).
2. Prepare stock `boot.img` and `Image` in your PC.
3. Run `chmod +x magiskboot`.
4. Enter the corresponding directory, execute `./magiskboot unpack boot.img` to unpack `boot.img`, you will get a `kernel` file, this is your stock kernel.
5. Replace `kernel` with `Image` by running the command: `mv -f Image kernel`.
6. Execute `./magiskboot repack boot.img` to repack the boot image, and you will get a `new-boot.img` file, flash this file to device by fastboot.

::: info
Official `magiskboot` can run in `Linux` environments normally, if you're a Linux user, you can use the official build.
::: 

## Build it yourself

1. Fork this repo.
2. Go to **Actions** $\rightarrow$ **Build NP2 Kernel** $\rightarrow$ **Run workflow**.
3. Download the zip from the completed run.

## Building Kernel with BakaSU

BakaSU can be integrated into non-GKI kernels and was <mark>backported to 3.4 and earlier</mark> versions.

Due to the fragmentation of non-GKI kernels, we don't have a universal way to build them; therefore, we cannot provide a non-GKI boot.img. However, you can build the kernel with BakaSU integrated on your own.

First, you should be able to build a bootable kernel from kernel source code. If the kernel isn't open source, then it is difficult to run BakaSU for your device.

If you're able to build a bootable kernel, you can add BakaSU into your kernel by following this guide.

### Sync the kernel source code

```sh
repo init -u https://android.googlesource.com/kernel/manifest
mv <kernel_manifest.xml> .repo/manifests
repo init -m manifest.xml
repo sync
```

The `<kernel_manifest.xml>` file is a manifest that uniquely identifies a build, allowing you to make it reproducible. To do this, you should download the manifest file from [GKI release builds](https://source.android.com/docs/core/architecture/kernel/gki-release-builds).

### Build

Please check the [Building kernels](https://source.android.com/docs/setup/build/building-kernels) first.

For example, to build an `aarch64` kernel image:

```sh
LTO=thin BUILD_CONFIG=common/build.config.gki.aarch64 build/build.sh
```

Don't forget to add the `LTO=thin` flag; otherwise, the build may fail if your computer has less than 24 GB of memory.

Starting from Android 13, the kernel is built by `bazel`:

```sh
tools/bazel build --config=fast //common:kernel_aarch64_dist
```

### Build kernel with BakaSU

First, add BakaSU to your kernel source tree:

```sh
curl -LSs "https://raw.githubusercontent.com/Baka-SU/BakaSU/main/kernel/setup.sh" | bash
```

Then, choose **one of the following methods** to integrate BakaSU into your kernel:

### Manual hooks

::: tip
Keep in mind that, on some devices, your defconfig may be located at `arch/arm64/configs` or in other cases, it may be at `arch/arm64/configs/vendor/your_defconfig`. Regardless of the defconfig you're using, make sure to enable `CONFIG_KSU` with `y` to enable or `n` to disable it. For example, if you choose to enable it, your defconfig should contain the following string：

`arch/arm64/configs/...`

```diff
+# BakaSU
+CONFIG_KSU=y
+CONFIG_KSU_MANUAL_HOOK=y
```
:::

Then, add [BakaSU's hooks](#manual-hooks-reference) into your kernel, and build your kernel again, and BakaSU should work correctly.

### SUSFS

::: warning
SUSFS is no longer supported for NonGKI kernels, if you want to use SUSFS on NonGKI kernel, please manually backport the patches from `gki-android12-5.10` branch.
:::

::: danger
BakaSU's SUSFS part of the kernel code is **updated from the SUSFS repository**. If you encounter build errors or boot problems, please CHECK the update log of the SUSFS repository FIRST.

if you are sure that BakaSU's SUSFS part of the kernel code has not been updated, please report this issue to BakaSU.
:::

::: tip
Keep in mind that, on some devices, your defconfig may be located at `arch/arm64/configs` or in other cases, it may be at `arch/arm64/configs/vendor/your_defconfig`. Regardless of the defconfig you're using, make sure to enable `CONFIG_KSU` with `y` to enable or `n` to disable it. For example, if you choose to enable it, your defconfig should contain the following string：

`arch/arm64/configs/...`

```diff
+# BakaSU
+CONFIG_KSU=y
+CONFIG_KSU_SUSFS=y
```
:::

Then, in the [SUSFS repository](https://gitlab.com/simonpunk/susfs4ksu), **choose the branch that matches your kernel version** and apply the **kernel-side patches** as instructed; after making the changes, rebuild the kernel.

## Manual hooks reference

::: danger Notice：
BakaSU will check every hook here, and if any are missing, it will **cause compilation to fail**.
:::

::: info info
The hook in this part is adapted from [`backslashxx/KernelSU #5`](https://github.com/backslashxx/KernelSU/issues/5)
:::

### stat hook Required

::: code-group
```diff [stat.c]
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -353,6 +353,10 @@ SYSCALL_DEFINE2(newlstat, const char __user *, filename,
 	return cp_new_stat(&stat, statbuf);
 }

+#ifdef CONFIG_KSU_MANUAL_HOOK
+__attribute__((hot))
+extern int ksu_handle_stat(int *dfd, const char __user **filename_user,
+				int *flags);
+
+extern void ksu_handle_newfstat_ret(unsigned int *fd, struct stat __user **statbuf_ptr);
+#if defined(__ARCH_WANT_STAT64) || defined(__ARCH_WANT_COMPAT_STAT64)
+extern void ksu_handle_fstat64_ret(unsigned long *fd, struct stat64 __user **statbuf_ptr); // optional
+#endif
+#endif
+
 #if !defined(__ARCH_WANT_STAT64) || defined(__ARCH_WANT_SYS_NEWFSTATAT)
 SYSCALL_DEFINE4(newfstatat, int, dfd, const char __user *, filename,
 		struct stat __user *, statbuf, int, flag)
@@ -360,6 +364,9 @@ SYSCALL_DEFINE4(newfstatat, int, dfd, const char __user *, filename,
 	struct kstat stat;
 	int error;

+#ifdef CONFIG_KSU_MANUAL_HOOK
+	ksu_handle_stat(&dfd, &filename, &flag);
+#endif
 	error = vfs_fstatat(dfd, filename, &stat, flag);
 	if (error)
 		return error;
@@ -504,6 +511,9 @@ SYSCALL_DEFINE4(fstatat64, int, dfd, const char __user *, filename,
 	struct kstat stat;
 	int error;

+#ifdef CONFIG_KSU_MANUAL_HOOK // 32-bit su
+	ksu_handle_stat(&dfd, &filename, &flag);
+#endif
 	error = vfs_fstatat(dfd, filename, &stat, flag);
 	if (error)
 		return error;

@@ -364,X +364,XX @@
SYSCALL_DEFINE2(newfstat, unsigned int, fd, struct stat __user *, statbuf)
{
	struct kstat stat;
	int error = vfs_fstat(fd, &stat);

	if (!error)
		error = cp_new_stat(&stat, statbuf);

+#ifdef CONFIG_KSU_MANUAL_HOOK
+	ksu_handle_newfstat_ret(&fd, &statbuf);
+#endif
	return error;


@@ -490,X +497,X @@
SYSCALL_DEFINE2(fstat64, unsigned long, fd, struct stat64 __user *, statbuf)
{
	struct kstat stat;
	int error = vfs_fstat(fd, &stat);

	if (!error)
		error = cp_new_stat64(&stat, statbuf);

+#ifdef CONFIG_KSU_MANUAL_HOOK // for 32-bit
+	ksu_handle_fstat64_ret(&fd, &statbuf);
+#endif
	return error;
}
```
:::

In this part, you should find `newfstatat` and `fstatat64` (if 32-bit su is supported) in `fs/stat.c` and hook them. You also need to hook `newfstat` and `fstat64` (if 32-bit su is supported) for the return value.

### execve hook Required

For this hook, different kernel versions are inconsistent, so it is explained separately here

::: code-group

```diff [3.14+]
diff --git a/exec.c b/exec.c
index 5344364..cc612f0 100644
--- a/exec.c
+++ b/exec.c
@@ -1703,6 +1703,15 @@ static int exec_binprm(struct linux_binprm *bprm)
 	return ret;
 }
 
+#ifdef CONFIG_KSU_MANUAL_HOOK
+__attribute__((hot))
+extern int ksu_handle_execveat(int *fd, struct filename **filename_ptr,
+				void *argv, void *envp, int *flags);
+__attribute__((hot))
+extern int ksu_handle_post_execveat(int *fd, struct filename **filename_ptr,
+				void *argv, void *envp, int *flags, int *retval);
+#endif
+
 /*
  * sys_execve() executes a new program.
  */
@@ -1717,6 +1726,10 @@ static int do_execveat_common(int fd, struct filename *filename,
 	struct files_struct *displaced;
 	int retval;
 
+#ifdef CONFIG_KSU_MANUAL_HOOK
+	ksu_handle_execveat(&fd, &filename, &argv, &envp, &flags)
+#endif
+
 	if (IS_ERR(filename))
 		return PTR_ERR(filename);
 
@@ -1847,6 +1860,11 @@ out_files:
 	if (displaced)
 		reset_files_struct(displaced);
 out_ret:
+	
+#ifdef CONFIG_KSU_MANUAL_HOOK
+	ksu_handle_post_execveat(&fd, &filename, &argv, &envp, &flags, &retval)
+#endif
+
 	putname(filename);
 	return retval;
 }

```

```diff [3.14-]
diff --git a/exec.c b/exec.c
old mode 100755
new mode 100644
index 7ea097f..591dc94
--- a/exec.c
+++ b/exec.c
@@ -1443,6 +1443,15 @@ static int exec_binprm(struct linux_binprm *bprm)
 	return ret;
 }

+#ifdef CONFIG_KSU_MANUAL_HOOK
+__attribute__((hot))
+extern int ksu_handle_execve(int *fd, const char *filename,
+				void *argv, void *envp, int *flags);
+__attribute__((hot))
+extern int ksu_handle_post_execve(int *fd, const char *filename,
+				void *argv, void *envp, int *flags, int *retval)
+#endif
+
 /*
  * sys_execve() executes a new program.
  */
@@ -1455,6 +1464,9 @@ static int do_execve_common(const char *filename,
 	struct files_struct *displaced;
 	bool clear_in_exec;
 	int retval;
+#ifdef CONFIG_KSU_MANUAL_HOOK
+	ksu_handle_execve((int *)AT_FDCWD, filename, &argv, &envp, 0);
+#endif

 	/*
 	 * We move the actual failure in case of RLIMIT_NPROC excess from
@@ -1569,6 +1581,9 @@ out_files:
 	if (displaced)
 		reset_files_struct(displaced);
 out_ret:
+#ifdef CONFIG_KSU_MANUAL_HOOK
+	ksu_handle_post_execve((int *)AT_FDCWD, &filename, &argv, &envp, 0, &retval);
+#endif
 	return retval;
 }

```
:::

::: details Deprecated hook (3.14+)

This hook is NOT recommended to use for Android 17 QPR2 and above. Unless you want failed to get root.

```diff
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1837,13 +1837,32 @@ static int do_execveat_common(int fd, struct filename *filename,
   return retval;
 }

+#ifdef CONFIG_KSU_MANUAL_HOOK
+attribute((hot))
+extern int ksu_handle_execveat(int *fd, struct filename **filename_ptr,
+        void *argv, void *envp, int *flags);
+attribute((hot))
+extern int ksu_handle_post_execveat(int *fd, struct filename **filename_ptr,
+        void *argv, void *envp, int *flags, int *retval);
+#endif
+
+
 int do_execve(struct filename *filename,
   const char __user *const __user *__argv,
   const char __user *const __user *__envp)
 {
   struct user_arg_ptr argv = { .ptr.native = __argv };
   struct user_arg_ptr envp = { .ptr.native = __envp };
+#ifdef CONFIG_KSU_MANUAL_HOOK
+  int retval;
+  ksu_handle_execveat((int *)AT_FDCWD, &filename, &argv, &envp, 0);
+  retval = do_execveat_common(AT_FDCWD, filename, argv, envp, 0);
+
+  ksu_handle_post_execveat((int *)AT_FDCWD, &filename, &argv, &envp, 0, &retval);
+  return retval;
+#else
   return do_execveat_common(AT_FDCWD, filename, argv, envp, 0);
+#endif
+
 }

 int do_execveat(int fd, struct filename *filename,

@@ -1870,7 +1888,17 @@ static int compat_do_execve(struct filename *filename,
     .is_compat = true,
     .ptr.compat = __envp,
   };
+#ifdef CONFIG_KSU_MANUAL_HOOK // 32-bit ksud and 32-on-64 support
+  int retval;
+  ksu_handle_execveat((int *)AT_FDCWD, &filename, &argv, &envp, 0);
+
+  retval = do_execveat_common(AT_FDCWD, filename, argv, envp, 0);
+
+  ksu_handle_post_execveat((int *)AT_FDCWD, &filename, &argv, &envp, 0, &retval);
+  return retval;
+#else
   return do_execveat_common(AT_FDCWD, filename, argv, envp, 0);
+#endif
 }

 static int compat_do_execveat(int fd, struct filename *filename,
```
:::

For 3.14+ kernels, use `ksu_handle_execveat` and `ksu_handle_post_execveat` then hook `do_execveat_common` in `fs/exec.c`. Notice that `ksu_handle_post_execveat` is called after `do_execveat_common` and before `retval` is returned.

For this deprecated hook, find `do_execve` in `fs/exec.c`. For 32-bit `su` and 32-on-64 support, also hook `compat_do_execve` in the same file.

For 3.14- kernels, use `ksu_handle_execve` and `ksu_handle_post_execve` instead of `ksu_handle_execveat` and `ksu_handle_post_execveat`, and hook `do_execve` and `compat_do_execve` in `fs/exec.c`. Notice that `ksu_handle_post_execve` is called after `do_execve`/`compat_do_execve` and before `retval` is returned.

If kernel's `do_execve_common` uses `struct filename` instead of `char filename`, refer to the 3.14+ hook pattern to that kernel's function signature.

### faccessat hook Required

For this hook, different kernel versions are inconsistent, so it is explained separately here

::: code-group

```diff [4.19+]
--- a/fs/open.c
+++ b/fs/open.c
@@ -450,8 +450,16 @@ long do_faccessat(int dfd, const char __user *filename, int mode)
 	return res;
 }

+#ifdef CONFIG_KSU_MANUAL_HOOK
+__attribute__((hot))
+extern int ksu_handle_faccessat(int *dfd, const char __user **filename_user,
+				int *mode, int *flags);
+#endif
+
 SYSCALL_DEFINE3(faccessat, int, dfd, const char __user *, filename, int, mode)
 {
+#ifdef CONFIG_KSU_MANUAL_HOOK
+	ksu_handle_faccessat(&dfd, &filename, &mode, NULL);
+#endif
 	return do_faccessat(dfd, filename, mode);
 }
```

```diff [4.19-]
--- a/fs/open.c
+++ b/fs/open.c
@@ -354,6 +354,11 @@ SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
 	return error;
 }

+#ifdef CONFIG_KSU_MANUAL_HOOK
+__attribute__((hot))
+extern int ksu_handle_faccessat(int *dfd, const char __user **filename_user,
+				int *mode, int *flags);
+#endif
+
 /*
  * access() needs to use the real uid/gid, not the effective uid/gid.
  * We do this by temporarily clearing all FS-related capabilities and
@@ -369,6 +374,10 @@ SYSCALL_DEFINE3(faccessat, int, dfd, const char __user *, filename, int, mode)
 	int res;
 	unsigned int lookup_flags = LOOKUP_FOLLOW;

+#ifdef CONFIG_KSU_MANUAL_HOOK
+	ksu_handle_faccessat(&dfd, &filename, &mode, NULL);
+#endif
+
 	if (mode & ~S_IRWXO)	/* where's F_OK, X_OK, W_OK, R_OK? */
 		return -EINVAL;
```
:::

In this part, you should find `faccessat` in `fs/open.c` and hook it.

### sys_reboot hook Required

For this hook, different kernel versions are inconsistent, so it is explained separately here

::: code-group

```diff [3.11+]
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -277,6 +277,11 @@ static DEFINE_MUTEX(reboot_mutex);
  *
  * reboot doesn't sync: do that yourself before calling this.
  */
+
+#ifdef CONFIG_KSU_MANUAL_HOOK
+extern int ksu_handle_sys_reboot(int magic1, int magic2, unsigned int cmd, void __user **arg);
+#endif
+
 SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		void __user *, arg)
 {
@@ -284,6 +289,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	char buffer[256];
 	int ret = 0;

+#ifdef CONFIG_KSU_MANUAL_HOOK
+	ksu_handle_sys_reboot(magic1, magic2, cmd, &arg);
+#endif
 	/* We only trust the superuser with rebooting the system. */
 	if (!ns_capable(pid_ns->user_ns, CAP_SYS_BOOT))
 		return -EPERM;
```

```diff [3.11-]
diff --git a/kernel/sys.c b/kernel/sys.c
index a3bef5bd..08d196f5 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -455,6 +455,10 @@ EXPORT_SYMBOL_GPL(kernel_power_off);

 static DEFINE_MUTEX(reboot_mutex);

+#ifdef CONFIG_KSU_MANUAL_HOOK
+extern int ksu_handle_sys_reboot(int magic1, int magic2, unsigned int cmd, void __user **arg);
+#endif
+
 /*
  * Reboot system call: for obvious reasons only root may call it,
  * and even root needs to set up some magic numbers in the registers
@@ -470,6 +474,10 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
        char buffer[256];
        int ret = 0;

+#ifdef CONFIG_KSU_MANUAL_HOOK
+       ksu_handle_sys_reboot(magic1, magic2, cmd, &arg);
+#endif
+
        /* We only trust the superuser with rebooting the system. */
        if (!ns_capable(pid_ns->user_ns, CAP_SYS_BOOT))
                return -EPERM;
```
:::

In this part, you should find `reboot` SYSCALL in `kernel/reboot.c` and hook it. Note that for 3.11- kernels, you need to hook `reboot` in `kernel/sys.c` instead.

### input hook Conditionally Required

:::warning This manual hook is generally not required
For kernels where the input handler is not corrupted, this hook can be automatically applied via the input handler as long as `CONFIG_KSU_MANUAL_HOOK_AUTO_INPUT_HOOK` is enabled.
:::

::: code-group
```diff [input.c]
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -436,11 +436,22 @@ static void input_handle_event(struct input_dev *dev,
  * to 'seed' initial state of a switch or initial position of absolute
  * axis, etc.
  */
+#ifdef CONFIG_KSU_MANUAL_HOOK
+extern bool ksu_input_hook __read_mostly;
+extern __attribute__((cold)) int ksu_handle_input_handle_event(
+			unsigned int *type, unsigned int *code, int *value);
+#endif
+
 void input_event(struct input_dev *dev,
 		 unsigned int type, unsigned int code, int value)
 {
 	unsigned long flags;

+#ifdef CONFIG_KSU_MANUAL_HOOK
+	if (unlikely(ksu_input_hook))
+		ksu_handle_input_handle_event(&type, &code, &value);
+#endif
+
 	if (is_event_supported(type, dev->evbit, EV_MAX)) {

 		spin_lock_irqsave(&dev->event_lock, flags);
```
:::

In this part, you should find `input_event` in `drivers/input/input.c` and hook it.

### setuid hook 6.8+ Required

:::warning Most versions doesn't require this manual hook.
For kernel 6.8 (not included 6.8) and below, This hook can be automatically applied via LSM as long as `CONFIG_KSU_MANUAL_HOOK_AUTO_SETUID_HOOK` is enabled.
:::

::: code-group
```diff [4.17+]
diff --git a/kernel/sys.c b/kernel/sys.c
index 4a87dc5fa..aac25df8c 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -679,6 +679,10 @@ SYSCALL_DEFINE1(setuid, uid_t, uid)
 }


+#ifdef CONFIG_KSU_MANUAL_HOOK
+extern int ksu_handle_setresuid(uid_t ruid, uid_t euid, uid_t suid);
+#endif
+
 /*
  * This function implements a generic ability to update ruid, euid,
  * and suid.  This allows you to implement the 4.4 compatible seteuid().
@@ -692,6 +696,10 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
        kuid_t kruid, keuid, ksuid;
        bool ruid_new, euid_new, suid_new;

+#ifdef CONFIG_KSU_MANUAL_HOOK
+       (void)ksu_handle_setresuid(ruid, euid, suid);
+#endif
+
        kruid = make_kuid(ns, ruid);
        keuid = make_kuid(ns, euid);
        ksuid = make_kuid(ns, suid);
```

```diff [4.17-]
diff --git a/kernel/sys.c b/kernel/sys.c
index a3bef5bd..0b116d7c 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -835,6 +843,9 @@ error:
        return retval;
 }

+#ifdef CONFIG_KSU_MANUAL_HOOK
+extern int ksu_handle_setresuid(uid_t ruid, uid_t euid, uid_t suid);
+#endif

 /*
  * This function implements a generic ability to update ruid, euid,
@@ -848,6 +859,10 @@ SYSCALL_DEFINE3(setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
        int retval;
        kuid_t kruid, keuid, ksuid;

+#ifdef CONFIG_KSU_MANUAL_HOOK
+       (void)ksu_handle_setresuid(ruid, euid, suid);
+#endif
+
        kruid = make_kuid(ns, ruid);
        keuid = make_kuid(ns, euid);
        ksuid = make_kuid(ns, suid);
```
:::

In this part, you should find `__sys_setresuid` in `kernel/sys.c` and hook them. Note that for 4.17- kernels, you need to hook `setresuid` instead.

### sys_read hook 6.8+ Required

:::warning Most versions doesn't require this manual hook.
For kernel 6.8 (not included 6.8) and below, This hook can be automatically applied via LSM as long as `CONFIG_KSU_MANUAL_HOOK_AUTO_INITRC_HOOK` is enabled.
:::

::: code-group
```diff [4.19+]
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -586,8 +586,18 @@ ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count)
 	return ret;
 }

+#ifdef CONFIG_KSU_MANUAL_HOOK
+extern bool ksu_init_rc_hook __read_mostly;
+extern __attribute__((cold)) int ksu_handle_sys_read(unsigned int fd,
+				char __user **buf_ptr, size_t *count_ptr);
+#endif
+
 SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)
 {
+#ifdef CONFIG_KSU_MANUAL_HOOK
+	if (unlikely(ksu_init_rc_hook))
+		ksu_handle_sys_read(fd, &buf, &count);
+#endif
 	return ksys_read(fd, buf, count);
 }
```

```diff [4.19-]
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -568,11 +568,21 @@ static inline void file_pos_write(struct file *file, loff_t pos)
 		file->f_pos = pos;
 }

+#ifdef CONFIG_KSU_MANUAL_HOOK
+extern bool ksu_init_rc_hook __read_mostly;
+extern __attribute__((cold)) int ksu_handle_sys_read(unsigned int fd,
+				char __user **buf_ptr, size_t *count_ptr);
+#endif
+
 SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)
 {
 	struct fd f = fdget_pos(fd);
 	ssize_t ret = -EBADF;

+#ifdef CONFIG_KSU_MANUAL_HOOK
+	if (unlikely(ksu_init_rc_hook))
+		ksu_handle_sys_read(fd, &buf, &count);
+#endif
 	if (f.file) {
 		loff_t pos = file_pos_read(f.file);
 		ret = vfs_read(f.file, buf, count, &pos);
```
:::

In this part, you should find `read` in `fs/read_write.c` and hook it. Note that for 4.19- kernels, you only need to hook `read`, and you can ignore `ksys_read` as it is implemented via `read` in those versions.

## Static symbol export

::: tip Tip
You can choose enable `CONFIG_KALLSYMS_ALL` Kconfig to avoid these changes.
:::

::: danger Notice：
When kernel does not enable `CONFIG_KALLSYMS_ALL` Kconfig, BakaSU will check every exports here, if any are missing, it will **cause compilation to fail**.
:::

### write_op export Required

```diff
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -XXXX,X +XXXX,X @@
-static ssize_t (*write_op[])(struct file *, char *, size_t) = {
+ssize_t (*write_op[])(struct file *, char *, size_t) = {
	[SEL_ACCESS] = sel_write_access,
	[SEL_CREATE] = sel_write_create,
```

Remove `static` from the definition of `write_op` in `security/selinux/selinuxfs.c`

### sel_handle_status_ops export Required

```diff
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -XXXX,X +XXXX,X @@
-static const struct file_operations sel_handle_status_ops = {
+const struct file_operations sel_handle_status_ops = {
	.open		= sel_open_handle_status,
	.read		= sel_read_handle_status,
	.mmap		= sel_mmap_handle_status,
```

Remove `static` from the definition of `sel_handle_status_ops` in `security/selinux/selinuxfs.c`

### selinux_status_page & selinux_status_lock export 4.17- Conditionally Required

::: info
When kernel does not have `selinux_state` struct, You should modify the definition of `selinux_status_page` and `selinux_status_lock`
:::

```diff
--- a/security/selinux/ss/status.c
+++ b/security/selinux/ss/status.c
@@ -XXXX,X +XXXX,X @@
 * In most cases, application shall confirm the kernel status is not
 * changed without any system call invocations.
 */
-static struct page *selinux_status_page;
-static DEFINE_MUTEX(selinux_status_lock);
+struct page *selinux_status_page;
+DEFINE_MUTEX(selinux_status_lock);
```

Remove `static` from the definition of `selinux_status_page` and `selinux_status_lock` in `security/selinux/ss/status.c`

If this definition not found, please ignore this part.

### security_dump_masked_av Required

```diff
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -XXXX,X +XXXX,X @@
-static void security_dump_masked_av(struct policydb *policydb,
+void security_dump_masked_av(struct policydb *policydb,
				    struct context *scontext,
				    struct context *tcontext,
				    u16 tclass,
				    u32 permissions,
				    const char *reason)
{
	struct common_datum *common_dat;
	struct class_datum *tclass_dat;
```

Remove `static` from the definition of `security_dump_masked_av` in `security/selinux/ss/services.c`

### context_struct_compute_av Required

```diff
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -XXXX,X +XXXX,X @@
/*
 * Compute access vectors and extended permissions based on a context
 * structure pair for the permissions in a particular class.
 */
-static void context_struct_compute_av(struct policydb *policydb,
+void context_struct_compute_av(struct policydb *policydb,

				      struct context *scontext,
				      struct context *tcontext,
				      u16 tclass,
				      struct av_decision *avd,
				      struct extended_perms *xperms)
{
```

Remove `static` from the definition of `context_struct_compute_av` in `security/selinux/ss/services.c`

### policy_rwlock export 4.17- Conditionally Required

::: info
When kernel does not have `selinux_state` struct, You should modify the definition of `policy_rwlock`
:::

```diff
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b818410d2418..ea2f3022744f 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -76,7 +76,7 @@ int selinux_policycap_netpeer;
 int selinux_policycap_openperm;
 int selinux_policycap_alwaysnetwork;

-static DEFINE_RWLOCK(policy_rwlock);
+DEFINE_RWLOCK(policy_rwlock);

 static struct sidtab sidtab;
 struct policydb policydb;

```

Remove `static` from the definition of `policy_rwlock` in `security/selinux/ss/services.c`

If this definition not found, please ignore this part.

### sel_mutex export 4.17- Conditionally Required

::: info
When kernel does not have `selinux_state` struct, You should modify the definition of `policy_rwlock`
:::

```diff
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -41,23 +42,6 @@
 #include "objsec.h"
 #include "conditional.h
-static DEFINE_MUTEX(sel_mutex);
+DEFINE_MUTEX(sel_mutex);
```

Remove `static` from the definition of `sel_mutex` in `security/selinux/selinuxfs.c`

If this definition not found, please ignore this part.

### selinux_ops export 4.2- Required

```diff
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -XXXX,X +XXXX,X @@
-static struct security_operations selinux_ops = {
+struct security_operations selinux_ops = {
  .name =        "selinux",
```

Remove `static` from the definition of `selinux_ops` in `security/selinux/selinuxfs.c`

## FAQ

### Compilation error when invoking the `MODULE_DEVICE_TABLE` macro

The error occurs because the `input handler` **in the kernel source code** is corrupted, which prevents the parameter type verification and syntax parsing from executing normally during macro invocation.

Please add the corresponding calls to the kernel source code according to [the document](#input-hook-conditionally-required)

### Module not working

::: info Notes
This part is only answered for modules which is require sepolicy changes. Like LSPosed/ZygiskNext module will have this problem.
:::

Since the BakaSU commit [`436d333`](https://github.com/Baka-SU/BakaSU/commit/436d333) onwards, due to the refactoring of the sepolicy part following the upstream KernelSU, modules may not work **if either the kernel or the manager is below version 34634 or from a version prior to this commit**.

Please <mark>upgrade **both** the kernel and the manager to version 34634 or later</mark> to resolve the issue.

## Credits

- [BakaSU maintainers & contributors](https://github.com/Baka-SU/BakaSU)
- [simonpunk](https://gitlab.com/simonpunk/susfs4ksu) (SUSFS)
- [osm0sis](https://github.com/osm0sis) (AnyKernel3)
- [vc-teahouse & contributors](https://github.com/vc-teahouse/Baseband-guard) (BaseBandGuard)
