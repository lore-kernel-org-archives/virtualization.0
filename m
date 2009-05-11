From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] xen/blkfront: remove driver_data direct access of struct
 device
Date: Mon, 11 May 2009 21:02:08 +0200
Message-ID: <4A087630.30802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756736AbZEKTCZ@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jeremy@xensource.com
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

To avoid direct access to the driver_data pointer in struct device, the
functions dev_get_drvdata() and dev_set_drvdata() should be used.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 8f90508..ff09809 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -755,12 +755,12 @@ static int blkfront_probe(struct xenbus_device *dev,
 
 	/* Front end dir is a number, which is used as the id. */
 	info->handle = simple_strtoul(strrchr(dev->nodename, '/')+1, NULL, 0);
-	dev->dev.driver_data = info;
+	dev_set_drvdata(&dev->dev, info);
 
 	err = talk_to_backend(dev, info);
 	if (err) {
 		kfree(info);
-		dev->dev.driver_data = NULL;
+		dev_set_drvdata(&dev->dev, NULL);
 		return err;
 	}
 
@@ -845,7 +845,7 @@ static int blkif_recover(struct blkfront_info *info)
  */
 static int blkfront_resume(struct xenbus_device *dev)
 {
-	struct blkfront_info *info = dev->dev.driver_data;
+	struct blkfront_info *info = dev_get_drvdata(&dev->dev);
 	int err;
 
 	dev_dbg(&dev->dev, "blkfront_resume: %s\n", dev->nodename);
@@ -924,7 +924,7 @@ static void blkfront_connect(struct blkfront_info *info)
  */
 static void blkfront_closing(struct xenbus_device *dev)
 {
-	struct blkfront_info *info = dev->dev.driver_data;
+	struct blkfront_info *info = dev_get_drvdata(&dev->dev);
 	unsigned long flags;
 
 	dev_dbg(&dev->dev, "blkfront_closing: %s removed\n", dev->nodename);
@@ -959,7 +959,7 @@ static void blkfront_closing(struct xenbus_device *dev)
 static void backend_changed(struct xenbus_device *dev,
 			    enum xenbus_state backend_state)
 {
-	struct blkfront_info *info = dev->dev.driver_data;
+	struct blkfront_info *info = dev_get_drvdata(&dev->dev);
 	struct block_device *bd;
 
 	dev_dbg(&dev->dev, "blkfront:backend_changed.\n");
@@ -997,7 +997,7 @@ static void backend_changed(struct xenbus_device *dev,
 
 static int blkfront_remove(struct xenbus_device *dev)
 {
-	struct blkfront_info *info = dev->dev.driver_data;
+	struct blkfront_info *info = dev_get_drvdata(&dev->dev);
 
 	dev_dbg(&dev->dev, "blkfront_remove: %s removed\n", dev->nodename);
 
@@ -1010,7 +1010,7 @@ static int blkfront_remove(struct xenbus_device *dev)
 
 static int blkfront_is_ready(struct xenbus_device *dev)
 {
-	struct blkfront_info *info = dev->dev.driver_data;
+	struct blkfront_info *info = dev_get_drvdata(&dev->dev);
 
 	return info->is_ready;
 }
