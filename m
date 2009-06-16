From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 49/64] xen block: remove driver_data direct
	access of struct device
Date: Mon, 15 Jun 2009 22:46:38 -0700
Message-ID: <1245131213-24168-49-git-send-email-gregkh@suse.de>
References: <20090616051351.GA23627@kroah.com>
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20090616051351.GA23627@kroah.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, Greg Kroah-Hartman <gregkh@suse.de>, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

In the near future, the driver core is going to not allow direct access
to the driver_data pointer in struct device.  Instead, the functions
dev_get_drvdata() and dev_set_drvdata() should be used.  These functions
have been around since the beginning, so are backwards compatible with
all older kernel versions.


Cc: xen-devel@lists.xensource.com
Cc: virtualization@lists.osdl.org
Acked-by: Chris Wright <chrisw@sous-sol.org>
Acked-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/xen-blkfront.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index c199682..e532847 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -753,12 +753,12 @@ static int blkfront_probe(struct xenbus_device *dev,
 
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
 
@@ -843,7 +843,7 @@ static int blkif_recover(struct blkfront_info *info)
  */
 static int blkfront_resume(struct xenbus_device *dev)
 {
-	struct blkfront_info *info = dev->dev.driver_data;
+	struct blkfront_info *info = dev_get_drvdata(&dev->dev);
 	int err;
 
 	dev_dbg(&dev->dev, "blkfront_resume: %s\n", dev->nodename);
@@ -922,7 +922,7 @@ static void blkfront_connect(struct blkfront_info *info)
  */
 static void blkfront_closing(struct xenbus_device *dev)
 {
-	struct blkfront_info *info = dev->dev.driver_data;
+	struct blkfront_info *info = dev_get_drvdata(&dev->dev);
 	unsigned long flags;
 
 	dev_dbg(&dev->dev, "blkfront_closing: %s removed\n", dev->nodename);
@@ -957,7 +957,7 @@ static void blkfront_closing(struct xenbus_device *dev)
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
-- 
1.6.3.2
