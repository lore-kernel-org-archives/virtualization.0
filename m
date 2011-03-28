From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 09/20] Staging: hv: Get rid of the target_id from struct
	hv_storvsc_request
Date: Mon, 28 Mar 2011 09:33:34 -0700
Message-ID: <1301330025-25542-9-git-send-email-kys@microsoft.com>
References: <1301329950-25490-1-git-send-email-kys@microsoft.com>
	<1301330025-25542-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1301330025-25542-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for consolidating all I/O request state, get rid of the
target_id field from struct hv_storvsc_request and instead use the
equivalent  state in struct vmscsi_request - target_id field.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c  |    2 +-
 drivers/staging/hv/storvsc.c     |    5 ++---
 drivers/staging/hv/storvsc_api.h |    1 -
 drivers/staging/hv/storvsc_drv.c |    2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index a679e18..ec01662 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -943,7 +943,7 @@ static int blkvsc_submit_request(struct blkvsc_request *blkvsc_req,
 
 	vm_srb->port_number = blkdev->port;
 	vm_srb->path_id = blkdev->path;
-	storvsc_req->target_id = blkdev->target;
+	vm_srb->target_id = blkdev->target;
 	storvsc_req->lun_id = 0;	 /* this is not really used at all */
 
 	storvsc_req->cdb_len = blkvsc_req->cmd_len;
diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index c307922..2282ba2 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -531,9 +531,9 @@ int stor_vsc_on_io_request(struct hv_device *device,
 		   "Extension %p", device, stor_device, request,
 		   request_extension);
 
-	DPRINT_DBG(STORVSC, "req %p len %d  target %d, lun %d cdblen %d",
+	DPRINT_DBG(STORVSC, "req %p len %d lun %d cdblen %d",
 		   request, request->data_buffer.len,
-		   request->target_id, request->lun_id, request->cdb_len);
+		   request->lun_id, request->cdb_len);
 
 	if (!stor_device) {
 		DPRINT_ERR(STORVSC, "unable to get stor device..."
@@ -549,7 +549,6 @@ int stor_vsc_on_io_request(struct hv_device *device,
 
 	vstor_packet->vm_srb.length = sizeof(struct vmscsi_request);
 
-	vstor_packet->vm_srb.target_id = request->target_id;
 	vstor_packet->vm_srb.lun = request->lun_id;
 
 	vstor_packet->vm_srb.sense_info_length = SENSE_BUFFER_SIZE;
diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index 07a391b..54690ad 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -66,7 +66,6 @@ struct storvsc_request_extension {
 };
 
 struct hv_storvsc_request {
-	u32 target_id;
 	u32 lun_id;
 	u8 *cdb;
 	u32 cdb_len;
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 05339bf..c77ddc1 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -776,7 +776,7 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 	/* request->PortId = scmnd->device->channel; */
 	vm_srb->port_number = host_device_ctx->port;
 	vm_srb->path_id = scmnd->device->channel;
-	request->target_id = scmnd->device->id;
+	vm_srb->target_id = scmnd->device->id;
 	request->lun_id = scmnd->device->lun;
 
 	/* ASSERT(scmnd->cmd_len <= 16); */
-- 
1.7.4.1
