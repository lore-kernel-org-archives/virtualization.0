From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH 3] xen-netfront: remove driver_data direct access of struct
 device
Date: Mon, 11 May 2009 21:40:57 +0200
Message-ID: <4A087F49.7040204@gmail.com>
References: <4A08775C.20305@gmail.com> <4A0878DC.8040907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758805AbZEKTlQ@vger.kernel.org>
In-Reply-To: <4A0878DC.8040907@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jeremy@xensource.com
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

To avoid direct access to the driver_data pointer in struct device, the
functions dev_get_drvdata() and dev_set_drvdata() should be used.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index f673253..8d88dae 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1212,7 +1212,7 @@ static int __devinit netfront_probe(struct xenbus_device *dev,
 	}
 
 	info = netdev_priv(netdev);
-	dev->dev.driver_data = info;
+	dev_set_drvdata(&dev->dev, info);
 
 	err = register_netdev(info->netdev);
 	if (err) {
@@ -1233,7 +1233,7 @@ static int __devinit netfront_probe(struct xenbus_device *dev,
 
  fail:
 	free_netdev(netdev);
-	dev->dev.driver_data = NULL;
+	dev_set_drvdata(&dev->dev, NULL);
 	return err;
 }
 
@@ -1275,7 +1275,7 @@ static void xennet_disconnect_backend(struct netfront_info *info)
  */
 static int netfront_resume(struct xenbus_device *dev)
 {
-	struct netfront_info *info = dev->dev.driver_data;
+	struct netfront_info *info = dev_get_drvdata(&dev->dev);
 
 	dev_dbg(&dev->dev, "%s\n", dev->nodename);
 
@@ -1600,7 +1600,7 @@ static int xennet_connect(struct net_device *dev)
 static void backend_changed(struct xenbus_device *dev,
 			    enum xenbus_state backend_state)
 {
-	struct netfront_info *np = dev->dev.driver_data;
+	struct netfront_info *np = dev_get_drvdata(&dev->dev);
 	struct net_device *netdev = np->netdev;
 
 	dev_dbg(&dev->dev, "%s\n", xenbus_strstate(backend_state));
@@ -1774,7 +1774,7 @@ static struct xenbus_device_id netfront_ids[] = {
 
 static int __devexit xennet_remove(struct xenbus_device *dev)
 {
-	struct netfront_info *info = dev->dev.driver_data;
+	struct netfront_info *info = dev_get_drvdata(&dev->dev);
 
 	dev_dbg(&dev->dev, "%s\n", dev->nodename);
 
