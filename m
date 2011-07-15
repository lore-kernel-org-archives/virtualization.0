From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 036/117] Staging: hv: vmbus: Make class_id attribute a human
	readable string
Date: Fri, 15 Jul 2011 10:46:24 -0700
Message-ID: <1310752065-27895-36-git-send-email-kys@microsoft.com>
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

Now that we have a human readable device_type, use that and get rid of the
guid based device type.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   20 ++------------------
 1 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 9a0df2c..67415ab 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -113,24 +113,8 @@ static ssize_t vmbus_show_device_attr(struct device *dev,
 	get_channel_info(hv_dev, &device_info);
 
 	if (!strcmp(dev_attr->attr.name, "class_id")) {
-		return sprintf(buf, "{%02x%02x%02x%02x-%02x%02x-%02x%02x-"
-			       "%02x%02x%02x%02x%02x%02x%02x%02x}\n",
-			       device_info.chn_type.b[3],
-			       device_info.chn_type.b[2],
-			       device_info.chn_type.b[1],
-			       device_info.chn_type.b[0],
-			       device_info.chn_type.b[5],
-			       device_info.chn_type.b[4],
-			       device_info.chn_type.b[7],
-			       device_info.chn_type.b[6],
-			       device_info.chn_type.b[8],
-			       device_info.chn_type.b[9],
-			       device_info.chn_type.b[10],
-			       device_info.chn_type.b[11],
-			       device_info.chn_type.b[12],
-			       device_info.chn_type.b[13],
-			       device_info.chn_type.b[14],
-			       device_info.chn_type.b[15]);
+		return sprintf(buf, "%s\n",
+				hv_get_devtype_name(&device_info.chn_type));
 	} else if (!strcmp(dev_attr->attr.name, "device_id")) {
 		return sprintf(buf, "{%02x%02x%02x%02x-%02x%02x-%02x%02x-"
 			       "%02x%02x%02x%02x%02x%02x%02x%02x}\n",
-- 
1.7.4.1
