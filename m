From: Jason Wang <jasowang@redhat.com>
Subject: [RFC V3 5/5] virtio-net: add multiqueue support
Date: Fri,  6 Jul 2012 17:31:10 +0800
Message-ID: <1341567070-14136-6-git-send-email-jasowang__11893.2902849794$1341567500$gmane$org@redhat.com>
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

Based on the multiqueue support for taps and NICState, this patch add the
capability of multiqueue for virtio-net. For userspace virtio-net emulation,
each pair of VLANClientState peers were abstracted as a tx/rx queue. For vhost,
the vhost net devices were created per virtio-net tx/rx queue pairs, so when
multiqueue is enabled, N vhost devices/threads were created for a N queues
virtio-net devices.

Since guest may not want to use all queues that qemu provided ( one example is
the old guest w/o multiqueue support). The files were attached/detached on
demand when guest set status for virtio_net.

This feature was negotiated through VIRTIO_NET_F_MULTIQUEUE. A new property
"queues" were added to virtio-net device to specify the number of queues it
supported. With this patch a virtio-net backend with N queues could be created
by:

qemu -netdev tap,id=hn0,queues=2 -device virtio-net-pci,netdev=hn0,queues=2

To let user tweak the performance, guest could negotiate the num of queues it
wishes to use through control virtqueue.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio-net.c |  505 ++++++++++++++++++++++++++++++++++++++-----------------
 hw/virtio-net.h |   12 ++
 2 files changed, 361 insertions(+), 156 deletions(-)

diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index 30eb4f4..afe69e8 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -21,39 +21,48 @@
 #include "virtio-net.h"
 #include "vhost_net.h"
 
-#define VIRTIO_NET_VM_VERSION    11
+#define VIRTIO_NET_VM_VERSION    12
 
 #define MAC_TABLE_ENTRIES    64
 #define MAX_VLAN    (1 << 12)   /* Per 802.1Q definition */
 
