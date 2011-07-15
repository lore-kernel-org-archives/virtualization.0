From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 116/117] Staging: hv: vmbus: Add code to display modalias attribute
Date: Fri, 15 Jul 2011 10:47:44 -0700
Message-ID: <1310752065-27895-116-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Add code to display modalias attribute.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index f271e8d..433be51 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -113,6 +113,14 @@ static ssize_t vmbus_show_device_attr(struct device *dev,
 	if (!strcmp(dev_attr->attr.name, "class_id")) {
 		return sprintf(buf, "%s\n",
 				hv_get_devtype_name(&device_info.chn_type));
+	} else if (!strcmp(dev_attr->attr.name, "modalias")) {
+		int i;
+		char alias_name[((sizeof(struct hv_vmbus_device_id) + 1)) * 2];
+
+		for (i = 0; i < (sizeof(struct hv_vmbus_device_id) * 2); i += 2)
+			sprintf(&alias_name[i], "%02x",
+				hv_dev->dev_type.b[i/2]);
+		return sprintf("vmbus:%s\n", alias_name);
 	} else if (!strcmp(dev_attr->attr.name, "state")) {
 		return sprintf(buf, "%d\n", device_info.chn_state);
 	} else if (!strcmp(dev_attr->attr.name, "id")) {
@@ -167,6 +175,7 @@ static struct device_attribute vmbus_device_attrs[] = {
 	__ATTR(id, S_IRUGO, vmbus_show_device_attr, NULL),
 	__ATTR(state, S_IRUGO, vmbus_show_device_attr, NULL),
 	__ATTR(class_id, S_IRUGO, vmbus_show_device_attr, NULL),
+	__ATTR(modalias, S_IRUGO, vmbus_show_device_attr, NULL),
 	__ATTR(monitor_id, S_IRUGO, vmbus_show_device_attr, NULL),
 
 	__ATTR(server_monitor_pending, S_IRUGO, vmbus_show_device_attr, NULL),
-- 
1.7.4.1
