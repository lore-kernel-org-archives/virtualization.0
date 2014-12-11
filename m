From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v6 05/20] virtio: support more feature bits
Date: Thu, 11 Dec 2014 14:25:07 +0100
Message-ID: <1418304322-7546-6-git-send-email-cornelia.huck@de.ibm.com>
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

With virtio-1, we support more than 32 feature bits. Let's extend both
host and guest features to 64, which should suffice for a while.

vhost and migration have been ignored for now.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/9pfs/virtio-9p-device.c      |    2 +-
 hw/block/virtio-blk.c           |    2 +-
 hw/char/virtio-serial-bus.c     |    2 +-
 hw/core/qdev-properties.c       |   58 +++++++++++++++++++++++++++++++++++++++
 hw/net/virtio-net.c             |   22 +++++++--------
 hw/s390x/s390-virtio-bus.c      |    3 +-
 hw/s390x/s390-virtio-bus.h      |    2 +-
 hw/s390x/virtio-ccw.c           |   39 +++++++++++++++-----------
 hw/s390x/virtio-ccw.h           |    5 +---
 hw/scsi/vhost-scsi.c            |    3 +-
 hw/scsi/virtio-scsi.c           |    4 +--
 hw/virtio/virtio-balloon.c      |    2 +-
 hw/virtio/virtio-bus.c          |    6 ++--
 hw/virtio/virtio-mmio.c         |    4 +--
 hw/virtio/virtio-pci.c          |    3 +-
 hw/virtio/virtio-pci.h          |    2 +-
 hw/virtio/virtio-rng.c          |    2 +-
 hw/virtio/virtio.c              |   13 +++++----
 include/hw/qdev-properties.h    |   12 ++++++++
 include/hw/virtio/virtio-bus.h  |    8 +++---
 include/hw/virtio/virtio-net.h  |   46 +++++++++++++++----------------
 include/hw/virtio/virtio-scsi.h |    6 ++--
 include/hw/virtio/virtio.h      |   38 ++++++++++++++-----------
 23 files changed, 184 insertions(+), 100 deletions(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 30492ec..60f9ff9 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -21,7 +21,7 @@
 #include "virtio-9p-coth.h"
 #include "hw/virtio/virtio-access.h"
 
-static uint32_t virtio_9p_get_features(VirtIODevice *vdev, uint32_t features)
+static uint64_t virtio_9p_get_features(VirtIODevice *vdev, uint64_t features)
 {
     virtio_add_feature(&features, VIRTIO_9P_MOUNT_TAG);
     return features;
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 27f263a..9cfae66 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -564,7 +564,7 @@ static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
     aio_context_release(blk_get_aio_context(s->blk));
 }
 
-static uint32_t virtio_blk_get_features(VirtIODevice *vdev, uint32_t features)
+static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features)
 {
     VirtIOBlock *s = VIRTIO_BLK(vdev);
 
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index d49883f..2d2ed9c 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -467,7 +467,7 @@ static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
 {
 }
 
-static uint32_t get_features(VirtIODevice *vdev, uint32_t features)
+static uint64_t get_features(VirtIODevice *vdev, uint64_t features)
 {
     VirtIOSerial *vser;
 
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 2e47f70..1b24818 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -125,6 +125,64 @@ PropertyInfo qdev_prop_bit = {
     .set   = prop_set_bit,
 };
 
+/* Bit on a 64 bit value*/
+
+static uint64_t qdev_get_prop_mask64(Property *prop)
+{
+    assert(prop->info == &qdev_prop_bit64);
+    return 0x1ULL << prop->bitnr;
+}
+
+static void bit64_prop_set(DeviceState *dev, Property *props, bool val)
+{
+    uint64_t *p = qdev_get_prop_ptr(dev, props);
+    uint64_t mask = qdev_get_prop_mask64(props);
+    if (val) {
+        *p |= mask;
+    } else {
+        *p &= ~mask;
+    }
+}
+
+static void prop_get_bit64(Object *obj, Visitor *v, void *opaque,
+                    const char *name, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    uint64_t *p = qdev_get_prop_ptr(dev, prop);
+    bool value = (*p & qdev_get_prop_mask64(prop)) != 0;
+
+    visit_type_bool(v, &value, name, errp);
+}
+
+static void prop_set_bit64(Object *obj, Visitor *v, void *opaque,
+                    const char *name, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    Error *local_err = NULL;
+    bool value;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_bool(v, &value, name, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    bit64_prop_set(dev, prop, value);
+}
+
+PropertyInfo qdev_prop_bit64 = {
+    .name  = "bool",
+    .description = "on/off",
+    .get   = prop_get_bit64,
+    .set   = prop_set_bit64,
+};
+
 /* --- bool --- */
 
 static void get_bool(Object *obj, Visitor *v, void *opaque,
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9f3c58a..d6d1b98 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -38,16 +38,16 @@
     (offsetof(container, field) + sizeof(((container *)0)->field))
 
 typedef struct VirtIOFeature {
-    uint32_t flags;
+    uint64_t flags;
     size_t end;
 } VirtIOFeature;
 
 static VirtIOFeature feature_sizes[] = {
-    {.flags = 1 << VIRTIO_NET_F_MAC,
+    {.flags = 1ULL << VIRTIO_NET_F_MAC,
      .end = endof(struct virtio_net_config, mac)},
-    {.flags = 1 << VIRTIO_NET_F_STATUS,
+    {.flags = 1ULL << VIRTIO_NET_F_STATUS,
      .end = endof(struct virtio_net_config, status)},
-    {.flags = 1 << VIRTIO_NET_F_MQ,
+    {.flags = 1ULL << VIRTIO_NET_F_MQ,
      .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
     {}
 };
@@ -441,7 +441,7 @@ static void virtio_net_set_queues(VirtIONet *n)
 
 static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
 
-static uint32_t virtio_net_get_features(VirtIODevice *vdev, uint32_t features)
+static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc = qemu_get_queue(n->nic);
@@ -471,9 +471,9 @@ static uint32_t virtio_net_get_features(VirtIODevice *vdev, uint32_t features)
     return vhost_net_get_features(get_vhost_net(nc->peer), features);
 }
 
-static uint32_t virtio_net_bad_features(VirtIODevice *vdev)
+static uint64_t virtio_net_bad_features(VirtIODevice *vdev)
 {
-    uint32_t features = 0;
+    uint64_t features = 0;
 
     /* Linux kernel 2.6.25.  It understood MAC (as everyone must),
      * but also these: */
@@ -496,7 +496,7 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
             !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)));
 }
 
-static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
+static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
 {
     static const uint64_t guest_offloads_mask =
         (1ULL << VIRTIO_NET_F_GUEST_CSUM) |
@@ -514,7 +514,7 @@ static inline uint64_t virtio_net_supported_guest_offloads(VirtIONet *n)
     return virtio_net_guest_offloads_by_features(vdev->guest_features);
 }
 
-static void virtio_net_set_features(VirtIODevice *vdev, uint32_t features)
+static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     int i;
@@ -1036,7 +1036,7 @@ static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf, size_t
                 return -1;
             error_report("virtio-net unexpected empty queue: "
                     "i %zd mergeable %d offset %zd, size %zd, "
-                    "guest hdr len %zd, host hdr len %zd guest features 0x%x",
+                    "guest hdr len %zd, host hdr len %zd guest features 0x%lx",
                     i, n->mergeable_rx_bufs, offset, size,
                     n->guest_hdr_len, n->host_hdr_len, vdev->guest_features);
             exit(1);
@@ -1560,7 +1560,7 @@ static void virtio_net_guest_notifier_mask(VirtIODevice *vdev, int idx,
                              vdev, idx, mask);
 }
 
-void virtio_net_set_config_size(VirtIONet *n, uint32_t host_features)
+void virtio_net_set_config_size(VirtIONet *n, uint64_t host_features)
 {
     int i, config_size = 0;
     virtio_add_feature(&host_features, VIRTIO_NET_F_MAC);
diff --git a/hw/s390x/s390-virtio-bus.c b/hw/s390x/s390-virtio-bus.c
index 39dc201..3635909 100644
--- a/hw/s390x/s390-virtio-bus.c
+++ b/hw/s390x/s390-virtio-bus.c
@@ -490,9 +490,10 @@ static void virtio_s390_notify(DeviceState *d, uint16_t vector)
     s390_virtio_irq(0, token);
 }
 
-static unsigned virtio_s390_get_features(DeviceState *d)
+static uint64_t virtio_s390_get_features(DeviceState *d)
 {
     VirtIOS390Device *dev = to_virtio_s390_device(d);
+
     return dev->host_features;
 }
 
diff --git a/hw/s390x/s390-virtio-bus.h b/hw/s390x/s390-virtio-bus.h
index ffd0df7..e49d4ba 100644
--- a/hw/s390x/s390-virtio-bus.h
+++ b/hw/s390x/s390-virtio-bus.h
@@ -90,7 +90,7 @@ struct VirtIOS390Device {
     ram_addr_t feat_offs;
     uint8_t feat_len;
     VirtIODevice *vdev;
-    uint32_t host_features;
+    uint64_t host_features;
     VirtioBusState bus;
 };
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 3fee4aa..fbd909d 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -371,8 +371,10 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         } else {
             features.index = ldub_phys(&address_space_memory,
                                        ccw.cda + sizeof(features.features));
-            if (features.index < ARRAY_SIZE(dev->host_features)) {
-                features.features = dev->host_features[features.index];
+            if (features.index == 0) {
+                features.features = (uint32_t)dev->host_features;
+            } else if (features.index == 1) {
+                features.features = (uint32_t)(dev->host_features >> 32);
             } else {
                 /* Return zeroes if the guest supports more feature bits. */
                 features.features = 0;
@@ -399,8 +401,14 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             features.index = ldub_phys(&address_space_memory,
                                        ccw.cda + sizeof(features.features));
             features.features = ldl_le_phys(&address_space_memory, ccw.cda);
-            if (features.index < ARRAY_SIZE(dev->host_features)) {
-                virtio_set_features(vdev, features.features);
+            if (features.index == 0) {
+                virtio_set_features(vdev,
+                                    (vdev->guest_features & 0xffffffff00000000) |
+                                    features.features);
+            } else if (features.index == 1) {
+                virtio_set_features(vdev,
+                                    (vdev->guest_features & 0x00000000ffffffff) |
+                                    ((uint64_t)features.features << 32));
             } else {
                 /*
                  * If the guest supports more feature bits, assert that it
@@ -739,12 +747,12 @@ static int virtio_ccw_device_init(VirtioCcwDevice *dev, VirtIODevice *vdev)
     sch->id.cu_type = VIRTIO_CCW_CU_TYPE;
     sch->id.cu_model = vdev->device_id;
 
-    /* Only the first 32 feature bits are used. */
-    dev->host_features[0] = virtio_bus_get_vdev_features(&dev->bus,
-                                                         dev->host_features[0]);
+    /* Set default feature bits that are offered by the host. */
+    virtio_add_feature(&dev->host_features, VIRTIO_F_NOTIFY_ON_EMPTY);
+    virtio_add_feature(&dev->host_features, VIRTIO_F_BAD_FEATURE);
 
-    virtio_add_feature(&dev->host_features[0], VIRTIO_F_NOTIFY_ON_EMPTY);
-    virtio_add_feature(&dev->host_features[0], VIRTIO_F_BAD_FEATURE);
+    dev->host_features = virtio_bus_get_vdev_features(&dev->bus,
+                                                      dev->host_features);
 
     css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
                           parent->hotplugged, 1);
@@ -777,7 +785,7 @@ static int virtio_ccw_net_init(VirtioCcwDevice *ccw_dev)
     VirtIONetCcw *dev = VIRTIO_NET_CCW(ccw_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
 
-    virtio_net_set_config_size(&dev->vdev, ccw_dev->host_features[0]);
+    virtio_net_set_config_size(&dev->vdev, ccw_dev->host_features);
     virtio_net_set_netclient_name(&dev->vdev, qdev->id,
                                   object_get_typename(OBJECT(qdev)));
     qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
@@ -1063,12 +1071,11 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
     }
 }
 
-static unsigned virtio_ccw_get_features(DeviceState *d)
+static uint64_t virtio_ccw_get_features(DeviceState *d)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
 
-    /* Only the first 32 feature bits are used. */
-    return dev->host_features[0];
+    return dev->host_features;
 }
 
 static void virtio_ccw_reset(DeviceState *d)
@@ -1381,7 +1388,7 @@ static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
 
 static Property virtio_ccw_net_properties[] = {
     DEFINE_PROP_STRING("devno", VirtioCcwDevice, bus_id),
-    DEFINE_VIRTIO_NET_FEATURES(VirtioCcwDevice, host_features[0]),
+    DEFINE_VIRTIO_NET_FEATURES(VirtioCcwDevice, host_features),
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
@@ -1486,7 +1493,7 @@ static const TypeInfo virtio_ccw_balloon = {
 
 static Property virtio_ccw_scsi_properties[] = {
     DEFINE_PROP_STRING("devno", VirtioCcwDevice, bus_id),
-    DEFINE_VIRTIO_SCSI_FEATURES(VirtioCcwDevice, host_features[0]),
+    DEFINE_VIRTIO_SCSI_FEATURES(VirtioCcwDevice, host_features),
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
@@ -1614,7 +1621,7 @@ static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
 }
 
 static Property virtio_ccw_properties[] = {
-    DEFINE_VIRTIO_COMMON_FEATURES(VirtioCcwDevice, host_features[0]),
+    DEFINE_VIRTIO_COMMON_FEATURES(VirtioCcwDevice, host_features),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 5a1f16e..9087f7a 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -68,9 +68,6 @@ typedef struct VirtIOCCWDeviceClass {
     int (*exit)(VirtioCcwDevice *dev);
 } VirtIOCCWDeviceClass;
 
-/* Change here if we want to support more feature bits. */
-#define VIRTIO_CCW_FEATURE_SIZE 1
-
 /* Performance improves when virtqueue kick processing is decoupled from the
  * vcpu thread using ioeventfd for some devices. */
 #define VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT 1
@@ -88,7 +85,7 @@ struct VirtioCcwDevice {
     DeviceState parent_obj;
     SubchDev *sch;
     char *bus_id;
-    uint32_t host_features[VIRTIO_CCW_FEATURE_SIZE];
+    uint64_t host_features;
     VirtioBusState bus;
     bool ioeventfd_started;
     bool ioeventfd_disabled;
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index dcb2bc5..b5d7959 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -150,8 +150,7 @@ static void vhost_scsi_stop(VHostSCSI *s)
     vhost_dev_disable_notifiers(&s->dev, vdev);
 }
 
-static uint32_t vhost_scsi_get_features(VirtIODevice *vdev,
-                                        uint32_t features)
+static uint64_t vhost_scsi_get_features(VirtIODevice *vdev, uint64_t features)
 {
     VHostSCSI *s = VHOST_SCSI(vdev);
 
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 56c92fb..fbac794 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -627,8 +627,8 @@ static void virtio_scsi_set_config(VirtIODevice *vdev,
     vs->cdb_size = virtio_ldl_p(vdev, &scsiconf->cdb_size);
 }
 
-static uint32_t virtio_scsi_get_features(VirtIODevice *vdev,
-                                         uint32_t requested_features)
+static uint64_t virtio_scsi_get_features(VirtIODevice *vdev,
+                                         uint64_t requested_features)
 {
     return requested_features;
 }
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 21e449a..d2d7c3e 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -303,7 +303,7 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
     }
 }
 
-static uint32_t virtio_balloon_get_features(VirtIODevice *vdev, uint32_t f)
+static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f)
 {
     f |= (1 << VIRTIO_BALLOON_F_STATS_VQ);
     return f;
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index a8ffa07..32e3fab 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -97,8 +97,8 @@ size_t virtio_bus_get_vdev_config_len(VirtioBusState *bus)
 }
 
 /* Get the features of the plugged device. */
-uint32_t virtio_bus_get_vdev_features(VirtioBusState *bus,
-                                    uint32_t requested_features)
+uint64_t virtio_bus_get_vdev_features(VirtioBusState *bus,
+                                      uint64_t requested_features)
 {
     VirtIODevice *vdev = virtio_bus_get_device(bus);
     VirtioDeviceClass *k;
@@ -110,7 +110,7 @@ uint32_t virtio_bus_get_vdev_features(VirtioBusState *bus,
 }
 
 /* Get bad features of the plugged device. */
-uint32_t virtio_bus_get_vdev_bad_features(VirtioBusState *bus)
+uint64_t virtio_bus_get_vdev_bad_features(VirtioBusState *bus)
 {
     VirtIODevice *vdev = virtio_bus_get_device(bus);
     VirtioDeviceClass *k;
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 10123f3..43b7e02 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -80,7 +80,7 @@ typedef struct {
     SysBusDevice parent_obj;
     MemoryRegion iomem;
     qemu_irq irq;
-    uint32_t host_features;
+    uint64_t host_features;
     /* Guest accessible state needing migration and reset */
     uint32_t host_features_sel;
     uint32_t guest_features_sel;
@@ -306,7 +306,7 @@ static void virtio_mmio_update_irq(DeviceState *opaque, uint16_t vector)
     qemu_set_irq(proxy->irq, level);
 }
 
-static unsigned int virtio_mmio_get_features(DeviceState *opaque)
+static uint64_t virtio_mmio_get_features(DeviceState *opaque)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e7969bf..7382705 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -478,9 +478,10 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
     }
 }
 
-static unsigned virtio_pci_get_features(DeviceState *d)
+static uint64_t virtio_pci_get_features(DeviceState *d)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
+
     return proxy->host_features;
 }
 
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 8873b6d..85f102d 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -91,7 +91,7 @@ struct VirtIOPCIProxy {
     uint32_t flags;
     uint32_t class_code;
     uint32_t nvectors;
-    uint32_t host_features;
+    uint64_t host_features;
     bool ioeventfd_disabled;
     bool ioeventfd_started;
     VirtIOIRQFD *vector_irqfd;
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 473c044..edd39cc 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -99,7 +99,7 @@ static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
     virtio_rng_process(vrng);
 }
 
-static uint32_t get_features(VirtIODevice *vdev, uint32_t f)
+static uint64_t get_features(VirtIODevice *vdev, uint64_t f)
 {
     return f;
 }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 5814433..7f74ae5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -593,6 +593,7 @@ void virtio_reset(void *opaque)
     }
 
     vdev->guest_features = 0;
+
     vdev->queue_sel = 0;
     vdev->status = 0;
     vdev->isr = 0;
@@ -924,7 +925,8 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
     qemu_put_8s(f, &vdev->status);
     qemu_put_8s(f, &vdev->isr);
     qemu_put_be16s(f, &vdev->queue_sel);
-    qemu_put_be32s(f, &vdev->guest_features);
+    /* XXX features >= 32 */
+    qemu_put_be32s(f, (uint32_t *)&vdev->guest_features);
     qemu_put_be32(f, vdev->config_len);
     qemu_put_buffer(f, vdev->config, vdev->config_len);
 
@@ -958,12 +960,12 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
     vmstate_save_state(f, &vmstate_virtio, vdev);
 }
 
-int virtio_set_features(VirtIODevice *vdev, uint32_t val)
+int virtio_set_features(VirtIODevice *vdev, uint64_t val)
 {
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *vbusk = VIRTIO_BUS_GET_CLASS(qbus);
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
-    uint32_t supported_features = vbusk->get_features(qbus->parent);
+    uint64_t supported_features = vbusk->get_features(qbus->parent);
     bool bad = (val & ~supported_features) != 0;
 
     val &= supported_features;
@@ -980,7 +982,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     int32_t config_len;
     uint32_t num;
     uint32_t features;
-    uint32_t supported_features;
+    uint64_t supported_features;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
@@ -1005,9 +1007,10 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     }
     qemu_get_be32s(f, &features);
 
+    /* XXX features >= 32 */
     if (virtio_set_features(vdev, features) < 0) {
         supported_features = k->get_features(qbus->parent);
-        error_report("Features 0x%x unsupported. Allowed features: 0x%x",
+        error_report("Features 0x%x unsupported. Allowed features: 0x%lx",
                      features, supported_features);
         return -1;
     }
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 070006c..81e5d0b 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -6,6 +6,7 @@
 /*** qdev-properties.c ***/
 
 extern PropertyInfo qdev_prop_bit;
+extern PropertyInfo qdev_prop_bit64;
 extern PropertyInfo qdev_prop_bool;
 extern PropertyInfo qdev_prop_uint8;
 extern PropertyInfo qdev_prop_uint16;
@@ -51,6 +52,17 @@ extern PropertyInfo qdev_prop_arraylen;
         .defval    = (bool)_defval,                              \
         }
 
+#define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {  \
+        .name      = (_name),                                    \
+        .info      = &(qdev_prop_bit64),                           \
+        .bitnr    = (_bit),                                      \
+        .offset    = offsetof(_state, _field)                    \
+            + type_check(uint64_t,typeof_field(_state, _field)), \
+        .qtype     = QTYPE_QBOOL,                                \
+        .defval    = (bool)_defval,                              \
+        }
+
+
 #define DEFINE_PROP_BOOL(_name, _state, _field, _defval) {       \
         .name      = (_name),                                    \
         .info      = &(qdev_prop_bool),                          \
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index 0d2e7b4..0a4dde1 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -47,7 +47,7 @@ typedef struct VirtioBusClass {
     int (*load_config)(DeviceState *d, QEMUFile *f);
     int (*load_queue)(DeviceState *d, int n, QEMUFile *f);
     int (*load_done)(DeviceState *d, QEMUFile *f);
-    unsigned (*get_features)(DeviceState *d);
+    uint64_t (*get_features)(DeviceState *d);
     bool (*query_guest_notifiers)(DeviceState *d);
     int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
     int (*set_host_notifier)(DeviceState *d, int n, bool assigned);
@@ -82,10 +82,10 @@ uint16_t virtio_bus_get_vdev_id(VirtioBusState *bus);
 /* Get the config_len field of the plugged device. */
 size_t virtio_bus_get_vdev_config_len(VirtioBusState *bus);
 /* Get the features of the plugged device. */
-uint32_t virtio_bus_get_vdev_features(VirtioBusState *bus,
-                                    uint32_t requested_features);
+uint64_t virtio_bus_get_vdev_features(VirtioBusState *bus,
+                                      uint64_t requested_features);
 /* Get bad features of the plugged device. */
-uint32_t virtio_bus_get_vdev_bad_features(VirtioBusState *bus);
+uint64_t virtio_bus_get_vdev_bad_features(VirtioBusState *bus);
 /* Get config of the plugged device. */
 void virtio_bus_get_vdev_config(VirtioBusState *bus, uint8_t *config);
 /* Set config of the plugged device. */
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 6ceb5aa..5c58b4b 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -258,35 +258,35 @@ struct virtio_net_ctrl_mq {
  #define VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET        0
 
 #define DEFINE_VIRTIO_NET_FEATURES(_state, _field) \
-        DEFINE_PROP_BIT("any_layout", _state, _field, VIRTIO_F_ANY_LAYOUT, true), \
-        DEFINE_PROP_BIT("csum", _state, _field, VIRTIO_NET_F_CSUM, true), \
-        DEFINE_PROP_BIT("guest_csum", _state, _field, VIRTIO_NET_F_GUEST_CSUM, true), \
-        DEFINE_PROP_BIT("gso", _state, _field, VIRTIO_NET_F_GSO, true), \
-        DEFINE_PROP_BIT("guest_tso4", _state, _field, VIRTIO_NET_F_GUEST_TSO4, true), \
-        DEFINE_PROP_BIT("guest_tso6", _state, _field, VIRTIO_NET_F_GUEST_TSO6, true), \
-        DEFINE_PROP_BIT("guest_ecn", _state, _field, VIRTIO_NET_F_GUEST_ECN, true), \
-        DEFINE_PROP_BIT("guest_ufo", _state, _field, VIRTIO_NET_F_GUEST_UFO, true), \
-        DEFINE_PROP_BIT("guest_announce", _state, _field, VIRTIO_NET_F_GUEST_ANNOUNCE, true), \
-        DEFINE_PROP_BIT("host_tso4", _state, _field, VIRTIO_NET_F_HOST_TSO4, true), \
-        DEFINE_PROP_BIT("host_tso6", _state, _field, VIRTIO_NET_F_HOST_TSO6, true), \
-        DEFINE_PROP_BIT("host_ecn", _state, _field, VIRTIO_NET_F_HOST_ECN, true), \
-        DEFINE_PROP_BIT("host_ufo", _state, _field, VIRTIO_NET_F_HOST_UFO, true), \
-        DEFINE_PROP_BIT("mrg_rxbuf", _state, _field, VIRTIO_NET_F_MRG_RXBUF, true), \
-        DEFINE_PROP_BIT("status", _state, _field, VIRTIO_NET_F_STATUS, true), \
-        DEFINE_PROP_BIT("ctrl_vq", _state, _field, VIRTIO_NET_F_CTRL_VQ, true), \
-        DEFINE_PROP_BIT("ctrl_rx", _state, _field, VIRTIO_NET_F_CTRL_RX, true), \
-        DEFINE_PROP_BIT("ctrl_vlan", _state, _field, VIRTIO_NET_F_CTRL_VLAN, true), \
-        DEFINE_PROP_BIT("ctrl_rx_extra", _state, _field, VIRTIO_NET_F_CTRL_RX_EXTRA, true), \
-        DEFINE_PROP_BIT("ctrl_mac_addr", _state, _field, VIRTIO_NET_F_CTRL_MAC_ADDR, true), \
-        DEFINE_PROP_BIT("ctrl_guest_offloads", _state, _field, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true), \
-        DEFINE_PROP_BIT("mq", _state, _field, VIRTIO_NET_F_MQ, false)
+        DEFINE_PROP_BIT64("any_layout", _state, _field, VIRTIO_F_ANY_LAYOUT, true), \
+        DEFINE_PROP_BIT64("csum", _state, _field, VIRTIO_NET_F_CSUM, true), \
+        DEFINE_PROP_BIT64("guest_csum", _state, _field, VIRTIO_NET_F_GUEST_CSUM, true), \
+        DEFINE_PROP_BIT64("gso", _state, _field, VIRTIO_NET_F_GSO, true), \
+        DEFINE_PROP_BIT64("guest_tso4", _state, _field, VIRTIO_NET_F_GUEST_TSO4, true), \
+        DEFINE_PROP_BIT64("guest_tso6", _state, _field, VIRTIO_NET_F_GUEST_TSO6, true), \
+        DEFINE_PROP_BIT64("guest_ecn", _state, _field, VIRTIO_NET_F_GUEST_ECN, true), \
+        DEFINE_PROP_BIT64("guest_ufo", _state, _field, VIRTIO_NET_F_GUEST_UFO, true), \
+        DEFINE_PROP_BIT64("guest_announce", _state, _field, VIRTIO_NET_F_GUEST_ANNOUNCE, true), \
+        DEFINE_PROP_BIT64("host_tso4", _state, _field, VIRTIO_NET_F_HOST_TSO4, true), \
+        DEFINE_PROP_BIT64("host_tso6", _state, _field, VIRTIO_NET_F_HOST_TSO6, true), \
+        DEFINE_PROP_BIT64("host_ecn", _state, _field, VIRTIO_NET_F_HOST_ECN, true), \
+        DEFINE_PROP_BIT64("host_ufo", _state, _field, VIRTIO_NET_F_HOST_UFO, true), \
+        DEFINE_PROP_BIT64("mrg_rxbuf", _state, _field, VIRTIO_NET_F_MRG_RXBUF, true), \
+        DEFINE_PROP_BIT64("status", _state, _field, VIRTIO_NET_F_STATUS, true), \
+        DEFINE_PROP_BIT64("ctrl_vq", _state, _field, VIRTIO_NET_F_CTRL_VQ, true), \
+        DEFINE_PROP_BIT64("ctrl_rx", _state, _field, VIRTIO_NET_F_CTRL_RX, true), \
+        DEFINE_PROP_BIT64("ctrl_vlan", _state, _field, VIRTIO_NET_F_CTRL_VLAN, true), \
+        DEFINE_PROP_BIT64("ctrl_rx_extra", _state, _field, VIRTIO_NET_F_CTRL_RX_EXTRA, true), \
+        DEFINE_PROP_BIT64("ctrl_mac_addr", _state, _field, VIRTIO_NET_F_CTRL_MAC_ADDR, true), \
+        DEFINE_PROP_BIT64("ctrl_guest_offloads", _state, _field, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true), \
+        DEFINE_PROP_BIT64("mq", _state, _field, VIRTIO_NET_F_MQ, false)
 
 #define DEFINE_VIRTIO_NET_PROPERTIES(_state, _field)                           \
     DEFINE_PROP_UINT32("x-txtimer", _state, _field.txtimer, TX_TIMER_INTERVAL),\
     DEFINE_PROP_INT32("x-txburst", _state, _field.txburst, TX_BURST),          \
     DEFINE_PROP_STRING("tx", _state, _field.tx)
 
-void virtio_net_set_config_size(VirtIONet *n, uint32_t host_features);
+void virtio_net_set_config_size(VirtIONet *n, uint64_t host_features);
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
                                    const char *type);
 
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index bf17cc9..f0c0a6e 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -253,11 +253,11 @@ QEMU_BUILD_BUG_ON(offsetof(VirtIOSCSIReq, req.cdb) !=
     DEFINE_PROP_UINT32("cmd_per_lun", _state, _conf_field.cmd_per_lun, 128)
 
 #define DEFINE_VIRTIO_SCSI_FEATURES(_state, _feature_field)                    \
-    DEFINE_PROP_BIT("any_layout", _state, _feature_field,                      \
+    DEFINE_PROP_BIT64("any_layout", _state, _feature_field,                      \
                     VIRTIO_F_ANY_LAYOUT, true),                                \
-    DEFINE_PROP_BIT("hotplug", _state, _feature_field, VIRTIO_SCSI_F_HOTPLUG,  \
+    DEFINE_PROP_BIT64("hotplug", _state, _feature_field, VIRTIO_SCSI_F_HOTPLUG,  \
                                                        true),                  \
-    DEFINE_PROP_BIT("param_change", _state, _feature_field,                    \
+    DEFINE_PROP_BIT64("param_change", _state, _feature_field,                    \
                                             VIRTIO_SCSI_F_CHANGE, true)
 
 typedef void (*HandleOutput)(VirtIODevice *, VirtQueue *);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index f6c0379..08141c7 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -55,6 +55,12 @@
 /* A guest should never accept this.  It implies negotiation is broken. */
 #define VIRTIO_F_BAD_FEATURE		30
 
+/* v1.0 compliant. */
+#define VIRTIO_F_VERSION_1              32
+
+/* The highest feature bit that we support */
+#define VIRTIO_HIGHEST_FEATURE_BIT      32
+
 /* from Linux's linux/virtio_ring.h */
 
 /* This marks a buffer as continuing via the next field. */
@@ -117,7 +123,7 @@ struct VirtIODevice
     uint8_t status;
     uint8_t isr;
     uint16_t queue_sel;
-    uint32_t guest_features;
+    uint64_t guest_features;
     size_t config_len;
     void *config;
     uint16_t config_vector;
@@ -138,9 +144,9 @@ typedef struct VirtioDeviceClass {
     /* This is what a VirtioDevice must implement */
     DeviceRealize realize;
     DeviceUnrealize unrealize;
-    uint32_t (*get_features)(VirtIODevice *vdev, uint32_t requested_features);
-    uint32_t (*bad_features)(VirtIODevice *vdev);
-    void (*set_features)(VirtIODevice *vdev, uint32_t val);
+    uint64_t (*get_features)(VirtIODevice *vdev, uint64_t requested_features);
+    uint64_t (*bad_features)(VirtIODevice *vdev);
+    void (*set_features)(VirtIODevice *vdev, uint64_t val);
     void (*get_config)(VirtIODevice *vdev, uint8_t *config);
     void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
     void (*reset)(VirtIODevice *vdev);
@@ -225,7 +231,7 @@ void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector);
 void virtio_set_status(VirtIODevice *vdev, uint8_t val);
 void virtio_reset(void *opaque);
 void virtio_update_irq(VirtIODevice *vdev);
-int virtio_set_features(VirtIODevice *vdev, uint32_t val);
+int virtio_set_features(VirtIODevice *vdev, uint64_t val);
 
 /* Base devices.  */
 typedef struct VirtIOBlkConf VirtIOBlkConf;
@@ -238,9 +244,9 @@ typedef struct VirtIOSCSIConf VirtIOSCSIConf;
 typedef struct VirtIORNGConf VirtIORNGConf;
 
 #define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field) \
-	DEFINE_PROP_BIT("indirect_desc", _state, _field, \
+	DEFINE_PROP_BIT64("indirect_desc", _state, _field, \
 			VIRTIO_RING_F_INDIRECT_DESC, true), \
-	DEFINE_PROP_BIT("event_idx", _state, _field, \
+	DEFINE_PROP_BIT64("event_idx", _state, _field, \
 			VIRTIO_RING_F_EVENT_IDX, true)
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
@@ -266,22 +272,22 @@ void virtio_queue_set_host_notifier_fd_handler(VirtQueue *vq, bool assign,
 void virtio_queue_notify_vq(VirtQueue *vq);
 void virtio_irq(VirtQueue *vq);
 
-static inline void virtio_add_feature(uint32_t *features, unsigned int fbit)
+static inline void virtio_add_feature(uint64_t *features, unsigned int fbit)
 {
-    assert(fbit < 32);
-    *features |= (1 << fbit);
+    assert(fbit < 64);
+    *features |= (1ULL << fbit);
 }
 
-static inline void virtio_clear_feature(uint32_t *features, unsigned int fbit)
+static inline void virtio_clear_feature(uint64_t *features, unsigned int fbit)
 {
-    assert(fbit < 32);
-    *features &= ~(1 << fbit);
+    assert(fbit < 64);
+    *features &= ~(1ULL << fbit);
 }
 
-static inline bool __virtio_has_feature(uint32_t features, unsigned int fbit)
+static inline bool __virtio_has_feature(uint64_t features, unsigned int fbit)
 {
-    assert(fbit < 32);
-    return !!(features & (1 << fbit));
+    assert(fbit < 64);
+    return !!(features & (1ULL << fbit));
 }
 
 static inline bool virtio_has_feature(VirtIODevice *vdev, unsigned int fbit)
-- 
1.7.9.5
