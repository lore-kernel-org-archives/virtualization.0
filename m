From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 09/21] Staging: hv: Get rid of vmbus_child_dev_add()
Date: Thu, 10 Mar 2011 14:07:44 -0800
Message-ID: <1299794864-1165-1-git-send-email-kys@microsoft.com>
References: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
Sender: linux-kernel-owner@vger.kernel.org
To: kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <mike.sterling@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The function vmbus_child_dev_add() is a wrapper that can be
eliminated; get rid of it.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/channel_mgmt.c  |    2 +-
 drivers/staging/hv/vmbus_drv.c     |    9 +--------
 drivers/staging/hv/vmbus_private.h |    1 -
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
index 0781c0e..3368809 100644
--- a/drivers/staging/hv/channel_mgmt.c
+++ b/drivers/staging/hv/channel_mgmt.c
@@ -408,7 +408,7 @@ static void vmbus_process_offer(struct work_struct *work)
 	 * binding which eventually invokes the device driver's AddDevice()
 	 * method.
 	 */
-	ret = vmbus_child_dev_add(newchannel->device_obj);
+	ret = vmbus_child_device_register(newchannel->device_obj);
 	if (ret != 0) {
 		DPRINT_ERR(VMBUS,
 			   "unable to add child device object (relid %d)",
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 0b91eda..b473f46 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -139,13 +139,6 @@ static const struct hv_guid device_id = {
 
 static struct hv_device *vmbus_device; /* vmbus root device */
 
-/*
- * vmbus_child_dev_add - Registers the child device with the vmbus
- */
-int vmbus_child_dev_add(struct hv_device *child_dev)
-{
-	return vmbus_child_device_register(child_dev);
-}
 
 /*
  * vmbus_dev_add - Callback when the root bus device is added
@@ -662,7 +655,7 @@ struct hv_device *vmbus_child_device_create(struct hv_guid *type,
 }
 
 /*
- * vmbus_child_device_register - Register the child device on the specified bus
+ * vmbus_child_device_register - Register the child device
  */
 int vmbus_child_device_register(struct hv_device *child_device_obj)
 {
diff --git a/drivers/staging/hv/vmbus_private.h b/drivers/staging/hv/vmbus_private.h
index c176773..ca050a4 100644
--- a/drivers/staging/hv/vmbus_private.h
+++ b/drivers/staging/hv/vmbus_private.h
@@ -107,7 +107,6 @@ struct hv_device *vmbus_child_device_create(struct hv_guid *type,
 					 struct hv_guid *instance,
 					 struct vmbus_channel *channel);
 
-int vmbus_child_dev_add(struct hv_device *device);
 int vmbus_child_device_register(struct hv_device *child_device_obj);
 void vmbus_child_device_unregister(struct hv_device *device_obj);
 
-- 
1.5.5.6
