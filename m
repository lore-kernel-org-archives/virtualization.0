From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 03/25] Staging: hv: Get rid of the references to the priv element of struct hv_driver in hv_mouse.c
Date: Tue, 26 Apr 2011 09:20:20 -0700
Message-ID: <1303834842-5022-3-git-send-email-kys@microsoft.com>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
 <1303834842-5022-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303834842-5022-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for getting rid of the priv element from struct hv_driver,
get rid of the references to the priv element of struct hv_driver
in hv_mouse.c


Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index bd93548..4333247 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -52,6 +52,13 @@ struct mousevsc_drv_obj {
 };
 
 
+static inline
+struct mousevsc_drv_obj *drv_to_mousedrv(struct device_driver *d)
+{
+	struct hv_driver *hvdrv = drv_to_hv_drv(d);
+	return container_of(hvdrv, struct mousevsc_drv_obj, base);
+}
+
 /* The maximum size of a synthetic input message. */
 #define SYNTHHID_MAX_INPUT_REPORT_SIZE 16
 
@@ -428,7 +435,7 @@ static void mousevsc_on_receive_input_report(struct mousevsc_dev *input_device,
 		return;
 	}
 
-	input_drv = (struct mousevsc_drv_obj *)input_device->device->drv;
+	input_drv = drv_to_mousedrv(input_device->device->device.driver);
 
 	inputreport_callback(input_device->device,
 			     input_report->buffer,
@@ -713,7 +720,7 @@ static int mousevsc_on_device_add(struct hv_device *device,
 		return ret;
 	}
 
-	input_drv = (struct mousevsc_drv_obj *)input_dev->device->drv;
+	input_drv = drv_to_mousedrv(input_dev->device->device.driver);
 
 	dev_info.vendor = input_dev->hid_dev_info.vendor;
 	dev_info.product = input_dev->hid_dev_info.product;
@@ -829,9 +836,8 @@ static int mousevsc_probe(struct device *device)
 {
 	int ret = 0;
 
-	struct hv_driver *drv =
-		drv_to_hv_drv(device->driver);
-	struct mousevsc_drv_obj *mousevsc_drv_obj = drv->priv;
+	struct mousevsc_drv_obj *mousevsc_drv_obj =
+		drv_to_mousedrv(device->driver);
 
 	struct hv_device *device_obj = device_to_hv_device(device);
 	struct input_device_context *input_dev_ctx;
@@ -857,9 +863,8 @@ static int mousevsc_remove(struct device *device)
 {
 	int ret = 0;
 
-	struct hv_driver *drv =
-		drv_to_hv_drv(device->driver);
-	struct mousevsc_drv_obj *mousevsc_drv_obj = drv->priv;
+	struct mousevsc_drv_obj *mousevsc_drv_obj =
+		drv_to_mousedrv(device->driver);
 
 	struct hv_device *device_obj = device_to_hv_device(device);
 	struct input_device_context *input_dev_ctx;
@@ -1017,7 +1022,6 @@ static int __init mousevsc_init(void)
 	mouse_vsc_initialize(&input_drv_obj->base);
 
 	drv->driver.name = input_drv_obj->base.name;
-	drv->priv = input_drv_obj;
 
 	drv->driver.probe = mousevsc_probe;
 	drv->driver.remove = mousevsc_remove;
-- 
1.7.4.1
