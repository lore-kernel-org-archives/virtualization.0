From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 39/77] Staging: hv: vmbus: Get rid of the  device_id attribute
Date: Thu, 16 Jun 2011 13:17:12 -0700
Message-ID: <1308255470-3826-39-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The guid based instance data is not very useful. There is enough information
to identify the device. Get rid of this attribute.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 2702c48..36bba44 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -114,25 +114,6 @@ static ssize_t vmbus_show_device_attr(struct device *dev,
 
 	if (!strcmp(dev_attr->attr.name, "class_id")) {
 		return sprintf(buf, "%s\n", hv_dev->device_type);
-	} else if (!strcmp(dev_attr->attr.name, "device_id")) {
-		return sprintf(buf, "{%02x%02x%02x%02x-%02x%02x-%02x%02x-"
-			       "%02x%02x%02x%02x%02x%02x%02x%02x}\n",
-			       device_info.chn_instance.data[3],
-			       device_info.chn_instance.data[2],
-			       device_info.chn_instance.data[1],
-			       device_info.chn_instance.data[0],
-			       device_info.chn_instance.data[5],
-			       device_info.chn_instance.data[4],
-			       device_info.chn_instance.data[7],
-			       device_info.chn_instance.data[6],
-			       device_info.chn_instance.data[8],
-			       device_info.chn_instance.data[9],
-			       device_info.chn_instance.data[10],
-			       device_info.chn_instance.data[11],
-			       device_info.chn_instance.data[12],
-			       device_info.chn_instance.data[13],
-			       device_info.chn_instance.data[14],
-			       device_info.chn_instance.data[15]);
 	} else if (!strcmp(dev_attr->attr.name, "state")) {
 		return sprintf(buf, "%d\n", device_info.chn_state);
 	} else if (!strcmp(dev_attr->attr.name, "id")) {
@@ -187,7 +168,6 @@ static struct device_attribute vmbus_device_attrs[] = {
 	__ATTR(id, S_IRUGO, vmbus_show_device_attr, NULL),
 	__ATTR(state, S_IRUGO, vmbus_show_device_attr, NULL),
 	__ATTR(class_id, S_IRUGO, vmbus_show_device_attr, NULL),
-	__ATTR(device_id, S_IRUGO, vmbus_show_device_attr, NULL),
 	__ATTR(monitor_id, S_IRUGO, vmbus_show_device_attr, NULL),
 
 	__ATTR(server_monitor_pending, S_IRUGO, vmbus_show_device_attr, NULL),
-- 
1.7.4.1
