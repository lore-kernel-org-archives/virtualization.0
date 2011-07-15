From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 020/117] Staging: hv: vmbus: Support the notion of id tables
	in vmbus_match()
Date: Fri, 15 Jul 2011 10:46:08 -0700
Message-ID: <1310752065-27895-20-git-send-email-kys@microsoft.com>
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

Introduce code to handle driver specific id tables to the vmbus core
(vmbus_match). This would allow us to handle more than one device type
with a given driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 7baba62..3a8eb36 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -255,21 +255,32 @@ static int vmbus_uevent(struct device *device, struct kobj_uevent_env *env)
 	return ret;
 }
 
+static bool is_not_null_guid(const __u8 *guid)
+{
+	int i;
+
+	for (i = 0; i < (sizeof(struct hv_vmbus_device_id)); i++)
+		if (guid[i] != 0)
+			return true;
+	return false;
+}
+
 
 /*
  * vmbus_match - Attempt to match the specified device to the specified driver
  */
 static int vmbus_match(struct device *device, struct device_driver *driver)
 {
-	int match = 0;
 	struct hv_driver *drv = drv_to_hv_drv(driver);
 	struct hv_device *hv_dev = device_to_hv_device(device);
+	const struct hv_vmbus_device_id *id_array = drv->id_table;
 
-	/* We found our driver ? */
-	if (!uuid_le_cmp(hv_dev->dev_type, drv->dev_type))
-		match = 1;
+	for (; is_not_null_guid(id_array->guid); id_array++)
+		if (!memcmp(&id_array->guid, &hv_dev->dev_type.b,
+				sizeof(struct hv_vmbus_device_id)))
+			return 1;
 
-	return match;
+	return 0;
 }
 
 /*
-- 
1.7.4.1
