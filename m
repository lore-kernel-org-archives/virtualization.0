From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v4 03/16] virtio: support more feature bits
Date: Thu, 27 Nov 2014 16:16:36 +0100
Message-ID: <1417101409-29482-4-git-send-email-cornelia.huck__43191.1806263544$1417101461$gmane$org@de.ibm.com>
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

With virtio-1, we support more than 32 feature bits. Let's make
vdev->guest_features depend on the number of supported feature bits,
allowing us to grow the feature bits automatically.

We also need to enhance the internal functions dealing with getting
and setting features with an additional index field, so that all feature
bits may be accessed (in chunks of 32 bits).

vhost and migration have been ignored for now.

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/9pfs/virtio-9p-device.c     |    7 ++++++-
 hw/block/virtio-blk.c          |    9 +++++++--
 hw/char/virtio-serial-bus.c    |    9 +++++++--
 hw/net/virtio-net.c            |   38 ++++++++++++++++++++++++++------------
 hw/s390x/s390-virtio-bus.c     |    9 +++++----
 hw/s390x/virtio-ccw.c          |   17 ++++++++++-------
 hw/scsi/vhost-scsi.c           |    7 +++++--
 hw/scsi/virtio-scsi.c          |   10 +++++-----
 hw/virtio/dataplane/vring.c    |   10 +++++-----
 hw/virtio/virtio-balloon.c     |    8 ++++++--
 hw/virtio/virtio-bus.c         |    9 +++++----
 hw/virtio/virtio-mmio.c        |    9 +++++----
 hw/virtio/virtio-pci.c         |   13 +++++++------
 hw/virtio/virtio-rng.c         |    2 +-
 hw/virtio/virtio.c             |   29 +++++++++++++++++------------
 include/hw/virtio/virtio-bus.h |    7 ++++---
 include/hw/virtio/virtio.h     |   19 ++++++++++++++-----
 17 files changed, 135 insertions(+), 77 deletions(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 2572747..c29c8c8 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -21,8 +21,13 @@
 #include "virtio-9p-coth.h"
 #include "hw/virtio/virtio-access.h"
 
-static uint32_t virtio_9p_get_features(VirtIODevice *vdev, uint32_t features)
+static uint32_t virtio_9p_get_features(VirtIODevice *vdev, unsigned int index,
+                                       uint32_t features)
 {
+    if (index > 0) {
+        return features;
+    }
+
     features |= 1 << VIRTIO_9P_MOUNT_TAG;
     return features;
 }
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b19b102..6d86f60 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -564,10 +564,15 @@ static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
     aio_context_release(blk_get_aio_context(s->blk));
 }
 
-static uint32_t virtio_blk_get_features(VirtIODevice *vdev, uint32_t features)
+static uint32_t virtio_blk_get_features(VirtIODevice *vdev, unsigned int index,
+                                        uint32_t features)
 {
     VirtIOBlock *s = VIRTIO_BLK(vdev);
 
+    if (index > 0) {
+        return features;
+    }
+
     features |= (1 << VIRTIO_BLK_F_SEG_MAX);
     features |= (1 << VIRTIO_BLK_F_GEOMETRY);
     features |= (1 << VIRTIO_BLK_F_TOPOLOGY);
@@ -601,7 +606,7 @@ static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
         return;
     }
 
