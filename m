From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: [PATCH] Staging: hv: Add code to create the device directory
	under /sys/block/hdx
Date: Thu, 16 Dec 2010 18:59:19 -0700
Message-ID: <4D0A8C7A.E57C.0030.1@novell.com>
References: <1292530231-14109-1-git-send-email-ksrinivasan@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: devel@linuxdriverproject.org, Virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org



Add code to create the device directory under sysfs.


Signed-off-by: K. Y. Srinivasan <ksrinivasan@novell.com>
---
 drivers/staging/hv/blkvsc_drv.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index b3d05fc..4fb8094 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -368,6 +368,7 @@ static int blkvsc_probe(struct device *device)
 		blkdev->gd->first_minor = 0;
 	blkdev->gd->fops = &block_ops;
 	blkdev->gd->private_data = blkdev;
+	blkdev->gd->driverfs_dev = &(blkdev->device_ctx->device);
 	sprintf(blkdev->gd->disk_name, "hd%c", 'a' + devnum);
 
 	blkvsc_do_inquiry(blkdev);
-- 
1.7.1
