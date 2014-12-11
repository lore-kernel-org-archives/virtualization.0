From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v6 04/20] virtio: add feature checking helpers
Date: Thu, 11 Dec 2014 14:25:06 +0100
Message-ID: <1418304322-7546-5-git-send-email-cornelia.huck@de.ibm.com>
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

Add a helper function for checking whether a bit is set in the guest
features for a vdev as well as one that works on a feature bit set.

Convert code that open-coded this: It cleans up the code and makes it
easier to extend the guest feature bits.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/block/virtio-blk.c       |    7 ++-----
 hw/char/virtio-serial-bus.c |    2 +-
 hw/net/virtio-net.c         |   23 +++++++++++++----------
 hw/scsi/virtio-scsi.c       |    8 ++++----
 hw/virtio/dataplane/vring.c |   10 +++++-----
 hw/virtio/virtio-balloon.c  |    2 +-
 hw/virtio/virtio.c          |   10 +++++-----
 include/hw/virtio/virtio.h  |   11 +++++++++++
 8 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 3f76e2a..27f263a 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -590,7 +590,6 @@ static uint32_t virtio_blk_get_features(VirtIODevice *vdev, uint32_t features)
 static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VirtIOBlock *s = VIRTIO_BLK(vdev);
-    uint32_t features;
 
     if (s->dataplane && !(status & (VIRTIO_CONFIG_S_DRIVER |
                                     VIRTIO_CONFIG_S_DRIVER_OK))) {
@@ -601,8 +600,6 @@ static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
         return;
     }
 
-    features = vdev->guest_features;
-
     /* A guest that supports VIRTIO_BLK_F_CONFIG_WCE must be able to send
      * cache flushes.  Thus, the "auto writethrough" behavior is never
      * necessary for guests that support the VIRTIO_BLK_F_CONFIG_WCE feature.
@@ -618,10 +615,10 @@ static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
      *
      * s->blk would erroneously be placed in writethrough mode.
      */
-    if (!(features & (1 << VIRTIO_BLK_F_CONFIG_WCE))) {
+    if (!virtio_has_feature(vdev, VIRTIO_BLK_F_CONFIG_WCE)) {
         aio_context_acquire(blk_get_aio_context(s->blk));
         blk_set_enable_write_cache(s->blk,
-                                   !!(features & (1 << VIRTIO_BLK_F_WCE)));
+                                   virtio_has_feature(vdev, VIRTIO_BLK_F_WCE));
         aio_context_release(blk_get_aio_context(s->blk));
     }
 }
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 0f637db..d49883f 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -75,7 +75,7 @@ static VirtIOSerialPort *find_port_by_name(char *name)
 static bool use_multiport(VirtIOSerial *vser)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(vser);
-    return vdev->guest_features & (1 << VIRTIO_CONSOLE_F_MULTIPORT);
+    return virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT);
 }
 
 static size_t write_to_port(VirtIOSerialPort *port,
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f1aa100..9f3c58a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -86,7 +86,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
 
     memcpy(&netcfg, config, n->config_size);
 
-    if (!(vdev->guest_features >> VIRTIO_NET_F_CTRL_MAC_ADDR & 1) &&
+    if (!virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR) &&
         memcmp(netcfg.mac, n->mac, ETH_ALEN)) {
         memcpy(n->mac, netcfg.mac, ETH_ALEN);
         qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
@@ -305,7 +305,7 @@ static RxFilterInfo *virtio_net_query_rxfilter(NetClientState *nc)
     info->multicast_table = str_list;
     info->vlan_table = get_vlan_table(n);
 
-    if (!((1 << VIRTIO_NET_F_CTRL_VLAN) & vdev->guest_features)) {
+    if (!virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VLAN)) {
         info->vlan = RX_STATE_ALL;
     } else if (!info->vlan_table) {
         info->vlan = RX_STATE_NONE;
@@ -519,9 +519,12 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint32_t features)
     VirtIONet *n = VIRTIO_NET(vdev);
     int i;
 
-    virtio_net_set_multiqueue(n, !!(features & (1 << VIRTIO_NET_F_MQ)));
+    virtio_net_set_multiqueue(n,
+                              __virtio_has_feature(features, VIRTIO_NET_F_MQ));
 
-    virtio_net_set_mrg_rx_bufs(n, !!(features & (1 << VIRTIO_NET_F_MRG_RXBUF)));
+    virtio_net_set_mrg_rx_bufs(n,
+                               __virtio_has_feature(features,
+                                                    VIRTIO_NET_F_MRG_RXBUF));
 
     if (n->has_vnet_hdr) {
         n->curr_guest_offloads =
@@ -538,7 +541,7 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint32_t features)
         vhost_net_ack_features(get_vhost_net(nc->peer), features);
     }
 
-    if ((1 << VIRTIO_NET_F_CTRL_VLAN) & features) {
+    if (__virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
         memset(n->vlans, 0, MAX_VLAN >> 3);
     } else {
         memset(n->vlans, 0xff, MAX_VLAN >> 3);
@@ -585,7 +588,7 @@ static int virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,
     uint64_t offloads;
     size_t s;
 
-    if (!((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) & vdev->guest_features)) {
+    if (!virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
         return VIRTIO_NET_ERR;
     }
 
@@ -1378,7 +1381,7 @@ static void virtio_net_save_device(VirtIODevice *vdev, QEMUFile *f)
         }
     }
 
-    if ((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) & vdev->guest_features) {
+    if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
         qemu_put_be64(f, n->curr_guest_offloads);
     }
 }
@@ -1486,7 +1489,7 @@ static int virtio_net_load_device(VirtIODevice *vdev, QEMUFile *f,
         }
     }
 
