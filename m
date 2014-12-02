From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v5 07/19] virtio: allow virtio-1 queue layout
Date: Tue, 2 Dec 2014 16:41:36 +0100
Message-ID: <20141202164136.1a57f358.cornelia.huck__23372.3922785886$1417534922$gmane$org@de.ibm.com>
References: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
	<1417525227-14051-8-git-send-email-cornelia.huck@de.ibm.com>
	<20141202144628.GA2974@redhat.com>
	<20141202155444.0731c48f.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141202155444.0731c48f.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2 Dec 2014 15:54:44 +0100
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> On Tue, 2 Dec 2014 16:46:28 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:

> > pa == -1ULL tricks look quite ugly.
> > Can't we set desc/avail/used unconditionally, and drop
> > the pa value?
> 
> And have virtio_queue_get_addr() return desc? Let me see if I can come
> up with a patch.

I came up with the following (untested) patch, which should hopefully
suit mmio as well. I haven't cared about migration yet.

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 8f69ffa..ac3c615 100644
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
@@ -92,12 +91,13 @@ struct VirtQueue
 };
 
 /* virt queue functions */
-static void virtqueue_init(VirtQueue *vq)
+static void virtqueue_update_rings(VirtQueue *vq)
 {
-    hwaddr pa = vq->pa;
-
-    vq->vring.desc = pa;
-    vq->vring.avail = pa + vq->vring.num * sizeof(VRingDesc);
+    if (!vq->vring.desc) {
+        /* not yet setup -> nothing to do */
+        return;
+    }
+    vq->vring.avail = vq->vring.desc + vq->vring.num * sizeof(VRingDesc);
     vq->vring.used = vring_align(vq->vring.avail +
                                  offsetof(VRingAvail, ring[vq->vring.num]),
                                  vq->vring.align);
@@ -605,7 +605,6 @@ void virtio_reset(void *opaque)
         vdev->vq[i].vring.avail = 0;
         vdev->vq[i].vring.used = 0;
         vdev->vq[i].last_avail_idx = 0;
-        vdev->vq[i].pa = 0;
         vdev->vq[i].vector = VIRTIO_NO_VECTOR;
         vdev->vq[i].signalled_used = 0;
         vdev->vq[i].signalled_used_valid = false;
@@ -708,17 +707,34 @@ void virtio_config_writel(VirtIODevice *vdev, uint32_t addr, uint32_t data)
 
 void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
 {
-    vdev->vq[n].pa = addr;
-    virtqueue_init(&vdev->vq[n]);
+    vdev->vq[n].vring.desc = addr;
+    virtqueue_update_rings(&vdev->vq[n]);
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
 {
+    /*
+     * For virtio-1 devices, the number of buffers may only be
+     * updated if the ring addresses have not yet been set up.
+     */
+    if (virtio_has_feature(vdev, VIRTIO_F_VERSION_1) &&
+        vdev->vq[n].vring.desc) {
+        error_report("tried to modify buffer num for virtio-1 device");
+        return;
+    }
     /* Don't allow guest to flip queue between existent and
      * nonexistent states, or to set it to an invalid size.
      */
@@ -728,7 +744,7 @@ void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
         return;
     }
     vdev->vq[n].vring.num = num;
-    virtqueue_init(&vdev->vq[n]);
+    virtqueue_update_rings(&vdev->vq[n]);
 }
 
 int virtio_queue_get_num(VirtIODevice *vdev, int n)
@@ -748,6 +764,11 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
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
@@ -755,7 +776,7 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
     assert(k->has_variable_vring_alignment);
 
     vdev->vq[n].vring.align = align;
-    virtqueue_init(&vdev->vq[n]);
+    virtqueue_update_rings(&vdev->vq[n]);
 }
 
 void virtio_queue_notify_vq(VirtQueue *vq)
@@ -949,7 +970,8 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
         if (k->has_variable_vring_alignment) {
             qemu_put_be32(f, vdev->vq[i].vring.align);
         }
-        qemu_put_be64(f, vdev->vq[i].pa);
+        /* XXX virtio-1 devices */
+        qemu_put_be64(f, vdev->vq[i].vring.desc);
         qemu_put_be16s(f, &vdev->vq[i].last_avail_idx);
         if (k->save_queue) {
             k->save_queue(qbus->parent, i, f);
@@ -1044,13 +1066,14 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
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
+            virtqueue_update_rings(&vdev->vq[i]);
         } else if (vdev->vq[i].last_avail_idx) {
             error_report("VQ %d address 0x0 "
                          "inconsistent with Host index 0x%x",
@@ -1084,7 +1107,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     }
 
     for (i = 0; i < num; i++) {
-        if (vdev->vq[i].pa) {
+        if (vdev->vq[i].vring.desc) {
             uint16_t nheads;
             nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
             /* Check it isn't doing strange things with descriptor numbers. */
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 68c40db..80ee313 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -224,6 +224,8 @@ void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr);
 hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n);
 void virtio_queue_set_num(VirtIODevice *vdev, int n, int num);
 int virtio_queue_get_num(VirtIODevice *vdev, int n);
+void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
+                            hwaddr avail, hwaddr used);
 void virtio_queue_set_align(VirtIODevice *vdev, int n, int align);
 void virtio_queue_notify(VirtIODevice *vdev, int n);
 uint16_t virtio_queue_vector(VirtIODevice *vdev, int n);
