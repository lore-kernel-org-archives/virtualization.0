From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 09/24] Staging: hv: mousevsc: Get rid of unnecessary DPRINT calls
Date: Thu, 29 Sep 2011 11:54:49 -0700
Message-ID: <1317322504-9788-9-git-send-email-kys@microsoft.com>
References: <1317322456-9747-1-git-send-email-kys@microsoft.com>
 <1317322504-9788-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317322504-9788-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of unnecessary DPRINT calls.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |   18 +++---------------
 1 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 8d94aef..8dd902a 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -665,10 +665,8 @@ static void reportdesc_callback(struct hv_device *dev, void *packet, u32 len)
 	hid_dev->ll_driver = &mousevsc_ll_driver;
 	hid_dev->driver = &mousevsc_hid_driver;
 
-	if (hid_parse_report(hid_dev, packet, len)) {
-		DPRINT_INFO(INPUTVSC_DRV, "Unable to call hd_parse_report");
+	if (hid_parse_report(hid_dev, packet, len))
 		return;
-	}
 
 	hid_dev->bus = BUS_VIRTUAL;
 	hid_dev->vendor = input_device->hid_dev_info.vendor;
@@ -797,11 +795,8 @@ static int mousevsc_probe(struct hv_device *dev,
 	/* Call to the vsc driver to add the device */
 	ret = mousevsc_on_device_add(dev, NULL);
 
-	if (ret != 0) {
-		DPRINT_ERR(INPUTVSC_DRV, "unable to add input vsc device");
-
+	if (ret != 0)
 		return -1;
-	}
 
 	return 0;
 }
@@ -809,7 +804,6 @@ static int mousevsc_probe(struct hv_device *dev,
 static int mousevsc_remove(struct hv_device *dev)
 {
 	struct mousevsc_dev *input_dev = hv_get_drvdata(dev);
-	int ret;
 
 	if (input_dev->connected) {
 		hidinput_disconnect(input_dev->hid_device);
@@ -821,13 +815,7 @@ static int mousevsc_remove(struct hv_device *dev)
 	 * Call to the vsc driver to let it know that the device
 	 * is being removed
 	 */
-	ret = mousevsc_on_device_remove(dev);
-	if (ret != 0) {
-		DPRINT_ERR(INPUTVSC_DRV,
-			   "unable to remove vsc device (ret %d)", ret);
-	}
-
-	return ret;
+	return mousevsc_on_device_remove(dev);
 }
 
 static const struct hv_vmbus_device_id id_table[] = {
-- 
1.7.4.1
