From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 061/206] Staging: hv: Get rid of unnecessary comments/dead code
Date: Mon,  9 May 2011 14:55:43 -0700
Message-ID: <1304978288-22999-61-git-send-email-kys@microsoft.com>
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

Get rid of unnecessary comments/dead code.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 89a0b05..650e11f 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -147,7 +147,6 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
 	blk_queue_merge_bvec(sdevice->request_queue, storvsc_merge_bvec);
 
 	blk_queue_bounce_limit(sdevice->request_queue, BLK_BOUNCE_ANY);
-	/* sdevice->timeout = (2000 * HZ);//(75 * HZ); */
 
 	return 0;
 }
@@ -554,15 +553,7 @@ static void storvsc_commmand_completion(struct hv_storvsc_request *request)
 	struct scsi_sense_hdr sense_hdr;
 	struct vmscsi_request *vm_srb;
 
-	/* ASSERT(request == &cmd_request->request); */
-	/* ASSERT(scmnd); */
-	/* ASSERT((unsigned long)scmnd->host_scribble == */
-	/*        (unsigned long)cmd_request); */
-	/* ASSERT(scmnd->scsi_done); */
-
 	if (cmd_request->bounce_sgl_count) {
-		/* using bounce buffer */
-		/* printk("copy_from_bounce_buffer\n"); */
 
 		/* FIXME: We can optimize on writes by just skipping this */
 		copy_from_bounce_buffer(scsi_sglist(scmnd),
@@ -581,7 +572,6 @@ static void storvsc_commmand_completion(struct hv_storvsc_request *request)
 			scsi_print_sense_hdr("storvsc", &sense_hdr);
 	}
 
-	/* ASSERT(request->BytesXfer <= request->data_buffer.Length); */
 	scsi_set_resid(scmnd,
 		request->data_buffer.len -
 		vm_srb->data_transfer_length);
@@ -621,7 +611,6 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 
 	/* If retrying, no need to prep the cmd */
 	if (scmnd->host_scribble) {
-		/* ASSERT(scmnd->scsi_done != NULL); */
 
 		cmd_request =
 			(struct storvsc_cmd_request *)scmnd->host_scribble;
@@ -631,9 +620,6 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 		goto retry_request;
 	}
 
-	/* ASSERT(scmnd->scsi_done == NULL); */
-	/* ASSERT(scmnd->host_scribble == NULL); */
-
 	scmnd->scsi_done = done;
 
 	request_size = sizeof(struct storvsc_cmd_request);
@@ -672,13 +658,11 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 	request->on_io_completion = storvsc_commmand_completion;
 	request->context = cmd_request;/* scmnd; */
 
-	/* request->PortId = scmnd->device->channel; */
 	vm_srb->port_number = host_dev->port;
 	vm_srb->path_id = scmnd->device->channel;
 	vm_srb->target_id = scmnd->device->id;
 	vm_srb->lun = scmnd->device->lun;
 
-	/* ASSERT(scmnd->cmd_len <= 16); */
 	vm_srb->cdb_length = scmnd->cmd_len;
 
 	memcpy(vm_srb->cdb, scmnd->cmnd, vm_srb->cdb_length);
@@ -727,7 +711,6 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 				page_to_pfn(sg_page((&sgl[i])));
 
 	} else if (scsi_sglist(scmnd)) {
-		/* ASSERT(scsi_bufflen(scmnd) <= PAGE_SIZE); */
 		request->data_buffer.offset =
 			virt_to_phys(scsi_sglist(scmnd)) & (PAGE_SIZE-1);
 		request->data_buffer.pfn_array[0] =
-- 
1.7.4.1
