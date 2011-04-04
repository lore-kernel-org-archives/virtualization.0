From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 18/22] Staging: hv: Cleanup blkvsc_open()
Date: Mon,  4 Apr 2011 15:48:07 -0700
Message-ID: <1301957291-8035-18-git-send-email-kys@microsoft.com>
References: <1301957186-7853-1-git-send-email-kys@microsoft.com>
	<1301957291-8035-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1301957291-8035-1-git-send-email-kys@microsoft.com>
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

Given that we don't support removable media, cleanup blkvsc_open()


Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 7f511ee..05a0e87 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -254,20 +254,12 @@ static int blkvsc_open(struct block_device *bdev, fmode_t mode)
 {
 	struct block_device_context *blkdev = bdev->bd_disk->private_data;
 
-
-	mutex_lock(&blkvsc_mutex);
 	spin_lock(&blkdev->lock);
 
-	if (!blkdev->users && blkdev->device_type == DVD_TYPE) {
-		spin_unlock(&blkdev->lock);
-		check_disk_change(bdev);
-		spin_lock(&blkdev->lock);
-	}
-
 	blkdev->users++;
 
 	spin_unlock(&blkdev->lock);
-	mutex_unlock(&blkvsc_mutex);
+
 	return 0;
 }
 
-- 
1.7.4.1