-typedef struct VirtIONet
+struct VirtIONet;
+
+typedef struct VirtIONetQueue
 {
-    VirtIODevice vdev;
-    uint8_t mac[ETH_ALEN];
-    uint16_t status;
     VirtQueue *rx_vq;
     VirtQueue *tx_vq;
-    VirtQueue *ctrl_vq;
-    NICState *nic;
     QEMUTimer *tx_timer;
     QEMUBH *tx_bh;
     uint32_t tx_timeout;
-    int32_t tx_burst;
     int tx_waiting;
-    uint32_t has_vnet_hdr;
-    uint8_t has_ufo;
     struct {
         VirtQueueElement elem;
         ssize_t len;
     } async_tx;
+    struct VirtIONet *n;
+    uint8_t vhost_started;
+} VirtIONetQueue;
+
+typedef struct VirtIONet
+{
+    VirtIODevice vdev;
+    uint8_t mac[ETH_ALEN];
+    uint16_t status;
+    VirtIONetQueue vqs[MAX_QUEUE_NUM];
+    VirtQueue *ctrl_vq;
+    NICState *nic;
+    int32_t tx_burst;
+    uint32_t has_vnet_hdr;
+    uint8_t has_ufo;
     int mergeable_rx_bufs;
+    int multiqueue;
     uint8_t promisc;
     uint8_t allmulti;
     uint8_t alluni;
     uint8_t nomulti;
     uint8_t nouni;
     uint8_t nobcast;
-    uint8_t vhost_started;
     struct {
         int in_use;
         int first_multi;
@@ -63,6 +72,8 @@ typedef struct VirtIONet
     } mac_table;
     uint32_t *vlans;
     DeviceState *qdev;
+    uint16_t queues;
+    uint16_t real_queues;
 } VirtIONet;
 
 /* TODO
@@ -74,12 +85,25 @@ static VirtIONet *to_virtio_net(VirtIODevice *vdev)
     return (VirtIONet *)vdev;
 }
 
+static int vq_get_pair_index(VirtIONet *n, VirtQueue *vq)
+{
+    int i;
+    for (i = 0; i < n->queues; i++) {
+        if (n->vqs[i].tx_vq == vq || n->vqs[i].rx_vq == vq) {
+            return i;
+        }
+    }
+    assert(1);
+    return -1;
+}
+
 static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VirtIONet *n = to_virtio_net(vdev);
     struct virtio_net_config netcfg;
 
     stw_p(&netcfg.status, n->status);
+    netcfg.queues = n->queues * 2;
     memcpy(netcfg.mac, n->mac, ETH_ALEN);
     memcpy(config, &netcfg, sizeof(netcfg));
 }
@@ -103,78 +127,146 @@ static bool virtio_net_started(VirtIONet *n, uint8_t status)
         (n->status & VIRTIO_NET_S_LINK_UP) && n->vdev.vm_running;
 }
 
-static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
+static void virtio_net_vhost_status(VLANClientState *nc, VirtIONet *n,
+                                    uint8_t status)
 {
-    if (!n->nic->nc.peer) {
+    int queue_index = nc->queue_index;
+    VLANClientState *peer = nc->peer;
+    VirtIONetQueue *netq = &n->vqs[nc->queue_index];
+
+    if (!peer) {
         return;
     }
-    if (n->nic->nc.peer->info->type != NET_CLIENT_TYPE_TAP) {
+    if (peer->info->type != NET_CLIENT_TYPE_TAP) {
         return;
     }
 
-    if (!tap_get_vhost_net(n->nic->nc.peer)) {
+    if (!tap_get_vhost_net(peer)) {
         return;
     }
-    if (!!n->vhost_started == virtio_net_started(n, status) &&
-                              !n->nic->nc.peer->link_down) {
+    if (!!netq->vhost_started == virtio_net_started(n, status) &&
+                                 !peer->link_down) {
         return;
     }
-    if (!n->vhost_started) {
-        int r;
-        if (!vhost_net_query(tap_get_vhost_net(n->nic->nc.peer), &n->vdev)) {
+    if (!netq->vhost_started) {
+	int r;
+        if (!vhost_net_query(tap_get_vhost_net(peer), &n->vdev)) {
             return;
         }
-        r = vhost_net_start(tap_get_vhost_net(n->nic->nc.peer), &n->vdev, 0);
+
+        r = vhost_net_start(tap_get_vhost_net(peer), &n->vdev,
+                            queue_index == 0 ? 0 : queue_index * 2 + 1);
         if (r < 0) {
             error_report("unable to start vhost net: %d: "
                          "falling back on userspace virtio", -r);
         } else {
-            n->vhost_started = 1;
+            netq->vhost_started = 1;
         }
     } else {
-        vhost_net_stop(tap_get_vhost_net(n->nic->nc.peer), &n->vdev);
-        n->vhost_started = 0;
+        vhost_net_stop(tap_get_vhost_net(peer), &n->vdev);
+        netq->vhost_started = 0;
     }
 }
 
-static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
+static int peer_attach(VirtIONet *n, int index)
 {
-    VirtIONet *n = to_virtio_net(vdev);
+    if (!n->nic->ncs[index]->peer) {
+	return -1;
+    }
 
-    virtio_net_vhost_status(n, status);
+    if (n->nic->ncs[index]->peer->info->type != NET_CLIENT_TYPE_TAP) {
+	return -1;
+    }
 
-    if (!n->tx_waiting) {
-        return;
+    return tap_attach(n->nic->ncs[index]->peer);
+}
+
+static int peer_detach(VirtIONet *n, int index)
+{
+    if (!n->nic->ncs[index]->peer) {
+	return -1;
     }
 
-    if (virtio_net_started(n, status) && !n->vhost_started) {
-        if (n->tx_timer) {
-            qemu_mod_timer(n->tx_timer,
-                           qemu_get_clock_ns(vm_clock) + n->tx_timeout);
+    if (n->nic->ncs[index]->peer->info->type != NET_CLIENT_TYPE_TAP) {
+	return -1;
+    }
+
+    return tap_detach(n->nic->ncs[index]->peer);
+}
+
+static void virtio_net_set_queues(VirtIONet *n)
+{
+    int i;
+    for (i = 0; i < n->queues; i++) {
+        if ((!n->multiqueue && i != 0) || i >= n->real_queues) {
+            assert(peer_detach(n, i) == 0);
         } else {
-            qemu_bh_schedule(n->tx_bh);
+            assert(peer_attach(n, i) == 0);
         }
-    } else {
-        if (n->tx_timer) {
-            qemu_del_timer(n->tx_timer);
+    }
+}
+
+static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
+{
+    VirtIONet *n = to_virtio_net(vdev);
+    int i;
+
+    virtio_net_set_queues(n);
+
+    for (i = 0; i < n->queues; i++) {
+        VirtIONetQueue *netq = &n->vqs[i];
+
+        if ((!n->multiqueue && i != 0) || i >= n->real_queues)
+            status = 0;
+
+        virtio_net_vhost_status(n->nic->ncs[i], n, status);
+
+        if (!netq->tx_waiting) {
+            continue;
+        }
+
+        if (virtio_net_started(n, status) && !netq->vhost_started) {
+            if (netq->tx_timer) {
+                qemu_mod_timer(netq->tx_timer,
+                               qemu_get_clock_ns(vm_clock) + netq->tx_timeout);
+            } else {
+                qemu_bh_schedule(netq->tx_bh);
+            }
         } else {
-            qemu_bh_cancel(n->tx_bh);
+            if (netq->tx_timer) {
+                qemu_del_timer(netq->tx_timer);
+            } else {
+                qemu_bh_cancel(netq->tx_bh);
+            }
+        }
+    }
+}
+
+static bool virtio_net_is_link_up(VirtIONet *n)
+{
+    int i;
+    for (i = 0; i < n->queues; i++) {
+        if (n->nic->ncs[i]->link_down) {
+            return false;
         }
     }
+    return true;
 }
 
 static void virtio_net_set_link_status(VLANClientState *nc)
 {
-    VirtIONet *n = DO_UPCAST(NICState, nc, nc)->opaque;
+    VirtIONet *n = ((NICState *)(nc->opaque))->opaque;
     uint16_t old_status = n->status;
 
-    if (nc->link_down)
-        n->status &= ~VIRTIO_NET_S_LINK_UP;
-    else
+    if (virtio_net_is_link_up(n)) {
         n->status |= VIRTIO_NET_S_LINK_UP;
+    } else {
+        n->status &= ~VIRTIO_NET_S_LINK_UP;
+    }
 
-    if (n->status != old_status)
+    if (n->status != old_status) {
         virtio_notify_config(&n->vdev);
+    }
 
     virtio_net_set_status(&n->vdev, n->vdev.status);
 }
@@ -190,6 +282,7 @@ static void virtio_net_reset(VirtIODevice *vdev)
     n->nomulti = 0;
     n->nouni = 0;
     n->nobcast = 0;
+    n->real_queues = n->queues;
 
     /* Flush any MAC and VLAN filter table state */
     n->mac_table.in_use = 0;
