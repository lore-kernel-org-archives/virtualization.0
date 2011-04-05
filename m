From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 19/22] Staging: hv: Get rid of the bytes_xfer field from
	struct hv_storvsc_request
Date: Tue,  5 Apr 2011 07:05:03 -0700
Message-ID: <1302012306-21277-19-git-send-email-kys@microsoft.com>
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

In preparation of consolidating all I/O request state,
get rid of the  bytes_xfer field from struct hv_storvsc_request
and instead use the state in the struct vmscsi_request directly.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc.c     |    4 ++--
 drivers/staging/hv/storvsc_api.h |    2 --
 drivers/staging/hv/storvsc_drv.c |    2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index cee1fe9..c71481f 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -327,8 +327,8 @@ static void stor_vsc_on_io_completion(struct hv_device *device,
 		}
 	}
 
-	/* TODO: */
-	request->bytes_xfer = vstor_packet->vm_srb.data_transfer_length;
+	stor_pkt->vm_srb.data_transfer_length =
+	vstor_packet->vm_srb.data_transfer_length;
 
 	request->extension.on_io_completion(request);
 
diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index 3cfae2d..738627c 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -70,8 +70,6 @@ struct storvsc_request_extension {
 };
 
 struct hv_storvsc_request {
-	u32 bytes_xfer;
-
 	struct storvsc_request_extension extension;
 
 	struct hv_multipage_buffer data_buffer;
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 05ff110..fbeec70 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -485,7 +485,7 @@ static void storvsc_commmand_completion(struct hv_storvsc_request *request)
 
 	/* ASSERT(request->BytesXfer <= request->data_buffer.Length); */
 	scsi_set_resid(scmnd,
-		request->data_buffer.len - request->bytes_xfer);
+		request->data_buffer.len - vm_srb->data_transfer_length);
 
 	scsi_done_fn = scmnd->scsi_done;
 
-- 
1.7.4.1
