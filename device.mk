#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

COMMON_PATH := device/xiaomi/mi845-mainline

# Inherit from mainline/qcom-common
$(call inherit-product, device/mainline/qcom-common/mainline_qcom-common.mk)

# Bootanimation
TARGET_BOOTANIMATION_HALF_RES := true

# Dalvik heap
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# HIDL
PRODUCT_PACKAGES += \
    vndservicemanager

# Images
PRODUCT_BUILD_BOOT_IMAGE := true
PRODUCT_BUILD_RAMDISK_IMAGE := true
PRODUCT_BUILD_RECOVERY_IMAGE := true

# Init
PRODUCT_PACKAGES += \
    fstab.mi845 \
    fstab.mi845.ramdisk \
    init.mi845.rc \
    init.recovery.mi845.rc \
    ueventd.mi845.rc

$(call soong_config_set,libinit,vendor_init_lib,//$(COMMON_PATH):init_mi845_mainline)

PRODUCT_PACKAGES += \
    use_memfd.rc

# Kernel
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/modprobe/modules.blocklist:$(TARGET_COPY_OUT_VENDOR_DLKM)/lib/modules/modules.blocklist

PRODUCT_PACKAGES += \
    modules.load.normal

PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml

# Scoped Storage
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 26

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(COMMON_PATH) \
    kernel/mainline/configs