@@ -202,13 +295,15 @@ static void virtio_net_reset(VirtIODevice *vdev)
 
 static int peer_has_vnet_hdr(VirtIONet *n)
 {
-    if (!n->nic->nc.peer)
+    if (!n->nic->ncs[0]->peer) {
         return 0;
+    }
 
-    if (n->nic->nc.peer->info->type != NET_CLIENT_TYPE_TAP)
+    if (n->nic->ncs[0]->peer->info->type != NET_CLIENT_TYPE_TAP) {
         return 0;
+    }
 
-    n->has_vnet_hdr = tap_has_vnet_hdr(n->nic->nc.peer);
+    n->has_vnet_hdr = tap_has_vnet_hdr(n->nic->ncs[0]->peer);
 
     return n->has_vnet_hdr;
 }
@@ -218,7 +313,7 @@ static int peer_has_ufo(VirtIONet *n)
     if (!peer_has_vnet_hdr(n))
         return 0;
 
-    n->has_ufo = tap_has_ufo(n->nic->nc.peer);
+    n->has_ufo = tap_has_ufo(n->nic->ncs[0]->peer);
 
     return n->has_ufo;
 }
@@ -228,9 +323,13 @@ static uint32_t virtio_net_get_features(VirtIODevice *vdev, uint32_t features)
     VirtIONet *n = to_virtio_net(vdev);
 
     features |= (1 << VIRTIO_NET_F_MAC);
+    features |= (1 << VIRTIO_NET_F_MULTIQUEUE);
 
     if (peer_has_vnet_hdr(n)) {
-        tap_using_vnet_hdr(n->nic->nc.peer, 1);
+        int i;
+        for (i = 0; i < n->queues; i++) {
+            tap_using_vnet_hdr(n->nic->ncs[i]->peer, 1);
+        }
     } else {
         features &= ~(0x1 << VIRTIO_NET_F_CSUM);
         features &= ~(0x1 << VIRTIO_NET_F_HOST_TSO4);
@@ -248,14 +347,15 @@ static uint32_t virtio_net_get_features(VirtIODevice *vdev, uint32_t features)
         features &= ~(0x1 << VIRTIO_NET_F_HOST_UFO);
     }
 
