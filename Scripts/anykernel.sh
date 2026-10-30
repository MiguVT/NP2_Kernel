# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
properties() { '
kernel.string=NP2 Kernel - BakaSU by MiguVT
do.devicecheck=1
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=Pong
device.name2=pong
supported.versions=13 - 16
supported.patchlevels=
'; }

# Shell variables
BLOCK=boot;
IS_SLOT_DEVICE=1;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

## AnyKernel methods
. tools/ak3-core.sh;

## AnyKernel boot install
split_boot;
flash_boot;

## end boot install
