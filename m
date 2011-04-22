From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 10/21] Staging: hv: Get rid of some DPRINT_INFO() statements
Date: Fri, 22 Apr 2011 14:55:15 -0700
Message-ID: <1303509326-3094-10-git-send-email-kys@microsoft.com>
References: <1303509246-3053-1-git-send-email-kys@microsoft.com>
 <1303509326-3094-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303509326-3094-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of some of the DPRINT_INFO() statements.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 5cf82f0..09633cc 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -331,7 +331,6 @@ static int blkvsc_ioctl(struct block_device *bd, fmode_t mode,
 
 	switch (cmd) {
 	case HDIO_GET_IDENTITY:
-		DPRINT_INFO(BLKVSC_DRV, "HDIO_GET_IDENTITY\n");
 		if (copy_to_user((void __user *)arg, blkdev->device_id,
 				 blkdev->device_id_len))
 			ret = -EFAULT;
@@ -1264,8 +1263,6 @@ static int __init blkvsc_init(void)
 
 	BUILD_BUG_ON(sizeof(sector_t) != 8);
 
-	DPRINT_INFO(BLKVSC_DRV, "Blkvsc initializing....");
-
 	ret = blkvsc_drv_init();
 
 	return ret;
-- 
1.7.4.1
