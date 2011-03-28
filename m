From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 13/20] Staging: hv: Get rid of sense_buffer_size from struct hv_storvsc_request
Date: Mon, 28 Mar 2011 09:33:38 -0700
Message-ID: <1301330025-25542-13-git-send-email-kys@microsoft.com>
References: <1301329950-25490-1-git-send-email-kys@microsoft.com>
 <1301330025-25542-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1301330025-25542-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for consolidating all I/O request state, get rid of the
sense_buffer_size field from struct hv_storvsc_request and instead
hardcode this value as is currently done.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c  |    1 -
 drivers/staging/hv/storvsc.c     |    2 --
 drivers/staging/hv/storvsc_api.h |    1 -
 drivers/staging/hv/storvsc_drv.c |    3 +--
 4 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index a156930..04117be 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -951,7 +951,6 @@ static int blkvsc_submit_request(struct blkvsc_request *blkvsc_req,
 	memcpy(vm_srb->cdb, blkvsc_req->cmnd, vm_srb->cdb_length);
 
 	storvsc_req->sense_buffer = blkvsc_req->sense_buffer;
-	storvsc_req->sense_buffer_size = SCSI_SENSE_BUFFERSIZE;
 
 	ret = storvsc_drv_obj->on_io_request(blkdev->device_ctx,
 					   &blkvsc_req->request);
diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index ca41c05..b322f86 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -318,8 +318,6 @@ static void stor_vsc_on_io_completion(struct hv_device *device,
 			       vstor_packet->vm_srb.sense_data,
 			       vstor_packet->vm_srb.sense_info_length);
 
-			request->sense_buffer_size =
-					vstor_packet->vm_srb.sense_info_length;
 		}
 	}
 
diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index 55c5cc6..3eccc27 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -70,7 +70,6 @@ struct hv_storvsc_request {
 	u32 bytes_xfer;
 
 	unsigned char *sense_buffer;
-	u32 sense_buffer_size;
 
 	void *context;
 
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 08c2df4..bc435d6 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -477,7 +477,7 @@ static void storvsc_commmand_completion(struct hv_storvsc_request *request)
 
 	if (scmnd->result) {
 		if (scsi_normalize_sense(scmnd->sense_buffer,
-				request->sense_buffer_size, &sense_hdr))
+				SCSI_SENSE_BUFFERSIZE, &sense_hdr))
 			scsi_print_sense_hdr("storvsc", &sense_hdr);
 	}
 
@@ -785,7 +785,6 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 	memcpy(vm_srb->cdb, scmnd->cmnd, vm_srb->cdb_length);
 
 	request->sense_buffer = scmnd->sense_buffer;
-	request->sense_buffer_size = SCSI_SENSE_BUFFERSIZE;
 
 
 	request->data_buffer.len = scsi_bufflen(scmnd);
-- 
1.7.4.1
