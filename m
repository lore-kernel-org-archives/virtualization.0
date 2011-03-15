From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 05/12] Get rid of the forward declaration for vmbus_uevent
Date: Tue, 15 Mar 2011 15:03:36 -0700
Message-ID: <1300226624-27004-5-git-send-email-kys@microsoft.com>
References: <1300226527-26933-1-git-send-email-kys@microsoft.com>
	<1300226624-27004-1-git-send-email-kys@microsoft.com>
	<1300226624-27004-2-git-send-email-kys@microsoft.com>
	<1300226624-27004-3-git-send-email-kys@microsoft.com>
	<1300226624-27004-4-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1300226624-27004-4-git-send-email-kys@microsoft.com>
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
List-Id: virtualization@lists.linuxfoundation.org


Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |  151 ++++++++++++++++++++--------------------
 1 files changed, 75 insertions(+), 76 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 1331a6f..42066e9 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -51,7 +51,6 @@ static int vmbus_match(struct device *device, struct device_driver *driver);
 static int vmbus_probe(struct device *device);
 static int vmbus_remove(struct device *device);
 static void vmbus_shutdown(struct device *device);
-static int vmbus_uevent(struct device *device, struct kobj_uevent_env *env);
 
 static irqreturn_t vmbus_isr(int irq, void *dev_id);
 
@@ -98,6 +97,81 @@ static struct device_attribute vmbus_device_attrs[] = {
 	__ATTR_NULL
 };
 
