From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 24/25] Staging: hv: Use the shutdown() function in struct
	hv_driver
Date: Tue, 26 Apr 2011 09:20:41 -0700
Message-ID: <1303834842-5022-24-git-send-email-kys@microsoft.com>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
	<1303834842-5022-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1303834842-5022-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
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
index e09b363..f95ec2b 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -368,6 +368,7 @@ static int vmbus_remove(struct device *child_device)
 static void vmbus_shutdown(struct device *child_device)
 {
 	struct hv_driver *drv;
+	struct hv_device *dev = device_to_hv_device(child_device);
 
 
 	/* The device may not be attached yet */
@@ -376,9 +377,8 @@ static void vmbus_shutdown(struct device *child_device)
 
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
