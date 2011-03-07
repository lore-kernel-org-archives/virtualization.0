From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 12/16] Staging: hv: Move probe_failed_work_item from vm_device
Date: Mon,  7 Mar 2011 13:34:27 -0800
Message-ID: <1299533667-22824-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for consolidating all device related state into
struct hv_device, move probe_failed_work_item from vm_device to
hv_device.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus.h     |    1 -
 drivers/staging/hv/vmbus_api.h |    3 +++
 drivers/staging/hv/vmbus_drv.c |    5 +++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/vmbus.h b/drivers/staging/hv/vmbus.h
index a6be405..a12e9e5 100644
--- a/drivers/staging/hv/vmbus.h
+++ b/drivers/staging/hv/vmbus.h
@@ -30,7 +30,6 @@
 
 
 struct vm_device {
-	struct work_struct probe_failed_work_item;
 	struct hv_guid class_id;
 	struct hv_guid device_id;
 	int probe_error;
diff --git a/drivers/staging/hv/vmbus_api.h b/drivers/staging/hv/vmbus_api.h
index 7f891fb..60e4000 100644
--- a/drivers/staging/hv/vmbus_api.h
+++ b/drivers/staging/hv/vmbus_api.h
@@ -26,6 +26,7 @@
 #define _VMBUS_API_H_
 
 #include <linux/device.h>
+#include <linux/workqueue.h>
 
 #define MAX_PAGE_BUFFER_COUNT				16
 #define MAX_MULTIPAGE_BUFFER_COUNT			32 /* 128K */
@@ -117,6 +118,8 @@ struct hv_device {
 
 	char name[64];
 
+	struct work_struct probe_failed_work_item;
+
 	/* the device type id of this device */
 	struct hv_guid dev_type;
 
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 9a9e426..36c4ec8 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -904,6 +904,7 @@ static int vmbus_probe(struct device *child_device)
 			drv_to_hv_drv(child_device->driver);
 	struct vm_device *device_ctx =
 			device_to_vm_device(child_device);
+	struct hv_device *dev = &device_ctx->device_obj;
 
 	/* Let the specific open-source driver handles the probe if it can */
 	if (drv->driver.probe) {
@@ -915,9 +916,9 @@ static int vmbus_probe(struct device *child_device)
 				   dev_name(child_device), child_device,
 				   child_device->driver->name, ret);
 
-			INIT_WORK(&device_ctx->probe_failed_work_item,
+			INIT_WORK(&dev->probe_failed_work_item,
 				  vmbus_probe_failed_cb);
-			schedule_work(&device_ctx->probe_failed_work_item);
+			schedule_work(&dev->probe_failed_work_item);
 		}
 	} else {
 		DPRINT_ERR(VMBUS_DRV, "probe() method not set for driver - %s",
-- 
1.5.5.6
