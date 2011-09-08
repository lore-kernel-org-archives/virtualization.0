From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 03/25] Staging: hv: vmbus: Rename vmbus_child_device_unregister
Date: Thu,  8 Sep 2011 07:24:14 -0700
Message-ID: <1315491876-9554-3-git-send-email-kys@microsoft.com>
References: <1315491843-9513-1-git-send-email-kys@microsoft.com>
 <1315491876-9554-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1315491876-9554-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The vmbus devices are NOT child devices; rename vmbus_child_device_unregister
to reflect this.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/channel_mgmt.c |    2 +-
 drivers/staging/hv/hyperv_vmbus.h |    2 +-
 drivers/staging/hv/vmbus_drv.c    |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
index a927046..60ce1d1 100644
--- a/drivers/staging/hv/channel_mgmt.c
+++ b/drivers/staging/hv/channel_mgmt.c
@@ -333,7 +333,7 @@ static void vmbus_process_rescind_offer(struct work_struct *work)
 						     struct vmbus_channel,
 						     work);
 
-	vmbus_child_device_unregister(channel->device_obj);
+	vmbus_device_unregister(channel->device_obj);
 }
 
 /*
diff --git a/drivers/staging/hv/hyperv_vmbus.h b/drivers/staging/hv/hyperv_vmbus.h
index b2dfcd6..3d2d836 100644
--- a/drivers/staging/hv/hyperv_vmbus.h
+++ b/drivers/staging/hv/hyperv_vmbus.h
@@ -606,7 +606,7 @@ struct hv_device *vmbus_device_create(uuid_le *type,
 					 struct vmbus_channel *channel);
 
 int vmbus_device_register(struct hv_device *child_device_obj);
-void vmbus_child_device_unregister(struct hv_device *device_obj);
+void vmbus_device_unregister(struct hv_device *device_obj);
 
 /* static void */
 /* VmbusChildDeviceDestroy( */
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 6d54ea1..375e451 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -650,10 +650,10 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 }
 
 /*
- * vmbus_child_device_unregister - Remove the specified child device
+ * vmbus_device_unregister - Remove the specified child device
  * from the vmbus.
  */
-void vmbus_child_device_unregister(struct hv_device *device_obj)
+void vmbus_device_unregister(struct hv_device *device_obj)
 {
 	/*
 	 * Kick off the process of unregistering the device.
-- 
1.7.4.1
