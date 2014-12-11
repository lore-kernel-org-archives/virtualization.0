From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v6 16/20] virtio-net: support longer header
Date: Thu, 11 Dec 2014 14:25:18 +0100
Message-ID: <1418304322-7546-17-git-send-email-cornelia.huck@de.ibm.com>
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

virtio-1 devices always use num_buffers in the header, even if
mergeable rx buffers have not been negotiated.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/net/virtio-net.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ebbea60..7ee2bd6 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -373,15 +373,21 @@ static int peer_has_ufo(VirtIONet *n)
     return n->has_ufo;
 }
 
-static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs)
+static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
+                                       int version_1)
 {
     int i;
     NetClientState *nc;
 
     n->mergeable_rx_bufs = mergeable_rx_bufs;
 
-    n->guest_hdr_len = n->mergeable_rx_bufs ?
-        sizeof(struct virtio_net_hdr_mrg_rxbuf) : sizeof(struct virtio_net_hdr);
+    if (version_1) {
+        n->guest_hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+    } else {
+        n->guest_hdr_len = n->mergeable_rx_bufs ?
+            sizeof(struct virtio_net_hdr_mrg_rxbuf) :
+            sizeof(struct virtio_net_hdr);
+    }
 
     for (i = 0; i < n->max_queues; i++) {
         nc = qemu_get_subqueue(n->nic, i);
@@ -525,7 +531,9 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
 
     virtio_net_set_mrg_rx_bufs(n,
                                __virtio_has_feature(features,
-                                                    VIRTIO_NET_F_MRG_RXBUF));
+                                                    VIRTIO_NET_F_MRG_RXBUF),
+                               __virtio_has_feature(features,
+                                                    VIRTIO_F_VERSION_1));
 
     if (n->has_vnet_hdr) {
         n->curr_guest_offloads =
@@ -1407,7 +1415,8 @@ static int virtio_net_load_device(VirtIODevice *vdev, QEMUFile *f,
     qemu_get_buffer(f, n->mac, ETH_ALEN);
     n->vqs[0].tx_waiting = qemu_get_be32(f);
 
-    virtio_net_set_mrg_rx_bufs(n, qemu_get_be32(f));
+    virtio_net_set_mrg_rx_bufs(n, qemu_get_be32(f),
+                               virtio_has_feature(vdev, VIRTIO_F_VERSION_1));
 
     if (version_id >= 3)
         n->status = qemu_get_be16(f);
@@ -1653,7 +1662,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     n->vqs[0].tx_waiting = 0;
     n->tx_burst = n->net_conf.txburst;
-    virtio_net_set_mrg_rx_bufs(n, 0);
+    virtio_net_set_mrg_rx_bufs(n, 0, 0);
     n->promisc = 1; /* for compatibility */
 
     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
-- 
1.7.9.5
