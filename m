From: Hank Janssen <hjanssen@microsoft.com>
Subject: [PATCH 3/5] staging: hv: Convert camel case member of struct mousevsc_drv_obj to lower case
Date: Fri,  1 Apr 2011 14:32:12 -0700
Message-ID: <1301693534-14629-3-git-send-email-hjanssen@microsoft.com>
References: <1301693534-14629-1-git-send-email-hjanssen@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1301693534-14629-1-git-send-email-hjanssen@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hjanssen@microsoft.com, hjanssen@linuxonhyperv.com, haiyangz@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Abhishek Kane <v-abkane@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Change camelcase members of mousevsc_drv_obj to lower case in hv_mouse.

Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

---
 drivers/staging/hv/hv_mouse.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 3b0390d..ce88868 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -46,7 +46,7 @@ struct hv_input_dev_info {
 /* Represents the input vsc driver */
 /* FIXME - can be removed entirely */
 struct mousevsc_drv_obj {
-	struct hv_driver Base;
+	struct hv_driver base;
 };
 
 
@@ -836,7 +836,7 @@ static int mousevsc_probe(struct device *device)
 	dev_set_drvdata(device, input_dev_ctx);
 
 	/* Call to the vsc driver to add the device */
-	ret = mousevsc_drv_obj->Base.dev_add(device_obj, NULL);
+	ret = mousevsc_drv_obj->base.dev_add(device_obj, NULL);
 
 	if (ret != 0) {
 		DPRINT_ERR(INPUTVSC_DRV, "unable to add input vsc device");
@@ -868,14 +868,14 @@ static int mousevsc_remove(struct device *device)
 		input_dev_ctx->connected = 0;
 	}
 
-	if (!mousevsc_drv_obj->Base.dev_rm)
+	if (!mousevsc_drv_obj->base.dev_rm)
 		return -1;
 
 	/*
 	 * Call to the vsc driver to let it know that the device
 	 * is being removed
 	 */
-	ret = mousevsc_drv_obj->Base.dev_rm(device_obj);
+	ret = mousevsc_drv_obj->base.dev_rm(device_obj);
 
 	if (ret != 0) {
 		DPRINT_ERR(INPUTVSC_DRV,
@@ -951,7 +951,7 @@ static int mousevsc_drv_exit_cb(struct device *dev, void *data)
 static void mousevsc_drv_exit(void)
 {
 	struct mousevsc_drv_obj *mousevsc_drv_obj = &g_mousevsc_drv;
-	struct hv_driver *drv = &g_mousevsc_drv.Base;
+	struct hv_driver *drv = &g_mousevsc_drv.base;
 	int ret;
 
 	struct device *current_dev = NULL;
@@ -973,8 +973,8 @@ static void mousevsc_drv_exit(void)
 		device_unregister(current_dev);
 	}
 
-	if (mousevsc_drv_obj->Base.cleanup)
-		mousevsc_drv_obj->Base.cleanup(&mousevsc_drv_obj->Base);
+	if (mousevsc_drv_obj->base.cleanup)
+		mousevsc_drv_obj->base.cleanup(&mousevsc_drv_obj->base);
 
 	vmbus_child_driver_unregister(&drv->driver);
 
@@ -992,9 +992,9 @@ static int mouse_vsc_initialize(struct hv_driver *driver)
 	       sizeof(struct hv_guid));
 
 	/* Setup the dispatch table */
-	inputDriver->Base.dev_add = mousevsc_on_device_add;
-	inputDriver->Base.dev_rm = mousevsc_on_device_remove;
-	inputDriver->Base.cleanup = mousevsc_on_cleanup;
+	inputDriver->base.dev_add = mousevsc_on_device_add;
+	inputDriver->base.dev_rm = mousevsc_on_device_remove;
+	inputDriver->base.cleanup = mousevsc_on_cleanup;
 
 	return ret;
 }
@@ -1003,14 +1003,14 @@ static int mouse_vsc_initialize(struct hv_driver *driver)
 static int __init mousevsc_init(void)
 {
 	struct mousevsc_drv_obj *input_drv_obj = &g_mousevsc_drv;
-	struct hv_driver *drv = &g_mousevsc_drv.Base;
+	struct hv_driver *drv = &g_mousevsc_drv.base;
 
 	DPRINT_INFO(INPUTVSC_DRV, "Hyper-V Mouse driver initializing.");
 
 	/* Callback to client driver to complete the initialization */
-	mouse_vsc_initialize(&input_drv_obj->Base);
+	mouse_vsc_initialize(&input_drv_obj->base);
 
-	drv->driver.name = input_drv_obj->Base.name;
+	drv->driver.name = input_drv_obj->base.name;
 	drv->priv = input_drv_obj;
 
 	drv->driver.probe = mousevsc_probe;
-- 
1.7.1
