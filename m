From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 4/8] staging: hv: Convert camel cased functions in vmbus_drv.c to lower cases
Date: Wed, 26 Jan 2011 09:50:02 -0800
Message-ID: <1296064206-11372-4-git-send-email-haiyangz@microsoft.com>
References: <1296064206-11372-1-git-send-email-haiyangz@microsoft.com>
 <1296064206-11372-2-git-send-email-haiyangz@microsoft.com>
 <1296064206-11372-3-git-send-email-haiyangz@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296064206-11372-3-git-send-email-haiyangz@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/channel_mgmt.c  |    4 ++--
 drivers/staging/hv/vmbus_drv.c     |   22 +++++++++++-----------
 drivers/staging/hv/vmbus_private.h |    6 +++---
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
index 0ce8f54..732a457 100644
--- a/drivers/staging/hv/channel_mgmt.c
+++ b/drivers/staging/hv/channel_mgmt.c
@@ -391,7 +391,7 @@ static void vmbus_process_offer(struct work_struct *work)
 	/*
 	 * Start the process of binding this offer to the driver
 	 * We need to set the DeviceObject field before calling
-	 * VmbusChildDeviceAdd()
+	 * vmbus_child_dev_add()
 	 */
 	newchannel->device_obj = vmbus_child_device_create(
 		&newchannel->offermsg.offer.InterfaceType,
@@ -406,7 +406,7 @@ static void vmbus_process_offer(struct work_struct *work)
 	 * binding which eventually invokes the device driver's AddDevice()
 	 * method.
 	 */
-	ret = VmbusChildDeviceAdd(newchannel->device_obj);
+	ret = vmbus_child_dev_add(newchannel->device_obj);
 	if (ret != 0) {
 		DPRINT_ERR(VMBUS,
 			   "unable to add child device object (relid %d)",
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 99686f0..0c0aadb 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -148,17 +148,17 @@ static const struct hv_guid device_id = {
 static struct hv_device *vmbus_device; /* vmbus root device */
 
 /*
- * VmbusChildDeviceAdd - Registers the child device with the vmbus
+ * vmbus_child_dev_add - Registers the child device with the vmbus
  */
-int VmbusChildDeviceAdd(struct hv_device *child_dev)
+int vmbus_child_dev_add(struct hv_device *child_dev)
 {
 	return vmbus_child_device_register(vmbus_device, child_dev);
 }
 
 /*
- * VmbusOnDeviceAdd - Callback when the root bus device is added
+ * vmbus_dev_add - Callback when the root bus device is added
  */
-static int VmbusOnDeviceAdd(struct hv_device *dev, void *info)
+static int vmbus_dev_add(struct hv_device *dev, void *info)
 {
 	u32 *irqvector = info;
 	int ret;
@@ -181,9 +181,9 @@ static int VmbusOnDeviceAdd(struct hv_device *dev, void *info)
 }
 
 /*
- * VmbusOnDeviceRemove - Callback when the root bus device is removed
+ * vmbus_dev_rm - Callback when the root bus device is removed
  */
-static int VmbusOnDeviceRemove(struct hv_device *dev)
+static int vmbus_dev_rm(struct hv_device *dev)
 {
 	int ret = 0;
 
@@ -194,9 +194,9 @@ static int VmbusOnDeviceRemove(struct hv_device *dev)
 }
 
 /*
- * VmbusOnCleanup - Perform any cleanup when the driver is removed
+ * vmbus_cleanup - Perform any cleanup when the driver is removed
  */
-static void VmbusOnCleanup(struct hv_driver *drv)
+static void vmbus_cleanup(struct hv_driver *drv)
 {
 	/* struct vmbus_driver *driver = (struct vmbus_driver *)drv; */
 
@@ -482,9 +482,9 @@ static int vmbus_bus_init(void)
 	memcpy(&driver->deviceType, &device_type, sizeof(struct hv_guid));
 
 	/* Setup dispatch table */
-	driver->OnDeviceAdd	= VmbusOnDeviceAdd;
-	driver->OnDeviceRemove	= VmbusOnDeviceRemove;
-	driver->OnCleanup	= VmbusOnCleanup;
+	driver->OnDeviceAdd	= vmbus_dev_add;
+	driver->OnDeviceRemove	= vmbus_dev_rm;
+	driver->OnCleanup	= vmbus_cleanup;
 
 	/* Hypervisor initialization...setup hypercall page..etc */
 	ret = hv_init();
diff --git a/drivers/staging/hv/vmbus_private.h b/drivers/staging/hv/vmbus_private.h
index e3b0663..0ab404e 100644
--- a/drivers/staging/hv/vmbus_private.h
+++ b/drivers/staging/hv/vmbus_private.h
@@ -102,11 +102,11 @@ extern struct VMBUS_CONNECTION vmbus_connection;
 
 /* General vmbus interface */
 
-struct hv_device *vmbus_child_device_create(struct hv_guid *deviceType,
-					 struct hv_guid *deviceInstance,
+struct hv_device *vmbus_child_device_create(struct hv_guid *type,
+					 struct hv_guid *instance,
 					 struct vmbus_channel *channel);
 
-int VmbusChildDeviceAdd(struct hv_device *Device);
+int vmbus_child_dev_add(struct hv_device *device);
 int vmbus_child_device_register(struct hv_device *root_device_obj,
 				struct hv_device *child_device_obj);
 void vmbus_child_device_unregister(struct hv_device *device_obj);
-- 
1.6.3.2