-    features = vdev->guest_features;
+    features = vdev->guest_features[0];
 
     /* A guest that supports VIRTIO_BLK_F_CONFIG_WCE must be able to send
      * cache flushes.  Thus, the "auto writethrough" behavior is never
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index a7b1b68..55de504 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -75,7 +75,7 @@ static VirtIOSerialPort *find_port_by_name(char *name)
 static bool use_multiport(VirtIOSerial *vser)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(vser);
-    return vdev->guest_features & (1 << VIRTIO_CONSOLE_F_MULTIPORT);
+    return vdev->guest_features[0] & (1 << VIRTIO_CONSOLE_F_MULTIPORT);
 }
 
 static size_t write_to_port(VirtIOSerialPort *port,
@@ -467,10 +467,15 @@ static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
 {
 }
 
-static uint32_t get_features(VirtIODevice *vdev, uint32_t features)
+static uint32_t get_features(VirtIODevice *vdev, unsigned int index,
+                             uint32_t features)
 {
     VirtIOSerial *vser;
 
+    if (index > 0) {
+        return features;
+    }
+
     vser = VIRTIO_SERIAL(vdev);
 
     if (vser->bus.max_nr_ports > 1) {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9b88775..1e214b5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -86,7 +86,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
 
     memcpy(&netcfg, config, n->config_size);
 
-    if (!(vdev->guest_features >> VIRTIO_NET_F_CTRL_MAC_ADDR & 1) &&
+    if (!(vdev->guest_features[0] >> VIRTIO_NET_F_CTRL_MAC_ADDR & 1) &&
         memcmp(netcfg.mac, n->mac, ETH_ALEN)) {
         memcpy(n->mac, netcfg.mac, ETH_ALEN);
         qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
@@ -305,7 +305,7 @@ static RxFilterInfo *virtio_net_query_rxfilter(NetClientState *nc)
     info->multicast_table = str_list;
     info->vlan_table = get_vlan_table(n);
 
-    if (!((1 << VIRTIO_NET_F_CTRL_VLAN) & vdev->guest_features)) {
+    if (!((1 << VIRTIO_NET_F_CTRL_VLAN) & vdev->guest_features[0])) {
         info->vlan = RX_STATE_ALL;
     } else if (!info->vlan_table) {
         info->vlan = RX_STATE_NONE;
@@ -441,11 +441,16 @@ static void virtio_net_set_queues(VirtIONet *n)
 
 static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
 
-static uint32_t virtio_net_get_features(VirtIODevice *vdev, uint32_t features)
+static uint32_t virtio_net_get_features(VirtIODevice *vdev, unsigned int index,
+                                        uint32_t features)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc = qemu_get_queue(n->nic);
 
+    if (index > 0) {
+        return features;
+    }
+
     features |= (1 << VIRTIO_NET_F_MAC);
 
     if (!peer_has_vnet_hdr(n)) {
@@ -471,10 +476,14 @@ static uint32_t virtio_net_get_features(VirtIODevice *vdev, uint32_t features)
     return vhost_net_get_features(get_vhost_net(nc->peer), features);
 }
 
-static uint32_t virtio_net_bad_features(VirtIODevice *vdev)
+static uint32_t virtio_net_bad_features(VirtIODevice *vdev, unsigned int index)
 {
     uint32_t features = 0;
 
+    if (index > 0) {
+        return 0;
+    }
+
     /* Linux kernel 2.6.25.  It understood MAC (as everyone must),
      * but also these: */
     features |= (1 << VIRTIO_NET_F_MAC);
@@ -511,14 +520,19 @@ static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
 static inline uint64_t virtio_net_supported_guest_offloads(VirtIONet *n)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
-    return virtio_net_guest_offloads_by_features(vdev->guest_features);
+    return virtio_net_guest_offloads_by_features(vdev->guest_features[0]);
 }
 
-static void virtio_net_set_features(VirtIODevice *vdev, uint32_t features)
+static void virtio_net_set_features(VirtIODevice *vdev, unsigned int index,
+                                    uint32_t features)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     int i;
 
+    if (index > 0) {
+        return;
+    }
+
     virtio_net_set_multiqueue(n, !!(features & (1 << VIRTIO_NET_F_MQ)));
 
     virtio_net_set_mrg_rx_bufs(n, !!(features & (1 << VIRTIO_NET_F_MRG_RXBUF)));
@@ -585,7 +599,7 @@ static int virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,
     uint64_t offloads;
     size_t s;
 
-    if (!((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) & vdev->guest_features)) {
+    if (!((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) & vdev->guest_features[0])) {
         return VIRTIO_NET_ERR;
     }
 
@@ -1034,7 +1048,7 @@ static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf, size_t
                     "i %zd mergeable %d offset %zd, size %zd, "
                     "guest hdr len %zd, host hdr len %zd guest features 0x%x",
                     i, n->mergeable_rx_bufs, offset, size,
-                    n->guest_hdr_len, n->host_hdr_len, vdev->guest_features);
+                    n->guest_hdr_len, n->host_hdr_len, vdev->guest_features[0]);
             exit(1);
         }
 
@@ -1377,7 +1391,7 @@ static void virtio_net_save_device(VirtIODevice *vdev, QEMUFile *f)
         }
     }
 
-    if ((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) & vdev->guest_features) {
+    if ((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) & vdev->guest_features[0]) {
         qemu_put_be64(f, n->curr_guest_offloads);
     }
 }
