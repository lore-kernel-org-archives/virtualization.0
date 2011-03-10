From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 07/21] Staging: hv: Get rid of vmbus_cleanup() function
Date: Thu, 10 Mar 2011 14:06:55 -0800
Message-ID: <1299794815-1077-1-git-send-email-kys@microsoft.com>
References: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
Sender: linux-kernel-owner@vger.kernel.org
To: kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <mike.sterling@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the vmbus_cleanup() function by inlining the
necessary code.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 11c69c5..e078c59 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -173,15 +173,6 @@ static int vmbus_dev_add(struct hv_device *dev, void *info)
 }
 
 
-/*
- * vmbus_cleanup - Perform any cleanup when the driver is removed
- */
-static void vmbus_cleanup(void)
-{
-
-	hv_cleanup();
-}
-
 struct onmessage_work_context {
 	struct work_struct work;
 	struct hv_message msg;
@@ -560,7 +551,7 @@ static void vmbus_bus_exit(void)
 	vmbus_disconnect();
 	on_each_cpu(hv_synic_cleanup, NULL, 1);
 
-	vmbus_cleanup();
+	hv_cleanup();
 
 	/* Unregister the root bus device */
 	device_unregister(&dev_ctx->device);
-- 
1.5.5.6
