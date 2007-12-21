From: Dor Laor <dor.laor@gmail.com>
Subject: [Virtio-for-kvm] [PATCH 3/7] userspace virtio
Date: Fri, 21 Dec 2007 16:43:50 +0200
Message-ID: <476BD126.7010600__26220.4345003285$1198248347$gmane$org@qumranet.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rus>
List-Id: virtualization@lists.linuxfoundation.org

 From 4780a4792ca7776268107e200ae77003c36d55c9 Mon Sep 17 00:00:00 2001
From: Dor Laor <dor.laor@qumranet.com>
Date: Wed, 19 Dec 2007 23:52:43 +0200
Subject: [PATCH] virtio block device

This patch implements the backend support for the virtio block device.  It's
designed to support in-order queueing of a virtually unlimited size so 
it will
be able to perform better than SCSI.  Besides performance, the virtio block
interface passes through guest SCSI commands so it can be used to expose any
type of block device (although only normal disks are supported in this 
patch).

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Avi Kivity <avi@qumranet.com>
Cc: Dor Laor <dor.laor@qumranet.com>
---
 qemu/Makefile.target |    2 +-
 qemu/hw/pc.c         |   12 ++++
 qemu/hw/pc.h         |    4 +
 qemu/hw/virtio-blk.c |  163 
++++++++++++++++++++++++++++++++++++++++++++++++++
 qemu/sysemu.h        |    2 +-
 qemu/vl.c            |    4 +
 6 files changed, 185 insertions(+), 2 deletions(-)
 create mode 100644 qemu/hw/virtio-blk.c

diff --git a/qemu/Makefile.target b/qemu/Makefile.target
index 17ff6f2..535f4f5 100644
--- a/qemu/Makefile.target
+++ b/qemu/Makefile.target
@@ -464,7 +464,7 @@ VL_OBJS += rtl8139.o
 VL_OBJS+= hypercall.o
 
 # virtio devices
-VL_OBJS += virtio.o virtio-net.o
+VL_OBJS += virtio.o virtio-net.o virtio-blk.o
 
 ifeq ($(TARGET_BASE_ARCH), i386)
 # Hardware support
diff --git a/qemu/hw/pc.c b/qemu/hw/pc.c
index dde40c3..003d15d 100644
--- a/qemu/hw/pc.c
+++ b/qemu/hw/pc.c
@@ -1103,6 +1103,18 @@ static void pc_init1(ram_addr_t ram_size, int 
vga_ram_size,
         }
         }
     }
