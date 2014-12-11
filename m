From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v6 07/20] virtio: allow virtio-1 queue layout
Date: Thu, 11 Dec 2014 14:25:09 +0100
Message-ID: <1418304322-7546-8-git-send-email-cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

For virtio-1 devices, we allow a more complex queue layout that doesn't
require descriptor table and rings on a physically-contigous memory area:
add virtio_queue_set_rings() to allow transports to set this up.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/virtio/virtio-mmio.c    |    3 +++
 hw/virtio/virtio.c         |   53 ++++++++++++++++++++++++++++----------------
 include/hw/virtio/virtio.h |    3 +++
 3 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 43b7e02..0c9b63b 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -244,8 +244,11 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
     case VIRTIO_MMIO_QUEUENUM:
         DPRINTF("mmio_queue write %d max %d\n", (int)value, VIRTQUEUE_MAX_SIZE);
         virtio_queue_set_num(vdev, vdev->queue_sel, value);
+        /* Note: only call this function for legacy devices */
+        virtio_queue_update_rings(vdev, vdev->queue_sel);
         break;
     case VIRTIO_MMIO_QUEUEALIGN:
+        /* Note: this is only valid for legacy devices */
         virtio_queue_set_align(vdev, vdev->queue_sel, value);
         break;
     case VIRTIO_MMIO_QUEUEPFN:
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 8f69ffa..57190ba 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -69,7 +69,6 @@ typedef struct VRing
 struct VirtQueue
 {
     VRing vring;
-    hwaddr pa;
     uint16_t last_avail_idx;
     /* Last used index value we have signalled on */
     uint16_t signalled_used;
@@ -92,15 +91,18 @@ struct VirtQueue
 };
 
 /* virt queue functions */
-static void virtqueue_init(VirtQueue *vq)
+void virtio_queue_update_rings(VirtIODevice *vdev, int n)
 {
-    hwaddr pa = vq->pa;
+    VRing *vring = &vdev->vq[n].vring;
 
-    vq->vring.desc = pa;
-    vq->vring.avail = pa + vq->vring.num * sizeof(VRingDesc);
-    vq->vring.used = vring_align(vq->vring.avail +
-                                 offsetof(VRingAvail, ring[vq->vring.num]),
-                                 vq->vring.align);
+    if (!vring->desc) {
+        /* not yet setup -> nothing to do */
+        return;
+    }
+    vring->avail = vring->desc + vring->num * sizeof(VRingDesc);
+    vring->used = vring_align(vring->avail +
+                              offsetof(VRingAvail, ring[vring->num]),
+                              vring->align);
 }
 
 static inline uint64_t vring_desc_addr(VirtIODevice *vdev, hwaddr desc_pa,
@@ -605,7 +607,6 @@ void virtio_reset(void *opaque)
         vdev->vq[i].vring.avail = 0;
         vdev->vq[i].vring.used = 0;
         vdev->vq[i].last_avail_idx = 0;
-        vdev->vq[i].pa = 0;
         vdev->vq[i].vector = VIRTIO_NO_VECTOR;
         vdev->vq[i].signalled_used = 0;
         vdev->vq[i].signalled_used_valid = false;
@@ -708,13 +709,21 @@ void virtio_config_writel(VirtIODevice *vdev, uint32_t addr, uint32_t data)
 
 void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
 {
-    vdev->vq[n].pa = addr;
-    virtqueue_init(&vdev->vq[n]);
+    vdev->vq[n].vring.desc = addr;
+    virtio_queue_update_rings(vdev, n);
 }
 
 hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n)
 {
-    return vdev->vq[n].pa;
+    return vdev->vq[n].vring.desc;
+}
+
+void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
+                            hwaddr avail, hwaddr used)
+{
+    vdev->vq[n].vring.desc = desc;
+    vdev->vq[n].vring.avail = avail;
+    vdev->vq[n].vring.used = used;
 }
 
 void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
@@ -728,7 +737,6 @@ void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
         return;
     }
     vdev->vq[n].vring.num = num;
-    virtqueue_init(&vdev->vq[n]);
 }
 
 int virtio_queue_get_num(VirtIODevice *vdev, int n)
@@ -748,6 +756,11 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
+    /* virtio-1 compliant devices cannot change the aligment */
+    if (virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        error_report("tried to modify queue alignment for virtio-1 device");
+        return;
+    }
     /* Check that the transport told us it was going to do this
      * (so a buggy transport will immediately assert rather than
      * silently failing to migrate this state)
@@ -755,7 +768,7 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
     assert(k->has_variable_vring_alignment);
 
     vdev->vq[n].vring.align = align;
-    virtqueue_init(&vdev->vq[n]);
+    virtio_queue_update_rings(vdev, n);
 }
 
 void virtio_queue_notify_vq(VirtQueue *vq)
@@ -949,7 +962,8 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
         if (k->has_variable_vring_alignment) {
             qemu_put_be32(f, vdev->vq[i].vring.align);
         }
-        qemu_put_be64(f, vdev->vq[i].pa);
+        /* XXX virtio-1 devices */
+        qemu_put_be64(f, vdev->vq[i].vring.desc);
         qemu_put_be16s(f, &vdev->vq[i].last_avail_idx);
         if (k->save_queue) {
             k->save_queue(qbus->parent, i, f);
@@ -1044,13 +1058,14 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         if (k->has_variable_vring_alignment) {
             vdev->vq[i].vring.align = qemu_get_be32(f);
         }
-        vdev->vq[i].pa = qemu_get_be64(f);
+        vdev->vq[i].vring.desc = qemu_get_be64(f);
         qemu_get_be16s(f, &vdev->vq[i].last_avail_idx);
         vdev->vq[i].signalled_used_valid = false;
         vdev->vq[i].notification = true;
 
-        if (vdev->vq[i].pa) {
-            virtqueue_init(&vdev->vq[i]);
+        if (vdev->vq[i].vring.desc) {
+            /* XXX virtio-1 devices */
+            virtio_queue_update_rings(vdev, i);
         } else if (vdev->vq[i].last_avail_idx) {
             error_report("VQ %d address 0x0 "
                          "inconsistent with Host index 0x%x",
@@ -1084,7 +1099,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     }
 
     for (i = 0; i < num; i++) {
-        if (vdev->vq[i].pa) {
+        if (vdev->vq[i].vring.desc) {
             uint16_t nheads;
             nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
             /* Check it isn't doing strange things with descriptor numbers. */
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 68c40db..b63ced3 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -224,6 +224,9 @@ void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr);
 hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n);
 void virtio_queue_set_num(VirtIODevice *vdev, int n, int num);
 int virtio_queue_get_num(VirtIODevice *vdev, int n);
+void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
+                            hwaddr avail, hwaddr used);
+void virtio_queue_update_rings(VirtIODevice *vdev, int n);
 void virtio_queue_set_align(VirtIODevice *vdev, int n, int align);
 void virtio_queue_notify(VirtIODevice *vdev, int n);
 uint16_t virtio_queue_vector(VirtIODevice *vdev, int n);
-- 
1.7.9.5
