From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] xen pvfb: remove driver_data direct access of struct device
Date: Mon, 11 May 2009 21:07:08 +0200
Message-ID: <4A08775C.20305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756173AbZEKTH1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jeremy@xensource.com
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

To avoid direct access to the driver_data pointer in struct device, the
functions dev_get_drvdata() and dev_set_drvdata() should be used.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/input/xen-kbdfront.c b/drivers/input/xen-kbdfront.c
index 928d2ed..b115726 100644
--- a/drivers/input/xen-kbdfront.c
+++ b/drivers/input/xen-kbdfront.c
@@ -114,7 +114,7 @@ static int __devinit xenkbd_probe(struct xenbus_device *dev,
 		xenbus_dev_fatal(dev, -ENOMEM, "allocating info structure");
 		return -ENOMEM;
 	}
-	dev->dev.driver_data = info;
+	dev_set_drvdata(&dev->dev, info);
 	info->xbdev = dev;
 	info->irq = -1;
 	snprintf(info->phys, sizeof(info->phys), "xenbus/%s", dev->nodename);
@@ -186,7 +186,7 @@ static int __devinit xenkbd_probe(struct xenbus_device *dev,
 
 static int xenkbd_resume(struct xenbus_device *dev)
 {
-	struct xenkbd_info *info = dev->dev.driver_data;
+	struct xenkbd_info *info = dev_get_drvdata(&dev->dev);
 
 	xenkbd_disconnect_backend(info);
 	memset(info->page, 0, PAGE_SIZE);
@@ -195,7 +195,7 @@ static int xenkbd_resume(struct xenbus_device *dev)
 
 static int xenkbd_remove(struct xenbus_device *dev)
 {
-	struct xenkbd_info *info = dev->dev.driver_data;
+	struct xenkbd_info *info = dev_get_drvdata(&dev->dev);
 
 	xenkbd_disconnect_backend(info);
 	if (info->kbd)
@@ -266,7 +266,7 @@ static void xenkbd_disconnect_backend(struct xenkbd_info *info)
 static void xenkbd_backend_changed(struct xenbus_device *dev,
 				   enum xenbus_state backend_state)
 {
-	struct xenkbd_info *info = dev->dev.driver_data;
+	struct xenkbd_info *info = dev_get_drvdata(&dev->dev);
 	int ret, val;
 
 	switch (backend_state) {
