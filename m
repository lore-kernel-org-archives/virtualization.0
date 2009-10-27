From: hare@suse.de (Hannes Reinecke)
Subject: [PATCH 4/4] megasas: Add SCSI command emulation
Date: Tue, 27 Oct 2009 16:29:07 +0100
Message-ID: <20091027152907.BD19239742__47587.3100491755$1256657565$gmane$org@ochil.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Now that we can use SCSI command emulation without using the SCSI
disk abstraction we can easily add it to the megasas HBA.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 hw/megasas.c |   88 +++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/hw/megasas.c b/hw/megasas.c
index a57e8e0..f32b313 100644
--- a/hw/megasas.c
+++ b/hw/megasas.c
@@ -661,40 +661,55 @@ static int megasas_handle_scsi(MPTState *s, uint8_t fcmd,
     }
     }
 
-    memset(&cmd->hdr, 0, sizeof(struct sg_io_hdr));
-    cmd->hdr.interface_id = 'S';
-    cmd->hdr.cmd_len = cdb_len;
-    cmd->hdr.cmdp = cdb;
-    cmd->hdr.iovec_count = cmd->sge_count;
-    cmd->hdr.dxferp = cmd->iov;
-    for (n = 0; n < cmd->sge_count; n++)
-	cmd->hdr.dxfer_len += cmd->iov[n].iov_len;
-    if (cmd->sge_count) {
-	if (dir)
-	    cmd->hdr.dxfer_direction = SG_DXFER_TO_DEV;
-	else
-	    cmd->hdr.dxfer_direction = SG_DXFER_FROM_DEV;
-    } else {
-	cmd->hdr.dxfer_direction = SG_DXFER_NONE;
-    }
-    cmd->hdr.sbp = cmd->sense;
-    cmd->hdr.mx_sb_len = cmd->sense_len;
+    if (bdrv_is_sg(cmd->lun->bdrv)) {
+	memset(&cmd->hdr, 0, sizeof(struct sg_io_hdr));
+	cmd->hdr.interface_id = 'S';
+	cmd->hdr.cmd_len = cdb_len;
+	cmd->hdr.cmdp = cdb;
+	cmd->hdr.iovec_count = cmd->sge_count;
+	cmd->hdr.dxferp = cmd->iov;
+	for (n = 0; n < cmd->sge_count; n++)
+	    cmd->hdr.dxfer_len += cmd->iov[n].iov_len;
+	if (cmd->sge_count) {
+	    if (dir)
+		cmd->hdr.dxfer_direction = SG_DXFER_TO_DEV;
+	    else
+		cmd->hdr.dxfer_direction = SG_DXFER_FROM_DEV;
+	} else {
+	    cmd->hdr.dxfer_direction = SG_DXFER_NONE;
+	}
+	cmd->hdr.sbp = cmd->sense;
+	cmd->hdr.mx_sb_len = cmd->sense_len;
 
-    ret = bdrv_ioctl(cmd->lun->bdrv, SG_IO, &cmd->hdr);
-    if (ret) {
-	DPRINTF("SCSI pthru dev %x lun %x failed with %d\n",
-		target, lun, errno);
-	sense_len = scsi_build_sense(cmd->sense, SENSE_IO_ERROR);
-	cmd->sge_size = 0;
-	scsi_status = SAM_STAT_CHECK_CONDITION;
-    } else if (cmd->hdr.status) {
-	sense_len = cmd->hdr.sb_len_wr;
-	scsi_status = cmd->hdr.status;
-	cmd->sge_size = cmd->hdr.dxfer_len;
-	scsi_status = SAM_STAT_CHECK_CONDITION;
+	ret = bdrv_ioctl(cmd->lun->bdrv, SG_IO, &cmd->hdr);
+	if (ret) {
+	    DPRINTF("SCSI pthru dev %x lun %x failed with %d\n",
+		    target, lun, errno);
+	    sense_len = scsi_build_sense(cmd->sense, SENSE_IO_ERROR);
+	    cmd->sge_size = 0;
+	    scsi_status = SAM_STAT_CHECK_CONDITION;
+	} else if (cmd->hdr.status) {
+	    sense_len = cmd->hdr.sb_len_wr;
+	    scsi_status = cmd->hdr.status;
+	    cmd->sge_size = cmd->hdr.dxfer_len;
+	    scsi_status = SAM_STAT_CHECK_CONDITION;
+	} else {
+	    sense_len = 0;
+	    cmd->sge_size = cmd->hdr.dxfer_len;
+	}
     } else {
-	sense_len = 0;
-	cmd->sge_size = cmd->hdr.dxfer_len;
+	uint32_t sense;
+
+	DPRINTF("Emulate SCSI pthru cmd %x\n", cdb[0]);
+	sense = scsi_emulate_command(cmd->lun->bdrv, 0, cdb,
+				     cmd->iov[0].iov_len,
+				     cmd->iov[0].iov_base,
+				     &cmd->sge_size);
+	sense_len = scsi_build_sense(cmd->sense, sense);
+	if (sense_len)
+	    scsi_status = SAM_STAT_CHECK_CONDITION;
+	else
+	    scsi_status = SAM_STAT_GOOD;
     }
 out:
     megasas_unmap_sense(cmd, sense_len);
@@ -1105,13 +1120,16 @@ static int megasas_scsi_init(PCIDevice *dev)
 	    lun->bdrv = NULL;
 	    continue;
 	}
+	bdrv_set_tcq(lun->bdrv, 1);
 	/* check if we can use SG_IO */
 	ret = bdrv_ioctl(lun->bdrv, SG_IO, &hdr);
 	if (ret) {
-	    DPRINTF("SCSI cmd passthrough not available on dev %d (error %d)\n",
+	    DPRINTF("Using SCSI cmd emulation on dev %d (error %d)\n",
 		    unit, ret);
-	    lun->sdev = NULL;
-	    lun->bdrv = NULL;
+	    bdrv_set_sg(lun->bdrv, 0);
+	} else {
+	    DPRINTF("Using SCSI cmd passthrough on dev %d\n", unit);
+	    bdrv_set_sg(lun->bdrv, 1);
 	}
     }
     register_savevm("megasas", -1, 0, megasas_scsi_save, megasas_scsi_load, s);
-- 
1.6.0.2
