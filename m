From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 01/24] Staging: hv: mousevsc: Fixup struct hv_input_dev_info
Date: Thu, 29 Sep 2011 11:54:41 -0700
Message-ID: <1317322504-9788-1-git-send-email-kys@microsoft.com>
References: <1317322456-9747-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317322456-9747-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

This structure is protocol defined structure and must match the definition
on the host side. Make appropriate adjustments.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index fcb023a..44a2b23 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -30,10 +30,11 @@
  * Data types
  */
 struct hv_input_dev_info {
+	unsigned int size;
 	unsigned short vendor;
 	unsigned short product;
 	unsigned short version;
-	char name[128];
+	unsigned short reserved[11];
 };
 
 /* The maximum size of a synthetic input message. */
@@ -686,7 +687,7 @@ static void reportdesc_callback(struct hv_device *dev, void *packet, u32 len)
 		hid_dev->dev = dev->device;
 
 		sprintf(hid_dev->name, "%s",
-			input_device_ctx->device_info.name);
+			"Microsoft Vmbus HID-compliant Mouse");
 
 		/*
 		 * HJ Do we want to call it with a 0
@@ -763,7 +764,6 @@ static int mousevsc_on_device_add(struct hv_device *device,
 	dev_info.vendor = input_dev->hid_dev_info.vendor;
 	dev_info.product = input_dev->hid_dev_info.product;
 	dev_info.version = input_dev->hid_dev_info.version;
-	strcpy(dev_info.name, "Microsoft Vmbus HID-compliant Mouse");
 
 	/* Send the device info back up */
 	input_device_ctx = dev_get_drvdata(&device->device);
-- 
1.7.4.1
