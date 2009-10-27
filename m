From: hare@suse.de (Hannes Reinecke)
Subject: [PATCH 3/4] scsi-disk: Factor out SCSI command emulation
Date: Tue, 27 Oct 2009 16:28:59 +0100
Message-ID: <20091027152859.C6CF739742__26590.429506223$1256657554$gmane$org@ochil.suse.de>
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


Other drives might want to use SCSI command emulation without
going through the SCSI disk abstraction, as this imposes too
many limits on the emulation.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block.c        |   15 ++
 block.h        |    3 +
 block_int.h    |    1 +
 hw/scsi-disk.c |  610 ++++++++++++++++++++++++++++++--------------------------
 hw/scsi-disk.h |    3 +
 5 files changed, 346 insertions(+), 286 deletions(-)

diff --git a/block.c b/block.c
index 33f3d65..06f92c4 100644
--- a/block.c
+++ b/block.c
@@ -930,6 +930,21 @@ int bdrv_is_sg(BlockDriverState *bs)
     return bs->sg;
 }
 
+void bdrv_set_sg(BlockDriverState *bs, int set)
+{
+    bs->sg = set;
+}
+
+int bdrv_get_tcq(BlockDriverState *bs)
+{
+    return bs->tcq;
+}
+
+void bdrv_set_tcq(BlockDriverState *bs, int set)
+{
+    bs->tcq = set;
+}
+
 int bdrv_enable_write_cache(BlockDriverState *bs)
 {
     return bs->enable_write_cache;
diff --git a/block.h b/block.h
index a966afb..7862fa0 100644
--- a/block.h
+++ b/block.h
@@ -134,9 +134,12 @@ void bdrv_get_geometry_hint(BlockDriverState *bs,
                             int *pcyls, int *pheads, int *psecs);
 int bdrv_get_type_hint(BlockDriverState *bs);
 int bdrv_get_translation_hint(BlockDriverState *bs);
+int bdrv_get_tcq(BlockDriverState *bs);
+void bdrv_set_tcq(BlockDriverState *bs, int set);
 int bdrv_is_removable(BlockDriverState *bs);
 int bdrv_is_read_only(BlockDriverState *bs);
 int bdrv_is_sg(BlockDriverState *bs);
+void bdrv_set_sg(BlockDriverState *bs, int set);
 int bdrv_enable_write_cache(BlockDriverState *bs);
 int bdrv_is_inserted(BlockDriverState *bs);
 int bdrv_media_changed(BlockDriverState *bs);
diff --git a/block_int.h b/block_int.h
index 8e72abe..e5ee57b 100644
--- a/block_int.h
+++ b/block_int.h
@@ -129,6 +129,7 @@ struct BlockDriverState {
     int encrypted; /* if true, the media is encrypted */
     int valid_key; /* if true, a valid encryption key has been set */
     int sg;        /* if true, the device is a /dev/sg* */
+    int tcq;       /* if true, the device supports tagged command queueing */
     /* event callback when inserting/removing */
     void (*change_cb)(void *opaque);
     void *change_opaque;
diff --git a/hw/scsi-disk.c b/hw/scsi-disk.c
index 68b4e83..3e68518 100644
--- a/hw/scsi-disk.c
+++ b/hw/scsi-disk.c
@@ -56,7 +56,7 @@ typedef struct SCSIRequest {
     /* Both sector and sector_count are in terms of qemu 512 byte blocks.  */
     uint64_t sector;
     uint32_t sector_count;
-    struct iovec iov;
+    struct iovec *iov;
     QEMUIOVector qiov;
     BlockDriverAIOCB *aiocb;
     struct SCSIRequest *next;
@@ -72,7 +72,8 @@ struct SCSIDiskState
        This is the number of 512 byte blocks in a single scsi sector.  */
     int cluster_size;
     uint64_t max_lba;
-    int sense;
+    uint8_t sense[SCSI_SENSE_LEN];
+    uint8_t sense_len;
     char drive_serial_str[21];
     QEMUBH *bh;
 };
@@ -90,13 +91,12 @@ static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag)
         free_requests = r->next;
     } else {
         r = qemu_malloc(sizeof(SCSIRequest));
-        r->iov.iov_base = qemu_memalign(512, SCSI_DMA_BUF_SIZE);
+	r->iov = NULL;
     }
     r->bus = scsi_bus_from_device(d);
     r->dev = s;
     r->tag = tag;
     r->sector_count = 0;
-    r->iov.iov_len = 0;
     r->aiocb = NULL;
     r->status = 0;
 
@@ -126,6 +126,17 @@ static void scsi_remove_request(SCSIRequest *r)
     free_requests = r;
 }
 
+static void *scsi_allocate_iovec(SCSIRequest *r) {
+    if (!r->iov) {
+	r->iov = qemu_malloc(sizeof(struct iovec));
+	if (!r->iov)
+	    return NULL;
+	r->iov->iov_base = qemu_memalign(512, SCSI_DMA_BUF_SIZE);
+	r->iov->iov_len = SCSI_DMA_BUF_SIZE;
+    }
+    return r->iov;
+}
+
 static SCSIRequest *scsi_find_request(SCSIDiskState *s, uint32_t tag)
 {
     SCSIRequest *r;
@@ -137,12 +148,11 @@ static SCSIRequest *scsi_find_request(SCSIDiskState *s, uint32_t tag)
     return r;
 }
 
-/* Helper function to build a sense block */
 int32_t scsi_build_sense(uint8_t *sense_buf, uint32_t sense)
 {
     memset(sense_buf, 0, SCSI_SENSE_LEN);
     if (!sense)
-       return 0;
+	return 0;
 
     sense_buf[0] = 0xf0; /* current, fixed format */
     sense_buf[2] = (sense >> 16) & 0x0F;
@@ -154,15 +164,19 @@ int32_t scsi_build_sense(uint8_t *sense_buf, uint32_t sense)
 }
 
 /* Helper function for command completion.  */
