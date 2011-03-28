From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 03/20] Staging: hv: Get rid of request_ext_size from struct
	storvsc_driver_object
Date: Mon, 28 Mar 2011 09:33:28 -0700
Message-ID: <1301330025-25542-3-git-send-email-kys@microsoft.com>
References: <1301329950-25490-1-git-send-email-kys@microsoft.com>
	<1301330025-25542-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1301330025-25542-1-git-send-email-kys@microsoft.com>
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

Now that struct storvsc_request_extension is part of struct hv_storvsc_request
get rid of the field request_ext_size from struct storvsc_driver_object.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c  |    5 +----
 drivers/staging/hv/storvsc_api.h |    3 ---
 drivers/staging/hv/storvsc_drv.c |   11 +++--------
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 9ceaa99..3672e15 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -162,8 +162,6 @@ static int blk_vsc_initialize(struct hv_driver *driver)
 	driver->name = g_blk_driver_name;
 	memcpy(&driver->dev_type, &g_blk_device_type, sizeof(struct hv_guid));
 
-	stor_driver->request_ext_size =
-	sizeof(struct storvsc_request_extension);
 
 	/*
 	 * Divide the ring buffer data size (which is 1 page less than the ring
@@ -346,8 +344,7 @@ static int blkvsc_probe(struct device *device)
 	/* 	sizeof(struct blkvsc_request)); */
 
 	blkdev->request_pool = kmem_cache_create(dev_name(&device_obj->device),
-					sizeof(struct blkvsc_request) +
-					storvsc_drv_obj->request_ext_size, 0,
+					sizeof(struct blkvsc_request), 0,
 					SLAB_HWCACHE_ALIGN, NULL);
 	if (!blkdev->request_pool) {
 		ret = -ENOMEM;
diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index e41b68b..eeaeaef 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -97,9 +97,6 @@ struct storvsc_driver_object {
 	/* Set by caller (in bytes) */
 	u32 ring_buffer_size;
 
-	/* Allocate this much private extension for each I/O request */
-	u32 request_ext_size;
-
 	/* Maximum # of requests in flight per channel/device */
 	u32 max_outstanding_req_per_channel;
 
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 58d12e0..1d13f1b 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -96,8 +96,6 @@ static int stor_vsc_initialize(struct hv_driver *driver)
 	memcpy(&driver->dev_type, &gStorVscDeviceType,
 	       sizeof(struct hv_guid));
 
-	stor_driver->request_ext_size =
-			sizeof(struct storvsc_request_extension);
 
 	/*
 	 * Divide the ring buffer data size (which is 1 page less
@@ -203,8 +201,7 @@ static int storvsc_drv_init(void)
 	drv->priv = storvsc_drv_obj;
 
 	DPRINT_INFO(STORVSC_DRV,
-		    "request extension size %u, max outstanding reqs %u",
-		    storvsc_drv_obj->request_ext_size,
+		    "max outstanding reqs %u",
 		    storvsc_drv_obj->max_outstanding_req_per_channel);
 
 	if (storvsc_drv_obj->max_outstanding_req_per_channel <
@@ -359,8 +356,7 @@ static int storvsc_probe(struct device *device)
 
 	host_device_ctx->request_pool =
 				kmem_cache_create(dev_name(&device_obj->device),
-					sizeof(struct storvsc_cmd_request) +
-					storvsc_drv_obj->request_ext_size, 0,
+					sizeof(struct storvsc_cmd_request), 0,
 					SLAB_HWCACHE_ALIGN, NULL);
 
 	if (!host_device_ctx->request_pool) {
@@ -759,8 +755,7 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 
 	request = &cmd_request->request;
 
-	DPRINT_DBG(STORVSC_DRV, "req %p size %d ext %d", request, request_size,
-		   storvsc_drv_obj->request_ext_size);
+	DPRINT_DBG(STORVSC_DRV, "req %p size %d", request, request_size);
 
 	/* Build the SRB */
 	switch (scmnd->sc_data_direction) {
-- 
1.7.4.1