@@ -1485,7 +1499,7 @@ static int virtio_net_load_device(VirtIODevice *vdev, QEMUFile *f,
         }
     }
 
-    if ((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) & vdev->guest_features) {
+    if ((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) & vdev->guest_features[0]) {
         n->curr_guest_offloads = qemu_get_be64(f);
     } else {
         n->curr_guest_offloads = virtio_net_supported_guest_offloads(n);
@@ -1512,8 +1526,8 @@ static int virtio_net_load_device(VirtIODevice *vdev, QEMUFile *f,
         qemu_get_subqueue(n->nic, i)->link_down = link_down;
     }
 
-    if (vdev->guest_features & (0x1 << VIRTIO_NET_F_GUEST_ANNOUNCE) &&
-        vdev->guest_features & (0x1 << VIRTIO_NET_F_CTRL_VQ)) {
+    if (vdev->guest_features[0] & (0x1 << VIRTIO_NET_F_GUEST_ANNOUNCE) &&
+        vdev->guest_features[0] & (0x1 << VIRTIO_NET_F_CTRL_VQ)) {
         n->announce_counter = SELF_ANNOUNCE_ROUNDS;
         timer_mod(n->announce_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL));
     }
diff --git a/hw/s390x/s390-virtio-bus.c b/hw/s390x/s390-virtio-bus.c
index 39dc201..b5cc131 100644
--- a/hw/s390x/s390-virtio-bus.c
+++ b/hw/s390x/s390-virtio-bus.c
@@ -128,7 +128,7 @@ static int s390_virtio_device_init(VirtIOS390Device *dev, VirtIODevice *vdev)
 
     bus->dev_offs += dev_len;
 
-    dev->host_features = virtio_bus_get_vdev_features(&dev->bus,
+    dev->host_features = virtio_bus_get_vdev_features(&dev->bus, 0,
                                                       dev->host_features);
     s390_virtio_device_sync(dev);
     s390_virtio_reset_idx(dev);
@@ -419,7 +419,7 @@ void s390_virtio_device_update_status(VirtIOS390Device *dev)
     /* Update guest supported feature bitmap */
 
     features = bswap32(ldl_be_phys(&address_space_memory, dev->feat_offs));
-    virtio_set_features(vdev, features);
+    virtio_set_features(vdev, 0, features);
 }
 
 VirtIOS390Device *s390_virtio_bus_console(VirtIOS390Bus *bus)
@@ -490,10 +490,11 @@ static void virtio_s390_notify(DeviceState *d, uint16_t vector)
     s390_virtio_irq(0, token);
 }
 
-static unsigned virtio_s390_get_features(DeviceState *d)
+static unsigned virtio_s390_get_features(DeviceState *d, unsigned int index)
 {
     VirtIOS390Device *dev = to_virtio_s390_device(d);
-    return dev->host_features;
+
+    return index == 0 ? dev->host_features : 0;
 }
 
 /**************** S390 Virtio Bus Device Descriptions *******************/
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 84f17bc..2f52b82 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -400,7 +400,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                                        ccw.cda + sizeof(features.features));
             features.features = ldl_le_phys(&address_space_memory, ccw.cda);
             if (features.index < ARRAY_SIZE(dev->host_features)) {
-                virtio_set_features(vdev, features.features);
+                virtio_set_features(vdev, features.index, features.features);
             } else {
                 /*
                  * If the guest supports more feature bits, assert that it
@@ -619,6 +619,7 @@ static int virtio_ccw_device_init(VirtioCcwDevice *dev, VirtIODevice *vdev)
     int ret;
     int num;
     DeviceState *parent = DEVICE(dev);
+    int i;
 
     sch = g_malloc0(sizeof(SubchDev));
 
@@ -739,9 +740,11 @@ static int virtio_ccw_device_init(VirtioCcwDevice *dev, VirtIODevice *vdev)
     sch->id.cu_type = VIRTIO_CCW_CU_TYPE;
     sch->id.cu_model = vdev->device_id;
 
-    /* Only the first 32 feature bits are used. */
-    dev->host_features[0] = virtio_bus_get_vdev_features(&dev->bus,
-                                                         dev->host_features[0]);
+    /* Set default feature bits that are offered by the host. */
+    for (i = 0; i < ARRAY_SIZE(dev->host_features); i++) {
+        dev->host_features[i] =
+            virtio_bus_get_vdev_features(&dev->bus, i, dev->host_features[i]);
+    }
 
     dev->host_features[0] |= 0x1 << VIRTIO_F_NOTIFY_ON_EMPTY;
     dev->host_features[0] |= 0x1 << VIRTIO_F_BAD_FEATURE;
@@ -1063,12 +1066,12 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
     }
 }
 