-static void scsi_command_complete(SCSIRequest *r, int status, int sense)
+static void scsi_command_complete(SCSIRequest *r, int status, uint32_t sense)
 {
     SCSIDiskState *s = r->dev;
     uint32_t tag;
-    DPRINTF("Command complete tag=0x%x status=%d sense=%d\n", r->tag, status, sense);
-    s->sense = sense;
+
+    DPRINTF("Command complete tag=0x%x status=%d sense=%d\n", r->tag,
+	    status, s->sense_len);
+    if (status == STATUS_CHECK_CONDITION) {
+	s->sense_len = scsi_build_sense(s->sense, sense);
+    }
     tag = r->tag;
     scsi_remove_request(r);
-    r->bus->complete(r->bus, SCSI_REASON_DONE, tag, status);
+    r->bus->complete(r->bus, SCSI_REASON_DONE, tag, (uint32_t)status);
 }
 
 /* Cancel a pending data transfer.  */
@@ -187,12 +201,13 @@ static void scsi_read_complete(void * opaque, int ret)
     if (ret) {
         DPRINTF("IO error\n");
         r->bus->complete(r->bus, SCSI_REASON_DATA, r->tag, 0);
-        scsi_command_complete(r, STATUS_CHECK_CONDITION, SENSE_NO_SENSE);
+	scsi_command_complete(r, STATUS_CHECK_CONDITION, SENSE_IO_ERROR);
         return;
     }
-    DPRINTF("Data ready tag=0x%x len=%" PRId64 "\n", r->tag, r->iov.iov_len);
+    r->iov->iov_len = r->qiov.size;
+    DPRINTF("Data ready tag=0x%x len=%" PRId64 "\n", r->tag, r->iov->iov_len);
 
-    r->bus->complete(r->bus, SCSI_REASON_DATA, r->tag, r->iov.iov_len);
+    r->bus->complete(r->bus, SCSI_REASON_DATA, r->tag, r->iov->iov_len);
 }
 
 /* Read more data from scsi device into buffer.  */
@@ -205,19 +220,18 @@ static void scsi_read_data(SCSIDevice *d, uint32_t tag)
     r = scsi_find_request(s, tag);
     if (!r) {
         BADF("Bad read tag 0x%x\n", tag);
-        /* ??? This is the wrong error.  */
-        scsi_command_complete(r, STATUS_CHECK_CONDITION, SENSE_HARDWARE_ERROR);
+        scsi_command_complete(r, STATUS_CHECK_CONDITION, SENSE_TAG_NOT_FOUND);
         return;
     }
     if (r->sector_count == (uint32_t)-1) {
-        DPRINTF("Read buf_len=%" PRId64 "\n", r->iov.iov_len);
+        DPRINTF("Read buf_len=%" PRId64 "\n", r->iov->iov_len);
         r->sector_count = 0;
-        r->bus->complete(r->bus, SCSI_REASON_DATA, r->tag, r->iov.iov_len);
+        r->bus->complete(r->bus, SCSI_REASON_DATA, r->tag, r->iov->iov_len);
         return;
     }
     DPRINTF("Read sector_count=%d\n", r->sector_count);
     if (r->sector_count == 0) {
-        scsi_command_complete(r, STATUS_GOOD, SENSE_NO_SENSE);
+	scsi_command_complete(r, STATUS_GOOD, 0);
         return;
     }
 
@@ -225,12 +239,13 @@ static void scsi_read_data(SCSIDevice *d, uint32_t tag)
     if (n > SCSI_DMA_BUF_SIZE / 512)
         n = SCSI_DMA_BUF_SIZE / 512;
 
-    r->iov.iov_len = n * 512;
-    qemu_iovec_init_external(&r->qiov, &r->iov, 1);
+    r->iov->iov_len = n * 512;
+    qemu_iovec_init_external(&r->qiov, r->iov, 1);
     r->aiocb = bdrv_aio_readv(s->dinfo->bdrv, r->sector, &r->qiov, n,
                               scsi_read_complete, r);
-    if (r->aiocb == NULL)
-        scsi_command_complete(r, STATUS_CHECK_CONDITION, SENSE_HARDWARE_ERROR);
+    if (r->aiocb == NULL) {
+	scsi_command_complete(r, STATUS_CHECK_CONDITION, SENSE_IO_ERROR);
+    }
     r->sector += n;
     r->sector_count -= n;
 }
@@ -247,8 +262,7 @@ static int scsi_handle_write_error(SCSIRequest *r, int error)
         r->status |= SCSI_REQ_STATUS_RETRY;
         vm_stop(0);
     } else {
-        scsi_command_complete(r, STATUS_CHECK_CONDITION,
-                SENSE_HARDWARE_ERROR);
+	scsi_command_complete(r, STATUS_CHECK_CONDITION, SENSE_TARGET_FAILURE);
     }
 
     return 1;
@@ -267,17 +281,17 @@ static void scsi_write_complete(void * opaque, int ret)
             return;
     }
 
-    n = r->iov.iov_len / 512;
+    n = r->qiov.size / 512;
     r->sector += n;
     r->sector_count -= n;
     if (r->sector_count == 0) {
-        scsi_command_complete(r, STATUS_GOOD, SENSE_NO_SENSE);
+	scsi_command_complete(r, STATUS_GOOD, 0);
     } else {
         len = r->sector_count * 512;
         if (len > SCSI_DMA_BUF_SIZE) {
             len = SCSI_DMA_BUF_SIZE;
         }
-        r->iov.iov_len = len;
+        r->iov->iov_len = len;
         DPRINTF("Write complete tag=0x%x more=%d\n", r->tag, len);
         r->bus->complete(r->bus, SCSI_REASON_DATA, r->tag, len);
     }
@@ -288,14 +302,13 @@ static void scsi_write_request(SCSIRequest *r)
     SCSIDiskState *s = r->dev;
     uint32_t n;
 
