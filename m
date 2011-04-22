From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 14/21] Staging: hv: Get rid of the code to manage removable
	media
Date: Fri, 22 Apr 2011 14:55:19 -0700
Message-ID: <1303509326-3094-14-git-send-email-kys@microsoft.com>
References: <1303509246-3053-1-git-send-email-kys@microsoft.com>
	<1303509326-3094-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1303509326-3094-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The Hyper-V block driver does not handle removable media.
Get rid of the code to manage removable media.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 7974e6c..92614d5 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -437,8 +437,6 @@ static int blkvsc_do_operation(struct block_device_context *blkdev,
 
 		if (device_type == 0x0)
 			blkdev->device_type = HARDDISK_TYPE;
-		 else if (device_type == 0x5)
-			blkdev->device_type = DVD_TYPE;
 		 else
 			blkdev->device_type = UNKNOWN_DEV_TYPE;
 
@@ -1076,12 +1074,7 @@ static int blkvsc_probe(struct device *device)
 	sprintf(blkdev->gd->disk_name, "hd%c", 'a' + devnum);
 
 	blkvsc_do_operation(blkdev, DO_INQUIRY);
-	if (blkdev->device_type == DVD_TYPE) {
-		set_disk_ro(blkdev->gd, 1);
-		blkdev->gd->flags |= GENHD_FL_REMOVABLE;
-		blkvsc_do_operation(blkdev, DO_CAPACITY);
-	} else
-		blkvsc_do_operation(blkdev, DO_CAPACITY);
+	blkvsc_do_operation(blkdev, DO_CAPACITY);
 
 	set_capacity(blkdev->gd, blkdev->capacity * (blkdev->sector_size/512));
 	blk_queue_logical_block_size(blkdev->gd->queue, blkdev->sector_size);
-- 
1.7.4.1
