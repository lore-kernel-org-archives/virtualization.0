From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 16/18] Staging: hv: Use the shutdown() function in struct hv_driver
Date: Fri, 29 Apr 2011 13:45:14 -0700
Message-ID: <1304109916-24874-16-git-send-email-kys@microsoft.com>
References: <1304109779-24819-1-git-send-email-kys@microsoft.com>
 <1304109916-24874-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304109916-24874-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Use the newly introduced  shutdown() function.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    6 +++---
 drivers/staging/hv/vmbus_drv.c  |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 80f7c0e..db44cf6 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -585,9 +585,9 @@ static int blkvsc_remove(struct hv_device *dev)
 
 }
 
-static void blkvsc_shutdown(struct device *device)
+static void blkvsc_shutdown(struct hv_device *dev)
 {
-	struct block_device_context *blkdev = dev_get_drvdata(device);
+	struct block_device_context *blkdev = dev_get_drvdata(&dev->device);
 	unsigned long flags;
 
 	if (!blkdev)
@@ -883,7 +883,7 @@ static int blkvsc_drv_init(void)
 
 	drv->probe = blkvsc_probe;
 	drv->remove = blkvsc_remove;
-	drv->driver.shutdown = blkvsc_shutdown;
+	drv->shutdown = blkvsc_shutdown;
 
 	/* The driver belongs to vmbus */
 	ret = vmbus_child_driver_register(&drv->driver);
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index b1e6cc4..6bf5365 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -367,6 +367,7 @@ static int vmbus_remove(struct device *child_device)
 static void vmbus_shutdown(struct device *child_device)
 {
 	struct hv_driver *drv;
+	struct hv_device *dev = device_to_hv_device(child_device);
 
 
 	/* The device may not be attached yet */
@@ -375,9 +376,8 @@ static void vmbus_shutdown(struct device *child_device)
 
 	drv = drv_to_hv_drv(child_device->driver);
 
-	/* Let the specific open-source driver handles the removal if it can */
-	if (drv->driver.shutdown)
-		drv->driver.shutdown(child_device);
+	if (drv->shutdown)
+		drv->shutdown(dev);
 
 	return;
 }
-- 
1.7.4.1
