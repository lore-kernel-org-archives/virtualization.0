From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv4 1/6] qemu/virtio: move features to an inline function
Date: Tue, 3 Nov 2009 00:23:30 +0200
Message-ID: <20091102222329.GB15153__30278.8154258907$1257200910$gmane$org@redhat.com>
References: <cover.1257200517.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1257200517.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

devices should have the final say over which virtio features they
support. E.g. indirect entries may or may not make sense in the context
of virtio-console. In particular, for vhost, we do not want to report to
guest bits not supported by kernel backend.  Move the common bits from
virtio-pci to an inline function and let each device call it.

No functional changes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio-balloon.c |    2 +-
 hw/virtio-blk.c     |    2 +-
 hw/virtio-console.c |    2 +-
 hw/virtio-net.c     |    2 +-
 hw/virtio-pci.c     |    3 ---
 hw/virtio.h         |   10 ++++++++++
 6 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/virtio-balloon.c b/hw/virtio-balloon.c
index 7ca783e..15b50bb 100644
--- a/hw/virtio-balloon.c
+++ b/hw/virtio-balloon.c
@@ -127,7 +127,7 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
 
 static uint32_t virtio_balloon_get_features(VirtIODevice *vdev)
 {
-    return 0;
+    return virtio_common_features();
 }
 
 static ram_addr_t virtio_balloon_to_target(void *opaque, ram_addr_t target)
diff --git a/hw/virtio-blk.c b/hw/virtio-blk.c
index 2630b99..db727b9 100644
--- a/hw/virtio-blk.c
+++ b/hw/virtio-blk.c
@@ -445,7 +445,7 @@ static uint32_t virtio_blk_get_features(VirtIODevice *vdev)
     if (strcmp(s->serial_str, "0"))
         features |= 1 << VIRTIO_BLK_F_IDENTIFY;
 
-    return features;
+    return features | virtio_common_features();
 }
 
 static void virtio_blk_save(QEMUFile *f, void *opaque)
diff --git a/hw/virtio-console.c b/hw/virtio-console.c
index 92c953c..79544bb 100644
--- a/hw/virtio-console.c
+++ b/hw/virtio-console.c
@@ -53,7 +53,7 @@ static void virtio_console_handle_input(VirtIODevice *vdev, VirtQueue *vq)
 
 static uint32_t virtio_console_get_features(VirtIODevice *vdev)
 {
-    return 0;
+    return virtio_common_features();
 }
 
 static int vcon_can_read(void *opaque)
diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index ce8e6cb..469c6e3 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -154,7 +154,7 @@ static uint32_t virtio_net_get_features(VirtIODevice *vdev)
     }
 #endif
 
-    return features;
+    return features | virtio_common_features();
 }
 
 static uint32_t virtio_net_bad_features(VirtIODevice *vdev)
diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index 01782e5..0716f6f 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -230,9 +230,6 @@ static uint32_t virtio_ioport_read(VirtIOPCIProxy *proxy, uint32_t addr)
     switch (addr) {
     case VIRTIO_PCI_HOST_FEATURES:
         ret = vdev->get_features(vdev);
-        ret |= (1 << VIRTIO_F_NOTIFY_ON_EMPTY);
-        ret |= (1 << VIRTIO_RING_F_INDIRECT_DESC);
-        ret |= (1 << VIRTIO_F_BAD_FEATURE);
         break;
     case VIRTIO_PCI_GUEST_FEATURES:
         ret = vdev->features;
diff --git a/hw/virtio.h b/hw/virtio.h
index 0f9be7d..799e608 100644
--- a/hw/virtio.h
+++ b/hw/virtio.h
@@ -167,4 +167,14 @@ VirtIODevice *virtio_net_init(DeviceState *dev);
 VirtIODevice *virtio_console_init(DeviceState *dev);
 VirtIODevice *virtio_balloon_init(DeviceState *dev);
 
+static inline uint32_t virtio_common_features(void)
+{
+    uint32_t features = 0;
+    features |= (1 << VIRTIO_F_NOTIFY_ON_EMPTY);
+    features |= (1 << VIRTIO_RING_F_INDIRECT_DESC);
+    features |= (1 << VIRTIO_F_BAD_FEATURE);
+
+    return features;
+}
+
 #endif
-- 
1.6.5.2.143.g8cc62
