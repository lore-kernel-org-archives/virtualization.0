From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 12/22] Staging: hv: Get rid of the cdb_len from struct
	hv_storvsc_request
Date: Tue,  5 Apr 2011 07:04:56 -0700
Message-ID: <1302012306-21277-12-git-send-email-kys@microsoft.com>
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

In preparation for consolidating all I/O request state, get rid of the
cdb_len field from struct hv_storvsc_request and instead use the
equivalent  state in struct vmscsi_request - cdb_length field.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c  |    2 +-
 drivers/staging/hv/storvsc.c     |    9 ++++-----
 drivers/staging/hv/storvsc_api.h |    1 -
 drivers/staging/hv/storvsc_drv.c |    2 +-
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index f440734..3db622d 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -946,7 +946,7 @@ static int blkvsc_submit_request(struct blkvsc_request *blkvsc_req,
 	vm_srb->target_id = blkdev->target;
 	vm_srb->lun = 0;	 /* this is not really used at all */
 
-	storvsc_req->cdb_len = blkvsc_req->cmd_len;
+	vm_srb->cdb_length = blkvsc_req->cmd_len;
 	storvsc_req->cdb = blkvsc_req->cmnd;
 
 	storvsc_req->sense_buffer = blkvsc_req->sense_buffer;
diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index c7d0620..dcfc5c5 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -531,9 +531,8 @@ int stor_vsc_on_io_request(struct hv_device *device,
 		   "Extension %p", device, stor_device, request,
 		   request_extension);
 
-	DPRINT_DBG(STORVSC, "req %p len %d cdblen %d",
-		   request, request->data_buffer.len,
-		   request->cdb_len);
+	DPRINT_DBG(STORVSC, "req %p len %d",
+		   request, request->data_buffer.len);
 
 	if (!stor_device) {
 		DPRINT_ERR(STORVSC, "unable to get stor device..."
@@ -554,8 +553,8 @@ int stor_vsc_on_io_request(struct hv_device *device,
 	vstor_packet->vm_srb.sense_info_length = SENSE_BUFFER_SIZE;
 
 	/* Copy over the scsi command descriptor block */
-	vstor_packet->vm_srb.cdb_length = request->cdb_len;
-	memcpy(&vstor_packet->vm_srb.cdb, request->cdb, request->cdb_len);
+	memcpy(&vstor_packet->vm_srb.cdb, request->cdb,
+		 vstor_packet->vm_srb.cdb_length);
 
 	vstor_packet->vm_srb.data_transfer_length = request->data_buffer.len;
 
diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index 940cf98..fd3af2b 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -67,7 +67,6 @@ struct storvsc_request_extension {
 
 struct hv_storvsc_request {
 	u8 *cdb;
-	u32 cdb_len;
 	u32 status;
 	u32 bytes_xfer;
 
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 1340b13..5571fd7 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -780,7 +780,7 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 	vm_srb->lun = scmnd->device->lun;
 
 	/* ASSERT(scmnd->cmd_len <= 16); */
-	request->cdb_len = scmnd->cmd_len;
+	vm_srb->cdb_length = scmnd->cmd_len;
 	request->cdb = scmnd->cmnd;
 
 	request->sense_buffer = scmnd->sense_buffer;
-- 
1.7.4.1
