From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 099/117] Staging: hv: storvsc: Optimize bounce buffer handling
	for the "write" case
Date: Fri, 15 Jul 2011 10:47:27 -0700
Message-ID: <1310752065-27895-99-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Optimize bounce buffer handling for the "write" case.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 5777482..e2294d5 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -428,17 +428,17 @@ static void storvsc_commmand_completion(struct hv_storvsc_request *request)
 	struct scsi_sense_hdr sense_hdr;
 	struct vmscsi_request *vm_srb;
 
+	vm_srb = &request->vstor_packet.vm_srb;
 	if (cmd_request->bounce_sgl_count) {
-
-		/* FIXME: We can optimize on writes by just skipping this */
-		copy_from_bounce_buffer(scsi_sglist(scmnd),
+		if (vm_srb->data_in == READ_TYPE) {
+			copy_from_bounce_buffer(scsi_sglist(scmnd),
 					cmd_request->bounce_sgl,
 					scsi_sg_count(scmnd));
-		destroy_bounce_buffer(cmd_request->bounce_sgl,
-				      cmd_request->bounce_sgl_count);
+			destroy_bounce_buffer(cmd_request->bounce_sgl,
+					cmd_request->bounce_sgl_count);
+		}
 	}
 
-	vm_srb = &request->vstor_packet.vm_srb;
 	scmnd->result = vm_srb->scsi_status;
 
 	if (scmnd->result) {
-- 
1.7.4.1
