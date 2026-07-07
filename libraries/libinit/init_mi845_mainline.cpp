/*
 * SPDX-FileCopyrightText: The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

#include "vendor_init.h"

#include <libinit_mainline_common.h>

void vendor_load_properties() {
    vendor_load_properties_mainline_common();
}