-    if (!n->nic->nc.peer ||
-        n->nic->nc.peer->info->type != NET_CLIENT_TYPE_TAP) {
+    if (!n->nic->ncs[0]->peer ||
+        n->nic->ncs[0]->peer->info->type != NET_CLIENT_TYPE_TAP) {
         return features;
     }
-    if (!tap_get_vhost_net(n->nic->nc.peer)) {
+    if (!tap_get_vhost_net(n->nic->ncs[0]->peer)) {
         return features;
     }
-    return vhost_net_get_features(tap_get_vhost_net(n->nic->nc.peer), features);
+    return vhost_net_get_features(tap_get_vhost_net(n->nic->ncs[0]->peer),
+                                  features);
 }
 
 static uint32_t virtio_net_bad_features(VirtIODevice *vdev)
@@ -276,25 +376,36 @@ static uint32_t virtio_net_bad_features(VirtIODevice *vdev)
 static void virtio_net_set_features(VirtIODevice *vdev, uint32_t features)
 {
     VirtIONet *n = to_virtio_net(vdev);
+    int i;
 
     n->mergeable_rx_bufs = !!(features & (1 << VIRTIO_NET_F_MRG_RXBUF));
+    n->multiqueue = !!(features & (1 << VIRTIO_NET_F_MULTIQUEUE));
 
-    if (n->has_vnet_hdr) {
-        tap_set_offload(n->nic->nc.peer,
-                        (features >> VIRTIO_NET_F_GUEST_CSUM) & 1,
-                        (features >> VIRTIO_NET_F_GUEST_TSO4) & 1,
-                        (features >> VIRTIO_NET_F_GUEST_TSO6) & 1,
-                        (features >> VIRTIO_NET_F_GUEST_ECN)  & 1,
-                        (features >> VIRTIO_NET_F_GUEST_UFO)  & 1);
-    }
-    if (!n->nic->nc.peer ||
-        n->nic->nc.peer->info->type != NET_CLIENT_TYPE_TAP) {
-        return;
-    }
-    if (!tap_get_vhost_net(n->nic->nc.peer)) {
-        return;
+    if (!n->multiqueue)
+	    n->real_queues = 1;
+
+    /* attach the files for tap_set_offload */
+    virtio_net_set_queues(n);
+
+    for (i = 0; i < n->real_queues; i++) {
+        if (n->has_vnet_hdr) {
+            tap_set_offload(n->nic->ncs[i]->peer,
+                            (features >> VIRTIO_NET_F_GUEST_CSUM) & 1,
+                            (features >> VIRTIO_NET_F_GUEST_TSO4) & 1,
+                            (features >> VIRTIO_NET_F_GUEST_TSO6) & 1,
+                            (features >> VIRTIO_NET_F_GUEST_ECN)  & 1,
+                            (features >> VIRTIO_NET_F_GUEST_UFO)  & 1);
+        }
+        if (!n->nic->ncs[i]->peer ||
+            n->nic->ncs[i]->peer->info->type != NET_CLIENT_TYPE_TAP) {
+            continue;
+        }
+        if (!tap_get_vhost_net(n->nic->ncs[i]->peer)) {
+            continue;
+        }
+        vhost_net_ack_features(tap_get_vhost_net(n->nic->ncs[i]->peer),
+                               features);
     }
-    vhost_net_ack_features(tap_get_vhost_net(n->nic->nc.peer), features);
 }
 
 static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
@@ -404,6 +515,26 @@ static int virtio_net_handle_vlan_table(VirtIONet *n, uint8_t cmd,
     return VIRTIO_NET_OK;
 }
 
+static int virtio_net_handle_multiqueue(VirtIONet *n, uint8_t cmd,
+                                        VirtQueueElement *elem)
+{
+    if (elem->out_num != 2 ||
+        elem->out_sg[1].iov_len != sizeof(n->real_queues)) {
+        error_report("virtio-net ctrl invalid multiqueue command");
+        return VIRTIO_NET_ERR;
+    }
+
+    n->real_queues = lduw_p(elem->out_sg[1].iov_base);
+    if (n->real_queues > n->queues) {
+	    return VIRTIO_NET_ERR;
+    }
+
+    virtio_net_set_status(&n->vdev, n->vdev.status);
+
+    return VIRTIO_NET_OK;
+}
+
+
 static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIONet *n = to_virtio_net(vdev);
@@ -432,6 +563,8 @@ static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
             status = virtio_net_handle_mac(n, ctrl.cmd, &elem);
         else if (ctrl.class == VIRTIO_NET_CTRL_VLAN)
             status = virtio_net_handle_vlan_table(n, ctrl.cmd, &elem);
+        else if (ctrl.class == VIRTIO_NET_CTRL_MULTIQUEUE)
+            status = virtio_net_handle_multiqueue(n, ctrl.cmd, &elem);
 
         stb_p(elem.in_sg[elem.in_num - 1].iov_base, status);
 
@@ -446,7 +579,7 @@ static void virtio_net_handle_rx(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIONet *n = to_virtio_net(vdev);
 
-    qemu_flush_queued_packets(&n->nic->nc);
+    qemu_flush_queued_packets(n->nic->ncs[vq_get_pair_index(n, vq)]);
 
     /* We now have RX buffers, signal to the IO thread to break out of the
      * select to re-poll the tap file descriptor */
@@ -455,36 +588,37 @@ static void virtio_net_handle_rx(VirtIODevice *vdev, VirtQueue *vq)
 
 static int virtio_net_can_receive(VLANClientState *nc)
 {
-    VirtIONet *n = DO_UPCAST(NICState, nc, nc)->opaque;
+    int queue_index = nc->queue_index;
+    VirtIONet *n = ((NICState *)nc->opaque)->opaque;
+
     if (!n->vdev.vm_running) {
         return 0;
     }
 
-    if (!virtio_queue_ready(n->rx_vq) ||
+    if (!virtio_queue_ready(n->vqs[queue_index].rx_vq) ||
         !(n->vdev.status & VIRTIO_CONFIG_S_DRIVER_OK))
         return 0;
 
     return 1;
 }
 
-static int virtio_net_has_buffers(VirtIONet *n, int bufsize)
+static int virtio_net_has_buffers(VirtIONet *n, int bufsize, VirtQueue *vq)
 {
-    if (virtio_queue_empty(n->rx_vq) ||
-        (n->mergeable_rx_bufs &&
-         !virtqueue_avail_bytes(n->rx_vq, bufsize, 0))) {
-        virtio_queue_set_notification(n->rx_vq, 1);
+    if (virtio_queue_empty(vq) || (n->mergeable_rx_bufs &&
+        !virtqueue_avail_bytes(vq, bufsize, 0))) {
+        virtio_queue_set_notification(vq, 1);
 
         /* To avoid a race condition where the guest has made some buffers
          * available after the above check but before notification was
          * enabled, check for available buffers again.
          */
-        if (virtio_queue_empty(n->rx_vq) ||
-            (n->mergeable_rx_bufs &&
-             !virtqueue_avail_bytes(n->rx_vq, bufsize, 0)))
+        if (virtio_queue_empty(vq) || (n->mergeable_rx_bufs &&
+            !virtqueue_avail_bytes(vq, bufsize, 0))) {
             return 0;
+        }
     }
 
-    virtio_queue_set_notification(n->rx_vq, 0);
+    virtio_queue_set_notification(vq, 0);
     return 1;
 }
 
@@ -595,12 +729,15 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
 
 static ssize_t virtio_net_receive(VLANClientState *nc, const uint8_t *buf, size_t size)
 {
-    VirtIONet *n = DO_UPCAST(NICState, nc, nc)->opaque;
+    int queue_index = nc->queue_index;
+    VirtIONet *n = ((NICState *)(nc->opaque))->opaque;
+    VirtQueue *vq = n->vqs[queue_index].rx_vq;
     struct virtio_net_hdr_mrg_rxbuf *mhdr = NULL;
     size_t guest_hdr_len, offset, i, host_hdr_len;
 
-    if (!virtio_net_can_receive(&n->nic->nc))
+    if (!virtio_net_can_receive(n->nic->ncs[queue_index])) {
         return -1;
+    }
 
     /* hdr_len refers to the header we supply to the guest */
     guest_hdr_len = n->mergeable_rx_bufs ?
@@ -608,7 +745,7 @@ static ssize_t virtio_net_receive(VLANClientState *nc, const uint8_t *buf, size_
 
 
     host_hdr_len = n->has_vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
-    if (!virtio_net_has_buffers(n, size + guest_hdr_len - host_hdr_len))
+    if (!virtio_net_has_buffers(n, size + guest_hdr_len - host_hdr_len, vq))
         return 0;
 
     if (!receive_filter(n, buf, size))
@@ -623,7 +760,7 @@ static ssize_t virtio_net_receive(VLANClientState *nc, const uint8_t *buf, size_
 
         total = 0;
 
-        if (virtqueue_pop(n->rx_vq, &elem) == 0) {
+        if (virtqueue_pop(vq, &elem) == 0) {
             if (i == 0)
                 return -1;
             error_report("virtio-net unexpected empty queue: "
@@ -675,47 +812,50 @@ static ssize_t virtio_net_receive(VLANClientState *nc, const uint8_t *buf, size_
         }
 
         /* signal other side */
-        virtqueue_fill(n->rx_vq, &elem, total, i++);
+        virtqueue_fill(vq, &elem, total, i++);
     }
 
     if (mhdr) {
         stw_p(&mhdr->num_buffers, i);
     }
 
-    virtqueue_flush(n->rx_vq, i);
-    virtio_notify(&n->vdev, n->rx_vq);
+    virtqueue_flush(vq, i);
+    virtio_notify(&n->vdev, vq);
 
     return size;
 }
 
-static int32_t virtio_net_flush_tx(VirtIONet *n, VirtQueue *vq);
+static int32_t virtio_net_flush_tx(VirtIONet *n, VirtIONetQueue *tvq);
 
 static void virtio_net_tx_complete(VLANClientState *nc, ssize_t len)
 {
-    VirtIONet *n = DO_UPCAST(NICState, nc, nc)->opaque;
+    VirtIONet *n = ((NICState *)nc->opaque)->opaque;
+    VirtIONetQueue *netq = &n->vqs[nc->queue_index];
 
-    virtqueue_push(n->tx_vq, &n->async_tx.elem, n->async_tx.len);
-    virtio_notify(&n->vdev, n->tx_vq);
+    virtqueue_push(netq->tx_vq, &netq->async_tx.elem, netq->async_tx.len);
+    virtio_notify(&n->vdev, netq->tx_vq);
 
-    n->async_tx.elem.out_num = n->async_tx.len = 0;
+    netq->async_tx.elem.out_num = netq->async_tx.len;
 
-    virtio_queue_set_notification(n->tx_vq, 1);
-    virtio_net_flush_tx(n, n->tx_vq);
+    virtio_queue_set_notification(netq->tx_vq, 1);
+    virtio_net_flush_tx(n, netq);
 }
 
 /* TX */
-static int32_t virtio_net_flush_tx(VirtIONet *n, VirtQueue *vq)
+static int32_t virtio_net_flush_tx(VirtIONet *n, VirtIONetQueue *netq)
 {
     VirtQueueElement elem;
     int32_t num_packets = 0;
+    VirtQueue *vq = netq->tx_vq;
+
     if (!(n->vdev.status & VIRTIO_CONFIG_S_DRIVER_OK)) {
         return num_packets;
     }
 
     assert(n->vdev.vm_running);
 
-    if (n->async_tx.elem.out_num) {
-        virtio_queue_set_notification(n->tx_vq, 0);
+    if (netq->async_tx.elem.out_num) {
+        virtio_queue_set_notification(vq, 0);
         return num_packets;
     }
 
@@ -747,12 +887,12 @@ static int32_t virtio_net_flush_tx(VirtIONet *n, VirtQueue *vq)
             len += hdr_len;
         }
 
-        ret = qemu_sendv_packet_async(&n->nic->nc, out_sg, out_num,
-                                      virtio_net_tx_complete);
+        ret = qemu_sendv_packet_async(n->nic->ncs[vq_get_pair_index(n, vq)],
+                                      out_sg, out_num, virtio_net_tx_complete);
         if (ret == 0) {
-            virtio_queue_set_notification(n->tx_vq, 0);
-            n->async_tx.elem = elem;
-            n->async_tx.len  = len;
+            virtio_queue_set_notification(vq, 0);
+            netq->async_tx.elem = elem;
+            netq->async_tx.len  = len;
             return -EBUSY;
         }
 
@@ -771,22 +911,23 @@ static int32_t virtio_net_flush_tx(VirtIONet *n, VirtQueue *vq)
 static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIONet *n = to_virtio_net(vdev);
+    VirtIONetQueue *netq = &n->vqs[vq_get_pair_index(n, vq)];
 
     /* This happens when device was stopped but VCPU wasn't. */
     if (!n->vdev.vm_running) {
-        n->tx_waiting = 1;
+        netq->tx_waiting = 1;
         return;
     }
 
-    if (n->tx_waiting) {
+    if (netq->tx_waiting) {
         virtio_queue_set_notification(vq, 1);
-        qemu_del_timer(n->tx_timer);
-        n->tx_waiting = 0;
-        virtio_net_flush_tx(n, vq);
+        qemu_del_timer(netq->tx_timer);
+        netq->tx_waiting = 0;
+        virtio_net_flush_tx(n, netq);
     } else {
-        qemu_mod_timer(n->tx_timer,
-                       qemu_get_clock_ns(vm_clock) + n->tx_timeout);
-        n->tx_waiting = 1;
+        qemu_mod_timer(netq->tx_timer,
+                       qemu_get_clock_ns(vm_clock) + netq->tx_timeout);
+        netq->tx_waiting = 1;
         virtio_queue_set_notification(vq, 0);
     }
 }
@@ -794,48 +935,53 @@ static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *vq)
 static void virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIONet *n = to_virtio_net(vdev);
+    VirtIONetQueue *netq = &n->vqs[vq_get_pair_index(n, vq)];
 
-    if (unlikely(n->tx_waiting)) {
+    if (unlikely(netq->tx_waiting)) {
         return;
     }
-    n->tx_waiting = 1;
+    netq->tx_waiting = 1;
     /* This happens when device was stopped but VCPU wasn't. */
     if (!n->vdev.vm_running) {
         return;
     }
     virtio_queue_set_notification(vq, 0);
-    qemu_bh_schedule(n->tx_bh);
+    qemu_bh_schedule(netq->tx_bh);
 }
 
 static void virtio_net_tx_timer(void *opaque)
 {
-    VirtIONet *n = opaque;
+    VirtIONetQueue *netq = opaque;
+    VirtIONet *n = netq->n;
+
     assert(n->vdev.vm_running);
 
-    n->tx_waiting = 0;
+    netq->tx_waiting = 0;
 
     /* Just in case the driver is not ready on more */
     if (!(n->vdev.status & VIRTIO_CONFIG_S_DRIVER_OK))
         return;
 
-    virtio_queue_set_notification(n->tx_vq, 1);
-    virtio_net_flush_tx(n, n->tx_vq);
+    virtio_queue_set_notification(netq->tx_vq, 1);
+    virtio_net_flush_tx(n, netq);
 }
 
 static void virtio_net_tx_bh(void *opaque)
 {
-    VirtIONet *n = opaque;
+    VirtIONetQueue *netq = opaque;
+    VirtQueue *vq = netq->tx_vq;
+    VirtIONet *n = netq->n;
     int32_t ret;
 
     assert(n->vdev.vm_running);
 
-    n->tx_waiting = 0;
+    netq->tx_waiting = 0;
 
     /* Just in case the driver is not ready on more */
     if (unlikely(!(n->vdev.status & VIRTIO_CONFIG_S_DRIVER_OK)))
         return;
 
-    ret = virtio_net_flush_tx(n, n->tx_vq);
+    ret = virtio_net_flush_tx(n, netq);
     if (ret == -EBUSY) {
         return; /* Notification re-enable handled by tx_complete */
     }
@@ -843,33 +989,39 @@ static void virtio_net_tx_bh(void *opaque)
     /* If we flush a full burst of packets, assume there are
      * more coming and immediately reschedule */
     if (ret >= n->tx_burst) {
-        qemu_bh_schedule(n->tx_bh);
-        n->tx_waiting = 1;
+        qemu_bh_schedule(netq->tx_bh);
+        netq->tx_waiting = 1;
         return;
     }
 
     /* If less than a full burst, re-enable notification and flush
      * anything that may have come in while we weren't looking.  If
      * we find something, assume the guest is still active and reschedule */
-    virtio_queue_set_notification(n->tx_vq, 1);
-    if (virtio_net_flush_tx(n, n->tx_vq) > 0) {
-        virtio_queue_set_notification(n->tx_vq, 0);
-        qemu_bh_schedule(n->tx_bh);
-        n->tx_waiting = 1;
+    virtio_queue_set_notification(vq, 1);
+    if (virtio_net_flush_tx(n, netq) > 0) {
+        virtio_queue_set_notification(vq, 0);
+        qemu_bh_schedule(netq->tx_bh);
+        netq->tx_waiting = 1;
     }
 }
 
 static void virtio_net_save(QEMUFile *f, void *opaque)
 {
     VirtIONet *n = opaque;
+    int i;
 
     /* At this point, backend must be stopped, otherwise
      * it might keep writing to memory. */
-    assert(!n->vhost_started);
+    for (i = 0; i < n->queues; i++) {
+        assert(!n->vqs[i].vhost_started);
+    }
     virtio_save(&n->vdev, f);
 
     qemu_put_buffer(f, n->mac, ETH_ALEN);
-    qemu_put_be32(f, n->tx_waiting);
+    qemu_put_be32(f, n->queues);
+    for (i = 0; i < n->queues; i++) {
+        qemu_put_be32(f, n->vqs[i].tx_waiting);
+    }
     qemu_put_be32(f, n->mergeable_rx_bufs);
     qemu_put_be16(f, n->status);
     qemu_put_byte(f, n->promisc);
@@ -885,6 +1037,8 @@ static void virtio_net_save(QEMUFile *f, void *opaque)
     qemu_put_byte(f, n->nouni);
     qemu_put_byte(f, n->nobcast);
     qemu_put_byte(f, n->has_ufo);
+    qemu_put_be16(f, n->queues);
+    qemu_put_be16(f, n->real_queues);
 }
 
 static int virtio_net_load(QEMUFile *f, void *opaque, int version_id)
@@ -902,7 +1056,10 @@ static int virtio_net_load(QEMUFile *f, void *opaque, int version_id)
     }
 
     qemu_get_buffer(f, n->mac, ETH_ALEN);
-    n->tx_waiting = qemu_get_be32(f);
+    n->queues = qemu_get_be32(f);
+    for (i = 0; i < n->queues; i++) {
+        n->vqs[i].tx_waiting = qemu_get_be32(f);
+    }
     n->mergeable_rx_bufs = qemu_get_be32(f);
 
     if (version_id >= 3)
@@ -930,7 +1087,7 @@ static int virtio_net_load(QEMUFile *f, void *opaque, int version_id)
             n->mac_table.in_use = 0;
         }
     }
- 
+
     if (version_id >= 6)
         qemu_get_buffer(f, (uint8_t *)n->vlans, MAX_VLAN >> 3);
 
@@ -941,13 +1098,16 @@ static int virtio_net_load(QEMUFile *f, void *opaque, int version_id)
         }
 
         if (n->has_vnet_hdr) {
-            tap_using_vnet_hdr(n->nic->nc.peer, 1);
-            tap_set_offload(n->nic->nc.peer,
-                    (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_CSUM) & 1,
-                    (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_TSO4) & 1,
-                    (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_TSO6) & 1,
-                    (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_ECN)  & 1,
-                    (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_UFO)  & 1);
+            for(i = 0; i < n->queues; i++) {
+                tap_using_vnet_hdr(n->nic->ncs[i]->peer, 1);
+                tap_set_offload(n->nic->ncs[i]->peer,
+                        (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_CSUM) & 1,
+                        (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_TSO4) & 1,
+                        (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_TSO6) & 1,
+                        (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_ECN)  & 1,
+                        (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_UFO)  &
+                        1);
+           }
         }
     }
 
@@ -970,6 +1130,13 @@ static int virtio_net_load(QEMUFile *f, void *opaque, int version_id)
         }
     }
 
+    if (version_id >= 12) {
+        if (n->queues != qemu_get_be16(f)) {
+            error_report("virtio-net: the number of queues does not match");
+        }
+        n->real_queues = qemu_get_be16(f);
+    }
+
     /* Find the first multicast entry in the saved MAC filter */
     for (i = 0; i < n->mac_table.in_use; i++) {
         if (n->mac_table.macs[i * ETH_ALEN] & 1) {
@@ -982,7 +1149,7 @@ static int virtio_net_load(QEMUFile *f, void *opaque, int version_id)
 
 static void virtio_net_cleanup(VLANClientState *nc)
 {
-    VirtIONet *n = DO_UPCAST(NICState, nc, nc)->opaque;
+    VirtIONet *n = ((NICState *)nc->opaque)->opaque;
 
     n->nic = NULL;
 }
@@ -1000,6 +1167,7 @@ VirtIODevice *virtio_net_init(DeviceState *dev, NICConf *conf,
                               virtio_net_conf *net)
 {
     VirtIONet *n;
+    int i;
 
     n = (VirtIONet *)virtio_common_init("virtio-net", VIRTIO_ID_NET,
                                         sizeof(struct virtio_net_config),
@@ -1012,7 +1180,6 @@ VirtIODevice *virtio_net_init(DeviceState *dev, NICConf *conf,
     n->vdev.bad_features = virtio_net_bad_features;
     n->vdev.reset = virtio_net_reset;
     n->vdev.set_status = virtio_net_set_status;
-    n->rx_vq = virtio_add_queue(&n->vdev, 256, virtio_net_handle_rx);
 
     if (net->tx && strcmp(net->tx, "timer") && strcmp(net->tx, "bh")) {
         error_report("virtio-net: "
@@ -1021,15 +1188,6 @@ VirtIODevice *virtio_net_init(DeviceState *dev, NICConf *conf,
         error_report("Defaulting to \"bh\"");
     }
 
-    if (net->tx && !strcmp(net->tx, "timer")) {
-        n->tx_vq = virtio_add_queue(&n->vdev, 256, virtio_net_handle_tx_timer);
-        n->tx_timer = qemu_new_timer_ns(vm_clock, virtio_net_tx_timer, n);
-        n->tx_timeout = net->txtimer;
-    } else {
-        n->tx_vq = virtio_add_queue(&n->vdev, 256, virtio_net_handle_tx_bh);
-        n->tx_bh = qemu_bh_new(virtio_net_tx_bh, n);
-    }
-    n->ctrl_vq = virtio_add_queue(&n->vdev, 64, virtio_net_handle_ctrl);
     qemu_macaddr_default_if_unset(&conf->macaddr);
     memcpy(&n->mac[0], &conf->macaddr, sizeof(n->mac));
     n->status = VIRTIO_NET_S_LINK_UP;
@@ -1038,7 +1196,6 @@ VirtIODevice *virtio_net_init(DeviceState *dev, NICConf *conf,
 
     qemu_format_nic_info_str(&n->nic->nc, conf->macaddr.a);
 
-    n->tx_waiting = 0;
     n->tx_burst = net->txburst;
     n->mergeable_rx_bufs = 0;
     n->promisc = 1; /* for compatibility */
@@ -1046,6 +1203,33 @@ VirtIODevice *virtio_net_init(DeviceState *dev, NICConf *conf,
     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
 
     n->vlans = g_malloc0(MAX_VLAN >> 3);
+    n->queues = conf->queues;
+    n->real_queues = n->queues;
+
+    /* Allocate per rx/tx vq's */
+    for (i = 0; i < n->queues; i++) {
+        n->vqs[i].rx_vq = virtio_add_queue(&n->vdev, 256, virtio_net_handle_rx);
+        if (net->tx && !strcmp(net->tx, "timer")) {
+            n->vqs[i].tx_vq = virtio_add_queue(&n->vdev, 256,
+                                               virtio_net_handle_tx_timer);
+            n->vqs[i].tx_timer = qemu_new_timer_ns(vm_clock,
+                                                   virtio_net_tx_timer,
+                                                   &n->vqs[i]);
+            n->vqs[i].tx_timeout = net->txtimer;
+        } else {
+            n->vqs[i].tx_vq = virtio_add_queue(&n->vdev, 256,
+                                               virtio_net_handle_tx_bh);
+            n->vqs[i].tx_bh = qemu_bh_new(virtio_net_tx_bh, &n->vqs[i]);
+        }
+
+        n->vqs[i].tx_waiting = 0;
+        n->vqs[i].n = n;
+
+        if (i == 0) {
+            /* keep compatiable with spec and old guest */
+            n->ctrl_vq = virtio_add_queue(&n->vdev, 64, virtio_net_handle_ctrl);
+        }
+    }
 
     n->qdev = dev;
     register_savevm(dev, "virtio-net", -1, VIRTIO_NET_VM_VERSION,
@@ -1059,24 +1243,33 @@ VirtIODevice *virtio_net_init(DeviceState *dev, NICConf *conf,
 void virtio_net_exit(VirtIODevice *vdev)
 {
     VirtIONet *n = DO_UPCAST(VirtIONet, vdev, vdev);
+    int i;
 
     /* This will stop vhost backend if appropriate. */
     virtio_net_set_status(vdev, 0);
 
-    qemu_purge_queued_packets(&n->nic->nc);
+    for (i = 0; i < n->queues; i++) {
+        qemu_purge_queued_packets(n->nic->ncs[i]);
+    }
 
     unregister_savevm(n->qdev, "virtio-net", n);
 
     g_free(n->mac_table.macs);
     g_free(n->vlans);
 
-    if (n->tx_timer) {
-        qemu_del_timer(n->tx_timer);
-        qemu_free_timer(n->tx_timer);
-    } else {
-        qemu_bh_delete(n->tx_bh);
+    for (i = 0; i < n->queues; i++) {
+        VirtIONetQueue *netq = &n->vqs[i];
+        if (netq->tx_timer) {
+            qemu_del_timer(netq->tx_timer);
+            qemu_free_timer(netq->tx_timer);
+        } else {
+            qemu_bh_delete(netq->tx_bh);
+        }
     }
 
-    qemu_del_vlan_client(&n->nic->nc);
     virtio_cleanup(&n->vdev);
+
+    for (i = 0; i < n->queues; i++) {
+        qemu_del_vlan_client(n->nic->ncs[i]);
+    }
 }
diff --git a/hw/virtio-net.h b/hw/virtio-net.h
index 36aa463..987b5dd 100644
--- a/hw/virtio-net.h
+++ b/hw/virtio-net.h
@@ -44,6 +44,7 @@
 #define VIRTIO_NET_F_CTRL_RX    18      /* Control channel RX mode support */
 #define VIRTIO_NET_F_CTRL_VLAN  19      /* Control channel VLAN filtering */
 #define VIRTIO_NET_F_CTRL_RX_EXTRA 20   /* Extra RX mode control support */
+#define VIRTIO_NET_F_MULTIQUEUE   22
 
 #define VIRTIO_NET_S_LINK_UP    1       /* Link is up */
 
@@ -72,6 +73,8 @@ struct virtio_net_config
     uint8_t mac[ETH_ALEN];
     /* See VIRTIO_NET_F_STATUS and VIRTIO_NET_S_* above */
     uint16_t status;
+
+    uint16_t queues;
 } QEMU_PACKED;
 
 /* This is the first element of the scatter-gather list.  If you don't
@@ -168,6 +171,15 @@ struct virtio_net_ctrl_mac {
  #define VIRTIO_NET_CTRL_VLAN_ADD             0
  #define VIRTIO_NET_CTRL_VLAN_DEL             1
 
+/* Control Multiqueue
+ *
+ */
+struct virtio_net_ctrl_multiqueue {
+    uint16_t num_queue_pairs;
+};
+#define VIRTIO_NET_CTRL_MULTIQUEUE    4
+ #define VIRTIO_NET_CTRL_MULTIQUEUE_QNUM        0
+
 #define DEFINE_VIRTIO_NET_FEATURES(_state, _field) \
         DEFINE_VIRTIO_COMMON_FEATURES(_state, _field), \
         DEFINE_PROP_BIT("csum", _state, _field, VIRTIO_NET_F_CSUM, true), \
-- 
1.7.1