+/*
+ * vmbus_uevent - add uevent for our device
+ *
+ * This routine is invoked when a device is added or removed on the vmbus to
+ * generate a uevent to udev in the userspace. The udev will then look at its
+ * rule and the uevent generated here to load the appropriate driver
+ */
+static int vmbus_uevent(struct device *device, struct kobj_uevent_env *env)
+{
+	struct hv_device *dev = device_to_hv_device(device);
+	int ret;
+
+	DPRINT_INFO(VMBUS_DRV, "generating uevent - VMBUS_DEVICE_CLASS_GUID={"
+		    "%02x%02x%02x%02x-%02x%02x-%02x%02x-"
+		    "%02x%02x%02x%02x%02x%02x%02x%02x}",
+		    dev->dev_type.data[3], dev->dev_type.data[2],
+		    dev->dev_type.data[1], dev->dev_type.data[0],
+		    dev->dev_type.data[5], dev->dev_type.data[4],
+		    dev->dev_type.data[7], dev->dev_type.data[6],
+		    dev->dev_type.data[8], dev->dev_type.data[9],
+		    dev->dev_type.data[10],
+		    dev->dev_type.data[11],
+		    dev->dev_type.data[12],
+		    dev->dev_type.data[13],
+		    dev->dev_type.data[14],
+		    dev->dev_type.data[15]);
+
+	ret = add_uevent_var(env, "VMBUS_DEVICE_CLASS_GUID={"
+			     "%02x%02x%02x%02x-%02x%02x-%02x%02x-"
+			     "%02x%02x%02x%02x%02x%02x%02x%02x}",
+			     dev->dev_type.data[3],
+			     dev->dev_type.data[2],
+			     dev->dev_type.data[1],
+			     dev->dev_type.data[0],
+			     dev->dev_type.data[5],
+			     dev->dev_type.data[4],
+			     dev->dev_type.data[7],
+			     dev->dev_type.data[6],
+			     dev->dev_type.data[8],
+			     dev->dev_type.data[9],
+			     dev->dev_type.data[10],
+			     dev->dev_type.data[11],
+			     dev->dev_type.data[12],
+			     dev->dev_type.data[13],
+			     dev->dev_type.data[14],
+			     dev->dev_type.data[15]);
+
+	if (ret)
+		return ret;
+
+	ret = add_uevent_var(env, "VMBUS_DEVICE_DEVICE_GUID={"
+			     "%02x%02x%02x%02x-%02x%02x-%02x%02x-"
+			     "%02x%02x%02x%02x%02x%02x%02x%02x}",
+			     dev->dev_instance.data[3],
+			     dev->dev_instance.data[2],
+			     dev->dev_instance.data[1],
+			     dev->dev_instance.data[0],
+			     dev->dev_instance.data[5],
+			     dev->dev_instance.data[4],
+			     dev->dev_instance.data[7],
+			     dev->dev_instance.data[6],
+			     dev->dev_instance.data[8],
+			     dev->dev_instance.data[9],
+			     dev->dev_instance.data[10],
+			     dev->dev_instance.data[11],
+			     dev->dev_instance.data[12],
+			     dev->dev_instance.data[13],
+			     dev->dev_instance.data[14],
+			     dev->dev_instance.data[15]);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /* The one and only one */
 static struct hv_bus  hv_bus = {
 	.bus.name =		"vmbus",
@@ -627,81 +701,6 @@ void vmbus_child_device_unregister(struct hv_device *device_obj)
 }
 
 /*
- * vmbus_uevent - add uevent for our device
- *
- * This routine is invoked when a device is added or removed on the vmbus to
- * generate a uevent to udev in the userspace. The udev will then look at its
- * rule and the uevent generated here to load the appropriate driver
- */
-static int vmbus_uevent(struct device *device, struct kobj_uevent_env *env)
-{
-	struct hv_device *dev = device_to_hv_device(device);
-	int ret;
-
-	DPRINT_INFO(VMBUS_DRV, "generating uevent - VMBUS_DEVICE_CLASS_GUID={"
-		    "%02x%02x%02x%02x-%02x%02x-%02x%02x-"
-		    "%02x%02x%02x%02x%02x%02x%02x%02x}",
-		    dev->dev_type.data[3], dev->dev_type.data[2],
-		    dev->dev_type.data[1], dev->dev_type.data[0],
-		    dev->dev_type.data[5], dev->dev_type.data[4],
-		    dev->dev_type.data[7], dev->dev_type.data[6],
-		    dev->dev_type.data[8], dev->dev_type.data[9],
-		    dev->dev_type.data[10],
-		    dev->dev_type.data[11],
-		    dev->dev_type.data[12],
-		    dev->dev_type.data[13],
-		    dev->dev_type.data[14],
-		    dev->dev_type.data[15]);
-
-	ret = add_uevent_var(env, "VMBUS_DEVICE_CLASS_GUID={"
-			     "%02x%02x%02x%02x-%02x%02x-%02x%02x-"
-			     "%02x%02x%02x%02x%02x%02x%02x%02x}",
-			     dev->dev_type.data[3],
-			     dev->dev_type.data[2],
-			     dev->dev_type.data[1],
-			     dev->dev_type.data[0],
-			     dev->dev_type.data[5],
-			     dev->dev_type.data[4],
-			     dev->dev_type.data[7],
-			     dev->dev_type.data[6],
-			     dev->dev_type.data[8],
-			     dev->dev_type.data[9],
-			     dev->dev_type.data[10],
-			     dev->dev_type.data[11],
-			     dev->dev_type.data[12],
-			     dev->dev_type.data[13],
-			     dev->dev_type.data[14],
-			     dev->dev_type.data[15]);
-
-	if (ret)
-		return ret;
-
-	ret = add_uevent_var(env, "VMBUS_DEVICE_DEVICE_GUID={"
-			     "%02x%02x%02x%02x-%02x%02x-%02x%02x-"
-			     "%02x%02x%02x%02x%02x%02x%02x%02x}",
-			     dev->dev_instance.data[3],
-			     dev->dev_instance.data[2],
-			     dev->dev_instance.data[1],
-			     dev->dev_instance.data[0],
-			     dev->dev_instance.data[5],
-			     dev->dev_instance.data[4],
-			     dev->dev_instance.data[7],
-			     dev->dev_instance.data[6],
-			     dev->dev_instance.data[8],
-			     dev->dev_instance.data[9],
-			     dev->dev_instance.data[10],
-			     dev->dev_instance.data[11],
-			     dev->dev_instance.data[12],
-			     dev->dev_instance.data[13],
-			     dev->dev_instance.data[14],
-			     dev->dev_instance.data[15]);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-/*
  * vmbus_match - Attempt to match the specified device to the specified driver
  */
 static int vmbus_match(struct device *device, struct device_driver *driver)
-- 
1.5.5.6
