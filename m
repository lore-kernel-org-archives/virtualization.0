From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] staging: hv: storvsc: ignore SET_WINDOW scsi command
Date: Mon, 10 Oct 2011 09:37:39 +0200
Message-ID: <20111010073739.GA19807@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Some commands sent by smartd will offline the device.
With this change applied, smartd sill not monitor the device anymore.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/staging/hv/storvsc_drv.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -1122,6 +1122,22 @@ static void storvsc_command_completion(s
 	kmem_cache_free(host_dev->request_pool, cmd_request);
 }
 
+static bool storvsc_check_scsi_cmd(struct scsi_cmnd *scmnd)
+{
+	bool allowed = true;
+	u8 scsi_op = scmnd->cmnd[0];
+
+	switch (scsi_op) {
+		/* smartd sends this command, which will offline the device */
+		case SET_WINDOW:
+			scmnd->result = DID_ERROR << 16;
+			allowed = false;
+			break;
+		default:
+			break;
+	}
+	return allowed;
+}
 
 /*
  * storvsc_queuecommand - Initiate command processing
@@ -1141,6 +1157,10 @@ static int storvsc_queuecommand_lck(stru
 	unsigned int sg_count = 0;
 	struct vmscsi_request *vm_srb;
 
+	if (storvsc_check_scsi_cmd(scmnd) == false) {
+		done(scmnd);
+		return 0;
+	}
 
 	/* If retrying, no need to prep the cmd */
 	if (scmnd->host_scribble) {
