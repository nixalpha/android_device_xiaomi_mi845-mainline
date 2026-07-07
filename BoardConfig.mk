#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

USES_DEVICE_XIAOMI_MI845_MAINLINE := true

COMMON_PATH := device/xiaomi/mi845-mainline

# Inherit from mainline/qcom-common
include device/mainline/qcom-common/BoardConfigMainlineQcomCommon.mk

# A/B
AB_OTA_UPDATER := false

# Boot parameters
BOARD_KERNEL_CMDLINE := \
    $(MAINLINE_COMMON_ANDROIDBOOT_PARAMS) \
    $(MAINLINE_COMMON_KERNEL_PARAMS) \
    $(MAINLINE_QCOM_KERNEL_PARAMS) \
    $(MAINLINE_QCOM_SOC_ANDROIDBOOT_PARAMS) \
    androidboot.fstab_suffix=mi845 \
    androidboot.verifiedbootstate=orange \
    androidboot.serialconsole=0 \
    console=tty0

BOARD_KERNEL_CMDLINE += \
    androidboot.selinux=permissive \
    audit=0 \
    regulator_ignore_unused

# Bootloader
BOARD_BOOT_HEADER_VERSION := 1
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
TARGET_BOOTLOADER_BOARD_NAME := sdm845

# Fastboot
TARGET_BOARD_FASTBOOT_INFO_FILE := $(COMMON_PATH)/misc/fastboot-info.txt

# Filesystem
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_USE_EXT4 := true

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_IMAGE_NAME := Image.gz
BOARD_KERNEL_PAGESIZE := 4096
TARGET_KERNEL_SOURCE := kernel/mainline/sdm845-mainline

TARGET_KERNEL_CONFIG := \
    defconfig \
    sdm845.config

TARGET_KERNEL_CONFIG_EXT := \
    kernel/mainline/configs/fragments/android-base-pre/common.config \
    kernel/mainline/configs/fragments/android-base-pre/arm64.config \
    kernel/configs/b/android-6.12/android-base.config \
    kernel/mainline/configs/fragments/android-base-conditional/CONFIG_ARM64-y.config \
    kernel/mainline/configs/fragments/common.config \
    kernel/mainline/configs/fragments/y/fbcon.config \
    kernel/mainline/configs/fragments/n/disable-clang-hardening-features.config \
    kernel/mainline/configs/fragments/n/faster-build-time.config \
    $(COMMON_PATH)/kconfigs/make-basic-drivers-builtin.config

# Kernel modules
BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD :=
BOARD_VENDOR_KERNEL_MODULES_LOAD := \
    $(BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD)
RECOVERY_KERNEL_MODULES := \
    $(BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD)

TARGET_AUTO_COLLECT_KERNEL_MODULE_DEPS := true

# Partitions
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 57453555712

DLKM_PARTITIONS := system_dlkm vendor_dlkm
SSI_PARTITIONS := product system system_ext
TREBLE_PARTITIONS := odm vendor
ALL_PARTITIONS := $(DLKM_PARTITIONS) $(SSI_PARTITIONS) $(TREBLE_PARTITIONS)

$(foreach p, $(call to-upper, $(ALL_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4) \
    $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# Partitions - dynamic
BOARD_SUPER_PARTITION_SIZE := 5167382528
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := $(ALL_PARTITIONS)
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 5163188224 # (BOARD_SUPER_PARTITION_SIZE - 4MiB)
BOARD_SUPER_PARTITION_BLOCK_DEVICES := system vendor cust
BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE := 3221225472
BOARD_SUPER_PARTITION_VENDOR_DEVICE_SIZE := 1073741824
BOARD_SUPER_PARTITION_CUST_DEVICE_SIZE := 872415232
BOARD_SUPER_PARTITION_METADATA_DEVICE := system

# Partitions - reserved size
-include vendor/lineage/config/BoardConfigReservedSize.mk
$(foreach p, $(call to-upper, $(DLKM_PARTITIONS) $(TREBLE_PARTITIONS)), \
    $(eval BOARD_USES_$(call to-upper, $(p))IMAGE := true) \
    $(eval BOARD_$(p)IMAGE_EXTFS_INODE_COUNT := -1) \
    $(eval BOARD_$(p)IMAGE_PARTITION_RESERVED_SIZE := 83886080))

# Ramdisk
BOARD_RAMDISK_USE_LZ4 := true

# Recovery
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/fstab/fstab.mi845

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := $(COMMON_PATH)/misc

# VINTF
DEVICE_MANIFEST_FILE := \
    $(COMMON_PATH)/vintf/manifest.xml
