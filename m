From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 22/77] Staging: hv: storvsc: Get rid of the DMI signature
Date: Thu, 16 Jun 2011 13:16:55 -0700
Message-ID: <1308255470-3826-22-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now that we have implemented a vmbus specific mechanism for auto-loading,
get rid of the DMI signature.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index dc9b12a..7d605c9 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -24,7 +24,6 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/blkdev.h>
-#include <linux/dmi.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
@@ -729,27 +728,6 @@ static struct hv_driver storvsc_drv = {
 	.remove = storvsc_remove,
 };
 
-/*
- * We use a DMI table to determine if we should autoload this driver  This is
- * needed by distro tools to determine if the hyperv drivers should be
- * installed and/or configured.  We don't do anything else with the table, but
- * it needs to be present.
- */
-
-static const struct dmi_system_id __initconst
-hv_stor_dmi_table[] __maybe_unused  = {
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
-MODULE_DEVICE_TABLE(dmi, hv_stor_dmi_table);
-
 static int __init storvsc_drv_init(void)
 {
 	int ret;
-- 
1.7.4.1
