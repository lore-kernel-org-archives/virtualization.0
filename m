From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 024/206] Staging: hv: Cleanup blkvsc_shutdown()
Date: Mon,  9 May 2011 14:55:06 -0700
Message-ID: <1304978288-22999-24-git-send-email-kys@microsoft.com>
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

Use the newly introduced function to wait for draining I/Os to
cleanup blkvsc_shutdown().

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 217676a..7fb0cf1 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -588,15 +588,13 @@ static void blkvsc_shutdown(struct hv_device *dev)
 
 	spin_unlock_irqrestore(&blkdev->lock, flags);
 
-	while (blkdev->num_outstanding_reqs) {
-		DPRINT_INFO(STORVSC, "waiting for %d requests to complete...",
-			    blkdev->num_outstanding_reqs);
-		udelay(100);
-	}
-
-
 	blkvsc_do_operation(blkdev, DO_FLUSH);
 
+	/*
+	 * Now wait for all outgoing I/O to be drained.
+	 */
+	storvsc_wait_to_drain((struct storvsc_device *)dev->ext);
+
 }
 
 static int blkvsc_release(struct gendisk *disk, fmode_t mode)
-- 
1.7.4.1
