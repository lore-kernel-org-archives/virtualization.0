From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 09/59] Staging: hv: mousevsc: Use the newly introduced vmbus
	ID in mouse driver
Date: Thu, 25 Aug 2011 09:48:35 -0700
Message-ID: <1314290965-2698-9-git-send-email-kys@microsoft.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
	<1314290965-2698-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314290965-2698-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Use the newly introduced vmbus ID in mouse driver. Also, do the associated
cleanup. Since the mouse driver is not functional, we disable the
autoloading of this driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 950f4b4..dd8a114 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -178,12 +178,6 @@ struct mousevsc_dev {
 
 static const char *driver_name = "mousevsc";
 
-/* {CFA8B69E-5B4A-4cc0-B98B-8BA1A1F3F95A} */
-static const uuid_le mouse_guid = {
-	.b = {0x9E, 0xB6, 0xA8, 0xCF, 0x4A, 0x5B, 0xc0, 0x4c,
-		 0xB9, 0x8B, 0x8B, 0xA1, 0xA1, 0xF3, 0xF9, 0x5A}
-};
-
 static void deviceinfo_callback(struct hv_device *dev, struct hv_input_dev_info *info);
 static void inputreport_callback(struct hv_device *dev, void *packet, u32 len);
 static void reportdesc_callback(struct hv_device *dev, void *packet, u32 len);
@@ -914,8 +908,26 @@ static void reportdesc_callback(struct hv_device *dev, void *packet, u32 len)
 	kfree(hid_dev);
 }
 
+static const struct hv_vmbus_device_id id_table[] = {
+	{
+		/* Mouse guid */
+		.guid = {
+			0x9E, 0xB6, 0xA8, 0xCF, 0x4A, 0x5B, 0xc0, 0x4c,
+			0xB9, 0x8B, 0x8B, 0xA1, 0xA1, 0xF3, 0xF9, 0x5A
+		}
+	},
+	{
+		.guid = { }
+	},
+};
+
+/*
+ * The mouse driver is not functional; do not auto-load it.
+ */
+/* MODULE_DEVICE_TABLE(vmbus, id_table); */
 
 static struct  hv_driver mousevsc_drv = {
+	.id_table = id_table,
 	.probe = mousevsc_probe,
 	.remove = mousevsc_remove,
 };
@@ -931,9 +943,6 @@ static int __init mousevsc_init(void)
 
 	DPRINT_INFO(INPUTVSC_DRV, "Hyper-V Mouse driver initializing.");
 
-	memcpy(&drv->dev_type, &mouse_guid,
-	       sizeof(uuid_le));
-
 	drv->driver.name = driver_name;
 
 	/* The driver belongs to vmbus */
-- 
1.7.4.1
