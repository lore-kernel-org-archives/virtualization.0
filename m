From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 15/22] Staging: hv: Get rid of the code to manage removable media
Date: Wed,  6 Apr 2011 16:05:15 -0700
Message-ID: <1302131122-15530-15-git-send-email-kys@microsoft.com>
References: <1302131006-15411-1-git-send-email-kys@microsoft.com>
 <1302131122-15530-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1302131122-15530-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
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