-    if ((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) & vdev->guest_features) {
+    if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
         n->curr_guest_offloads = qemu_get_be64(f);
     } else {
         n->curr_guest_offloads = virtio_net_supported_guest_offloads(n);
@@ -1513,8 +1516,8 @@ static int virtio_net_load_device(VirtIODevice *vdev, QEMUFile *f,
         qemu_get_subqueue(n->nic, i)->link_down = link_down;
     }
 
-    if (vdev->guest_features & (0x1 << VIRTIO_NET_F_GUEST_ANNOUNCE) &&
-        vdev->guest_features & (0x1 << VIRTIO_NET_F_CTRL_VQ)) {
+    if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ANNOUNCE) &&
+        virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ)) {
         n->announce_counter = SELF_ANNOUNCE_ROUNDS;
         timer_mod(n->announce_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL));
     }
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index ef48550..56c92fb 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -144,7 +144,7 @@ static int virtio_scsi_parse_req(VirtIOSCSIReq *req,
      *
      * TODO: always disable this workaround for virtio 1.0 devices.
      */
-    if ((vdev->guest_features & VIRTIO_F_ANY_LAYOUT) == 0) {
+    if (!virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT)) {
         req_size = req->elem.out_sg[0].iov_len;
         resp_size = req->elem.in_sg[0].iov_len;
     }
@@ -748,7 +748,7 @@ static void virtio_scsi_change(SCSIBus *bus, SCSIDevice *dev, SCSISense sense)
     VirtIOSCSI *s = container_of(bus, VirtIOSCSI, bus);
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
-    if (((vdev->guest_features >> VIRTIO_SCSI_F_CHANGE) & 1) &&
+    if (virtio_has_feature(vdev, VIRTIO_SCSI_F_CHANGE) &&
         dev->type != TYPE_ROM) {
         virtio_scsi_push_event(s, dev, VIRTIO_SCSI_T_PARAM_CHANGE,
                                sense.asc | (sense.ascq << 8));
@@ -769,7 +769,7 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         blk_op_block_all(sd->conf.blk, s->blocker);
     }
 
-    if ((vdev->guest_features >> VIRTIO_SCSI_F_HOTPLUG) & 1) {
+    if (virtio_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
         virtio_scsi_push_event(s, sd,
                                VIRTIO_SCSI_T_TRANSPORT_RESET,
                                VIRTIO_SCSI_EVT_RESET_RESCAN);
@@ -783,7 +783,7 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     VirtIOSCSI *s = VIRTIO_SCSI(vdev);
     SCSIDevice *sd = SCSI_DEVICE(dev);
 
-    if ((vdev->guest_features >> VIRTIO_SCSI_F_HOTPLUG) & 1) {
+    if (virtio_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
         virtio_scsi_push_event(s, sd,
                                VIRTIO_SCSI_T_TRANSPORT_RESET,
                                VIRTIO_SCSI_EVT_RESET_REMOVED);
diff --git a/hw/virtio/dataplane/vring.c b/hw/virtio/dataplane/vring.c
index 61f6d83..6e283fc 100644
--- a/hw/virtio/dataplane/vring.c
+++ b/hw/virtio/dataplane/vring.c
@@ -103,7 +103,7 @@ void vring_teardown(Vring *vring, VirtIODevice *vdev, int n)
 /* Disable guest->host notifies */
 void vring_disable_notification(VirtIODevice *vdev, Vring *vring)
 {
-    if (!(vdev->guest_features & (1 << VIRTIO_RING_F_EVENT_IDX))) {
+    if (!virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring->vr.used->flags |= VRING_USED_F_NO_NOTIFY;
     }
 }
@@ -114,7 +114,7 @@ void vring_disable_notification(VirtIODevice *vdev, Vring *vring)
  */
 bool vring_enable_notification(VirtIODevice *vdev, Vring *vring)
 {
-    if (vdev->guest_features & (1 << VIRTIO_RING_F_EVENT_IDX)) {
+    if (virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_avail_event(&vring->vr) = vring->vr.avail->idx;
     } else {
         vring->vr.used->flags &= ~VRING_USED_F_NO_NOTIFY;
@@ -133,12 +133,12 @@ bool vring_should_notify(VirtIODevice *vdev, Vring *vring)
      * interrupts. */
     smp_mb();
 
-    if ((vdev->guest_features & VIRTIO_F_NOTIFY_ON_EMPTY) &&
+    if (virtio_has_feature(vdev, VIRTIO_F_NOTIFY_ON_EMPTY) &&
         unlikely(vring->vr.avail->idx == vring->last_avail_idx)) {
         return true;
     }
 
-    if (!(vdev->guest_features & VIRTIO_RING_F_EVENT_IDX)) {
+    if (!virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
         return !(vring->vr.avail->flags & VRING_AVAIL_F_NO_INTERRUPT);
     }
     old = vring->signalled_used;
@@ -388,7 +388,7 @@ int vring_pop(VirtIODevice *vdev, Vring *vring,
 
     /* On success, increment avail index. */
     vring->last_avail_idx++;
-    if (vdev->guest_features & (1 << VIRTIO_RING_F_EVENT_IDX)) {
+    if (virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_avail_event(&vring->vr) = vring->last_avail_idx;
     }
 
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 7bfbb75..21e449a 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -69,7 +69,7 @@ static inline void reset_stats(VirtIOBalloon *dev)
 static bool balloon_stats_supported(const VirtIOBalloon *s)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
-    return vdev->guest_features & (1 << VIRTIO_BALLOON_F_STATS_VQ);
+    return virtio_has_feature(vdev, VIRTIO_BALLOON_F_STATS_VQ);
 }
 
 static bool balloon_stats_enabled(const VirtIOBalloon *s)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 013979a..5814433 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -217,7 +217,7 @@ static inline void vring_avail_event(VirtQueue *vq, uint16_t val)
 void virtio_queue_set_notification(VirtQueue *vq, int enable)
 {
     vq->notification = enable;
-    if (vq->vdev->guest_features & (1 << VIRTIO_RING_F_EVENT_IDX)) {
+    if (virtio_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_avail_event(vq, vring_avail_idx(vq));
     } else if (enable) {
         vring_used_flags_unset_bit(vq, VRING_USED_F_NO_NOTIFY);
@@ -468,7 +468,7 @@ int virtqueue_pop(VirtQueue *vq, VirtQueueElement *elem)
     max = vq->vring.num;
 
     i = head = virtqueue_get_head(vq, vq->last_avail_idx++);
-    if (vdev->guest_features & (1 << VIRTIO_RING_F_EVENT_IDX)) {
+    if (virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_avail_event(vq, vq->last_avail_idx);
     }
 
@@ -839,12 +839,12 @@ static bool vring_notify(VirtIODevice *vdev, VirtQueue *vq)
     /* We need to expose used array entries before checking used event. */
     smp_mb();
     /* Always notify when queue is empty (when feature acknowledge) */
-    if (((vdev->guest_features & (1 << VIRTIO_F_NOTIFY_ON_EMPTY)) &&
-         !vq->inuse && vring_avail_idx(vq) == vq->last_avail_idx)) {
+    if (virtio_has_feature(vdev, VIRTIO_F_NOTIFY_ON_EMPTY) &&
+        !vq->inuse && vring_avail_idx(vq) == vq->last_avail_idx) {
         return true;
     }
 
-    if (!(vdev->guest_features & (1 << VIRTIO_RING_F_EVENT_IDX))) {
+    if (!virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
         return !(vring_avail_flags(vq) & VRING_AVAIL_F_NO_INTERRUPT);
     }
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 2fede2e..f6c0379 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -278,6 +278,17 @@ static inline void virtio_clear_feature(uint32_t *features, unsigned int fbit)
     *features &= ~(1 << fbit);
 }
 
+static inline bool __virtio_has_feature(uint32_t features, unsigned int fbit)
+{
+    assert(fbit < 32);
+    return !!(features & (1 << fbit));
+}
+
+static inline bool virtio_has_feature(VirtIODevice *vdev, unsigned int fbit)
+{
+    return __virtio_has_feature(vdev->guest_features, fbit);
+}
+
 static inline bool virtio_is_big_endian(VirtIODevice *vdev)
 {
     assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
-- 
1.7.9.5
