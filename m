From: Jason Wang <jasowang@redhat.com>
Subject: [RFC V3 4/5] vhost: multiqueue support
Date: Fri,  6 Jul 2012 17:31:09 +0800
Message-ID: <1341567070-14136-5-git-send-email-jasowang__22895.9615495571$1341567494$gmane$org@redhat.com>
References: <1341567070-14136-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1341567070-14136-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: krkumar2@in.ibm.com, habanero@linux.vnet.ibm.com, aliguori@us.ibm.com, rusty@rustcorp.com.au, mst@redhat.com, mashirle@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, tahm@linux.vnet.ibm.com, jwhan@filewood.snu.ac.kr, akong@redhat.com
Cc: kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This patch converts the vhost to support multiqueue queues. It implement a 1:1
mapping of vhost devs and tap fds. That it to say, the patch creates and uses
N vhost devs as the backend of the N queues virtio-net deivce.

The main work is to convert the virtqueue index into vhost queue index, this is
done by introducing an vq_index filed in vhost_dev struct to record the index of
first virtuque that is used by the vhost devs. Then vhost could simply convert
it to the local vhost queue index and issue ioctls.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/vhost.c      |   53 ++++++++++++++++++++++++++++++++++-------------------
 hw/vhost.h      |    2 ++
 hw/vhost_net.c  |    7 +++++--
 hw/vhost_net.h  |    2 +-
 hw/virtio-net.c |    2 +-
 5 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/hw/vhost.c b/hw/vhost.c
