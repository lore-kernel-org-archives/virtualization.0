From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 002/206] Staging: hv: Cleanup spin lock usage
Date: Mon,  9 May 2011 14:54:44 -0700
Message-ID: <1304978288-22999-2-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
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

This spin lock is potentially acquired from interrupt context.
Ensure that the interrupts are blocked whenever the lock is held.
The current code was not consistent with regards to blocking
interrupts - the same lock would be acquired without blocking
interrupts in some instance while the interrupts would be blocked
in other instances. Fix this potential deadlock problem.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index cfef1c0..74d51bb 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -249,12 +249,13 @@ static int blkvsc_submit_request(struct blkvsc_request *blkvsc_req,
 static int blkvsc_open(struct block_device *bdev, fmode_t mode)
 {
 	struct block_device_context *blkdev = bdev->bd_disk->private_data;
+	unsigned long flags;
 
-	spin_lock(&blkdev->lock);
+	spin_lock_irqsave(&blkdev->lock, flags);
 
 	blkdev->users++;
 
-	spin_unlock(&blkdev->lock);
+	spin_unlock_irqrestore(&blkdev->lock, flags);
 
 	return 0;
 }
@@ -616,17 +617,18 @@ static void blkvsc_shutdown(struct hv_device *dev)
 static int blkvsc_release(struct gendisk *disk, fmode_t mode)
 {
 	struct block_device_context *blkdev = disk->private_data;
+	unsigned long flags;
 
-	spin_lock(&blkdev->lock);
+	spin_lock_irqsave(&blkdev->lock, flags);
 	if (blkdev->users == 1) {
-		spin_unlock(&blkdev->lock);
+		spin_unlock_irqrestore(&blkdev->lock, flags);
 		blkvsc_do_operation(blkdev, DO_FLUSH);
-		spin_lock(&blkdev->lock);
+		spin_lock_irqsave(&blkdev->lock, flags);
 	}
 
 	blkdev->users--;
 
-	spin_unlock(&blkdev->lock);
+	spin_unlock_irqrestore(&blkdev->lock, flags);
 	return 0;
 }
 
-- 
1.7.4.1
