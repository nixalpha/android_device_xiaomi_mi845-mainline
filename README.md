# Common Android device tree for Xiaomi SDM845 devices running mainline Linux

This tree is the shared mainline-kernel base for Xiaomi SDM845 devices. Device-specific products should include this tree from their `BoardConfig.mk` and inherit `device.mk` from their product `device.mk`.

## Kernel

The kernel source is `kernel/mainline/sdm845-mainline`, configured with:

- `defconfig`
- `sdm845.config`
- Lineage mainline Android fragments from `kernel/mainline/configs`
- `kconfigs/make-basic-drivers-builtin.config`

Device products append board DTBs with `BOARD_KERNEL_APPEND_DTBS`. Polaris uses
boot image header v1 with `Image.gz` plus appended DTB for bootloader
compatibility.
