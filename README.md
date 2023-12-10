Device configuration for Qualcomm Reference Device sm8350
=========================================

## Device specifications

Basic   | Spec Sheet
-------:|:-------------------------
CPU     | Octa-core (1x2.84 GHz Kryo 680 & 3x2.42 GHz Kryo 680 & 4x1.80 GHz Kryo 680)
Chipset | Qualcomm SM8350 Snapdragon 888 5G (5 nm)
GPU     | Adreno 660
Memory  | 12 GB, LPDDR5
Storage | 256 GB, UFS 3.1
Shipped Android Version | 11

## Features

**Works**

- ADB
- Booting (Tested on `aospa-uvite-built-on-UotanWorkStation-lahaina-20231211.zip`)
- Brightness adjust
- **Decryption**
- MTP
- Vibration

## Kernel Source
https://github.com/QRD-Development/android_kernel_qcom_sm8350

## Notice
- TWRP images built with this branch is only compatible with the AOSPA ROM compiled with [AOSPA dt](https://github.com/QRD-Development/android_device_qcom_lahaina) by [QRD-Development](https://github.com/QRD-Development) or other ROMs that uses boot header v4 and may not boot with other firmware!
- Please use the branch [twrp-12.1](https://github.com/QRD-Development/twrp_device_qcom_lahaina/tree/twrp-12.1) or this [boot.img](https://github.com/QRD-Development/twrp_device_qcom_lahaina/releases/download/20231118/boot.img) for legacy firmwares.

## Building
#### Install Dependencies (Ubuntu 22.04 LTS)
```
sudo apt update
sudo apt upgrade
sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev libelf-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev
```
For Archlinux, you can install `lineageos-devel` from `AUR`

#### Sync Source
```
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
repo sync
```

#### Clone Device Tree
```
git clone --depth=1 -b twrp-12.1-for-boot-header-v4 https://github.com/QRD-Development/twrp_device_qcom_lahaina.git device/qcom/lahaina
```

#### Initialize the Environment
```
. build/envsetup.sh
```

#### Pick Addtional Changes from Gerrit (Optional)
```
repopick 6526 6049 5743 5693
```
See [TWRP Gerrit Code Review](https://gerrit.twrp.me/) for Details

#### Start Building
```
lunch twrp_lahaina-userdebug
mka vendorbootimage
```

You'll get `recovery.cpio.lz4` in `out/target/product/lahaina/obj/PACKAGING/vendor_ramdisk_fragments_intermediates`

## Installation
### For AOSPA ROM made by us that uses lz4-compressed vendor_boot ramdisks:
#### Enter fastbootd mode
It seems that our bootloader does *not* support the commands `getvar:max-fetch-size` and `fetch:name`, so we have to enter fastbootd(see [Fastboot in Userspace](https://source.android.com/docs/core/architecture/bootloader/fastbootd)). Here, we use `adb` for example.
```
adb reboot fastboot
```
#### Flash the modular recovery ramdisk
```
cd out/target/product/lahaina/obj/PACKAGING/vendor_ramdisk_fragments_intermediates
fastboot flash vendor_boot:recovery recovery.cpio.lz4
```
This will only work with `userdebug` or `eng` builds. (As per https://source.android.com/docs/core/architecture/bootloader/fastbootd#fastbootd-changes)

## Thanks

- [FsCrypt fix by mauronofrio](https://github.com/mauronofrio/android_bootable_recovery)
- [Decryption by bigbiff](https://github.com/bigbiff/android_bootable_recovery)
- [Oneplus 8 TWRP by mauronofrio](https://github.com/mauronofrio/android_device_oneplus_instantnoodle_TWRP)
- [Xiaomi Mi 10 TWRP by sekaiacg](https://github.com/sekaiacg/android_device_xiaomi_umi_TWRP)
- [Sony Xperia mark III series TWRP by lolipuru](https://github.com/sonybasement/twrp_android_sony_pdx215)
- [marmalade TWRP by CyberDroid23](https://github.com/CyberDroid23/recovery_generic_marmalade)
- [TWRP A/B Installer Zip Template by osm0sis](https://github.com/osm0sis/twrp_abtemplate)
- [Kernel Source from LineageOS team](https://github.com/LineageOS/android_kernel_qcom_sm8350)
- A powerful server from [mujianwu](https://github.com/mujianwu)
- QRD8350 from [Nonenoon](https://github.com/Nonenoon)
- Additional assistance from [Idonotkno](https://github.com/Idonotkno) , [BigfootACA](https://github.com/BigfootACA) and [MollySophia](https://github.com/MollySophia)
