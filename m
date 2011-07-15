From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 025/117] Staging: hv: util: Get rid of the DMI signature in hv_util.c
Date: Fri, 15 Jul 2011 10:46:13 -0700
Message-ID: <1310752065-27895-25-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now that we have implemented a vmbus specific mechanism for auto-loading,
get rid of the DMI signature.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_util.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/hv/hv_util.c b/drivers/staging/hv/hv_util.c
index 8d327c5..6fabc99 100644
--- a/drivers/staging/hv/hv_util.c
+++ b/drivers/staging/hv/hv_util.c
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/reboot.h>
-#include <linux/dmi.h>
 #include <linux/pci.h>
 
 #include "hyperv.h"
@@ -279,22 +278,6 @@ hv_utils_pci_table[] __maybe_unused = {
 };
 MODULE_DEVICE_TABLE(pci, hv_utils_pci_table);
 
-
-static const struct dmi_system_id __initconst
-hv_utils_dmi_table[] __maybe_unused  = {
-	{
-		.ident = "Hyper-V",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Virtual Machine"),
-			DMI_MATCH(DMI_BOARD_NAME, "Virtual Machine"),
-		},
-	},
-	{ },
-};
-MODULE_DEVICE_TABLE(dmi, hv_utils_dmi_table);
-
-
 static int __init init_hyperv_utils(void)
 {
 	pr_info("Registering HyperV Utility Driver\n");
@@ -303,9 +286,6 @@ static int __init init_hyperv_utils(void)
 		return -ENODEV;
 
 
-	if (!dmi_check_system(hv_utils_dmi_table))
-		return -ENODEV;
-
 	shut_txf_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	time_txf_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	hbeat_txf_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-- 
1.7.4.1