+
+    /* Add virtio block devices */
+    if (pci_enabled) {
+    int index;
+    int unit_id = 0;
+
+    while ((index = drive_get_index(IF_VIRTIO, 0, unit_id)) != -1) {
+        virtio_blk_init(pci_bus, 0x5002, 0x2258,
+                drives_table[index].bdrv);
+        unit_id++;
+    }
+    }
 }
 
 static void pc_init_pci(ram_addr_t ram_size, int vga_ram_size,
diff --git a/qemu/hw/pc.h b/qemu/hw/pc.h
index ce1a1f3..95471f3 100644
--- a/qemu/hw/pc.h
+++ b/qemu/hw/pc.h
@@ -147,4 +147,8 @@ void isa_ne2000_init(int base, qemu_irq irq, NICInfo 
*nd);
 void *virtio_net_init(PCIBus *bus, NICInfo *nd, int devfn);
 
 
+/* virtio-blk.h */
+void *virtio_blk_init(PCIBus *bus, uint16_t vendor, uint16_t device,
+              BlockDriverState *bs);
+
 #endif
diff --git a/qemu/hw/virtio-blk.c b/qemu/hw/virtio-blk.c
new file mode 100644
index 0000000..0ae3592
--- /dev/null
+++ b/qemu/hw/virtio-blk.c
@@ -0,0 +1,163 @@
+/*
+ * Virtio Block Device
+ *
+ * Copyright IBM, Corp. 2007
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include "virtio.h"
+#include "block.h"
+#include "pc.h"
+
+/* from Linux's linux/virtio_blk.h */
+
+/* The ID for virtio_block */
+#define VIRTIO_ID_BLOCK    2
+
+/* Feature bits */
+#define VIRTIO_BLK_F_BARRIER    0    /* Does host support barriers? */
+#define VIRTIO_BLK_F_SIZE_MAX    1    /* Indicates maximum segment size */
+#define VIRTIO_BLK_F_SEG_MAX    2    /* Indicates maximum # of segments */
+
+struct virtio_blk_config
+{
+    uint64_t capacity;
+    uint32_t size_max;
+    uint32_t seg_max;
+};
+
+/* These two define direction. */
+#define VIRTIO_BLK_T_IN        0
+#define VIRTIO_BLK_T_OUT    1
+
+/* This bit says it's a scsi command, not an actual read or write. */
+#define VIRTIO_BLK_T_SCSI_CMD    2
+
+/* Barrier before this op. */
+#define VIRTIO_BLK_T_BARRIER    0x80000000
+
+/* This is the first element of the read scatter-gather list. */
+struct virtio_blk_outhdr
+{
+    /* VIRTIO_BLK_T* */
+    uint32_t type;
+    /* io priority. */
+    uint32_t ioprio;
+    /* Sector (ie. 512 byte offset) */
+    uint64_t sector;
+    /* Where to put reply. */
+    uint64_t id;
+};
+
+#define VIRTIO_BLK_S_OK        0
+#define VIRTIO_BLK_S_IOERR    1
+#define VIRTIO_BLK_S_UNSUPP    2
+
+/* This is the first element of the write scatter-gather list */
+struct virtio_blk_inhdr
+{
+    unsigned char status;
+};
+
+typedef struct VirtIOBlock
+{
+    VirtIODevice vdev;
+    BlockDriverState *bs;
+} VirtIOBlock;
+
+static VirtIOBlock *to_virtio_blk(VirtIODevice *vdev)
+{
+    return (VirtIOBlock *)vdev;
+}
+
+static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOBlock *s = to_virtio_blk(vdev);
+    VirtQueueElement elem;
+    unsigned int count;
+
+    while ((count = virtqueue_pop(vq, &elem)) != 0) {
+    struct virtio_blk_inhdr *in;
+    struct virtio_blk_outhdr *out;
+    unsigned int wlen;
+    off_t off;
+    int i;
+
+    out = (void *)elem.out_sg[0].iov_base;
+    in = (void *)elem.in_sg[elem.in_num - 1].iov_base;
+    off = out->sector;
+
+    if (out->type & VIRTIO_BLK_T_SCSI_CMD) {
+        wlen = sizeof(*in);
+        in->status = VIRTIO_BLK_S_UNSUPP;
+    } else if (out->type & VIRTIO_BLK_T_OUT) {
+        wlen = sizeof(*in);
+
+        for (i = 1; i < elem.out_num; i++) {
+        bdrv_write(s->bs, off,
+               elem.out_sg[i].iov_base,
+               elem.out_sg[i].iov_len / 512);
+        off += elem.out_sg[i].iov_len / 512;
+        }
+
+        in->status = VIRTIO_BLK_S_OK;
+    } else {
+        wlen = sizeof(*in);
+
+        for (i = 0; i < elem.in_num - 1; i++) {
+        bdrv_read(s->bs, off,
+              elem.in_sg[i].iov_base,
+              elem.in_sg[i].iov_len / 512);
+        off += elem.in_sg[i].iov_len / 512;
+        wlen += elem.in_sg[i].iov_len;
+        }
+
+        in->status = VIRTIO_BLK_S_OK;
+    }
+
+    virtqueue_push(vq, &elem, wlen);
+    virtio_notify(vdev, vq);
+    }
+}
+
+static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VirtIOBlock *s = to_virtio_blk(vdev);
+    struct virtio_blk_config blkcfg;
+    int64_t capacity;
+
+    bdrv_get_geometry(s->bs, &capacity);
+    blkcfg.capacity = capacity;
+    blkcfg.seg_max = 128 - 2;
+    memcpy(config, &blkcfg, sizeof(blkcfg));
+}
+
+static uint32_t virtio_blk_get_features(VirtIODevice *vdev)
+{
+    return (1 << VIRTIO_BLK_F_SEG_MAX);
+}
+
+void *virtio_blk_init(PCIBus *bus, uint16_t vendor, uint16_t device,
+              BlockDriverState *bs)
+{
+    VirtIOBlock *s;
+
+    s = (VirtIOBlock *)virtio_init_pci(bus, "virtio-blk", 6900, 0x1001,
+                       0, VIRTIO_ID_BLOCK,
+                       0x01, 0x80, 0x00,
+                       16, sizeof(VirtIOBlock));
+
+    s->vdev.update_config = virtio_blk_update_config;
+    s->vdev.get_features = virtio_blk_get_features;
+    s->bs = bs;
+
+    virtio_add_queue(&s->vdev, 128, virtio_blk_handle_output);
+
+    return &s->vdev;
+}
diff --git a/qemu/sysemu.h b/qemu/sysemu.h
index 1f5b093..e20159d 100644
--- a/qemu/sysemu.h
+++ b/qemu/sysemu.h
@@ -117,7 +117,7 @@ extern unsigned int nb_prom_envs;
 #endif
 
 typedef enum {
-    IF_IDE, IF_SCSI, IF_FLOPPY, IF_PFLASH, IF_MTD, IF_SD
+    IF_IDE, IF_SCSI, IF_FLOPPY, IF_PFLASH, IF_MTD, IF_SD, IF_VIRTIO
 } BlockInterfaceType;
 
 typedef struct DriveInfo {
diff --git a/qemu/vl.c b/qemu/vl.c
index 28c5df4..26055a4 100644
--- a/qemu/vl.c
+++ b/qemu/vl.c
@@ -4970,6 +4970,9 @@ static int drive_init(const char *str, int 
snapshot, QEMUMachine *machine)
     } else if (!strcmp(buf, "sd")) {
         interface = IF_SD;
             max_devs = 0;
+    } else if (!strcmp(buf, "virtio")) {
+        interface = IF_VIRTIO;
+        max_devs = 0;
     } else {
             fprintf(stderr, "qemu: '%s' unsupported bus type '%s'\n", 
str, buf);
             return -1;
@@ -5143,6 +5146,7 @@ static int drive_init(const char *str, int 
snapshot, QEMUMachine *machine)
         break;
     case IF_PFLASH:
     case IF_MTD:
+    case IF_VIRTIO:
         break;
     }
     if (!file[0])
-- 
1.5.3.3
