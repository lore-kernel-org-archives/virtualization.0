From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 19/22] Staging: hv: Fix a jump label (Cleanup) in blkvsc_drv
Date: Wed,  6 Apr 2011 16:05:19 -0700
Message-ID: <1302131122-15530-19-git-send-email-kys@microsoft.com>
References: <1302131006-15411-1-git-send-email-kys@microsoft.com>
	<1302131122-15530-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1302131122-15530-1-git-send-email-kys@microsoft.com>
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

One of the goto labels was named Cleanup; change it to cleanup.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index bf8647e..a47581c 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -963,7 +963,7 @@ static int blkvsc_probe(struct device *device)
 	blkdev = kzalloc(sizeof(struct block_device_context), GFP_KERNEL);
 	if (!blkdev) {
 		ret = -ENOMEM;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	INIT_LIST_HEAD(&blkdev->pending_list);
@@ -977,14 +977,14 @@ static int blkvsc_probe(struct device *device)
 					SLAB_HWCACHE_ALIGN, NULL);
 	if (!blkdev->request_pool) {
 		ret = -ENOMEM;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 
 	/* Call to the vsc driver to add the device */
 	ret = storvsc_drv_obj->base.dev_add(device_obj, &device_info);
 	if (ret != 0)
-		goto Cleanup;
+		goto cleanup;
 
 	blkdev->device_ctx = device_obj;
 	/* this identified the device 0 or 1 */
@@ -1027,7 +1027,7 @@ static int blkvsc_probe(struct device *device)
 		}
 	} else {
 		ret = -1;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	DPRINT_INFO(BLKVSC_DRV, "blkvsc registered for major %d!!", major);
@@ -1035,7 +1035,7 @@ static int blkvsc_probe(struct device *device)
 	blkdev->gd = alloc_disk(BLKVSC_MINORS);
 	if (!blkdev->gd) {
 		ret = -1;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	blkdev->gd->queue = blk_init_queue(blkvsc_request, &blkdev->lock);
@@ -1074,7 +1074,7 @@ static int blkvsc_probe(struct device *device)
 Remove:
 	storvsc_drv_obj->base.dev_rm(device_obj);
 
-Cleanup:
+cleanup:
 	if (blkdev) {
 		if (blkdev->request_pool) {
 			kmem_cache_destroy(blkdev->request_pool);
-- 
1.7.4.1
