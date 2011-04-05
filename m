From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 06/22] Staging: hv: Allocate request structures zeroed out.
Date: Tue,  5 Apr 2011 07:04:50 -0700
Message-ID: <1302012306-21277-6-git-send-email-kys@microsoft.com>
References: <1302012261-21236-1-git-send-email-kys@microsoft.com>
	<1302012306-21277-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1302012306-21277-1-git-send-email-kys@microsoft.com>
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

In preparation for moving state out of struct hv_storvsc_request, allocate
request structures so that they zeroed out to begin with.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c  |   14 ++++++++------
 drivers/staging/hv/storvsc.c     |    1 -
 drivers/staging/hv/storvsc_drv.c |    2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 1e5320e..2661356 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -510,7 +510,7 @@ static int blkvsc_do_flush(struct block_device_context *blkdev)
 	if (blkdev->device_type != HARDDISK_TYPE)
 		return 0;
 
-	blkvsc_req = kmem_cache_alloc(blkdev->request_pool, GFP_KERNEL);
+	blkvsc_req = kmem_cache_zalloc(blkdev->request_pool, GFP_KERNEL);
 	if (!blkvsc_req)
 		return -ENOMEM;
 
@@ -551,7 +551,7 @@ static int blkvsc_do_inquiry(struct block_device_context *blkdev)
 
 	DPRINT_DBG(BLKVSC_DRV, "blkvsc_do_inquiry()\n");
 
-	blkvsc_req = kmem_cache_alloc(blkdev->request_pool, GFP_KERNEL);
+	blkvsc_req = kmem_cache_zalloc(blkdev->request_pool, GFP_KERNEL);
 	if (!blkvsc_req)
 		return -ENOMEM;
 
@@ -638,7 +638,7 @@ static int blkvsc_do_read_capacity(struct block_device_context *blkdev)
 	blkdev->capacity = 0;
 	blkdev->media_not_present = 0; /* assume a disk is present */
 
-	blkvsc_req = kmem_cache_alloc(blkdev->request_pool, GFP_KERNEL);
+	blkvsc_req = kmem_cache_zalloc(blkdev->request_pool, GFP_KERNEL);
 	if (!blkvsc_req)
 		return -ENOMEM;
 
@@ -715,7 +715,7 @@ static int blkvsc_do_read_capacity16(struct block_device_context *blkdev)
 	blkdev->capacity = 0;
 	blkdev->media_not_present = 0; /* assume a disk is present */
 
-	blkvsc_req = kmem_cache_alloc(blkdev->request_pool, GFP_KERNEL);
+	blkvsc_req = kmem_cache_zalloc(blkdev->request_pool, GFP_KERNEL);
 	if (!blkvsc_req)
 		return -ENOMEM;
 
@@ -983,7 +983,7 @@ static int blkvsc_do_request(struct block_device_context *blkdev,
 		  (unsigned long)blk_rq_pos(req));
 
 	/* Create a group to tie req to list of blkvsc_reqs */
-	group = kmem_cache_alloc(blkdev->request_pool, GFP_ATOMIC);
+	group = kmem_cache_zalloc(blkdev->request_pool, GFP_ATOMIC);
 	if (!group)
 		return -ENOMEM;
 
@@ -1026,7 +1026,9 @@ static int blkvsc_do_request(struct block_device_context *blkdev,
 					 * Create new blkvsc_req to represent
 					 * the current bvec
 					 */
-					blkvsc_req = kmem_cache_alloc(blkdev->request_pool, GFP_ATOMIC);
+					blkvsc_req =
+					kmem_cache_zalloc(
+					blkdev->request_pool, GFP_ATOMIC);
 					if (!blkvsc_req) {
 						/* free up everything */
 						list_for_each_entry_safe(
diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 8dc17b9..e02622d 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -545,7 +545,6 @@ int stor_vsc_on_io_request(struct hv_device *device,
 	request_extension->request = request;
 	request_extension->device  = device;
 
-	memset(vstor_packet, 0 , sizeof(struct vstor_packet));
 
 	vstor_packet->flags |= REQUEST_COMPLETION_FLAG;
 
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index c2a3a5b..fd1416d 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -735,7 +735,7 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 
 	request_size = sizeof(struct storvsc_cmd_request);
 
-	cmd_request = kmem_cache_alloc(host_device_ctx->request_pool,
+	cmd_request = kmem_cache_zalloc(host_device_ctx->request_pool,
 				       GFP_ATOMIC);
 	if (!cmd_request) {
 		DPRINT_ERR(STORVSC_DRV, "scmnd (%p) - unable to allocate "
-- 
1.7.4.1
