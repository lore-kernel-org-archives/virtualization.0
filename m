From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 19/21] Staging: hv: Get rid of the forward declaration for vmbus_device_release
Date: Thu, 10 Mar 2011 14:15:26 -0800
Message-ID: <1299795326-1563-1-git-send-email-kys@microsoft.com>
References: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
Sender: linux-kernel-owner@vger.kernel.org
To: kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <mike.sterling@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the forward declaration of vmbus_device_release by moving
the code around.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   27 ++++++++++++---------------
 1 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 6f4094b..7c16acd 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -53,8 +53,6 @@ struct hv_bus {
 
 static irqreturn_t vmbus_isr(int irq, void *dev_id);
 
-static void vmbus_device_release(struct device *device);
-
 static ssize_t vmbus_show_device_attr(struct device *dev,
 				      struct device_attribute *dev_attr,
 				      char *buf);
@@ -300,6 +298,18 @@ static void vmbus_shutdown(struct device *child_device)
 	return;
 }
 
+
+/*
+ * vmbus_device_release - Final callback release of the vmbus child device
+ */
+static void vmbus_device_release(struct device *device)
+{
+	struct hv_device *device_ctx = device_to_hv_device(device);
+
+	kfree(device_ctx);
+
+}
+
 /* The one and only one */
 static struct hv_bus  hv_bus = {
 	.bus.name =		"vmbus",
@@ -848,19 +858,6 @@ void vmbus_child_device_unregister(struct hv_device *device_obj)
 }
 
 
-/*
- * vmbus_device_release - Final callback release of the vmbus child device
- */
-static void vmbus_device_release(struct device *device)
-{
-	struct hv_device *device_ctx = device_to_hv_device(device);
-
-	kfree(device_ctx);
-
-	/* !!DO NOT REFERENCE device_ctx anymore at this point!! */
-}
-
-
 
 static irqreturn_t vmbus_isr(int irq, void *dev_id)
 {
-- 
1.5.5.6