-    n = r->iov.iov_len / 512;
+    n = r->iov->iov_len / 512;
     if (n) {
-        qemu_iovec_init_external(&r->qiov, &r->iov, 1);
+        qemu_iovec_init_external(&r->qiov, r->iov, 1);
         r->aiocb = bdrv_aio_writev(s->dinfo->bdrv, r->sector, &r->qiov, n,
                                    scsi_write_complete, r);
         if (r->aiocb == NULL)
-            scsi_command_complete(r, STATUS_CHECK_CONDITION,
-                                  SENSE_HARDWARE_ERROR);
+	    scsi_command_complete(r, STATUS_CHECK_CONDITION, SENSE_IO_ERROR);
     } else {
         /* Invoke completion routine to fetch data from host.  */
         scsi_write_complete(r, 0);
@@ -313,7 +326,8 @@ static int scsi_write_data(SCSIDevice *d, uint32_t tag)
     r = scsi_find_request(s, tag);
     if (!r) {
         BADF("Bad write tag 0x%x\n", tag);
-        scsi_command_complete(r, STATUS_CHECK_CONDITION, SENSE_HARDWARE_ERROR);
+        /* I_T Nexus loss occurred  */
+	scsi_command_complete(r, STATUS_CHECK_CONDITION, SENSE_TAG_NOT_FOUND);
         return 1;
     }
 
@@ -366,124 +380,101 @@ static uint8_t *scsi_get_buf(SCSIDevice *d, uint32_t tag)
         BADF("Bad buffer tag 0x%x\n", tag);
         return NULL;
     }
-    return (uint8_t *)r->iov.iov_base;
+    return (uint8_t *)r->iov->iov_base;
 }
 
-/* Execute a scsi command.  Returns the length of the data expected by the
-   command.  This will be Positive for data transfers from the device
-   (eg. disk reads), negative for transfers to the device (eg. disk writes),
-   and zero if the command does not transfer any data.  */
-
-static int32_t scsi_send_command(SCSIDevice *d, uint32_t tag,
-                                 uint8_t *buf, int lun)
+static int scsi_check_cdb_len(uint8_t *cdb, uint32_t *datalen, uint64_t *lba)
 {
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, d);
-    uint64_t nb_sectors;
-    uint64_t lba;
-    uint32_t len;
-    int cmdlen;
-    int is_write;
-    uint8_t command;
-    uint8_t *outbuf;
-    SCSIRequest *r;
+    int cmdlen = 0;
 
