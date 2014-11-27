From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v4 07/16] dataplane: allow virtio-1 devices
Date: Thu, 27 Nov 2014 16:16:40 +0100
Message-ID: <1417101409-29482-8-git-send-email-cornelia.huck__10927.1675385118$1417101528$gmane$org@de.ibm.com>
References: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Handle endianness conversion for virtio-1 virtqueues correctly.

Note that dataplane now needs to be built per-target.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/block/dataplane/virtio-blk.c               |    4 +-
 hw/scsi/virtio-scsi-dataplane.c               |    2 +-
 hw/virtio/Makefile.objs                       |    2 +-
 hw/virtio/dataplane/Makefile.objs             |    2 +-
 hw/virtio/dataplane/vring.c                   |   86 ++++++++++++++-----------
 include/hw/virtio/dataplane/vring-accessors.h |   75 +++++++++++++++++++++
 include/hw/virtio/dataplane/vring.h           |   14 +---
 7 files changed, 131 insertions(+), 54 deletions(-)
 create mode 100644 include/hw/virtio/dataplane/vring-accessors.h

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 1222a37..2d8cc15 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -16,7 +16,9 @@
 #include "qemu/iov.h"
 #include "qemu/thread.h"
 #include "qemu/error-report.h"
+#include "hw/virtio/virtio-access.h"
 #include "hw/virtio/dataplane/vring.h"
+#include "hw/virtio/dataplane/vring-accessors.h"
 #include "sysemu/block-backend.h"
 #include "hw/virtio/virtio-blk.h"
 #include "virtio-blk.h"
@@ -75,7 +77,7 @@ static void complete_request_vring(VirtIOBlockReq *req, unsigned char status)
     VirtIOBlockDataPlane *s = req->dev->dataplane;
     stb_p(&req->in->status, status);
 
-    vring_push(&req->dev->dataplane->vring, &req->elem,
+    vring_push(s->vdev, &req->dev->dataplane->vring, &req->elem,
                req->qiov.size + sizeof(*req->in));
 
     /* Suppress notification to guest by BH and its scheduled
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 03a1e8c..418d73b 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -94,7 +94,7 @@ void virtio_scsi_vring_push_notify(VirtIOSCSIReq *req)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(req->vring->parent);
 
-    vring_push(&req->vring->vring, &req->elem,
+    vring_push(vdev, &req->vring->vring, &req->elem,
                req->qsgl.size + req->resp_iov.size);
 
     if (vring_should_notify(vdev, &req->vring->vring)) {
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index d21c397..19b224a 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -2,7 +2,7 @@ common-obj-y += virtio-rng.o
 common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
 common-obj-y += virtio-bus.o
 common-obj-y += virtio-mmio.o
-common-obj-$(CONFIG_VIRTIO) += dataplane/
+obj-$(CONFIG_VIRTIO) += dataplane/
 
 obj-y += virtio.o virtio-balloon.o 
 obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
diff --git a/hw/virtio/dataplane/Makefile.objs b/hw/virtio/dataplane/Makefile.objs
index 9a8cfc0..753a9ca 100644
--- a/hw/virtio/dataplane/Makefile.objs
+++ b/hw/virtio/dataplane/Makefile.objs
@@ -1 +1 @@
-common-obj-y += vring.o
+obj-y += vring.o
diff --git a/hw/virtio/dataplane/vring.c b/hw/virtio/dataplane/vring.c
index a051775..0da8d6b 100644
--- a/hw/virtio/dataplane/vring.c
+++ b/hw/virtio/dataplane/vring.c
@@ -18,7 +18,9 @@
 #include "hw/hw.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
+#include "hw/virtio/virtio-access.h"
 #include "hw/virtio/dataplane/vring.h"
+#include "hw/virtio/dataplane/vring-accessors.h"
 #include "qemu/error-report.h"
 
 /* vring_map can be coupled with vring_unmap or (if you still have the
@@ -83,7 +85,7 @@ bool vring_setup(Vring *vring, VirtIODevice *vdev, int n)
     vring_init(&vring->vr, virtio_queue_get_num(vdev, n), vring_ptr, 4096);
 
     vring->last_avail_idx = virtio_queue_get_last_avail_idx(vdev, n);
-    vring->last_used_idx = vring->vr.used->idx;
+    vring->last_used_idx = vring_get_used_idx(vdev, vring);
     vring->signalled_used = 0;
     vring->signalled_used_valid = false;
 
@@ -104,7 +106,7 @@ void vring_teardown(Vring *vring, VirtIODevice *vdev, int n)
 void vring_disable_notification(VirtIODevice *vdev, Vring *vring)
 {
     if (!(vdev->guest_features[0] & (1 << VIRTIO_RING_F_EVENT_IDX))) {
-        vring->vr.used->flags |= VRING_USED_F_NO_NOTIFY;
+        vring_set_used_flags(vdev, vring, VRING_USED_F_NO_NOTIFY);
     }
 }
 
@@ -117,10 +119,10 @@ bool vring_enable_notification(VirtIODevice *vdev, Vring *vring)
     if (vdev->guest_features[0] & (1 << VIRTIO_RING_F_EVENT_IDX)) {
         vring_avail_event(&vring->vr) = vring->vr.avail->idx;
     } else {
-        vring->vr.used->flags &= ~VRING_USED_F_NO_NOTIFY;
+        vring_clear_used_flags(vdev, vring, VRING_USED_F_NO_NOTIFY);
     }
     smp_mb(); /* ensure update is seen before reading avail_idx */
-    return !vring_more_avail(vring);
+    return !vring_more_avail(vdev, vring);
 }
 
 /* This is stolen from linux/drivers/vhost/vhost.c:vhost_notify() */
