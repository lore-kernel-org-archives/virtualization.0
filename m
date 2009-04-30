From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] xen block: remove driver_data direct access of struct device
Date: Thu, 30 Apr 2009 15:24:48 -0700
Message-ID: <20090430222448.GA18690@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>, Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Greg Kroah-Hartman <gregkh@suse.de>

In the near future, the driver core is going to not allow direct access
to the driver_data pointer in struct device.  Instead, the functions
dev_get_drvdata() and dev_set_drvdata() should be used.  These functions
have been around since the beginning, so are backwards compatible with
all older kernel versions.


Cc: xen-devel@lists.xensource.com
Cc: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/xen-blkfront.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -755,12 +755,12 @@ static int blkfront_probe(struct xenbus_
 
 	/* Front end dir is a number, which is used as the id. */
 	info->handle = simple_strtoul(strrchr(dev->nodename, '/')+1, NULL, 0);
-	dev->dev.driver_data = info;
+	dev_det_drvdata(&dev->dev, info);
 
 	err = talk_to_backend(dev, info);
 	if (err) {
 		kfree(info);
-		dev->dev.driver_data = NULL;
+		dev_det_drvdata(&dev->dev, NULL);
 		return err;
 	}
 
@@ -845,7 +845,7 @@ static int blkif_recover(struct blkfront
  */
 static int blkfront_resume(struct xenbus_device *dev)
 {
-	struct blkfront_info *info = dev->dev.driver_data;
+	struct blkfront_info *info = dev_get_drvdata(&dev->dev);
 	int err;
 
 	dev_dbg(&dev->dev, "blkfront_resume: %s\n", dev->nodename);
@@ -924,7 +924,7 @@ static void blkfront_connect(struct blkf
  */
 static void blkfront_closing(struct xenbus_device *dev)
 {
-	struct blkfront_info *info = dev->dev.driver_data;
+	struct blkfront_info *info = dev_get_drvdata(&dev->dev);
 	unsigned long flags;
 
 	dev_dbg(&dev->dev, "blkfront_closing: %s removed\n", dev->nodename);
@@ -959,7 +959,7 @@ static void blkfront_closing(struct xenb
 static void backend_changed(struct xenbus_device *dev,
 			    enum xenbus_state backend_state)
 {
-	struct blkfront_info *info = dev->dev.driver_data;
+	struct blkfront_info *info = dev_get_drvdata(&dev->dev);
 	struct block_device *bd;
 
 	dev_dbg(&dev->dev, "blkfront:backend_changed.\n");
@@ -997,7 +997,7 @@ static void backend_changed(struct xenbu
 
 static int blkfront_remove(struct xenbus_device *dev)
 {
-	struct blkfront_info *info = dev->dev.driver_data;
+	struct blkfront_info *info = dev_get_drvdata(&dev->dev);
 
 	dev_dbg(&dev->dev, "blkfront_remove: %s removed\n", dev->nodename);
 
@@ -1010,7 +1010,7 @@ static int blkfront_remove(struct xenbus
 
 static int blkfront_is_ready(struct xenbus_device *dev)
 {
-	struct blkfront_info *info = dev->dev.driver_data;
+	struct blkfront_info *info = dev_get_drvdata(&dev->dev);
 
 	return info->is_ready;
 }
