From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 11/11] Staging: hv: storvsc: Support hot-removing of scsi
	devices
Date: Tue,  8 Nov 2011 09:01:50 -0800
Message-ID: <1320771710-29139-11-git-send-email-kys@microsoft.com>
References: <1320771677-29095-1-git-send-email-kys@microsoft.com>
	<1320771710-29139-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1320771710-29139-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, James.Bottomley@HansenPartnership.com, hch@infradead.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Support hot-removing of scsi devices.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   45 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 7c82d14..0245143 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -328,6 +328,27 @@ static void storvsc_bus_scan(struct work_struct *work)
 	kfree(wrk);
 }
 
+static void storvsc_remove_lun(struct work_struct *work)
+{
+	struct storvsc_scan_work *wrk;
+	struct scsi_device *sdev;
+
+	wrk = container_of(work, struct storvsc_scan_work, work);
+	if (!scsi_host_get(wrk->host))
+		goto done;
+
+	sdev = scsi_device_lookup(wrk->host, 0, 0, wrk->lun);
+
+	if (sdev) {
+		scsi_remove_device(sdev);
+		scsi_device_put(sdev);
+	}
+	scsi_host_put(wrk->host);
+
+done:
+	kfree(wrk);
+}
+
 static inline struct storvsc_device *get_out_stor_device(
 					struct hv_device *device)
 {
@@ -1112,6 +1133,7 @@ static void storvsc_command_completion(struct hv_storvsc_request *request)
 	void (*scsi_done_fn)(struct scsi_cmnd *);
 	struct scsi_sense_hdr sense_hdr;
 	struct vmscsi_request *vm_srb;
+	struct storvsc_scan_work *wrk;
 
 	vm_srb = &request->vstor_packet.vm_srb;
 	if (cmd_request->bounce_sgl_count) {
@@ -1134,6 +1156,29 @@ static void storvsc_command_completion(struct hv_storvsc_request *request)
 	else
 		scmnd->result = vm_srb->scsi_status;
 
+	/*
+	 * If the LUN is invalid; remove the device.
+	 */
+	if (vm_srb->srb_status == 0x20) {
+		struct storvsc_device *stor_dev;
+		struct hv_device *dev = host_dev->dev;
+		struct Scsi_Host *host;
+
+		stor_dev = get_in_stor_device(dev);
+		host = stor_dev->host;
+
+		wrk = kmalloc(sizeof(struct storvsc_scan_work),
+				GFP_ATOMIC);
+		if (!wrk) {
+			scmnd->result = DID_TARGET_FAILURE << 16;
+		} else {
+			wrk->host = host;
+			wrk->lun = vm_srb->lun;
+			INIT_WORK(&wrk->work, storvsc_remove_lun);
+			schedule_work(&wrk->work);
+		}
+	}
+
 	if (scmnd->result) {
 		if (scsi_normalize_sense(scmnd->sense_buffer,
 				SCSI_SENSE_BUFFERSIZE, &sense_hdr))
-- 
1.7.4.1