@@ -134,12 +136,13 @@ bool vring_should_notify(VirtIODevice *vdev, Vring *vring)
     smp_mb();
 
     if ((vdev->guest_features[0] & VIRTIO_F_NOTIFY_ON_EMPTY) &&
-        unlikely(vring->vr.avail->idx == vring->last_avail_idx)) {
+        unlikely(!vring_more_avail(vdev, vring))) {
         return true;
     }
 
     if (!(vdev->guest_features[0] & VIRTIO_RING_F_EVENT_IDX)) {
-        return !(vring->vr.avail->flags & VRING_AVAIL_F_NO_INTERRUPT);
+        return !(vring_get_avail_flags(vdev, vring) &
+                 VRING_AVAIL_F_NO_INTERRUPT);
     }
     old = vring->signalled_used;
     v = vring->signalled_used_valid;
@@ -154,15 +157,18 @@ bool vring_should_notify(VirtIODevice *vdev, Vring *vring)
 }
 
 
-static int get_desc(Vring *vring, VirtQueueElement *elem,
+static int get_desc(VirtIODevice *vdev, Vring *vring, VirtQueueElement *elem,
                     struct vring_desc *desc)
 {
     unsigned *num;
     struct iovec *iov;
     hwaddr *addr;
     MemoryRegion *mr;
+    int is_write = virtio_tswap16(vdev, desc->flags) & VRING_DESC_F_WRITE;
+    uint32_t len = virtio_tswap32(vdev, desc->len);
+    uint64_t desc_addr = virtio_tswap64(vdev, desc->addr);
 
-    if (desc->flags & VRING_DESC_F_WRITE) {
+    if (is_write) {
         num = &elem->in_num;
         iov = &elem->in_sg[*num];
         addr = &elem->in_addr[*num];
@@ -186,44 +192,45 @@ static int get_desc(Vring *vring, VirtQueueElement *elem,
     }
 
     /* TODO handle non-contiguous memory across region boundaries */
-    iov->iov_base = vring_map(&mr, desc->addr, desc->len,
-                              desc->flags & VRING_DESC_F_WRITE);
+    iov->iov_base = vring_map(&mr, desc_addr, len, is_write);
     if (!iov->iov_base) {
         error_report("Failed to map descriptor addr %#" PRIx64 " len %u",
-                     (uint64_t)desc->addr, desc->len);
+                     (uint64_t)desc_addr, len);
         return -EFAULT;
     }
 
     /* The MemoryRegion is looked up again and unref'ed later, leave the
      * ref in place.  */
-    iov->iov_len = desc->len;
-    *addr = desc->addr;
+    iov->iov_len = len;
+    *addr = desc_addr;
     *num += 1;
     return 0;
 }
 
 /* This is stolen from linux/drivers/vhost/vhost.c. */
-static int get_indirect(Vring *vring, VirtQueueElement *elem,
-                        struct vring_desc *indirect)
+static int get_indirect(VirtIODevice *vdev, Vring *vring,
+                        VirtQueueElement *elem, struct vring_desc *indirect)
 {
     struct vring_desc desc;
     unsigned int i = 0, count, found = 0;
     int ret;
+    uint32_t len = virtio_tswap32(vdev, indirect->len);
+    uint64_t addr = virtio_tswap64(vdev, indirect->addr);
 
     /* Sanity check */
-    if (unlikely(indirect->len % sizeof(desc))) {
+    if (unlikely(len % sizeof(desc))) {
         error_report("Invalid length in indirect descriptor: "
                      "len %#x not multiple of %#zx",
-                     indirect->len, sizeof(desc));
+                     len, sizeof(desc));
         vring->broken = true;
         return -EFAULT;
     }
 
-    count = indirect->len / sizeof(desc);
+    count = len / sizeof(desc);
     /* Buffers are chained via a 16 bit next field, so
      * we can have at most 2^16 of these. */
     if (unlikely(count > USHRT_MAX + 1)) {
-        error_report("Indirect buffer length too big: %d", indirect->len);
+        error_report("Indirect buffer length too big: %d", len);
         vring->broken = true;
         return -EFAULT;
     }
@@ -234,12 +241,12 @@ static int get_indirect(Vring *vring, VirtQueueElement *elem,
 
         /* Translate indirect descriptor */
         desc_ptr = vring_map(&mr,
-                             indirect->addr + found * sizeof(desc),
+                             addr + found * sizeof(desc),
                              sizeof(desc), false);
         if (!desc_ptr) {
             error_report("Failed to map indirect descriptor "
                          "addr %#" PRIx64 " len %zu",
-                         (uint64_t)indirect->addr + found * sizeof(desc),
+                         (uint64_t)addr + found * sizeof(desc),
                          sizeof(desc));
             vring->broken = true;
             return -EFAULT;
@@ -257,19 +264,20 @@ static int get_indirect(Vring *vring, VirtQueueElement *elem,
             return -EFAULT;
         }
 
-        if (unlikely(desc.flags & VRING_DESC_F_INDIRECT)) {
+        if (unlikely(virtio_tswap16(vdev, desc.flags)
+                     & VRING_DESC_F_INDIRECT)) {
             error_report("Nested indirect descriptor");
             vring->broken = true;
             return -EFAULT;
         }
 
-        ret = get_desc(vring, elem, &desc);
+        ret = get_desc(vdev, vring, elem, &desc);
         if (ret < 0) {
             vring->broken |= (ret == -EFAULT);
             return ret;
         }
-        i = desc.next;
-    } while (desc.flags & VRING_DESC_F_NEXT);
+        i = virtio_tswap16(vdev, desc.next);
+    } while (virtio_tswap16(vdev, desc.flags) & VRING_DESC_F_NEXT);
     return 0;
 }
 
@@ -320,7 +328,7 @@ int vring_pop(VirtIODevice *vdev, Vring *vring,
 
     /* Check it isn't doing very strange things with descriptor numbers. */
     last_avail_idx = vring->last_avail_idx;
-    avail_idx = vring->vr.avail->idx;
+    avail_idx = vring_get_avail_idx(vdev, vring);
     barrier(); /* load indices now and not again later */
 
     if (unlikely((uint16_t)(avail_idx - last_avail_idx) > num)) {
@@ -341,7 +349,7 @@ int vring_pop(VirtIODevice *vdev, Vring *vring,
 
     /* Grab the next descriptor number they're advertising, and increment
      * the index we've seen. */
-    head = vring->vr.avail->ring[last_avail_idx % num];
+    head = vring_get_avail_ring(vdev, vring, last_avail_idx % num);
 
     elem->index = head;
 
@@ -370,21 +378,21 @@ int vring_pop(VirtIODevice *vdev, Vring *vring,
         /* Ensure descriptor is loaded before accessing fields */
         barrier();
 
-        if (desc.flags & VRING_DESC_F_INDIRECT) {
-            ret = get_indirect(vring, elem, &desc);
+        if (virtio_tswap16(vdev, desc.flags) & VRING_DESC_F_INDIRECT) {
+            ret = get_indirect(vdev, vring, elem, &desc);
             if (ret < 0) {
                 goto out;
             }
             continue;
         }
 
-        ret = get_desc(vring, elem, &desc);
+        ret = get_desc(vdev, vring, elem, &desc);
         if (ret < 0) {
             goto out;
         }
 
-        i = desc.next;
-    } while (desc.flags & VRING_DESC_F_NEXT);
+        i = virtio_tswap16(vdev, desc.next);
+    } while (virtio_tswap16(vdev, desc.flags) & VRING_DESC_F_NEXT);
 
     /* On success, increment avail index. */
     vring->last_avail_idx++;
@@ -407,9 +415,9 @@ out:
  *
  * Stolen from linux/drivers/vhost/vhost.c.
  */
-void vring_push(Vring *vring, VirtQueueElement *elem, int len)
+void vring_push(VirtIODevice *vdev, Vring *vring, VirtQueueElement *elem,
+                int len)
 {
-    struct vring_used_elem *used;
     unsigned int head = elem->index;
     uint16_t new;
 
@@ -422,14 +430,16 @@ void vring_push(Vring *vring, VirtQueueElement *elem, int len)
 
     /* The virtqueue contains a ring of used buffers.  Get a pointer to the
      * next entry in that used ring. */
-    used = &vring->vr.used->ring[vring->last_used_idx % vring->vr.num];
-    used->id = head;
-    used->len = len;
+    vring_set_used_ring_id(vdev, vring, vring->last_used_idx % vring->vr.num,
+                           head);
+    vring_set_used_ring_len(vdev, vring, vring->last_used_idx % vring->vr.num,
+                            len);
 
     /* Make sure buffer is written before we update index. */
     smp_wmb();
 
-    new = vring->vr.used->idx = ++vring->last_used_idx;
+    new = ++vring->last_used_idx;
+    vring_set_used_idx(vdev, vring, new);
     if (unlikely((int16_t)(new - vring->signalled_used) < (uint16_t)1)) {
         vring->signalled_used_valid = false;
     }
diff --git a/include/hw/virtio/dataplane/vring-accessors.h b/include/hw/virtio/dataplane/vring-accessors.h
new file mode 100644
index 0000000..b508b87
--- /dev/null
+++ b/include/hw/virtio/dataplane/vring-accessors.h
@@ -0,0 +1,75 @@
+#ifndef VRING_ACCESSORS_H
+#define VRING_ACCESSORS_H
+
+#include "hw/virtio/virtio_ring.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-access.h"
+
+static inline uint16_t vring_get_used_idx(VirtIODevice *vdev, Vring *vring)
+{
+    return virtio_tswap16(vdev, vring->vr.used->idx);
+}
+
+static inline void vring_set_used_idx(VirtIODevice *vdev, Vring *vring,
+                                      uint16_t idx)
+{
+    vring->vr.used->idx = virtio_tswap16(vdev, idx);
+}
+
+static inline uint16_t vring_get_avail_idx(VirtIODevice *vdev, Vring *vring)
+{
+    return virtio_tswap16(vdev, vring->vr.avail->idx);
+}
+
+static inline uint16_t vring_get_avail_ring(VirtIODevice *vdev, Vring *vring,
+                                            int i)
+{
+    return virtio_tswap16(vdev, vring->vr.avail->ring[i]);
+}
+
+static inline void vring_set_used_ring_id(VirtIODevice *vdev, Vring *vring,
+                                          int i, uint32_t id)
+{
+    vring->vr.used->ring[i].id = virtio_tswap32(vdev, id);
+}
+
+static inline void vring_set_used_ring_len(VirtIODevice *vdev, Vring *vring,
+                                          int i, uint32_t len)
+{
+    vring->vr.used->ring[i].len = virtio_tswap32(vdev, len);
+}
+
+static inline uint16_t vring_get_used_flags(VirtIODevice *vdev, Vring *vring)
+{
+    return virtio_tswap16(vdev, vring->vr.used->flags);
+}
+
+static inline uint16_t vring_get_avail_flags(VirtIODevice *vdev, Vring *vring)
+{
+    return virtio_tswap16(vdev, vring->vr.avail->flags);
+}
+
+static inline void vring_set_used_flags(VirtIODevice *vdev, Vring *vring,
+                                        uint16_t flags)
+{
+    vring->vr.used->flags |= virtio_tswap16(vdev, flags);
+}
+
+static inline void vring_clear_used_flags(VirtIODevice *vdev, Vring *vring,
+                                          uint16_t flags)
+{
+    vring->vr.used->flags &= virtio_tswap16(vdev, ~flags);
+}
+
+static inline unsigned int vring_get_num(Vring *vring)
+{
+    return vring->vr.num;
+}
+
+/* Are there more descriptors available? */
+static inline bool vring_more_avail(VirtIODevice *vdev, Vring *vring)
+{
+    return vring_get_avail_idx(vdev, vring) != vring->last_avail_idx;
+}
+
+#endif
diff --git a/include/hw/virtio/dataplane/vring.h b/include/hw/virtio/dataplane/vring.h
index d3e086a..e42c0fc 100644
--- a/include/hw/virtio/dataplane/vring.h
+++ b/include/hw/virtio/dataplane/vring.h
@@ -31,17 +31,6 @@ typedef struct {
     bool broken;                    /* was there a fatal error? */
 } Vring;
 
-static inline unsigned int vring_get_num(Vring *vring)
-{
-    return vring->vr.num;
-}
-
-/* Are there more descriptors available? */
-static inline bool vring_more_avail(Vring *vring)
-{
-    return vring->vr.avail->idx != vring->last_avail_idx;
-}
-
 /* Fail future vring_pop() and vring_push() calls until reset */
 static inline void vring_set_broken(Vring *vring)
 {
@@ -54,6 +43,7 @@ void vring_disable_notification(VirtIODevice *vdev, Vring *vring);
 bool vring_enable_notification(VirtIODevice *vdev, Vring *vring);
 bool vring_should_notify(VirtIODevice *vdev, Vring *vring);
 int vring_pop(VirtIODevice *vdev, Vring *vring, VirtQueueElement *elem);
-void vring_push(Vring *vring, VirtQueueElement *elem, int len);
+void vring_push(VirtIODevice *vdev, Vring *vring, VirtQueueElement *elem,
+                int len);
 
 #endif /* VRING_H */
-- 
1.7.9.5
