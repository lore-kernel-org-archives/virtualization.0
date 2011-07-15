From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 037/117] Staging: hv: vmbus: Get rid of the device_id attribute
Date: Fri, 15 Jul 2011 10:46:25 -0700
Message-ID: <1310752065-27895-37-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The guid based instance data is not very useful. There is enough information
to identify the device. Get rid of this attribute.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 67415ab..1d161ba 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -115,25 +115,6 @@ static ssize_t vmbus_show_device_attr(struct device *dev,
 	if (!strcmp(dev_attr->attr.name, "class_id")) {
 		return sprintf(buf, "%s\n",
 				hv_get_devtype_name(&device_info.chn_type));
-	} else if (!strcmp(dev_attr->attr.name, "device_id")) {
-		return sprintf(buf, "{%02x%02x%02x%02x-%02x%02x-%02x%02x-"
-			       "%02x%02x%02x%02x%02x%02x%02x%02x}\n",
-			       device_info.chn_instance.b[3],
-			       device_info.chn_instance.b[2],
-			       device_info.chn_instance.b[1],
-			       device_info.chn_instance.b[0],
-			       device_info.chn_instance.b[5],
-			       device_info.chn_instance.b[4],
-			       device_info.chn_instance.b[7],
-			       device_info.chn_instance.b[6],
-			       device_info.chn_instance.b[8],
-			       device_info.chn_instance.b[9],
-			       device_info.chn_instance.b[10],
-			       device_info.chn_instance.b[11],
-			       device_info.chn_instance.b[12],
-			       device_info.chn_instance.b[13],
-			       device_info.chn_instance.b[14],
-			       device_info.chn_instance.b[15]);
 	} else if (!strcmp(dev_attr->attr.name, "state")) {
 		return sprintf(buf, "%d\n", device_info.chn_state);
 	} else if (!strcmp(dev_attr->attr.name, "id")) {
@@ -188,7 +169,6 @@ static struct device_attribute vmbus_device_attrs[] = {
 	__ATTR(id, S_IRUGO, vmbus_show_device_attr, NULL),
 	__ATTR(state, S_IRUGO, vmbus_show_device_attr, NULL),
 	__ATTR(class_id, S_IRUGO, vmbus_show_device_attr, NULL),
-	__ATTR(device_id, S_IRUGO, vmbus_show_device_attr, NULL),
 	__ATTR(monitor_id, S_IRUGO, vmbus_show_device_attr, NULL),
 
 	__ATTR(server_monitor_pending, S_IRUGO, vmbus_show_device_attr, NULL),
-- 
1.7.4.1