-    command = buf[0];
-    r = scsi_find_request(s, tag);
-    if (r) {
-        BADF("Tag 0x%x already in use\n", tag);
-        scsi_cancel_io(d, tag);
-    }
-    /* ??? Tags are not unique for different luns.  We only implement a
-       single lun, so this should not matter.  */
-    r = scsi_new_request(d, tag);
-    outbuf = (uint8_t *)r->iov.iov_base;
-    is_write = 0;
-    DPRINTF("Command: lun=%d tag=0x%x data=0x%02x", lun, tag, buf[0]);
-    switch (command >> 5) {
+    DPRINTF("Command 0x%02x", cdb[0]);
+    switch (cdb[0] >> 5) {
     case 0:
-        lba = (uint64_t) buf[3] | ((uint64_t) buf[2] << 8) |
-              (((uint64_t) buf[1] & 0x1f) << 16);
-        len = buf[4];
+        *lba = (uint64_t) cdb[3] | ((uint64_t) cdb[2] << 8) |
+              (((uint64_t) cdb[1] & 0x1f) << 16);
+        *datalen = cdb[4];
         cmdlen = 6;
         break;
     case 1:
     case 2:
-        lba = (uint64_t) buf[5] | ((uint64_t) buf[4] << 8) |
-              ((uint64_t) buf[3] << 16) | ((uint64_t) buf[2] << 24);
-        len = buf[8] | (buf[7] << 8);
+        *lba = (uint64_t) cdb[5] | ((uint64_t) cdb[4] << 8) |
+              ((uint64_t) cdb[3] << 16) | ((uint64_t) cdb[2] << 24);
+        *datalen = cdb[8] | (cdb[7] << 8);
         cmdlen = 10;
         break;
     case 4:
-        lba = (uint64_t) buf[9] | ((uint64_t) buf[8] << 8) |
-              ((uint64_t) buf[7] << 16) | ((uint64_t) buf[6] << 24) |
-              ((uint64_t) buf[5] << 32) | ((uint64_t) buf[4] << 40) |
-              ((uint64_t) buf[3] << 48) | ((uint64_t) buf[2] << 56);
-        len = buf[13] | (buf[12] << 8) | (buf[11] << 16) | (buf[10] << 24);
+        *lba = (uint64_t) cdb[9] | ((uint64_t) cdb[8] << 8) |
+              ((uint64_t) cdb[7] << 16) | ((uint64_t) cdb[6] << 24) |
+              ((uint64_t) cdb[5] << 32) | ((uint64_t) cdb[4] << 40) |
+              ((uint64_t) cdb[3] << 48) | ((uint64_t) cdb[2] << 56);
+        *datalen = cdb[13] | (cdb[12] << 8) | (cdb[11] << 16) | (cdb[10] << 24);
         cmdlen = 16;
         break;
     case 5:
-        lba = (uint64_t) buf[5] | ((uint64_t) buf[4] << 8) |
-              ((uint64_t) buf[3] << 16) | ((uint64_t) buf[2] << 24);
-        len = buf[9] | (buf[8] << 8) | (buf[7] << 16) | (buf[6] << 24);
+        *lba = (uint64_t) cdb[5] | ((uint64_t) cdb[4] << 8) |
+              ((uint64_t) cdb[3] << 16) | ((uint64_t) cdb[2] << 24);
+        *datalen = cdb[9] | (cdb[8] << 8) | (cdb[7] << 16) | (cdb[6] << 24);
         cmdlen = 12;
         break;
     default:
-        BADF("Unsupported command length, command %x\n", command);
-        goto fail;
+        BADF("Unsupported command length, command %x\n", cdb[0]);
     }
 #ifdef DEBUG_SCSI
     {
         int i;
         for (i = 1; i < cmdlen; i++) {
-            printf(" 0x%02x", buf[i]);
+            printf(" 0x%02x", cdb[i]);
         }
         printf("\n");
     }
 #endif
-    if (lun || buf[1] >> 5) {
-        /* Only LUN 0 supported.  */
-        DPRINTF("Unimplemented LUN %d\n", lun ? lun : buf[1] >> 5);
-        if (command != 0x03 && command != 0x12) /* REQUEST SENSE and INQUIRY */
-            goto fail;
+    return cmdlen;
+}
+
+int32_t scsi_emulate_command(BlockDriverState *bdrv,
+			     int lun, uint8_t *cdb, int datalen,
+			     uint8_t *outbuf, uint32_t *out_len)
+{
+    uint64_t nb_sectors;
+    uint32_t data_xfer_len = 0;
+    int status = STATUS_GOOD;
+    int is_write;
+    uint8_t command;
+    uint32_t cluster_size = 1;
+
+    command = cdb[0];
+
+    is_write = 0;
+
+    if (!bdrv && command != 0x12 && command != 0x03) {
+	*out_len = 0;
+	return SENSE_LUN_NOT_SUPPORTED;
     }
+
+    if (bdrv_get_type_hint(bdrv) == BDRV_TYPE_CDROM) {
+	cluster_size = 4;
+    }
+
     switch (command) {
     case 0x0:
 	DPRINTF("Test Unit Ready\n");
-        if (!bdrv_is_inserted(s->dinfo->bdrv))
-            goto notready;
+	if (!bdrv_is_inserted(bdrv))
+	    status = SENSE_LUN_NOT_READY;
 	break;
-    case 0x03:
-        DPRINTF("Request Sense (len %d)\n", len);
-        if (len < 4)
-            goto fail;
-        memset(outbuf, 0, 4);
-        r->iov.iov_len = 4;
-        if (s->sense == SENSE_NOT_READY && len >= 18) {
-            memset(outbuf, 0, 18);
-            r->iov.iov_len = 18;
-            outbuf[7] = 10;
-            /* asc 0x3a, ascq 0: Medium not present */
-            outbuf[12] = 0x3a;
-            outbuf[13] = 0;
-        }
-        outbuf[0] = 0xf0;
-        outbuf[1] = 0;
-        outbuf[2] = s->sense;
-        break;
     case 0x12:
         DPRINTF("Inquiry (len %d)\n", len);
-        if (buf[1] & 0x2) {
+        if (cdb[1] & 0x2) {
             /* Command support data - optional, not implemented */
             BADF("optional INQUIRY command support request not implemented\n");
-            goto fail;
+            goto invalid_cdb;
         }
-        else if (buf[1] & 0x1) {
+        else if (cdb[1] & 0x1) {
             /* Vital product data */
-            uint8_t page_code = buf[2];
-            if (len < 4) {
+            uint8_t page_code = cdb[2];
+            if (datalen < 4) {
                 BADF("Error: Inquiry (EVPD[%02X]) buffer size %d is "
-                     "less than 4\n", page_code, len);
-                goto fail;
+                     "less than 4\n", page_code, datalen);
+                goto invalid_cdb;
             }
 
             switch (page_code) {
@@ -493,50 +484,50 @@ static int32_t scsi_send_command(SCSIDevice *d, uint32_t tag,
                         DPRINTF("Inquiry EVPD[Supported pages] "
                                 "buffer size %d\n", len);
 
-                        r->iov.iov_len = 0;
+                        data_xfer_len = 0;
 
-                        if (bdrv_get_type_hint(s->dinfo->bdrv) == BDRV_TYPE_CDROM) {
-                            outbuf[r->iov.iov_len++] = 5;
+                        if (bdrv_get_type_hint(bdrv) == BDRV_TYPE_CDROM) {
+                            outbuf[data_xfer_len++] = 5;
                         } else {
-                            outbuf[r->iov.iov_len++] = 0;
+                            outbuf[data_xfer_len++] = 0;
                         }
 
-                        outbuf[r->iov.iov_len++] = 0x00; // this page
-                        outbuf[r->iov.iov_len++] = 0x00;
-                        outbuf[r->iov.iov_len++] = 3;    // number of pages
-                        outbuf[r->iov.iov_len++] = 0x00; // list of supported pages (this page)
-                        outbuf[r->iov.iov_len++] = 0x80; // unit serial number
-                        outbuf[r->iov.iov_len++] = 0x83; // device identification
+                        outbuf[data_xfer_len++] = 0x00; // this page
+                        outbuf[data_xfer_len++] = 0x00;
+                        outbuf[data_xfer_len++] = 3;    // number of pages
+                        outbuf[data_xfer_len++] = 0x00; // list of supported pages (this page)
+                        outbuf[data_xfer_len++] = 0x80; // unit serial number
+                        outbuf[data_xfer_len++] = 0x83; // device identification
                     }
                     break;
                 case 0x80:
                     {
                         int l;
-
+			const char *serial_str = drive_get_serial(bdrv);
                         /* Device serial number, optional */
-                        if (len < 4) {
+                        if (datalen < 4) {
                             BADF("Error: EVPD[Serial number] Inquiry buffer "
-                                 "size %d too small, %d needed\n", len, 4);
-                            goto fail;
+                                 "size %d too small, %d needed\n", datalen, 4);
+                            goto invalid_cdb;
                         }
 
                         DPRINTF("Inquiry EVPD[Serial number] buffer size %d\n", len);
-                        l = MIN(len, strlen(s->drive_serial_str));
+                        l = MIN(datalen, strlen(serial_str));
 
-                        r->iov.iov_len = 0;
+                        data_xfer_len = 0;
 
                         /* Supported page codes */
-                        if (bdrv_get_type_hint(s->dinfo->bdrv) == BDRV_TYPE_CDROM) {
-                            outbuf[r->iov.iov_len++] = 5;
+                        if (bdrv_get_type_hint(bdrv) == BDRV_TYPE_CDROM) {
+                            outbuf[data_xfer_len++] = 5;
                         } else {
-                            outbuf[r->iov.iov_len++] = 0;
+                            outbuf[data_xfer_len++] = 0;
                         }
 
-                        outbuf[r->iov.iov_len++] = 0x80; // this page
-                        outbuf[r->iov.iov_len++] = 0x00;
-                        outbuf[r->iov.iov_len++] = l;
-                        memcpy(&outbuf[r->iov.iov_len], s->drive_serial_str, l);
-                        r->iov.iov_len += l;
+                        outbuf[data_xfer_len++] = 0x80; // this page
+                        outbuf[data_xfer_len++] = 0x00;
+                        outbuf[data_xfer_len++] = l;
+                        memcpy(&outbuf[data_xfer_len], serial_str, l);
+                        data_xfer_len += l;
                     }
 
                     break;
@@ -544,70 +535,67 @@ static int32_t scsi_send_command(SCSIDevice *d, uint32_t tag,
                     {
                         /* Device identification page, mandatory */
                         int max_len = 255 - 8;
-                        int id_len = strlen(bdrv_get_device_name(s->dinfo->bdrv));
+                        int id_len = strlen(bdrv_get_device_name(bdrv));
                         if (id_len > max_len)
                             id_len = max_len;
 
                         DPRINTF("Inquiry EVPD[Device identification] "
-                                "buffer size %d\n", len);
-                        r->iov.iov_len = 0;
-                        if (bdrv_get_type_hint(s->dinfo->bdrv) == BDRV_TYPE_CDROM) {
-                            outbuf[r->iov.iov_len++] = 5;
+                                "buffer size %d\n", datalen);
+                        data_xfer_len = 0;
+                        if (bdrv_get_type_hint(bdrv) == BDRV_TYPE_CDROM) {
+                            outbuf[data_xfer_len++] = 5;
                         } else {
-                            outbuf[r->iov.iov_len++] = 0;
+                            outbuf[data_xfer_len++] = 0;
                         }
 
-                        outbuf[r->iov.iov_len++] = 0x83; // this page
-                        outbuf[r->iov.iov_len++] = 0x00;
-                        outbuf[r->iov.iov_len++] = 3 + id_len;
+                        outbuf[data_xfer_len++] = 0x83; // this page
+                        outbuf[data_xfer_len++] = 0x00;
+                        outbuf[data_xfer_len++] = 4 + id_len;
 
-                        outbuf[r->iov.iov_len++] = 0x2; // ASCII
-                        outbuf[r->iov.iov_len++] = 0;   // not officially assigned
-                        outbuf[r->iov.iov_len++] = 0;   // reserved
-                        outbuf[r->iov.iov_len++] = id_len; // length of data following
+                        outbuf[data_xfer_len++] = 0x2; // ASCII
+                        outbuf[data_xfer_len++] = 0;   // not officially assigned
+                        outbuf[data_xfer_len++] = 0;   // reserved
+                        outbuf[data_xfer_len++] = id_len; // length of data following
 
-                        memcpy(&outbuf[r->iov.iov_len],
-                               bdrv_get_device_name(s->dinfo->bdrv), id_len);
-                        r->iov.iov_len += id_len;
+                        memcpy(&outbuf[data_xfer_len],
+                               bdrv_get_device_name(bdrv), id_len);
+                        data_xfer_len += id_len;
                     }
                     break;
                 default:
                     BADF("Error: unsupported Inquiry (EVPD[%02X]) "
-                         "buffer size %d\n", page_code, len);
-                    goto fail;
+                         "buffer size %d\n", page_code, datalen);
+                    goto invalid_cdb;
             }
             /* done with EVPD */
             break;
         }
         else {
             /* Standard INQUIRY data */
-            if (buf[2] != 0) {
+            if (cdb[2] != 0) {
                 BADF("Error: Inquiry (STANDARD) page or code "
-                     "is non-zero [%02X]\n", buf[2]);
-                goto fail;
+                     "is non-zero [%02X]\n", cdb[2]);
+                goto invalid_cdb;
             }
 
             /* PAGE CODE == 0 */
-            if (len < 5) {
+            if (datalen < 5) {
                 BADF("Error: Inquiry (STANDARD) buffer size %d "
-                     "is less than 5\n", len);
-                goto fail;
+                     "is less than 5\n", datalen);
+                goto invalid_cdb;
             }
 
-            if (len < 36) {
+            if (datalen < 36) {
                 BADF("Error: Inquiry (STANDARD) buffer size %d "
-                     "is less than 36 (TODO: only 5 required)\n", len);
+                     "is less than 36 (TODO: only 5 required)\n", datalen);
             }
         }
 
-        if(len > SCSI_MAX_INQUIRY_LEN)
-            len = SCSI_MAX_INQUIRY_LEN;
-
-        memset(outbuf, 0, len);
+        memset(outbuf, 0, 36);
 
-        if (lun || buf[1] >> 5) {
+        if (!bdrv || cdb[1] >> 5) {
             outbuf[0] = 0x7f;	/* LUN not supported */
-	} else if (bdrv_get_type_hint(s->dinfo->bdrv) == BDRV_TYPE_CDROM) {
+	} else if (bdrv_get_type_hint(bdrv) == BDRV_TYPE_CDROM) {
 	    outbuf[0] = 5;
             outbuf[1] = 0x80;
 	    memcpy(&outbuf[16], "QEMU CD-ROM    ", 16);
@@ -621,42 +609,32 @@ static int32_t scsi_send_command(SCSIDevice *d, uint32_t tag,
            Some later commands are also implemented. */
 	outbuf[2] = 3;
 	outbuf[3] = 2; /* Format 2 */
-	outbuf[4] = len - 5; /* Additional Length = (Len - 1) - 4 */
+	outbuf[4] = datalen - 5; /* Additional Length = (Len - 1) - 4 */
         /* Sync data transfer and TCQ.  */
-        outbuf[7] = 0x10 | (r->bus->tcq ? 0x02 : 0);
-	r->iov.iov_len = len;
+	outbuf[7] = 0x10 | (bdrv_get_tcq(bdrv) ? 0x02 : 0);
+	data_xfer_len = 36;
 	break;
-    case 0x16:
-        DPRINTF("Reserve(6)\n");
-        if (buf[1] & 1)
-            goto fail;
-        break;
-    case 0x17:
-        DPRINTF("Release(6)\n");
-        if (buf[1] & 1)
-            goto fail;
-        break;
     case 0x1a:
     case 0x5a:
         {
             uint8_t *p;
             int page;
-            int dbd;
+	    int dbd;
             
-            dbd = buf[1]  & 0x8;
-            page = buf[2] & 0x3f;
-            DPRINTF("Mode Sense (page %d, len %d)\n", page, len);
+            dbd = cdb[1]  & 0x8;
+            page = cdb[2] & 0x3f;
+            DPRINTF("Mode Sense (page %d, len %d)\n", page, datalen);
             p = outbuf;
             memset(p, 0, 4);
             outbuf[1] = 0; /* Default media type.  */
             outbuf[3] = 0; /* Block descriptor length.  */
-            if (bdrv_get_type_hint(s->dinfo->bdrv) == BDRV_TYPE_CDROM) {
+            if (bdrv_get_type_hint(bdrv) == BDRV_TYPE_CDROM) {
                 outbuf[2] = 0x80; /* Readonly.  */
             }
             p += 4;
-            bdrv_get_geometry(s->dinfo->bdrv, &nb_sectors);
+            bdrv_get_geometry(bdrv, &nb_sectors);
             if ((~dbd) & nb_sectors) {
-                nb_sectors /= s->cluster_size;
+                nb_sectors /= cluster_size;
                 nb_sectors--;
                 if (nb_sectors > 0xffffff)
                     nb_sectors = 0xffffff;
@@ -667,7 +645,7 @@ static int32_t scsi_send_command(SCSIDevice *d, uint32_t tag,
                 p[3] = nb_sectors & 0xff;
                 p[4] = 0; /* reserved */
                 p[5] = 0; /* bytes 5-7 are the sector size in bytes */
-                p[6] = s->cluster_size * 2;
+                p[6] = cluster_size * 2;
                 p[7] = 0;
                 p += 8;
             }
@@ -679,7 +657,7 @@ static int32_t scsi_send_command(SCSIDevice *d, uint32_t tag,
                 p[0] = 4;
                 p[1] = 0x16;
                 /* if a geometry hint is available, use it */
-                bdrv_get_geometry_hint(s->dinfo->bdrv, &cylinders, &heads, &secs);
+                bdrv_get_geometry_hint(bdrv, &cylinders, &heads, &secs);
                 p[2] = (cylinders >> 16) & 0xff;
                 p[3] = (cylinders >> 8) & 0xff;
                 p[4] = cylinders & 0xff;
@@ -713,10 +691,10 @@ static int32_t scsi_send_command(SCSIDevice *d, uint32_t tag,
                 p[2] = 5000 >> 8;
                 p[3] = 5000 & 0xff;
                 /* if a geometry hint is available, use it */
-                bdrv_get_geometry_hint(s->dinfo->bdrv, &cylinders, &heads, &secs);
+                bdrv_get_geometry_hint(bdrv, &cylinders, &heads, &secs);
                 p[4] = heads & 0xff;
                 p[5] = secs & 0xff;
-                p[6] = s->cluster_size * 2;
+                p[6] = cluster_size * 2;
                 p[8] = (cylinders >> 8) & 0xff;
                 p[9] = cylinders & 0xff;
                 /* Write precomp start cylinder, disabled */
@@ -746,13 +724,13 @@ static int32_t scsi_send_command(SCSIDevice *d, uint32_t tag,
                 memset(p,0,20);
                 p[0] = 8;
                 p[1] = 0x12;
-                if (bdrv_enable_write_cache(s->dinfo->bdrv)) {
+                if (bdrv_enable_write_cache(bdrv)) {
                      p[2] = 4; /* WCE */
                 }
                 p += 20;
             }
             if ((page == 0x3f || page == 0x2a)
-                    && (bdrv_get_type_hint(s->dinfo->bdrv) == BDRV_TYPE_CDROM)) {
+                    && (bdrv_get_type_hint(bdrv) == BDRV_TYPE_CDROM)) {
                 /* CD Capabilities and Mechanical Status page. */
                 p[0] = 0x2a;
                 p[1] = 0x14;
@@ -763,7 +741,7 @@ static int32_t scsi_send_command(SCSIDevice *d, uint32_t tag,
                 p[5] = 0xff; /* CD DA, DA accurate, RW supported,
                                          RW corrected, C2 errors, ISRC,
                                          UPC, Bar code */
-                p[6] = 0x2d | (bdrv_is_locked(s->dinfo->bdrv)? 2 : 0);
+                p[6] = 0x2d | (bdrv_is_locked(bdrv)? 2 : 0);
                 /* Locking supported, jumper present, eject, tray */
                 p[7] = 0; /* no volume & mute control, no
                                       changer */
@@ -781,34 +759,32 @@ static int32_t scsi_send_command(SCSIDevice *d, uint32_t tag,
                 p[21] = (16 * 176) & 0xff;
                 p += 22;
             }
-            r->iov.iov_len = p - outbuf;
-            outbuf[0] = r->iov.iov_len - 4;
-            if (r->iov.iov_len > len)
-                r->iov.iov_len = len;
+            data_xfer_len = p - outbuf;
+            outbuf[0] = data_xfer_len - 4;
+            if (data_xfer_len > datalen)
+                data_xfer_len = datalen;
         }
         break;
     case 0x1b:
         DPRINTF("Start Stop Unit\n");
-        if (bdrv_get_type_hint(s->dinfo->bdrv) == BDRV_TYPE_CDROM &&
-            (buf[4] & 2))
+	if (bdrv_get_type_hint(bdrv) == BDRV_TYPE_CDROM &&
+            (cdb[4] & 2))
             /* load/eject medium */
-            bdrv_eject(s->dinfo->bdrv, !(buf[4] & 1));
+            bdrv_eject(bdrv, !(cdb[4] & 1));
 	break;
     case 0x1e:
-        DPRINTF("Prevent Allow Medium Removal (prevent = %d)\n", buf[4] & 3);
-        bdrv_set_locked(s->dinfo->bdrv, buf[4] & 1);
+        DPRINTF("Prevent Allow Medium Removal (prevent = %d)\n", cdb[4] & 3);
+        bdrv_set_locked(bdrv, cdb[4] & 1);
 	break;
     case 0x25:
 	DPRINTF("Read Capacity\n");
         /* The normal LEN field for this command is zero.  */
 	memset(outbuf, 0, 8);
-	bdrv_get_geometry(s->dinfo->bdrv, &nb_sectors);
-        nb_sectors /= s->cluster_size;
+	bdrv_get_geometry(bdrv, &nb_sectors);
+        nb_sectors /= cluster_size;
         /* Returned value is the address of the last sector.  */
         if (nb_sectors) {
             nb_sectors--;
-            /* Remember the new size for read/write sanity checking. */
-            s->max_lba = nb_sectors;
             /* Clip to 2TB, instead of returning capacity modulo 2TB. */
             if (nb_sectors > UINT32_MAX)
                 nb_sectors = UINT32_MAX;
@@ -818,48 +794,23 @@ static int32_t scsi_send_command(SCSIDevice *d, uint32_t tag,
             outbuf[3] = nb_sectors & 0xff;
             outbuf[4] = 0;
             outbuf[5] = 0;
-            outbuf[6] = s->cluster_size * 2;
+            outbuf[6] = cluster_size * 2;
             outbuf[7] = 0;
-            r->iov.iov_len = 8;
-        } else {
-        notready:
-            scsi_command_complete(r, STATUS_CHECK_CONDITION, SENSE_NOT_READY);
-            return 0;
+            data_xfer_len = 8;
+	} else {
+	    return SENSE_LUN_NOT_READY;
         }
 	break;
-    case 0x08:
-    case 0x28:
-    case 0x88:
-        DPRINTF("Read (sector %" PRId64 ", count %d)\n", lba, len);
-        if (lba > s->max_lba)
-            goto illegal_lba;
-        r->sector = lba * s->cluster_size;
-        r->sector_count = len * s->cluster_size;
-        break;
-    case 0x0a:
-    case 0x2a:
-    case 0x8a:
-        DPRINTF("Write (sector %" PRId64 ", count %d)\n", lba, len);
-        if (lba > s->max_lba)
-            goto illegal_lba;
-        r->sector = lba * s->cluster_size;
-        r->sector_count = len * s->cluster_size;
-        is_write = 1;
-        break;
-    case 0x35:
-        DPRINTF("Synchronise cache (sector %" PRId64 ", count %d)\n", lba, len);
-        bdrv_flush(s->dinfo->bdrv);
-        break;
     case 0x43:
         {
-            int start_track, format, msf, toclen;
+	    int start_track, format, msf, toclen;
 
-            msf = buf[1] & 2;
-            format = buf[2] & 0xf;
-            start_track = buf[6];
-            bdrv_get_geometry(s->dinfo->bdrv, &nb_sectors);
+            msf = cdb[1] & 2;
+            format = cdb[2] & 0xf;
+            start_track = cdb[6];
+            bdrv_get_geometry(bdrv, &nb_sectors);
             DPRINTF("Read TOC (track %d format %d msf %d)\n", start_track, format, msf >> 1);
-            nb_sectors /= s->cluster_size;
+            nb_sectors /= cluster_size;
             switch(format) {
             case 0:
                 toclen = cdrom_read_toc(nb_sectors, outbuf, msf, start_track);
@@ -879,45 +830,34 @@ static int32_t scsi_send_command(SCSIDevice *d, uint32_t tag,
                 goto error_cmd;
             }
             if (toclen > 0) {
-                if (len > toclen)
-                  len = toclen;
-                r->iov.iov_len = len;
+                if (datalen > toclen)
+                  datalen = toclen;
+                data_xfer_len = datalen;
                 break;
             }
         error_cmd:
             DPRINTF("Read TOC error\n");
-            goto fail;
+	    status = SENSE_TARGET_FAILURE;
         }
     case 0x46:
-        DPRINTF("Get Configuration (rt %d, maxlen %d)\n", buf[1] & 3, len);
+        DPRINTF("Get Configuration (rt %d, maxlen %d)\n", cdb[1] & 3, datalen);
         memset(outbuf, 0, 8);
         /* ??? This should probably return much more information.  For now
            just return the basic header indicating the CD-ROM profile.  */
         outbuf[7] = 8; // CD-ROM
-        r->iov.iov_len = 8;
-        break;
-    case 0x56:
-        DPRINTF("Reserve(10)\n");
-        if (buf[1] & 3)
-            goto fail;
-        break;
-    case 0x57:
-        DPRINTF("Release(10)\n");
-        if (buf[1] & 3)
-            goto fail;
+        data_xfer_len = 8;
         break;
     case 0x9e:
         /* Service Action In subcommands. */
-        if ((buf[1] & 31) == 0x10) {
+        if ((cdb[1] & 31) == 0x10) {
             DPRINTF("SAI READ CAPACITY(16)\n");
-            memset(outbuf, 0, len);
-            bdrv_get_geometry(s->dinfo->bdrv, &nb_sectors);
-            nb_sectors /= s->cluster_size;
+            memset(outbuf, 0, datalen);
+            bdrv_get_geometry(bdrv, &nb_sectors);
+            nb_sectors /= cluster_size;
             /* Returned value is the address of the last sector.  */
             if (nb_sectors) {
                 nb_sectors--;
                 /* Remember the new size for read/write sanity checking. */
-                s->max_lba = nb_sectors;
                 outbuf[0] = (nb_sectors >> 56) & 0xff;
                 outbuf[1] = (nb_sectors >> 48) & 0xff;
                 outbuf[2] = (nb_sectors >> 40) & 0xff;
@@ -928,42 +868,140 @@ static int32_t scsi_send_command(SCSIDevice *d, uint32_t tag,
                 outbuf[7] = nb_sectors & 0xff;
                 outbuf[8] = 0;
                 outbuf[9] = 0;
-                outbuf[10] = s->cluster_size * 2;
+                outbuf[10] = cluster_size * 2;
                 outbuf[11] = 0;
                 /* Protection, exponent and lowest lba field left blank. */
-                r->iov.iov_len = len;
+                data_xfer_len = 12;
             } else {
-                scsi_command_complete(r, STATUS_CHECK_CONDITION, SENSE_NOT_READY);
-                return 0;
+		status = SENSE_LUN_NOT_READY;
             }
-            break;
-        }
-        DPRINTF("Unsupported Service Action In\n");
-        goto fail;
+	} else {
+	    DPRINTF("Unsupported Service Action In\n");
+	  invalid_cdb:
+	    status = SENSE_INVALID_FIELD;
+	}
+	break;
+    default:
+	DPRINTF("Unknown SCSI command (%2.2x)\n", buf[0]);
+	status = SENSE_INVALID_OPCODE;
+	break;
+    }
+    *out_len = data_xfer_len;
+
+    return status;
+}
+
+/* Execute a scsi command.  Returns the length of the data expected by the
+   command.  This will be Positive for data transfers from the device
+   (eg. disk reads), negative for transfers to the device (eg. disk writes),
+   and zero if the command does not transfer any data.  */
+
+static int32_t scsi_send_command(SCSIDevice *d, uint32_t tag,
+                                 uint8_t *buf, int lun)
+{
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, d);
+    uint64_t lba;
+    uint32_t len = 0;
+    uint32_t sense = 0;
+    int is_write;
+    uint8_t command;
+    uint8_t *outbuf;
+    SCSIRequest *r;
+
+    command = buf[0];
+    r = scsi_find_request(s, tag);
+    if (r) {
+        BADF("Tag 0x%x already in use\n", tag);
+        scsi_cancel_io(d, tag);
+    }
+    is_write = 0;
+    /* ??? Tags are not unique for different luns.  We only implement a
+       single lun, so this should not matter.  */
+    r = scsi_new_request(d, tag);
+    outbuf = scsi_allocate_iovec(r);
+    if (!outbuf) {
+	sense = SENSE_TARGET_FAILURE;
+	goto check_condition;
+    }
+
+    DPRINTF("Command: lun=%d tag=0x%x data=0x%02x", lun, tag, buf[0]);
+
+    if (!scsi_check_cdb_len(buf, &len, &lba)) {
+	/* Return INVALID COMMAND OPCODE */
+	sense = SENSE_INVALID_OPCODE;
+	goto check_condition;
+    }
+
+    if (lun || buf[1] >> 5) {
+        /* Only LUN 0 supported.  */
+	DPRINTF("Unimplemented LUN %d\n", lun ? lun : buf[1] >> 5);
+	if (command != 0x03 && command != 0x12) {
+	    sense = SENSE_LUN_NOT_SUPPORTED;
+            goto check_condition;
+	}
+    }
+
+    switch (command) {
+    case 0x03:
+        DPRINTF("Request Sense (len %d)\n", len);
+	r->iov->iov_len = s->sense_len > len ? len : s->sense_len;
+	if (r->iov->iov_len)
+	    memcpy(outbuf, s->sense, r->iov->iov_len);
+	s->sense_len = 0;
+        break;
+    case 0x08:
+    case 0x28:
+    case 0x88:
+        DPRINTF("Read (sector %" PRId64 ", count %d)\n", lba, len);
+	if (lba > s->max_lba) {
+	    sense = SENSE_LBA_OUT_OF_RANGE;
+            goto check_condition;
+	}
+        r->sector = lba * s->cluster_size;
+        r->sector_count = len * s->cluster_size;
+        break;
+    case 0x0a:
+    case 0x2a:
+    case 0x8a:
+        DPRINTF("Write (sector %" PRId64 ", count %d)\n", lba, len);
+	if (lba > s->max_lba) {
+	    sense = SENSE_LBA_OUT_OF_RANGE;
+            goto check_condition;
+	}
+        r->sector = lba * s->cluster_size;
+        r->sector_count = len * s->cluster_size;
+        is_write = 1;
+        break;
+    case 0x35:
+        DPRINTF("Synchronise cache (sector %" PRId64 ", count %d)\n", lba, len);
+        bdrv_flush(s->dinfo->bdrv);
+        break;
     case 0xa0:
         DPRINTF("Report LUNs (len %d)\n", len);
-        if (len < 16)
-            goto fail;
+	if (len < 16) {
+	    sense = SENSE_INVALID_FIELD;
+            goto check_condition;
+	}
         memset(outbuf, 0, 16);
         outbuf[3] = 8;
-        r->iov.iov_len = 16;
-        break;
-    case 0x2f:
-        DPRINTF("Verify (sector %" PRId64 ", count %d)\n", lba, len);
+        r->iov->iov_len = 16;
         break;
     default:
-	DPRINTF("Unknown SCSI command (%2.2x)\n", buf[0]);
-    fail:
-        scsi_command_complete(r, STATUS_CHECK_CONDITION, SENSE_ILLEGAL_REQUEST);
+	sense = scsi_emulate_command(s->dinfo->bdrv, lun, buf, len,
+				      r->iov->iov_base, &len);
+	break;
+    }
+check_condition:
+    r->iov->iov_len = len;
+    if (sense) {
+	scsi_command_complete(r, STATUS_CHECK_CONDITION, sense);
 	return 0;
-    illegal_lba:
-        scsi_command_complete(r, STATUS_CHECK_CONDITION, SENSE_HARDWARE_ERROR);
-        return 0;
     }
-    if (r->sector_count == 0 && r->iov.iov_len == 0) {
-        scsi_command_complete(r, STATUS_GOOD, SENSE_NO_SENSE);
+    if (r->sector_count == 0 && r->iov->iov_len == 0) {
+	s->sense_len = 0;
+	scsi_command_complete(r, STATUS_GOOD, 0);
     }
-    len = r->sector_count * 512 + r->iov.iov_len;
+    len = r->sector_count * 512 + r->iov->iov_len;
     if (is_write) {
         return -len;
     } else {
diff --git a/hw/scsi-disk.h b/hw/scsi-disk.h
index 5b54272..4ac8ac6 100644
--- a/hw/scsi-disk.h
+++ b/hw/scsi-disk.h
@@ -80,6 +80,9 @@ static inline SCSIBus *scsi_bus_from_device(SCSIDevice *d)
 
 SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, DriveInfo *dinfo, int unit);
 void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
+int32_t scsi_emulate_command(BlockDriverState *bdrv,
+                             int lun, uint8_t *cdb, int datalen,
+                             uint8_t *outbuf, uint32_t *out_len);
 int32_t scsi_build_sense(uint8_t *sense_buf, uint32_t sense);
 
 #endif
-- 
1.6.0.2
