From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 2/2] Staging: hv: storvsc: Fix checkpatch warnings
Date: Fri, 14 Oct 2011 21:31:57 -0700
Message-ID: <1318653117-7154-2-git-send-email-kys@microsoft.com>
References: <1318653084-7115-1-git-send-email-kys@microsoft.com>
 <1318653117-7154-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318653117-7154-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Fix checkpatch warnings.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 1f9d23e..ae8c33e 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -522,8 +522,9 @@ static void storvsc_on_io_completion(struct hv_device *device,
 		if (vstor_packet->vm_srb.srb_status & 0x80) {
 			/* autosense data available */
 			dev_warn(&device->device,
-				 "storvsc pkt %p autosense data valid - len %d\n",
-				 request, vstor_packet->vm_srb.sense_info_length);
+				 "stor pkt %p autosense data valid - len %d\n",
+				 request,
+				 vstor_packet->vm_srb.sense_info_length);
 
 			memcpy(request->sense_buffer,
 			       vstor_packet->vm_srb.sense_data,
@@ -1128,13 +1129,13 @@ static bool storvsc_check_scsi_cmd(struct scsi_cmnd *scmnd)
 	u8 scsi_op = scmnd->cmnd[0];
 
 	switch (scsi_op) {
-		/* smartd sends this command, which will offline the device */
-		case SET_WINDOW:
-			scmnd->result = DID_ERROR << 16;
-			allowed = false;
-			break;
-		default:
-			break;
+	/* smartd sends this command, which will offline the device */
+	case SET_WINDOW:
+		scmnd->result = DID_ERROR << 16;
+		allowed = false;
+		break;
+	default:
+		break;
 	}
 	return allowed;
 }
-- 
1.7.4.1
