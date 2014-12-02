From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v5 03/19] virtio: feature bit manipulation helpers
Date: Tue,  2 Dec 2014 14:00:11 +0100
Message-ID: <1417525227-14051-4-git-send-email-cornelia.huck@de.ibm.com>
References: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
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

Add virtio_{add,clear}_feature helper functions for manipulating a
feature bits variable. This has some benefits over open coding:
- add check that the bit is in a sane range
- make it obvious at a glance what is going on
- have a central point to change when we want to extend feature bits

Convert existing code manipulating features to use the new helpers.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/9pfs/virtio-9p-device.c  |    2 +-
 hw/block/virtio-blk.c       |   16 ++++++++--------
 hw/char/virtio-serial-bus.c |    2 +-
 hw/net/virtio-net.c         |   34 +++++++++++++++++-----------------
 hw/s390x/virtio-ccw.c       |    4 ++--
 hw/virtio/virtio-mmio.c     |    2 +-
 hw/virtio/virtio-pci.c      |    4 ++--
 include/hw/virtio/virtio.h  |   12 ++++++++++++
 8 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 2572747..30492ec 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -23,7 +23,7 @@
 
 static uint32_t virtio_9p_get_features(VirtIODevice *vdev, uint32_t features)
 {
-    features |= 1 << VIRTIO_9P_MOUNT_TAG;
+    virtio_add_feature(&features, VIRTIO_9P_MOUNT_TAG);
     return features;
 }
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b19b102..3f76e2a 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -568,20 +568,20 @@ static uint32_t virtio_blk_get_features(VirtIODevice *vdev, uint32_t features)
 {
     VirtIOBlock *s = VIRTIO_BLK(vdev);
 
-    features |= (1 << VIRTIO_BLK_F_SEG_MAX);
-    features |= (1 << VIRTIO_BLK_F_GEOMETRY);
-    features |= (1 << VIRTIO_BLK_F_TOPOLOGY);
-    features |= (1 << VIRTIO_BLK_F_BLK_SIZE);
-    features |= (1 << VIRTIO_BLK_F_SCSI);
+    virtio_add_feature(&features, VIRTIO_BLK_F_SEG_MAX);
+    virtio_add_feature(&features, VIRTIO_BLK_F_GEOMETRY);
+    virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
+    virtio_add_feature(&features, VIRTIO_BLK_F_BLK_SIZE);
+    virtio_add_feature(&features, VIRTIO_BLK_F_SCSI);
 
     if (s->conf.config_wce) {
-        features |= (1 << VIRTIO_BLK_F_CONFIG_WCE);
+        virtio_add_feature(&features, VIRTIO_BLK_F_CONFIG_WCE);
     }
     if (blk_enable_write_cache(s->blk)) {
-        features |= (1 << VIRTIO_BLK_F_WCE);
+        virtio_add_feature(&features, VIRTIO_BLK_F_WCE);
     }
     if (blk_is_read_only(s->blk)) {
-        features |= 1 << VIRTIO_BLK_F_RO;
+        virtio_add_feature(&features, VIRTIO_BLK_F_RO);
     }
 
     return features;
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index a7b1b68..0f637db 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -474,7 +474,7 @@ static uint32_t get_features(VirtIODevice *vdev, uint32_t features)
     vser = VIRTIO_SERIAL(vdev);
 
     if (vser->bus.max_nr_ports > 1) {
-        features |= (1 << VIRTIO_CONSOLE_F_MULTIPORT);
+        virtio_add_feature(&features, VIRTIO_CONSOLE_F_MULTIPORT);
     }
     return features;
 }
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e574bd4..f1aa100 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -446,23 +446,23 @@ static uint32_t virtio_net_get_features(VirtIODevice *vdev, uint32_t features)
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc = qemu_get_queue(n->nic);
 
-    features |= (1 << VIRTIO_NET_F_MAC);
+    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
 
     if (!peer_has_vnet_hdr(n)) {
-        features &= ~(0x1 << VIRTIO_NET_F_CSUM);
-        features &= ~(0x1 << VIRTIO_NET_F_HOST_TSO4);
-        features &= ~(0x1 << VIRTIO_NET_F_HOST_TSO6);
-        features &= ~(0x1 << VIRTIO_NET_F_HOST_ECN);
+        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
 
-        features &= ~(0x1 << VIRTIO_NET_F_GUEST_CSUM);
-        features &= ~(0x1 << VIRTIO_NET_F_GUEST_TSO4);
-        features &= ~(0x1 << VIRTIO_NET_F_GUEST_TSO6);
-        features &= ~(0x1 << VIRTIO_NET_F_GUEST_ECN);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
     }
 
     if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
