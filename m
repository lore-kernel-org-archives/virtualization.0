From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH 2] xen pvfb: remove driver_data direct access of struct device
Date: Mon, 11 May 2009 21:13:32 +0200
Message-ID: <4A0878DC.8040907@gmail.com>
References: <4A08775C.20305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754456AbZEKTNp@vger.kernel.org>
In-Reply-To: <4A08775C.20305@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jeremy@xensource.com
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

To avoid direct access to the driver_data pointer in struct device, the
functions dev_get_drvdata() and dev_set_drvdata() should be used.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
And another few, also see http://lkml.org/lkml/2009/5/4/353

diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
index 2493f05..15502d5 100644
--- a/drivers/video/xen-fbfront.c
+++ b/drivers/video/xen-fbfront.c
@@ -384,7 +384,7 @@ static int __devinit xenfb_probe(struct xenbus_device *dev,
 		fb_size = XENFB_DEFAULT_FB_LEN;
 	}
 
-	dev->dev.driver_data = info;
+	dev_set_drvdata(&dev->dev, info);
 	info->xbdev = dev;
 	info->irq = -1;
 	info->x1 = info->y1 = INT_MAX;
@@ -503,7 +503,7 @@ xenfb_make_preferred_console(void)
 
 static int xenfb_resume(struct xenbus_device *dev)
 {
-	struct xenfb_info *info = dev->dev.driver_data;
+	struct xenfb_info *info = dev_get_drvdata(&dev->dev);
 
 	xenfb_disconnect_backend(info);
 	xenfb_init_shared_page(info, info->fb_info);
@@ -512,7 +512,7 @@ static int xenfb_resume(struct xenbus_device *dev)
 
 static int xenfb_remove(struct xenbus_device *dev)
 {
-	struct xenfb_info *info = dev->dev.driver_data;
+	struct xenfb_info *info = dev_get_drvdata(&dev->dev);
 
 	xenfb_disconnect_backend(info);
 	if (info->fb_info) {
@@ -621,7 +621,7 @@ static void xenfb_disconnect_backend(struct xenfb_info *info)
 static void xenfb_backend_changed(struct xenbus_device *dev,
 				  enum xenbus_state backend_state)
 {
-	struct xenfb_info *info = dev->dev.driver_data;
+	struct xenfb_info *info = dev_get_drvdata(&dev->dev);
 	int val;
 
 	switch (backend_state) {
