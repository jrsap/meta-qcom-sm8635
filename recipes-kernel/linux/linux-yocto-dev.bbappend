# do not override KBRANCH and SRCREV_machine, use default ones.
COMPATIBLE_MACHINE:qcom = "(qcom)"

FILESEXTRAPATHS:prepend:qcom := "${THISDIR}/${PN}:"

SRC_URI:append:qcom = " \
    file://workarounds/0001-QCLINUX-arm64-dts-qcom-qcm6490-disable-sdhc1-for-ufs.patch \
    file://workarounds/0001-PENDING-arm64-dts-qcom-Remove-voltage-vote-support-f.patch \
    file://hamoa-iot-evk-dts/0001-arm64-dts-qcom-hamoa-iot-evk-camera-imx577-Add-DT-ov.patch \
"

# Include additional kernel configs.
SRC_URI:append:qcom = " \
    file://configs/qcom.cfg \
"

# When a defconfig is provided, the linux-yocto configuration
# uses the filename as a trigger to use a 'allnoconfig' baseline
# before merging the defconfig into the build.
#
# If the defconfig file was created with make_savedefconfig,
# not all options are specified, and should be restored with their
# defaults, not set to 'n'. To properly expand a defconfig like
# this, specify: KCONFIG_MODE="--alldefconfig" in the kernel
# recipe.
KCONFIG_MODE:qcom = "--alldefconfig"

KBUILD_DEFCONFIG:qcom ?= "defconfig"
KBUILD_DEFCONFIG:qcom-armv7a = "qcom_defconfig"

do_install:append:qcom() {
	sed -i 's:${TMPDIR}::g' ${WORKDIR}/linux-${PACKAGE_ARCH}-${LINUX_KERNEL_TYPE}-build/drivers/gpu/drm/msm/generated/*
}

# Retroid Pocket G2 (SM8635/cliffs) support, mirrored from
# vibe/retroid-g2-fef4cc in jrsap/linux-sm8635.
SRC_URI:append:retroid-pocket-g2 = " \
    file://retroid-g2/0001-arm64-dts-qcom-add-SM8635-cliffs-placeholder-dtsi-an.patch \
    file://retroid-g2/0002-drm-msm-adreno-add-Adreno-735-0x43030b00-catalog-ent.patch \
"