-static unsigned virtio_ccw_get_features(DeviceState *d)
+static unsigned virtio_ccw_get_features(DeviceState *d, unsigned int index)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
 
-    /* Only the first 32 feature bits are used. */
-    return dev->host_features[0];
+    return index < ARRAY_SIZE(dev->host_features) ?
+        dev->host_features[index] : 0;
 }
 
 static void virtio_ccw_reset(DeviceState *d)
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 308b393..8e1afa0 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -92,7 +92,7 @@ static int vhost_scsi_start(VHostSCSI *s)
         return ret;
     }
 
-    s->dev.acked_features = vdev->guest_features;
+    s->dev.acked_features = vdev->guest_features[0];
     ret = vhost_dev_start(&s->dev, vdev);
     if (ret < 0) {
         error_report("Error start vhost dev");
@@ -150,11 +150,14 @@ static void vhost_scsi_stop(VHostSCSI *s)
     vhost_dev_disable_notifiers(&s->dev, vdev);
 }
 
-static uint32_t vhost_scsi_get_features(VirtIODevice *vdev,
+static uint32_t vhost_scsi_get_features(VirtIODevice *vdev, unsigned int index,
                                         uint32_t features)
 {
     VHostSCSI *s = VHOST_SCSI(vdev);
 
+    if (index > 0) {
+        return features;
+    }
     return vhost_get_features(&s->dev, kernel_feature_bits, features);
 }
 
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index ef48550..189c59a 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -144,7 +144,7 @@ static int virtio_scsi_parse_req(VirtIOSCSIReq *req,
      *
      * TODO: always disable this workaround for virtio 1.0 devices.
      */
-    if ((vdev->guest_features & VIRTIO_F_ANY_LAYOUT) == 0) {
+    if ((vdev->guest_features[0] & VIRTIO_F_ANY_LAYOUT) == 0) {
         req_size = req->elem.out_sg[0].iov_len;
         resp_size = req->elem.in_sg[0].iov_len;
     }
@@ -627,7 +627,7 @@ static void virtio_scsi_set_config(VirtIODevice *vdev,
     vs->cdb_size = virtio_ldl_p(vdev, &scsiconf->cdb_size);
 }
 
-static uint32_t virtio_scsi_get_features(VirtIODevice *vdev,
+static uint32_t virtio_scsi_get_features(VirtIODevice *vdev, unsigned int index,
                                          uint32_t requested_features)
 {
     return requested_features;
@@ -748,7 +748,7 @@ static void virtio_scsi_change(SCSIBus *bus, SCSIDevice *dev, SCSISense sense)
     VirtIOSCSI *s = container_of(bus, VirtIOSCSI, bus);
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
-    if (((vdev->guest_features >> VIRTIO_SCSI_F_CHANGE) & 1) &&
+    if (((vdev->guest_features[0] >> VIRTIO_SCSI_F_CHANGE) & 1) &&
         dev->type != TYPE_ROM) {
         virtio_scsi_push_event(s, dev, VIRTIO_SCSI_T_PARAM_CHANGE,
                                sense.asc | (sense.ascq << 8));
@@ -769,7 +769,7 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         blk_op_block_all(sd->conf.blk, s->blocker);
     }
 
-    if ((vdev->guest_features >> VIRTIO_SCSI_F_HOTPLUG) & 1) {
+    if ((vdev->guest_features[0] >> VIRTIO_SCSI_F_HOTPLUG) & 1) {
         virtio_scsi_push_event(s, sd,
                                VIRTIO_SCSI_T_TRANSPORT_RESET,
                                VIRTIO_SCSI_EVT_RESET_RESCAN);
@@ -783,7 +783,7 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     VirtIOSCSI *s = VIRTIO_SCSI(vdev);
     SCSIDevice *sd = SCSI_DEVICE(dev);
 
-    if ((vdev->guest_features >> VIRTIO_SCSI_F_HOTPLUG) & 1) {
+    if ((vdev->guest_features[0] >> VIRTIO_SCSI_F_HOTPLUG) & 1) {
         virtio_scsi_push_event(s, sd,
                                VIRTIO_SCSI_T_TRANSPORT_RESET,
                                VIRTIO_SCSI_EVT_RESET_REMOVED);
diff --git a/hw/virtio/dataplane/vring.c b/hw/virtio/dataplane/vring.c
index 61f6d83..a051775 100644
--- a/hw/virtio/dataplane/vring.c
+++ b/hw/virtio/dataplane/vring.c
@@ -103,7 +103,7 @@ void vring_teardown(Vring *vring, VirtIODevice *vdev, int n)
 /* Disable guest->host notifies */
 void vring_disable_notification(VirtIODevice *vdev, Vring *vring)
 {
-    if (!(vdev->guest_features & (1 << VIRTIO_RING_F_EVENT_IDX))) {
+    if (!(vdev->guest_features[0] & (1 << VIRTIO_RING_F_EVENT_IDX))) {
         vring->vr.used->flags |= VRING_USED_F_NO_NOTIFY;
     }
 }
@@ -114,7 +114,7 @@ void vring_disable_notification(VirtIODevice *vdev, Vring *vring)
  */
 bool vring_enable_notification(VirtIODevice *vdev, Vring *vring)
 {
-    if (vdev->guest_features & (1 << VIRTIO_RING_F_EVENT_IDX)) {
+    if (vdev->guest_features[0] & (1 << VIRTIO_RING_F_EVENT_IDX)) {
         vring_avail_event(&vring->vr) = vring->vr.avail->idx;
     } else {
         vring->vr.used->flags &= ~VRING_USED_F_NO_NOTIFY;
@@ -133,12 +133,12 @@ bool vring_should_notify(VirtIODevice *vdev, Vring *vring)
      * interrupts. */
     smp_mb();
 
-    if ((vdev->guest_features & VIRTIO_F_NOTIFY_ON_EMPTY) &&
+    if ((vdev->guest_features[0] & VIRTIO_F_NOTIFY_ON_EMPTY) &&
         unlikely(vring->vr.avail->idx == vring->last_avail_idx)) {
         return true;
     }
 
-    if (!(vdev->guest_features & VIRTIO_RING_F_EVENT_IDX)) {
+    if (!(vdev->guest_features[0] & VIRTIO_RING_F_EVENT_IDX)) {
         return !(vring->vr.avail->flags & VRING_AVAIL_F_NO_INTERRUPT);
     }
     old = vring->signalled_used;
@@ -388,7 +388,7 @@ int vring_pop(VirtIODevice *vdev, Vring *vring,
 
     /* On success, increment avail index. */
     vring->last_avail_idx++;
-    if (vdev->guest_features & (1 << VIRTIO_RING_F_EVENT_IDX)) {
+    if (vdev->guest_features[0] & (1 << VIRTIO_RING_F_EVENT_IDX)) {
         vring_avail_event(&vring->vr) = vring->last_avail_idx;
     }
 
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 7bfbb75..c5b7a4d 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -69,7 +69,7 @@ static inline void reset_stats(VirtIOBalloon *dev)
 static bool balloon_stats_supported(const VirtIOBalloon *s)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
-    return vdev->guest_features & (1 << VIRTIO_BALLOON_F_STATS_VQ);
+    return vdev->guest_features[0] & (1 << VIRTIO_BALLOON_F_STATS_VQ);
 }
 
 static bool balloon_stats_enabled(const VirtIOBalloon *s)
@@ -303,8 +303,12 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
     }
 }
 
-static uint32_t virtio_balloon_get_features(VirtIODevice *vdev, uint32_t f)
+static uint32_t virtio_balloon_get_features(VirtIODevice *vdev,
+                                            unsigned int index, uint32_t f)
 {
+    if (index > 0) {
+        return f;
+    }
     f |= (1 << VIRTIO_BALLOON_F_STATS_VQ);
     return f;
 }
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index a8ffa07..503114d 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -97,7 +97,7 @@ size_t virtio_bus_get_vdev_config_len(VirtioBusState *bus)
 }
 
 /* Get the features of the plugged device. */
-uint32_t virtio_bus_get_vdev_features(VirtioBusState *bus,
+uint32_t virtio_bus_get_vdev_features(VirtioBusState *bus, unsigned int index,
                                     uint32_t requested_features)
 {
     VirtIODevice *vdev = virtio_bus_get_device(bus);
@@ -106,11 +106,12 @@ uint32_t virtio_bus_get_vdev_features(VirtioBusState *bus,
     assert(vdev != NULL);
     k = VIRTIO_DEVICE_GET_CLASS(vdev);
     assert(k->get_features != NULL);
-    return k->get_features(vdev, requested_features);
+    return k->get_features(vdev, index, requested_features);
 }
 
 /* Get bad features of the plugged device. */
-uint32_t virtio_bus_get_vdev_bad_features(VirtioBusState *bus)
+uint32_t virtio_bus_get_vdev_bad_features(VirtioBusState *bus,
+                                          unsigned int index)
 {
     VirtIODevice *vdev = virtio_bus_get_device(bus);
     VirtioDeviceClass *k;
@@ -118,7 +119,7 @@ uint32_t virtio_bus_get_vdev_bad_features(VirtioBusState *bus)
     assert(vdev != NULL);
     k = VIRTIO_DEVICE_GET_CLASS(vdev);
     if (k->bad_features != NULL) {
-        return k->bad_features(vdev);
+        return k->bad_features(vdev, index);
     } else {
         return 0;
     }
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 2450c13..e83bb47 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -222,7 +222,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         break;
     case VIRTIO_MMIO_GUESTFEATURES:
         if (!proxy->guest_features_sel) {
-            virtio_set_features(vdev, value);
+            virtio_set_features(vdev, 0, value);
         }
         break;
     case VIRTIO_MMIO_GUESTFEATURESSEL:
@@ -306,11 +306,12 @@ static void virtio_mmio_update_irq(DeviceState *opaque, uint16_t vector)
     qemu_set_irq(proxy->irq, level);
 }
 
-static unsigned int virtio_mmio_get_features(DeviceState *opaque)
+static unsigned int virtio_mmio_get_features(DeviceState *opaque,
+                                             unsigned int index)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
 
-    return proxy->host_features;
+    return index == 0 ? proxy->host_features : 0;
 }
 
 static int virtio_mmio_load_config(DeviceState *opaque, QEMUFile *f)
@@ -350,7 +351,7 @@ static void virtio_mmio_device_plugged(DeviceState *opaque)
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
 
     proxy->host_features |= (0x1 << VIRTIO_F_NOTIFY_ON_EMPTY);
-    proxy->host_features = virtio_bus_get_vdev_features(&proxy->bus,
+    proxy->host_features = virtio_bus_get_vdev_features(&proxy->bus, 0,
                                                         proxy->host_features);
 }
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index dde1d73..00eeeb6 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -272,9 +272,9 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
     case VIRTIO_PCI_GUEST_FEATURES:
         /* Guest does not negotiate properly?  We have to assume nothing. */
         if (val & (1 << VIRTIO_F_BAD_FEATURE)) {
-            val = virtio_bus_get_vdev_bad_features(&proxy->bus);
+            val = virtio_bus_get_vdev_bad_features(&proxy->bus, 0);
         }
-        virtio_set_features(vdev, val);
+        virtio_set_features(vdev, 0, val);
         break;
     case VIRTIO_PCI_QUEUE_PFN:
         pa = (hwaddr)val << VIRTIO_PCI_QUEUE_ADDR_SHIFT;
@@ -353,7 +353,7 @@ static uint32_t virtio_ioport_read(VirtIOPCIProxy *proxy, uint32_t addr)
         ret = proxy->host_features;
         break;
     case VIRTIO_PCI_GUEST_FEATURES:
-        ret = vdev->guest_features;
+        ret = vdev->guest_features[0];
         break;
     case VIRTIO_PCI_QUEUE_PFN:
         ret = virtio_queue_get_addr(vdev, vdev->queue_sel)
@@ -478,10 +478,11 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
     }
 }
 
-static unsigned virtio_pci_get_features(DeviceState *d)
+static unsigned virtio_pci_get_features(DeviceState *d, unsigned int index)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
-    return proxy->host_features;
+
+    return index == 0 ? proxy->host_features : 0;
 }
 
 static int kvm_virtio_pci_vq_vector_use(VirtIOPCIProxy *proxy,
@@ -998,7 +999,7 @@ static void virtio_pci_device_plugged(DeviceState *d)
 
     proxy->host_features |= 0x1 << VIRTIO_F_NOTIFY_ON_EMPTY;
     proxy->host_features |= 0x1 << VIRTIO_F_BAD_FEATURE;
-    proxy->host_features = virtio_bus_get_vdev_features(bus,
+    proxy->host_features = virtio_bus_get_vdev_features(bus, 0,
                                                       proxy->host_features);
 }
 
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index e85a979..2814017 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -99,7 +99,7 @@ static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
     virtio_rng_process(vrng);
 }
 
-static uint32_t get_features(VirtIODevice *vdev, uint32_t f)
+static uint32_t get_features(VirtIODevice *vdev, unsigned int index, uint32_t f)
 {
     return f;
 }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 013979a..2eb5d3c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -217,7 +217,7 @@ static inline void vring_avail_event(VirtQueue *vq, uint16_t val)
 void virtio_queue_set_notification(VirtQueue *vq, int enable)
 {
     vq->notification = enable;
-    if (vq->vdev->guest_features & (1 << VIRTIO_RING_F_EVENT_IDX)) {
+    if (vq->vdev->guest_features[0] & (1 << VIRTIO_RING_F_EVENT_IDX)) {
         vring_avail_event(vq, vring_avail_idx(vq));
     } else if (enable) {
         vring_used_flags_unset_bit(vq, VRING_USED_F_NO_NOTIFY);
@@ -468,7 +468,7 @@ int virtqueue_pop(VirtQueue *vq, VirtQueueElement *elem)
     max = vq->vring.num;
 
     i = head = virtqueue_get_head(vq, vq->last_avail_idx++);
-    if (vdev->guest_features & (1 << VIRTIO_RING_F_EVENT_IDX)) {
+    if (vdev->guest_features[0] & (1 << VIRTIO_RING_F_EVENT_IDX)) {
         vring_avail_event(vq, vq->last_avail_idx);
     }
 
@@ -592,7 +592,10 @@ void virtio_reset(void *opaque)
         k->reset(vdev);
     }
 
-    vdev->guest_features = 0;
+    for (i = 0; i < ARRAY_SIZE(vdev->guest_features); i++) {
+        vdev->guest_features[i] = 0;
+    }
+
     vdev->queue_sel = 0;
     vdev->status = 0;
     vdev->isr = 0;
@@ -839,12 +842,12 @@ static bool vring_notify(VirtIODevice *vdev, VirtQueue *vq)
     /* We need to expose used array entries before checking used event. */
     smp_mb();
     /* Always notify when queue is empty (when feature acknowledge) */
-    if (((vdev->guest_features & (1 << VIRTIO_F_NOTIFY_ON_EMPTY)) &&
+    if (((vdev->guest_features[0] & (1 << VIRTIO_F_NOTIFY_ON_EMPTY)) &&
          !vq->inuse && vring_avail_idx(vq) == vq->last_avail_idx)) {
         return true;
     }
 
-    if (!(vdev->guest_features & (1 << VIRTIO_RING_F_EVENT_IDX))) {
+    if (!(vdev->guest_features[0] & (1 << VIRTIO_RING_F_EVENT_IDX))) {
         return !(vring_avail_flags(vq) & VRING_AVAIL_F_NO_INTERRUPT);
     }
 
@@ -924,7 +927,8 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
     qemu_put_8s(f, &vdev->status);
     qemu_put_8s(f, &vdev->isr);
     qemu_put_be16s(f, &vdev->queue_sel);
-    qemu_put_be32s(f, &vdev->guest_features);
+    /* XXX features >= 32 */
+    qemu_put_be32s(f, &vdev->guest_features[0]);
     qemu_put_be32(f, vdev->config_len);
     qemu_put_buffer(f, vdev->config, vdev->config_len);
 
@@ -958,19 +962,19 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
     vmstate_save_state(f, &vmstate_virtio, vdev);
 }
 
-int virtio_set_features(VirtIODevice *vdev, uint32_t val)
+int virtio_set_features(VirtIODevice *vdev, unsigned int index, uint32_t val)
 {
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *vbusk = VIRTIO_BUS_GET_CLASS(qbus);
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
-    uint32_t supported_features = vbusk->get_features(qbus->parent);
+    uint32_t supported_features = vbusk->get_features(qbus->parent, index);
     bool bad = (val & ~supported_features) != 0;
 
     val &= supported_features;
     if (k->set_features) {
-        k->set_features(vdev, val);
+        k->set_features(vdev, index, val);
     }
-    vdev->guest_features = val;
+    vdev->guest_features[index] = val;
     return bad ? -1 : 0;
 }
 
@@ -1005,8 +1009,9 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     }
     qemu_get_be32s(f, &features);
 
-    if (virtio_set_features(vdev, features) < 0) {
-        supported_features = k->get_features(qbus->parent);
+    /* XXX features >= 32 */
+    if (virtio_set_features(vdev, 0, features) < 0) {
+        supported_features = k->get_features(qbus->parent, 0);
         error_report("Features 0x%x unsupported. Allowed features: 0x%x",
                      features, supported_features);
         return -1;
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index 0d2e7b4..03f4432 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -47,7 +47,7 @@ typedef struct VirtioBusClass {
     int (*load_config)(DeviceState *d, QEMUFile *f);
     int (*load_queue)(DeviceState *d, int n, QEMUFile *f);
     int (*load_done)(DeviceState *d, QEMUFile *f);
-    unsigned (*get_features)(DeviceState *d);
+    unsigned (*get_features)(DeviceState *d, unsigned int index);
     bool (*query_guest_notifiers)(DeviceState *d);
     int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
     int (*set_host_notifier)(DeviceState *d, int n, bool assigned);
@@ -82,10 +82,11 @@ uint16_t virtio_bus_get_vdev_id(VirtioBusState *bus);
 /* Get the config_len field of the plugged device. */
 size_t virtio_bus_get_vdev_config_len(VirtioBusState *bus);
 /* Get the features of the plugged device. */
-uint32_t virtio_bus_get_vdev_features(VirtioBusState *bus,
+uint32_t virtio_bus_get_vdev_features(VirtioBusState *bus, unsigned int index,
                                     uint32_t requested_features);
 /* Get bad features of the plugged device. */
-uint32_t virtio_bus_get_vdev_bad_features(VirtioBusState *bus);
+uint32_t virtio_bus_get_vdev_bad_features(VirtioBusState *bus,
+                                          unsigned int index);
 /* Get config of the plugged device. */
 void virtio_bus_get_vdev_config(VirtioBusState *bus, uint8_t *config);
 /* Set config of the plugged device. */
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 0726d76..b408166 100644
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
@@ -110,6 +116,8 @@ enum virtio_device_endian {
     VIRTIO_DEVICE_ENDIAN_BIG,
 };
 
+#define NR_VIRTIO_FEATURE_WORDS ((VIRTIO_HIGHEST_FEATURE_BIT + 32) / 32)
+
 struct VirtIODevice
 {
     DeviceState parent_obj;
@@ -117,7 +125,7 @@ struct VirtIODevice
     uint8_t status;
     uint8_t isr;
     uint16_t queue_sel;
-    uint32_t guest_features;
+    uint32_t guest_features[NR_VIRTIO_FEATURE_WORDS];
     size_t config_len;
     void *config;
     uint16_t config_vector;
@@ -138,9 +146,10 @@ typedef struct VirtioDeviceClass {
     /* This is what a VirtioDevice must implement */
     DeviceRealize realize;
     DeviceUnrealize unrealize;
-    uint32_t (*get_features)(VirtIODevice *vdev, uint32_t requested_features);
-    uint32_t (*bad_features)(VirtIODevice *vdev);
-    void (*set_features)(VirtIODevice *vdev, uint32_t val);
+    uint32_t (*get_features)(VirtIODevice *vdev, unsigned int index,
+                             uint32_t requested_features);
+    uint32_t (*bad_features)(VirtIODevice *vdev, unsigned int index);
+    void (*set_features)(VirtIODevice *vdev, unsigned int index, uint32_t val);
     void (*get_config)(VirtIODevice *vdev, uint8_t *config);
     void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
     void (*reset)(VirtIODevice *vdev);
@@ -225,7 +234,7 @@ void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector);
 void virtio_set_status(VirtIODevice *vdev, uint8_t val);
 void virtio_reset(void *opaque);
 void virtio_update_irq(VirtIODevice *vdev);
-int virtio_set_features(VirtIODevice *vdev, uint32_t val);
+int virtio_set_features(VirtIODevice *vdev, unsigned int index, uint32_t val);
 
 /* Base devices.  */
 typedef struct VirtIOBlkConf VirtIOBlkConf;
-- 
1.7.9.5
