From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 13/77] Staging: hv: vmbus: Introduce a human readable device type field to struct hv_device
Date: Thu, 16 Jun 2011 13:16:46 -0700
Message-ID: <1308255470-3826-13-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Introduce a human readable device type field to struct hv_device.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hyperv.h    |    1 +
 drivers/staging/hv/vmbus_drv.c |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
index 84f60a3..28fe7f9 100644
--- a/drivers/staging/hv/hyperv.h
+++ b/drivers/staging/hv/hyperv.h
@@ -825,6 +825,7 @@ struct hv_driver {
 struct hv_device {
 	/* the device type id of this device */
 	struct hv_guid dev_type;
+	const char *device_type;
 
 	/* the device instance id of this device */
 	struct hv_guid dev_instance;
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 559353d..04a6945 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -645,6 +645,10 @@ struct hv_device *vmbus_child_device_create(struct hv_guid *type,
 
 	child_device_obj->channel = channel;
 	memcpy(&child_device_obj->dev_type, type, sizeof(struct hv_guid));
+	/*
+	 * Get the human readable device type name and stash it away.
+	 */
+	child_device_obj->device_type = hv_get_devtype_name(type);
 	memcpy(&child_device_obj->dev_instance, instance,
 	       sizeof(struct hv_guid));
 
-- 
1.7.4.1
