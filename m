From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 06/21] Staging: hv: Get rid of  vmbus_dev_rm() function
Date: Thu, 10 Mar 2011 14:06:31 -0800
Message-ID: <1299794791-1040-1-git-send-email-kys@microsoft.com>
References: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
Sender: linux-kernel-owner@vger.kernel.org
To: kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <mike.sterling@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the vmbus_dev_rm() function by inlining
the necessary code.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 8e8a408..11c69c5 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -172,18 +172,6 @@ static int vmbus_dev_add(struct hv_device *dev, void *info)
 	return ret;
 }
 
-/*
- * vmbus_dev_rm - Callback when the root bus device is removed
- */
-static int vmbus_dev_rm(struct hv_device *dev)
-{
-	int ret = 0;
-
-	vmbus_release_unattached_channels();
-	vmbus_disconnect();
-	on_each_cpu(hv_synic_cleanup, NULL, 1);
-	return ret;
-}
 
 /*
  * vmbus_cleanup - Perform any cleanup when the driver is removed
@@ -568,8 +556,9 @@ static void vmbus_bus_exit(void)
 
 	struct hv_device *dev_ctx = &vmbus_drv.device_ctx;
 
-	/* Remove the root device */
-	vmbus_dev_rm(dev_ctx);
+	vmbus_release_unattached_channels();
+	vmbus_disconnect();
+	on_each_cpu(hv_synic_cleanup, NULL, 1);
 
 	vmbus_cleanup();
 
-- 
1.5.5.6
