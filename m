From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: [PATCH RFC 4/7] vhost: set vring endianness for legacy virtio
Date: Wed, 06 May 2015 14:08:02 +0200
Message-ID: <20150506120801.8607.64278.stgit@bahia.huguette.org>
References: <20150506120729.8607.23404.stgit@bahia.huguette.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150506120729.8607.23404.stgit@bahia.huguette.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Legacy virtio is native endian: if the guest and host endianness differ,
we have to tell vhost so it can swap bytes where appropriate. This is
done through a vhost ring ioctl.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 hw/virtio/vhost.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 54851b7..1d7b939 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -17,9 +17,11 @@
 #include "hw/hw.h"
 #include "qemu/atomic.h"
 #include "qemu/range.h"
+#include "qemu/error-report.h"
 #include <linux/vhost.h>
 #include "exec/address-spaces.h"
 #include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-access.h"
 #include "migration/migration.h"
 
 static void vhost_dev_sync_region(struct vhost_dev *dev,
@@ -647,6 +649,27 @@ static void vhost_log_stop(MemoryListener *listener,
     /* FIXME: implement */
 }
 
+static int vhost_virtqueue_set_vring_endian_legacy(struct vhost_dev *dev,
+                                                   bool is_big_endian,
+                                                   int vhost_vq_index)
+{
+    struct vhost_vring_state s = {
+        .index = vhost_vq_index,
+        .num = is_big_endian
+    };
+
+    if (!dev->vhost_ops->vhost_call(dev, VHOST_SET_VRING_ENDIAN, &s)) {
+        return 0;
+    }
+
+    if (errno == ENOTTY) {
+        error_report("vhost does not support cross-endian");
+        return -ENOSYS;
+    }
+
+    return -errno;
+}
+
 static int vhost_virtqueue_start(struct vhost_dev *dev,
                                 struct VirtIODevice *vdev,
                                 struct vhost_virtqueue *vq,
@@ -677,6 +700,16 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
         return -errno;
     }
 
+    if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1) &&
+        virtio_legacy_is_cross_endian(vdev)) {
+        r = vhost_virtqueue_set_vring_endian_legacy(dev,
+                                                    virtio_is_big_endian(vdev),
+                                                    vhost_vq_index);
+        if (r) {
+            return -errno;
+        }
+    }
+
     s = l = virtio_queue_get_desc_size(vdev, idx);
     a = virtio_queue_get_desc_addr(vdev, idx);
     vq->desc = cpu_physical_memory_map(a, &l, 0);
@@ -747,8 +780,9 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
                                     struct vhost_virtqueue *vq,
                                     unsigned idx)
 {
+    int vhost_vq_index = idx - dev->vq_index;
     struct vhost_vring_state state = {
-        .index = idx - dev->vq_index
+        .index = vhost_vq_index,
     };
     int r;
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
@@ -759,6 +793,20 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
     }
     virtio_queue_set_last_avail_idx(vdev, idx, state.num);
     virtio_queue_invalidate_signalled_used(vdev, idx);
+
+    /* In the cross-endian case, we need to reset the vring endianness to
+     * native as legacy devices expect so by default.
+     */
+    if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1) &&
+        virtio_legacy_is_cross_endian(vdev)) {
+        r = vhost_virtqueue_set_vring_endian_legacy(dev,
+                                                    !virtio_is_big_endian(vdev),
+                                                    vhost_vq_index);
+        if (r < 0) {
+            error_report("failed to reset vring endianness");
+        }
+    }
+
     assert (r >= 0);
     cpu_physical_memory_unmap(vq->ring, virtio_queue_get_ring_size(vdev, idx),
                               0, virtio_queue_get_ring_size(vdev, idx));
