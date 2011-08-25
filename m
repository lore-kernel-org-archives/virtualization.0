From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 17/59] Staging: hv: netvsc: Get rid of the DMI signature in netvsc_drv.c
Date: Thu, 25 Aug 2011 09:48:43 -0700
Message-ID: <1314290965-2698-17-git-send-email-kys@microsoft.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
 <1314290965-2698-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314290965-2698-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now that we have implemented a vmbus specific mechanism for auto-loading,
get rid of the DMI signature.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/netvsc_drv.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index ea5c289..d6c6180 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -33,7 +33,6 @@
 #include <linux/skbuff.h>
 #include <linux/in.h>
 #include <linux/slab.h>
-#include <linux/dmi.h>
 #include <net/arp.h>
 #include <net/route.h>
 #include <net/sock.h>
@@ -440,20 +439,6 @@ static void __exit netvsc_drv_exit(void)
 }
 
 
-static const struct dmi_system_id __initconst
-hv_netvsc_dmi_table[] __maybe_unused  = {
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
-MODULE_DEVICE_TABLE(dmi, hv_netvsc_dmi_table);
-
 static int __init netvsc_drv_init(void)
 {
 	struct hv_driver *drv = &netvsc_drv;
@@ -461,10 +446,6 @@ static int __init netvsc_drv_init(void)
 
 	pr_info("initializing....");
 
-	if (!dmi_check_system(hv_netvsc_dmi_table))
-		return -ENODEV;
-
-
 	/* Callback to client driver to complete the initialization */
 	netvsc_initialize(drv);
 
-- 
1.7.4.1
