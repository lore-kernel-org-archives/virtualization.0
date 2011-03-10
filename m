From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 17/21] Staging: hv: Get rid of the forward declaration for vmbus_remove
Date: Thu, 10 Mar 2011 14:14:46 -0800
Message-ID: <1299795286-1498-1-git-send-email-kys@microsoft.com>
References: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
Sender: linux-kernel-owner@vger.kernel.org
To: kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <mike.sterling@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the forward declaration of vmbus_remove by moving
the code around.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   59 +++++++++++++++++++--------------------
 1 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 35503b6..db5e735 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -50,7 +50,6 @@ struct hv_bus {
 	struct tasklet_struct event_dpc;
 };
 
-static int vmbus_remove(struct device *device);
 static void vmbus_shutdown(struct device *device);
 
 static irqreturn_t vmbus_isr(int irq, void *dev_id);
@@ -251,6 +250,35 @@ static int vmbus_probe(struct device *child_device)
 	return ret;
 }
 
+/*
+ * vmbus_remove - Remove a vmbus device
+ */
+static int vmbus_remove(struct device *child_device)
+{
+	int ret;
+	struct hv_driver *drv;
+
+
+	if (child_device->driver) {
+		drv = drv_to_hv_drv(child_device->driver);
+
+		/*
+		 * Let the specific open-source driver handles the removal if
+		 * it can
+		 */
+		if (drv->driver.remove) {
+			ret = drv->driver.remove(child_device);
+		} else {
+			DPRINT_ERR(VMBUS_DRV,
+				   "remove() method not set for driver - %s",
+				   child_device->driver->name);
+			ret = -1;
+		}
+	}
+
+	return 0;
+}
+
 /* The one and only one */
 static struct hv_bus  hv_bus = {
 	.bus.name =		"vmbus",
@@ -799,35 +827,6 @@ void vmbus_child_device_unregister(struct hv_device *device_obj)
 }
 
 /*
- * vmbus_remove - Remove a vmbus device
- */
-static int vmbus_remove(struct device *child_device)
-{
-	int ret;
-	struct hv_driver *drv;
-
-
-	if (child_device->driver) {
-		drv = drv_to_hv_drv(child_device->driver);
-
-		/*
-		 * Let the specific open-source driver handles the removal if
-		 * it can
-		 */
-		if (drv->driver.remove) {
-			ret = drv->driver.remove(child_device);
-		} else {
-			DPRINT_ERR(VMBUS_DRV,
-				   "remove() method not set for driver - %s",
-				   child_device->driver->name);
-			ret = -1;
-		}
-	}
-
-	return 0;
-}
-
-/*
  * vmbus_shutdown - Shutdown a vmbus device
  */
 static void vmbus_shutdown(struct device *child_device)
-- 
1.5.5.6
