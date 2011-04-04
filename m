From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 11/22] Staging: hv: Get rid of some DPRINT_INFO() statements
Date: Mon,  4 Apr 2011 15:48:00 -0700
Message-ID: <1301957291-8035-11-git-send-email-kys@microsoft.com>
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

Get rid of some of the DPRINT_INFO() statements.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 69b6290..1f4dd69 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -330,7 +330,6 @@ static int blkvsc_ioctl(struct block_device *bd, fmode_t mode,
 
 	switch (cmd) {
 	case HDIO_GET_IDENTITY:
-		DPRINT_INFO(BLKVSC_DRV, "HDIO_GET_IDENTITY\n");
 		if (copy_to_user((void __user *)arg, blkdev->device_id,
 				 blkdev->device_id_len))
 			ret = -EFAULT;
@@ -1262,8 +1261,6 @@ static int __init blkvsc_init(void)
 
 	BUILD_BUG_ON(sizeof(sector_t) != 8);
 
-	DPRINT_INFO(BLKVSC_DRV, "Blkvsc initializing....");
-
 	ret = blkvsc_drv_init();
 
 	return ret;
-- 
1.7.4.1
