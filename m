From: Hank Janssen <hjanssen@sailtheuniverse.com>
Subject: [PATCH 2/5] staging: hv: Fixed lockup problem with bounce_buffer
	scatter list - RESEND
Date: Tue, 31 Aug 2010 11:13:59 -0700
Message-ID: <4C7D4667.5040102@sailtheuniverse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, devel@driverdev.osuosl.org
Cc: haiyangz@microsoft.com
List-Id: virtualization@lists.linuxfoundation.org


(Send from a linux machine, not routed through exchange)

Fixed lockup problem with bounce_buffer scatter list which caused 
crashes in heavy loads.

Signed-off-by:Hank Janssen <hjanssen@microsoft.com
Signed-off-by:Haiyang Zhang <haiyangz@microsoft.com

---
 drivers/staging/hv/storvsc_drv.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 3b9ccb0..169d701 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -615,6 +615,7 @@ static int storvsc_queuecommand(struct scsi_cmnd *scmnd,
 	unsigned int request_size = 0;
 	int i;
 	struct scatterlist *sgl;
+	unsigned int sg_count = 0;
 
 	DPRINT_DBG(STORVSC_DRV, "scmnd %p dir %d, use_sg %d buf %p len %d "
 		   "queue depth %d tagged %d", scmnd, scmnd->sc_data_direction,
@@ -697,6 +698,7 @@ static int storvsc_queuecommand(struct scsi_cmnd *scmnd,
 	request->DataBuffer.Length = scsi_bufflen(scmnd);
 	if (scsi_sg_count(scmnd)) {
 		sgl = (struct scatterlist *)scsi_sglist(scmnd);
+		sg_count = scsi_sg_count(scmnd);
 
 		/* check if we need to bounce the sgl */
 		if (do_bounce_buffer(sgl, scsi_sg_count(scmnd)) != -1) {
@@ -731,15 +733,16 @@ static int storvsc_queuecommand(struct scsi_cmnd *scmnd,
 					      scsi_sg_count(scmnd));
 
 			sgl = cmd_request->bounce_sgl;
+			sg_count = cmd_request->bounce_sgl_count;
 		}
 
 		request->DataBuffer.Offset = sgl[0].offset;
 
-		for (i = 0; i < scsi_sg_count(scmnd); i++) {
+		for (i = 0; i < sg_count; i++) {
 			DPRINT_DBG(STORVSC_DRV, "sgl[%d] len %d offset %d\n",
 				   i, sgl[i].length, sgl[i].offset);
-			request->DataBuffer.PfnArray[i] =
-					page_to_pfn(sg_page((&sgl[i])));
+			request->DataBuffer.PfnArray[i] = 
+				page_to_pfn(sg_page((&sgl[i])));
 		}
 	} else if (scsi_sglist(scmnd)) {
 		/* ASSERT(scsi_bufflen(scmnd) <= PAGE_SIZE); */
-- 
1.6.0.2
