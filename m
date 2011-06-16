From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 35/77] Staging: hv: mouse: Get rid of the dev_type guid in hv_mouse.c
Date: Thu, 16 Jun 2011 13:17:08 -0700
Message-ID: <1308255470-3826-35-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the dev_type guid in hv_mouse.c, as it is not used.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index e615041..b902e0e 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -179,12 +179,6 @@ struct mousevsc_dev {
 
 static const char *driver_name = "mousevsc";
 
-/* {CFA8B69E-5B4A-4cc0-B98B-8BA1A1F3F95A} */
-static const struct hv_guid mouse_guid = {
-	.data = {0x9E, 0xB6, 0xA8, 0xCF, 0x4A, 0x5B, 0xc0, 0x4c,
-		 0xB9, 0x8B, 0x8B, 0xA1, 0xA1, 0xF3, 0xF9, 0x5A}
-};
-
 static void deviceinfo_callback(struct hv_device *dev, struct hv_input_dev_info *info);
 static void inputreport_callback(struct hv_device *dev, void *packet, u32 len);
 static void reportdesc_callback(struct hv_device *dev, void *packet, u32 len);
@@ -937,9 +931,6 @@ static int __init mousevsc_init(void)
 
 	DPRINT_INFO(INPUTVSC_DRV, "Hyper-V Mouse driver initializing.");
 
-	memcpy(&drv->dev_type, &mouse_guid,
-	       sizeof(struct hv_guid));
-
 	drv->driver.name = driver_name;
 
 	/* The driver belongs to vmbus */
-- 
1.7.4.1
