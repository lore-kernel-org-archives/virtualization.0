From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 15/20] Staging: hv: Move the context field from struct
	hv_storvsc_request
Date: Mon, 28 Mar 2011 09:33:40 -0700
Message-ID: <1301330025-25542-15-git-send-email-kys@microsoft.com>
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

In preparation of consolidating all I/O request state, move
the context field from struct hv_storvsc_request to
struct storvsc_request_extension.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c  |    6 +++---
 drivers/staging/hv/storvsc_api.h |    3 +--
 drivers/staging/hv/storvsc_drv.c |    4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index be7fae5..83c4ba3 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -939,7 +939,7 @@ static int blkvsc_submit_request(struct blkvsc_request *blkvsc_req,
 	vm_srb->data_in = blkvsc_req->write ? WRITE_TYPE : READ_TYPE;
 
 	storvsc_req->on_io_completion = request_completion;
-	storvsc_req->context = blkvsc_req;
+	storvsc_req->extension.context = blkvsc_req;
 
 	vm_srb->port_number = blkdev->port;
 	vm_srb->path_id = blkdev->path;
@@ -1136,7 +1136,7 @@ static int blkvsc_do_request(struct block_device_context *blkdev,
 static void blkvsc_cmd_completion(struct hv_storvsc_request *request)
 {
 	struct blkvsc_request *blkvsc_req =
-			(struct blkvsc_request *)request->context;
+			(struct blkvsc_request *)request->extension.context;
 	struct block_device_context *blkdev =
 			(struct block_device_context *)blkvsc_req->dev;
 	struct scsi_sense_hdr sense_hdr;
@@ -1158,7 +1158,7 @@ static void blkvsc_cmd_completion(struct hv_storvsc_request *request)
 static void blkvsc_request_completion(struct hv_storvsc_request *request)
 {
 	struct blkvsc_request *blkvsc_req =
-			(struct blkvsc_request *)request->context;
+			(struct blkvsc_request *)request->extension.context;
 	struct block_device_context *blkdev =
 			(struct block_device_context *)blkvsc_req->dev;
 	unsigned long flags;
diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index fd9165f..68c5036 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -63,6 +63,7 @@ struct storvsc_request_extension {
 	struct completion wait_event;
 
 	unsigned char *sense_buffer;
+	void *context;
 
 	struct vstor_packet vstor_packet;
 };
@@ -71,8 +72,6 @@ struct hv_storvsc_request {
 	u32 status;
 	u32 bytes_xfer;
 
-	void *context;
-
 	void (*on_io_completion)(struct hv_storvsc_request *request);
 
 	struct storvsc_request_extension extension;
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 3a999d0..65e03e6 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -448,7 +448,7 @@ static int storvsc_remove(struct device *device)
 static void storvsc_commmand_completion(struct hv_storvsc_request *request)
 {
 	struct storvsc_cmd_request *cmd_request =
-		(struct storvsc_cmd_request *)request->context;
+		(struct storvsc_cmd_request *)request->extension.context;
 	struct scsi_cmnd *scmnd = cmd_request->cmd;
 	struct host_device_context *host_device_ctx =
 		(struct host_device_context *)scmnd->device->host->hostdata;
@@ -771,7 +771,7 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 	}
 
 	request->on_io_completion = storvsc_commmand_completion;
-	request->context = cmd_request;/* scmnd; */
+	request->extension.context = cmd_request;/* scmnd; */
 
 	/* request->PortId = scmnd->device->channel; */
 	vm_srb->port_number = host_device_ctx->port;
-- 
1.7.4.1