-        features &= ~(0x1 << VIRTIO_NET_F_GUEST_UFO);
-        features &= ~(0x1 << VIRTIO_NET_F_HOST_UFO);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_UFO);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
     }
 
     if (!get_vhost_net(nc->peer)) {
@@ -477,11 +477,11 @@ static uint32_t virtio_net_bad_features(VirtIODevice *vdev)
 
     /* Linux kernel 2.6.25.  It understood MAC (as everyone must),
      * but also these: */
-    features |= (1 << VIRTIO_NET_F_MAC);
-    features |= (1 << VIRTIO_NET_F_CSUM);
-    features |= (1 << VIRTIO_NET_F_HOST_TSO4);
-    features |= (1 << VIRTIO_NET_F_HOST_TSO6);
-    features |= (1 << VIRTIO_NET_F_HOST_ECN);
+    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
+    virtio_add_feature(&features, VIRTIO_NET_F_CSUM);
+    virtio_add_feature(&features, VIRTIO_NET_F_HOST_TSO4);
+    virtio_add_feature(&features, VIRTIO_NET_F_HOST_TSO6);
+    virtio_add_feature(&features, VIRTIO_NET_F_HOST_ECN);
 
     return features;
 }
@@ -1560,7 +1560,7 @@ static void virtio_net_guest_notifier_mask(VirtIODevice *vdev, int idx,
 void virtio_net_set_config_size(VirtIONet *n, uint32_t host_features)
 {
     int i, config_size = 0;
-    host_features |= (1 << VIRTIO_NET_F_MAC);
+    virtio_add_feature(&host_features, VIRTIO_NET_F_MAC);
     for (i = 0; feature_sizes[i].flags != 0; i++) {
         if (host_features & feature_sizes[i].flags) {
             config_size = MAX(feature_sizes[i].end, config_size);
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 84f17bc..3fee4aa 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -743,8 +743,8 @@ static int virtio_ccw_device_init(VirtioCcwDevice *dev, VirtIODevice *vdev)
     dev->host_features[0] = virtio_bus_get_vdev_features(&dev->bus,
                                                          dev->host_features[0]);
 
-    dev->host_features[0] |= 0x1 << VIRTIO_F_NOTIFY_ON_EMPTY;
-    dev->host_features[0] |= 0x1 << VIRTIO_F_BAD_FEATURE;
+    virtio_add_feature(&dev->host_features[0], VIRTIO_F_NOTIFY_ON_EMPTY);
+    virtio_add_feature(&dev->host_features[0], VIRTIO_F_BAD_FEATURE);
 
     css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
                           parent->hotplugged, 1);
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 2450c13..10123f3 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -349,7 +349,7 @@ static void virtio_mmio_device_plugged(DeviceState *opaque)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
 
-    proxy->host_features |= (0x1 << VIRTIO_F_NOTIFY_ON_EMPTY);
+    virtio_add_feature(&proxy->host_features, VIRTIO_F_NOTIFY_ON_EMPTY);
     proxy->host_features = virtio_bus_get_vdev_features(&proxy->bus,
                                                         proxy->host_features);
 }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index dde1d73..e7969bf 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -996,8 +996,8 @@ static void virtio_pci_device_plugged(DeviceState *d)
         proxy->flags &= ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
     }
 
-    proxy->host_features |= 0x1 << VIRTIO_F_NOTIFY_ON_EMPTY;
-    proxy->host_features |= 0x1 << VIRTIO_F_BAD_FEATURE;
+    virtio_add_feature(&proxy->host_features, VIRTIO_F_NOTIFY_ON_EMPTY);
+    virtio_add_feature(&proxy->host_features, VIRTIO_F_BAD_FEATURE);
     proxy->host_features = virtio_bus_get_vdev_features(bus,
                                                       proxy->host_features);
 }
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 0726d76..2fede2e 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -266,6 +266,18 @@ void virtio_queue_set_host_notifier_fd_handler(VirtQueue *vq, bool assign,
 void virtio_queue_notify_vq(VirtQueue *vq);
 void virtio_irq(VirtQueue *vq);
 
+static inline void virtio_add_feature(uint32_t *features, unsigned int fbit)
+{
+    assert(fbit < 32);
+    *features |= (1 << fbit);
+}
+
+static inline void virtio_clear_feature(uint32_t *features, unsigned int fbit)
+{
+    assert(fbit < 32);
+    *features &= ~(1 << fbit);
+}
+
 static inline bool virtio_is_big_endian(VirtIODevice *vdev)
 {
     assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
-- 
1.7.9.5
