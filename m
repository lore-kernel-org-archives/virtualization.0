From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 106/117] Staging: hv: storvsc: Fixup srb and scsi status for INQUIRY and MODE_SENSE
Date: Fri, 15 Jul 2011 10:47:34 -0700
Message-ID: <1310752065-27895-106-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The current handler on the Windows Host does not correctly handle
INQUIRY and MODE_SENSE commands with some options. Fixup srb_status
in these cases since the failure is not fatal.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index a1e8d6a..9c2bb56 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -520,6 +520,23 @@ static void storvsc_on_io_completion(struct hv_device *device,
 
 	stor_pkt = &request->vstor_packet;
 
+	/*
+	 * The current SCSI handling on the host side does
+	 * not correctly handle:
+	 * INQUIRY command with page code parameter set to 0x80
+	 * MODE_SENSE command with cmd[2] == 0x1c
+	 *
+	 * Setup srb and scsi status so this won't be fatal.
+	 * We do this so we can distinguish truly fatal failues
+	 * (srb status == 0x4) and off-line the device in that case.
+	 */
+
+	if ((stor_pkt->vm_srb.cdb[0] == INQUIRY) ||
+		(stor_pkt->vm_srb.cdb[0] == MODE_SENSE)) {
+		vstor_packet->vm_srb.scsi_status = 0;
+		vstor_packet->vm_srb.srb_status = 0x1;
+	}
+
 
 	/* Copy over the status...etc */
 	stor_pkt->vm_srb.scsi_status = vstor_packet->vm_srb.scsi_status;
-- 
1.7.4.1
