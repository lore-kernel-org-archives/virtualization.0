From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 001/206] Staging: hv: Get rid of blkvsc_mutex
Date: Mon,  9 May 2011 14:54:43 -0700
Message-ID: <1304978288-22999-1-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978242-22958-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The blkvsc_mutex is unnecessary as the state it is protecting 
(blkdev->users) is already protected by the spin lock.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index db44cf6..cfef1c0 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -27,7 +27,6 @@
 #include <linux/major.h>
 #include <linux/delay.h>
 #include <linux/hdreg.h>
-#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -113,8 +112,6 @@ struct block_device_context {
 	int users;
 };
 
-static DEFINE_MUTEX(blkvsc_mutex);
-
 static const char *g_blk_driver_name = "blkvsc";
 
 /* {32412632-86cb-44a2-9b5c-50d1417354f5} */
@@ -620,7 +617,6 @@ static int blkvsc_release(struct gendisk *disk, fmode_t mode)
 {
 	struct block_device_context *blkdev = disk->private_data;
 
-	mutex_lock(&blkvsc_mutex);
 	spin_lock(&blkdev->lock);
 	if (blkdev->users == 1) {
 		spin_unlock(&blkdev->lock);
@@ -631,7 +627,6 @@ static int blkvsc_release(struct gendisk *disk, fmode_t mode)
 	blkdev->users--;
 
 	spin_unlock(&blkdev->lock);
-	mutex_unlock(&blkvsc_mutex);
 	return 0;
 }
 
-- 
1.7.4.1
