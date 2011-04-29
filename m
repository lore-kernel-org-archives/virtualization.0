From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 05/18] Staging: hv: Cleanup vmbus_probe() function
Date: Fri, 29 Apr 2011 13:45:03 -0700
Message-ID: <1304109916-24874-5-git-send-email-kys@microsoft.com>
References: <1304109779-24819-1-git-send-email-kys@microsoft.com>
	<1304109916-24874-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304109916-24874-1-git-send-email-kys@microsoft.com>
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

The logic for handling probe failure was broken. Now that we have
cleaned up error handling, get rid of the vmbus_probe_failed_cb()
function.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_api.h |    4 ----
 drivers/staging/hv/vmbus_drv.c |   31 ++-----------------------------
 2 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/hv/vmbus_api.h b/drivers/staging/hv/vmbus_api.h
index 02e3587..14df762 100644
--- a/drivers/staging/hv/vmbus_api.h
+++ b/drivers/staging/hv/vmbus_api.h
@@ -105,10 +105,6 @@ struct hv_driver {
 struct hv_device {
 	char name[64];
 
-	struct work_struct probe_failed_work_item;
-
-	int probe_error;
-
 	/* the device type id of this device */
 	struct hv_guid dev_type;
 
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 1183459..5f88249 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -313,27 +313,6 @@ static int vmbus_match(struct device *device, struct device_driver *driver)
 	return match;
 }
 
-
-/*
- * vmbus_probe_failed_cb - Callback when a driver probe failed in vmbus_probe()
- *
- * We need a callback because we cannot invoked device_unregister() inside
- * vmbus_probe() since vmbus_probe() may be invoked inside device_register()
- * i.e. we cannot call device_unregister() inside device_register()
- */
-static void vmbus_probe_failed_cb(struct work_struct *context)
-{
-	struct hv_device *device_ctx = (struct hv_device *)context;
-
-	/*
-	 * Kick off the process of unregistering the device.
-	 * This will call vmbus_remove() and eventually vmbus_device_release()
-	 */
-	device_unregister(&device_ctx->device);
-
-	/* put_device(&device_ctx->device); */
-}
-
 /*
  * vmbus_probe - Add the new vmbus's child device
  */
@@ -342,20 +321,14 @@ static int vmbus_probe(struct device *child_device)
 	int ret = 0;
 	struct hv_driver *drv =
 			drv_to_hv_drv(child_device->driver);
-	struct hv_device *dev = device_to_hv_device(child_device);
 
 	/* Let the specific open-source driver handles the probe if it can */
 	if (drv->driver.probe) {
-		ret = dev->probe_error =
-		drv->driver.probe(child_device);
-		if (ret != 0) {
+		ret = drv->driver.probe(child_device);
+		if (ret != 0)
 			pr_err("probe failed for device %s (%d)\n",
 			       dev_name(child_device), ret);
 
-			INIT_WORK(&dev->probe_failed_work_item,
-				  vmbus_probe_failed_cb);
-			schedule_work(&dev->probe_failed_work_item);
-		}
 	} else {
 		pr_err("probe not set for driver %s\n",
 		       dev_name(child_device));
-- 
1.7.4.1
