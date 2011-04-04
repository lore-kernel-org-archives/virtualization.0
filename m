From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 01/22] Staging: hv: Get rid of blkvsc_media_changed()
Date: Mon,  4 Apr 2011 15:47:50 -0700
Message-ID: <1301957291-8035-1-git-send-email-kys@microsoft.com>
References: <1301957186-7853-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1301957186-7853-1-git-send-email-kys@microsoft.com>
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

We don't support removable media in Hyper-V block driver.
Get rid of blkvsc_media_changed() as it is efectively "dead code".

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 9faccbe..1203049 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -251,12 +251,6 @@ static int blkvsc_submit_request(struct blkvsc_request *blkvsc_req,
 	return ret;
 }
 
-static int blkvsc_media_changed(struct gendisk *gd)
-{
-	DPRINT_DBG(BLKVSC_DRV, "- enter\n");
-	return 1;
-}
-
 static int blkvsc_open(struct block_device *bdev, fmode_t mode)
 {
 	struct block_device_context *blkdev = bdev->bd_disk->private_data;
@@ -1206,7 +1200,6 @@ static const struct block_device_operations block_ops = {
 	.owner = THIS_MODULE,
 	.open = blkvsc_open,
 	.release = blkvsc_release,
-	.media_changed = blkvsc_media_changed,
 	.revalidate_disk = blkvsc_revalidate_disk,
 	.getgeo = blkvsc_getgeo,
 	.ioctl  = blkvsc_ioctl,
-- 
1.7.4.1
