From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 15/22] Staging: hv: Move sense_buffer field
Date: Tue,  5 Apr 2011 07:04:59 -0700
Message-ID: <1302012306-21277-15-git-send-email-kys@microsoft.com>
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

In preparation for consolidating all I/O request state,
move sense_buffer field from struct hv_storvsc_request
to struct storvsc_request_extension.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c  |    2 +-
 drivers/staging/hv/storvsc.c     |    2 +-
 drivers/staging/hv/storvsc_api.h |    4 ++--
 drivers/staging/hv/storvsc_drv.c |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 04117be..be7fae5 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -950,7 +950,7 @@ static int blkvsc_submit_request(struct blkvsc_request *blkvsc_req,
 
 	memcpy(vm_srb->cdb, blkvsc_req->cmnd, vm_srb->cdb_length);
 
-	storvsc_req->sense_buffer = blkvsc_req->sense_buffer;
+	storvsc_req->extension.sense_buffer = blkvsc_req->sense_buffer;
 
 	ret = storvsc_drv_obj->on_io_request(blkdev->device_ctx,
 					   &blkvsc_req->request);
diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index e12a760..e0d635f 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -314,7 +314,7 @@ static void stor_vsc_on_io_completion(struct hv_device *device,
 				    "valid - len %d\n", request_ext,
 				    vstor_packet->vm_srb.sense_info_length);
 
-			memcpy(request->sense_buffer,
+			memcpy(request->extension.sense_buffer,
 			       vstor_packet->vm_srb.sense_data,
 			       vstor_packet->vm_srb.sense_info_length);
 
diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index 3eccc27..fd9165f 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -62,6 +62,8 @@ struct storvsc_request_extension {
 	/* Synchronize the request/response if needed */
 	struct completion wait_event;
 
+	unsigned char *sense_buffer;
+
 	struct vstor_packet vstor_packet;
 };
 
@@ -69,8 +71,6 @@ struct hv_storvsc_request {
 	u32 status;
 	u32 bytes_xfer;
 
-	unsigned char *sense_buffer;
-
 	void *context;
 
 	void (*on_io_completion)(struct hv_storvsc_request *request);
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 22709a2..df98476 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -784,7 +784,7 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 
 	memcpy(vm_srb->cdb, scmnd->cmnd, vm_srb->cdb_length);
 
-	request->sense_buffer = scmnd->sense_buffer;
+	request->extension.sense_buffer = scmnd->sense_buffer;
 
 
 	request->data_buffer.len = scsi_bufflen(scmnd);
-- 
1.7.4.1
