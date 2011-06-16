From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 20/77] Staging: hv: vmbus: Cleanup the vmbus_uevent() code
Date: Thu, 16 Jun 2011 13:16:53 -0700
Message-ID: <1308255470-3826-20-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now generate appropriate uevent based on the modalias string. As part of this,
cleanup the existing uevent code.


Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   50 +--------------------------------------
 1 files changed, 2 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 04a6945..af657a9 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -241,54 +241,8 @@ static struct device_attribute vmbus_device_attrs[] = {
 static int vmbus_uevent(struct device *device, struct kobj_uevent_env *env)
 {
 	struct hv_device *dev = device_to_hv_device(device);
-	int ret;
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
+	return add_uevent_var(env, "MODALIAS=vmbus:%s", dev->device_type);
 }
 
 
-- 
1.7.4.1
