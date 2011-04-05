From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 09/22] Staging: hv: Get rid of the bus field from struct
	hv_storvsc_request
Date: Tue,  5 Apr 2011 07:04:53 -0700
Message-ID: <1302012306-21277-9-git-send-email-kys@microsoft.com>
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
bus field from struct hv_storvsc_request and instead use the
equivalent  state in struct vmscsi_request - path_id field.

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
index eb184ff..a679e18 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -942,7 +942,7 @@ static int blkvsc_submit_request(struct blkvsc_request *blkvsc_req,
 	storvsc_req->context = blkvsc_req;
 
 	vm_srb->port_number = blkdev->port;
-	storvsc_req->bus = blkdev->path;
+	vm_srb->path_id = blkdev->path;
 	storvsc_req->target_id = blkdev->target;
 	storvsc_req->lun_id = 0;	 /* this is not really used at all */
 
diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 21ca3db..4d202f6 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -531,8 +531,8 @@ int stor_vsc_on_io_request(struct hv_device *device,
 		   "Extension %p", device, stor_device, request,
 		   request_extension);
 
-	DPRINT_DBG(STORVSC, "req %p len %d bus %d, target %d, lun %d cdblen %d",
-		   request, request->data_buffer.len, request->bus,
+	DPRINT_DBG(STORVSC, "req %p len %d  target %d, lun %d cdblen %d",
+		   request, request->data_buffer.len,
 		   request->target_id, request->lun_id, request->cdb_len);
 
 	if (!stor_device) {
@@ -550,7 +550,6 @@ int stor_vsc_on_io_request(struct hv_device *device,
 
 	vstor_packet->vm_srb.length = sizeof(struct vmscsi_request);
 
-	vstor_packet->vm_srb.path_id = request->bus;
 	vstor_packet->vm_srb.target_id = request->target_id;
 	vstor_packet->vm_srb.lun = request->lun_id;
 
diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index f9dc4f1..07a391b 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -66,7 +66,6 @@ struct storvsc_request_extension {
 };
 
 struct hv_storvsc_request {
-	u32 bus;
 	u32 target_id;
 	u32 lun_id;
 	u8 *cdb;
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index e772822..faadc8c 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -775,7 +775,7 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 
 	/* request->PortId = scmnd->device->channel; */
 	vm_srb->port_number = host_device_ctx->port;
-	request->bus = scmnd->device->channel;
+	vm_srb->path_id = scmnd->device->channel;
 	request->target_id = scmnd->device->id;
 	request->lun_id = scmnd->device->lun;
 
-- 
1.7.4.1
