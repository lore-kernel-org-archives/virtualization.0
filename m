From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 36/77] Staging: hv: vmbus: Cleanup the code displaying class_id
Date: Thu, 16 Jun 2011 13:17:09 -0700
Message-ID: <1308255470-3826-36-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now that we have a human readable device_type, use that and get rid of the
guid based device type.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   19 +------------------
 1 files changed, 1 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 0e1a13c..6ec6ef3 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -113,24 +113,7 @@ static ssize_t vmbus_show_device_attr(struct device *dev,
 	get_channel_info(hv_dev, &device_info);
 
 	if (!strcmp(dev_attr->attr.name, "class_id")) {
-		return sprintf(buf, "{%02x%02x%02x%02x-%02x%02x-%02x%02x-"
-			       "%02x%02x%02x%02x%02x%02x%02x%02x}\n",
-			       device_info.chn_type.data[3],
-			       device_info.chn_type.data[2],
-			       device_info.chn_type.data[1],
-			       device_info.chn_type.data[0],
-			       device_info.chn_type.data[5],
-			       device_info.chn_type.data[4],
-			       device_info.chn_type.data[7],
-			       device_info.chn_type.data[6],
-			       device_info.chn_type.data[8],
-			       device_info.chn_type.data[9],
-			       device_info.chn_type.data[10],
-			       device_info.chn_type.data[11],
-			       device_info.chn_type.data[12],
-			       device_info.chn_type.data[13],
-			       device_info.chn_type.data[14],
-			       device_info.chn_type.data[15]);
+		return sprintf(buf, "%s\n", hv_dev->device_type);
 	} else if (!strcmp(dev_attr->attr.name, "device_id")) {
 		return sprintf(buf, "{%02x%02x%02x%02x-%02x%02x-%02x%02x-"
 			       "%02x%02x%02x%02x%02x%02x%02x%02x}\n",
-- 
1.7.4.1
