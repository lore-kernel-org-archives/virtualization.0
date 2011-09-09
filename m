From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] Staging: hv: storvsc: advertise hv_storvsc instead of
 storvsc as driver name
Date: Fri, 9 Sep 2011 14:45:33 +0200
Message-ID: <20110909124533.GA23598@aepfle.de>
References: <20110908162650.GA10699@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110908162650.GA10699@aepfle.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org


Signed-off-by: Olaf Hering <olaf@aepfle.de>

--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -42,6 +42,8 @@
 
 #include "hyperv.h"
 
+#define MODULE_NAME "hv_storvsc"
+
 #define STORVSC_RING_BUFFER_SIZE			(20*PAGE_SIZE)
 static int storvsc_ringbuffer_size = STORVSC_RING_BUFFER_SIZE;
 
@@ -1164,7 +1166,7 @@ static void storvsc_command_completion(s
 	if (scmnd->result) {
 		if (scsi_normalize_sense(scmnd->sense_buffer,
 				SCSI_SENSE_BUFFERSIZE, &sense_hdr))
-			scsi_print_sense_hdr("storvsc", &sense_hdr);
+			scsi_print_sense_hdr(MODULE_NAME, &sense_hdr);
 	}
 
 	scsi_set_resid(scmnd,
@@ -1333,8 +1335,8 @@ static DEF_SCSI_QCMD(storvsc_queuecomman
 /* Scsi driver */
 static struct scsi_host_template scsi_driver = {
 	.module	=		THIS_MODULE,
-	.name =			"hv_storvsc",
-	.proc_name =		"hv_storvsc",
+	.name =			MODULE_NAME,
+	.proc_name =		MODULE_NAME,
 	.bios_param =		storvsc_get_chs,
 	.queuecommand =		storvsc_queuecommand,
 	.eh_host_reset_handler =	storvsc_host_reset_handler,
@@ -1468,7 +1470,7 @@ err_out:
 /* The one and only one */
 
 static struct hv_driver storvsc_drv = {
-	.name = "storvsc",
+	.name = MODULE_NAME,
 	.id_table = id_table,
 	.probe = storvsc_probe,
 	.remove = storvsc_remove,
