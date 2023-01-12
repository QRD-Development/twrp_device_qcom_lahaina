LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
    LOCAL_MODULE := lahaina_firmware
    LOCAL_MODULE_TAGS := optional
    LOCAL_MODULE_CLASS := ETC
    LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)
    LOCAL_HOST_REQUIRED_MODULES := depmod
    LOCAL_POST_INSTALL_CMD += \
        mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib/modules; \
        cp -rf $(LOCAL_PATH)/lahaina/modules $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib/; \
        cp -rf $(LOCAL_PATH)/modules.load.recovery $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib/modules/1.1/; \
        echo "calling depmod on prebuilt modules"; \
        $(DEPMOD) -b $(TARGET_RECOVERY_ROOT_OUT)/vendor 1.1;
include $(BUILD_PHONY_PACKAGE)
