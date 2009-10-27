From: hare@suse.de (Hannes Reinecke)
Subject: [PATCH 1/4] Add 'raid' interface class
Date: Tue, 27 Oct 2009 16:28:41 +0100
Message-ID: <20091027152842.001C33967A__21569.7717656896$1256657649$gmane$org@ochil.suse.de>
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


This patch adds a 'raid' interface class. It is basically a clone
of the existing 'scsi' interface, only allowing up to 128 disks.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 hw/pc.c          |    5 +++++
 hw/pci-hotplug.c |    1 +
 hw/scsi-disk.c   |   17 +++++++++++++++++
 hw/scsi-disk.h   |   20 +++++++++++++++++++-
 qemu-config.c    |    2 +-
 sysemu.h         |    3 ++-
 vl.c             |    8 ++++++--
 7 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/hw/pc.c b/hw/pc.c
index 83012a9..26aad4c 100644
--- a/hw/pc.c
+++ b/hw/pc.c
@@ -1345,6 +1345,11 @@ static void pc_init1(ram_addr_t ram_size,
 	for (bus = 0; bus <= max_bus; bus++) {
             pci_create_simple(pci_bus, -1, "lsi53c895a");
         }
+
+	max_bus = drive_get_max_bus(IF_RAID);
+	for (bus = 0; bus <= max_bus; bus++) {
+	    pci_create_simple(pci_bus, -1, "megasas");
+	}
     }
 
     if (extboot_drive) {
diff --git a/hw/pci-hotplug.c b/hw/pci-hotplug.c
index 410fa3f..855a1ad 100644
--- a/hw/pci-hotplug.c
+++ b/hw/pci-hotplug.c
@@ -85,6 +85,7 @@ void drive_hot_add(Monitor *mon, const QDict *qdict)
 
     switch (type) {
     case IF_SCSI:
+    case IF_RAID:
         if (pci_read_devaddr(mon, pci_addr, &dom, &pci_bus, &slot)) {
             goto err;
         }
diff --git a/hw/scsi-disk.c b/hw/scsi-disk.c
index 2a9268a..68b4e83 100644
--- a/hw/scsi-disk.c
+++ b/hw/scsi-disk.c
@@ -41,6 +41,7 @@ do { fprintf(stderr, "scsi-disk: " fmt , ## __VA_ARGS__); } while (0)
 
 #define SCSI_DMA_BUF_SIZE    131072
 #define SCSI_MAX_INQUIRY_LEN 256
+#define SCSI_SENSE_LEN 18
 
 #define SCSI_REQ_STATUS_RETRY 0x01
 
@@ -136,6 +137,22 @@ static SCSIRequest *scsi_find_request(SCSIDiskState *s, uint32_t tag)
     return r;
 }
 
+/* Helper function to build a sense block */
+int32_t scsi_build_sense(uint8_t *sense_buf, uint32_t sense)
+{
+    memset(sense_buf, 0, SCSI_SENSE_LEN);
+    if (!sense)
+       return 0;
+
+    sense_buf[0] = 0xf0; /* current, fixed format */
+    sense_buf[2] = (sense >> 16) & 0x0F;
+    sense_buf[7] = 10;
+    sense_buf[12] = (sense >> 8 ) & 0xFF;
+    sense_buf[13] = sense & 0xFF;
+
+    return SCSI_SENSE_LEN;
+}
+
 /* Helper function for command completion.  */
 static void scsi_command_complete(SCSIRequest *r, int status, int sense)
 {
diff --git a/hw/scsi-disk.h b/hw/scsi-disk.h
index b6b6c12..5b54272 100644
--- a/hw/scsi-disk.h
+++ b/hw/scsi-disk.h
@@ -9,6 +9,23 @@ enum scsi_reason {
     SCSI_REASON_DATA  /* Transfer complete, more data required.  */
 };
 
+/* LUN not ready, Manual intervention required */
+#define SENSE_LUN_NOT_READY 0x020403
+/* Hardware error, I/O process terminated */
+#define SENSE_IO_ERROR 0x040006
+/* Hardware error, I_T Nexus loss occured */
+#define SENSE_TAG_NOT_FOUND 0x042907
+/* Hardware error, internal target failure */
+#define SENSE_TARGET_FAILURE 0x044400
+/* Illegal request, invalid command operation code */
+#define SENSE_INVALID_OPCODE 0x052000
+/* Illegal request, LBA out of range */
+#define SENSE_LBA_OUT_OF_RANGE 0x052100
+/* Illegal request, Invalid field in CDB */
+#define SENSE_INVALID_FIELD 0x052400
+/* Illegal request, LUN not supported */
+#define SENSE_LUN_NOT_SUPPORTED 0x052500
+
 typedef struct SCSIBus SCSIBus;
 typedef struct SCSIDevice SCSIDevice;
 typedef struct SCSIDeviceInfo SCSIDeviceInfo;
@@ -49,7 +66,7 @@ struct SCSIBus {
     int tcq, ndev;
     scsi_completionfn complete;
 
-    SCSIDevice *devs[8];
+    SCSIDevice *devs[128];
 };
 
 void scsi_bus_new(SCSIBus *bus, DeviceState *host, int tcq, int ndev,
@@ -63,5 +80,6 @@ static inline SCSIBus *scsi_bus_from_device(SCSIDevice *d)
 
 SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, DriveInfo *dinfo, int unit);
 void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
+int32_t scsi_build_sense(uint8_t *sense_buf, uint32_t sense);
 
 #endif
diff --git a/qemu-config.c b/qemu-config.c
index 4fb7898..8d7a137 100644
--- a/qemu-config.c
+++ b/qemu-config.c
@@ -18,7 +18,7 @@ QemuOptsList qemu_drive_opts = {
         },{
             .name = "if",
             .type = QEMU_OPT_STRING,
-            .help = "interface (ide, scsi, sd, mtd, floppy, pflash, virtio)",
+            .help = "interface (ide, scsi, raid, sd, mtd, floppy, pflash, virtio)",
         },{
             .name = "index",
             .type = QEMU_OPT_NUMBER,
diff --git a/sysemu.h b/sysemu.h
index 2ef3797..8ed0b8c 100644
--- a/sysemu.h
+++ b/sysemu.h
@@ -159,7 +159,7 @@ extern unsigned int nb_prom_envs;
 
 typedef enum {
     IF_NONE,
-    IF_IDE, IF_SCSI, IF_FLOPPY, IF_PFLASH, IF_MTD, IF_SD, IF_VIRTIO, IF_XEN,
+    IF_IDE, IF_SCSI, IF_RAID, IF_FLOPPY, IF_PFLASH, IF_MTD, IF_SD, IF_VIRTIO, IF_XEN,
     IF_COUNT
 } BlockInterfaceType;
 
@@ -185,6 +185,7 @@ typedef struct DriveInfo {
 
 #define MAX_IDE_DEVS	2
 #define MAX_SCSI_DEVS	7
+#define MAX_RAID_DEVS	128
 #define MAX_DRIVES 32
 
 extern QTAILQ_HEAD(drivelist, DriveInfo) drives;
diff --git a/vl.c b/vl.c
index 5dc7b2b..404afc3 100644
--- a/vl.c
+++ b/vl.c
@@ -2065,6 +2065,9 @@ DriveInfo *drive_init(QemuOpts *opts, void *opaque,
         } else if (!strcmp(buf, "scsi")) {
 	    type = IF_SCSI;
             max_devs = MAX_SCSI_DEVS;
+        } else if (!strcmp(buf, "raid")) {
+	    type = IF_RAID;
+            max_devs = MAX_RAID_DEVS;
         } else if (!strcmp(buf, "floppy")) {
 	    type = IF_FLOPPY;
             max_devs = 0;
@@ -2190,7 +2193,7 @@ DriveInfo *drive_init(QemuOpts *opts, void *opaque,
 
     onerror = BLOCK_ERR_STOP_ENOSPC;
     if ((buf = qemu_opt_get(opts, "werror")) != NULL) {
-        if (type != IF_IDE && type != IF_SCSI && type != IF_VIRTIO) {
+        if (type != IF_IDE && type != IF_SCSI && type != IF_RAID && type != IF_VIRTIO) {
             fprintf(stderr, "werror is no supported by this format\n");
             return NULL;
         }
@@ -2273,7 +2276,7 @@ DriveInfo *drive_init(QemuOpts *opts, void *opaque,
     } else {
         /* no id supplied -> create one */
         dinfo->id = qemu_mallocz(32);
-        if (type == IF_IDE || type == IF_SCSI)
+        if (type == IF_IDE || type == IF_SCSI || type == IF_RAID)
             mediastr = (media == MEDIA_CDROM) ? "-cd" : "-hd";
         if (max_devs)
             snprintf(dinfo->id, 32, "%s%i%s%i",
@@ -2299,6 +2302,7 @@ DriveInfo *drive_init(QemuOpts *opts, void *opaque,
     switch(type) {
     case IF_IDE:
     case IF_SCSI:
+    case IF_RAID:
     case IF_XEN:
     case IF_NONE:
         switch(media) {
-- 
1.6.0.2