index 43664e7..3eb6037 100644
--- a/hw/vhost.c
+++ b/hw/vhost.c
@@ -620,11 +620,12 @@ static int vhost_virtqueue_init(struct vhost_dev *dev,
 {
     target_phys_addr_t s, l, a;
     int r;
+    int vhost_vq_index = (idx > 2 ? idx - 1 : idx) % dev->nvqs;
     struct vhost_vring_file file = {
-        .index = idx,
+        .index = vhost_vq_index
     };
     struct vhost_vring_state state = {
-        .index = idx,
+        .index = vhost_vq_index
     };
     struct VirtQueue *vvq = virtio_get_queue(vdev, idx);
 
@@ -670,11 +671,12 @@ static int vhost_virtqueue_init(struct vhost_dev *dev,
         goto fail_alloc_ring;
     }
 
-    r = vhost_virtqueue_set_addr(dev, vq, idx, dev->log_enabled);
+    r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
     if (r < 0) {
         r = -errno;
         goto fail_alloc;
     }
+
     file.fd = event_notifier_get_fd(virtio_queue_get_host_notifier(vvq));
     r = ioctl(dev->control, VHOST_SET_VRING_KICK, &file);
     if (r) {
@@ -715,7 +717,7 @@ static void vhost_virtqueue_cleanup(struct vhost_dev *dev,
                                     unsigned idx)
 {
     struct vhost_vring_state state = {
-        .index = idx,
+        .index = (idx > 2 ? idx - 1 : idx) % dev->nvqs,
     };
     int r;
     r = ioctl(dev->control, VHOST_GET_VRING_BASE, &state);
@@ -829,7 +831,9 @@ int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
     }
 
     for (i = 0; i < hdev->nvqs; ++i) {
-        r = vdev->binding->set_host_notifier(vdev->binding_opaque, i, true);
+        r = vdev->binding->set_host_notifier(vdev->binding_opaque,
+					     hdev->vq_index + i,
+					     true);
         if (r < 0) {
             fprintf(stderr, "vhost VQ %d notifier binding failed: %d\n", i, -r);
             goto fail_vq;
@@ -839,7 +843,9 @@ int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
     return 0;
 fail_vq:
     while (--i >= 0) {
-        r = vdev->binding->set_host_notifier(vdev->binding_opaque, i, false);
+        r = vdev->binding->set_host_notifier(vdev->binding_opaque,
+					     hdev->vq_index + i,
+					     false);
         if (r < 0) {
             fprintf(stderr, "vhost VQ %d notifier cleanup error: %d\n", i, -r);
             fflush(stderr);
@@ -860,7 +866,9 @@ void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
     int i, r;
 
     for (i = 0; i < hdev->nvqs; ++i) {
-        r = vdev->binding->set_host_notifier(vdev->binding_opaque, i, false);
+        r = vdev->binding->set_host_notifier(vdev->binding_opaque,
+                                             hdev->vq_index + i,
+                                             false);
         if (r < 0) {
             fprintf(stderr, "vhost VQ %d notifier cleanup failed: %d\n", i, -r);
             fflush(stderr);
@@ -879,10 +887,12 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
         goto fail;
     }
 
-    r = vdev->binding->set_guest_notifiers(vdev->binding_opaque, true);
-    if (r < 0) {
-        fprintf(stderr, "Error binding guest notifier: %d\n", -r);
-        goto fail_notifiers;
+    if (hdev->vq_index == 0) {
+        r = vdev->binding->set_guest_notifiers(vdev->binding_opaque, true);
+        if (r < 0) {
+            fprintf(stderr, "Error binding guest notifier: %d\n", -r);
+            goto fail_notifiers;
+        }
     }
 
     r = vhost_dev_set_features(hdev, hdev->log_enabled);
@@ -898,7 +908,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
         r = vhost_virtqueue_init(hdev,
                                  vdev,
                                  hdev->vqs + i,
-                                 i);
+                                 hdev->vq_index + i);
         if (r < 0) {
             goto fail_vq;
         }
@@ -925,8 +935,9 @@ fail_vq:
         vhost_virtqueue_cleanup(hdev,
                                 vdev,
                                 hdev->vqs + i,
-                                i);
+                                hdev->vq_index + i);
     }
+    i = hdev->nvqs;
 fail_mem:
 fail_features:
     vdev->binding->set_guest_notifiers(vdev->binding_opaque, false);
@@ -944,18 +955,22 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev)
         vhost_virtqueue_cleanup(hdev,
                                 vdev,
                                 hdev->vqs + i,
-                                i);
+                                hdev->vq_index + i);
     }
+
     for (i = 0; i < hdev->n_mem_sections; ++i) {
         vhost_sync_dirty_bitmap(hdev, &hdev->mem_sections[i],
                                 0, (target_phys_addr_t)~0x0ull);
     }
-    r = vdev->binding->set_guest_notifiers(vdev->binding_opaque, false);
-    if (r < 0) {
-        fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", r);
-        fflush(stderr);
+
+    if (hdev->vq_index == 0) {
+	r = vdev->binding->set_guest_notifiers(vdev->binding_opaque, false);
+	if (r < 0) {
+	    fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", r);
+	    fflush(stderr);
+	}
+	assert (r >= 0);
     }
-    assert (r >= 0);
 
     hdev->started = false;
     g_free(hdev->log);
diff --git a/hw/vhost.h b/hw/vhost.h
index 80e64df..edfe9d2 100644
--- a/hw/vhost.h
+++ b/hw/vhost.h
@@ -34,6 +34,8 @@ struct vhost_dev {
     MemoryRegionSection *mem_sections;
     struct vhost_virtqueue *vqs;
     int nvqs;
+    /* the first virtuque which would be used by this vhost dev */
+    int vq_index;
     unsigned long long features;
     unsigned long long acked_features;
     unsigned long long backend_features;
diff --git a/hw/vhost_net.c b/hw/vhost_net.c
index f672e9d..7cc3339 100644
--- a/hw/vhost_net.c
+++ b/hw/vhost_net.c
@@ -138,13 +138,15 @@ bool vhost_net_query(VHostNetState *net, VirtIODevice *dev)
 }
 
 int vhost_net_start(struct vhost_net *net,
-                    VirtIODevice *dev)
+                    VirtIODevice *dev,
+                    int vq_index)
 {
     struct vhost_vring_file file = { };
     int r;
 
     net->dev.nvqs = 2;
     net->dev.vqs = net->vqs;
+    net->dev.vq_index = vq_index;
 
     r = vhost_dev_enable_notifiers(&net->dev, dev);
     if (r < 0) {
@@ -227,7 +229,8 @@ bool vhost_net_query(VHostNetState *net, VirtIODevice *dev)
 }
 
 int vhost_net_start(struct vhost_net *net,
-		    VirtIODevice *dev)
+                    VirtIODevice *dev,
+		int vq_index)
 {
     return -ENOSYS;
 }
diff --git a/hw/vhost_net.h b/hw/vhost_net.h
index 91e40b1..6282b2c 100644
--- a/hw/vhost_net.h
+++ b/hw/vhost_net.h
@@ -9,7 +9,7 @@ typedef struct vhost_net VHostNetState;
 VHostNetState *vhost_net_init(VLANClientState *backend, int devfd, bool force);
 
 bool vhost_net_query(VHostNetState *net, VirtIODevice *dev);
-int vhost_net_start(VHostNetState *net, VirtIODevice *dev);
+int vhost_net_start(VHostNetState *net, VirtIODevice *dev, int vq_index);
 void vhost_net_stop(VHostNetState *net, VirtIODevice *dev);
 
 void vhost_net_cleanup(VHostNetState *net);
diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index 3f190d4..30eb4f4 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -124,7 +124,7 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
         if (!vhost_net_query(tap_get_vhost_net(n->nic->nc.peer), &n->vdev)) {
             return;
         }
-        r = vhost_net_start(tap_get_vhost_net(n->nic->nc.peer), &n->vdev);
+        r = vhost_net_start(tap_get_vhost_net(n->nic->nc.peer), &n->vdev, 0);
         if (r < 0) {
             error_report("unable to start vhost net: %d: "
                          "falling back on userspace virtio", -r);
-- 
1.7.1
