From: Jason Baron via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [PATCH 2/3] qemu: use 64-bit values for feature flags in virtio-net
Date: Fri, 22 Dec 2017 16:53:58 -0500
Message-ID: <1513979641-7999-1-git-send-email-jbaron__21946.4337955744$1515606536$gmane$org@akamai.com>
References: <cover.1513974243.git.jbaron@akamai.com>
Reply-To: Jason Baron <jbaron@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1513974243.git.jbaron@akamai.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Cc: mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

In prepartion for using some of the high order feature bits, make sure that
virtio-net uses 64-bit values everywhere.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c            | 54 +++++++++++++++++++++---------------------
 include/hw/virtio/virtio-net.h |  2 +-
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 38674b0..adc20df 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -48,18 +48,18 @@
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
-    {.flags = 1 << VIRTIO_NET_F_MTU,
+    {.flags = 1ULL << VIRTIO_NET_F_MTU,
      .end = endof(struct virtio_net_config, mtu)},
     {}
 };
@@ -1938,7 +1938,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     int i;
 
     if (n->net_conf.mtu) {
-        n->host_features |= (0x1 << VIRTIO_NET_F_MTU);
+        n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
     }
 
     virtio_net_set_config_size(n, n->host_features);
@@ -2109,45 +2109,45 @@ static const VMStateDescription vmstate_virtio_net = {
 };
 
 static Property virtio_net_properties[] = {
-    DEFINE_PROP_BIT("csum", VirtIONet, host_features, VIRTIO_NET_F_CSUM, true),
-    DEFINE_PROP_BIT("guest_csum", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("csum", VirtIONet, host_features, VIRTIO_NET_F_CSUM, true),
+    DEFINE_PROP_BIT64("guest_csum", VirtIONet, host_features,
                     VIRTIO_NET_F_GUEST_CSUM, true),
-    DEFINE_PROP_BIT("gso", VirtIONet, host_features, VIRTIO_NET_F_GSO, true),
-    DEFINE_PROP_BIT("guest_tso4", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("gso", VirtIONet, host_features, VIRTIO_NET_F_GSO, true),
+    DEFINE_PROP_BIT64("guest_tso4", VirtIONet, host_features,
                     VIRTIO_NET_F_GUEST_TSO4, true),
-    DEFINE_PROP_BIT("guest_tso6", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("guest_tso6", VirtIONet, host_features,
                     VIRTIO_NET_F_GUEST_TSO6, true),
-    DEFINE_PROP_BIT("guest_ecn", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("guest_ecn", VirtIONet, host_features,
                     VIRTIO_NET_F_GUEST_ECN, true),
-    DEFINE_PROP_BIT("guest_ufo", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("guest_ufo", VirtIONet, host_features,
                     VIRTIO_NET_F_GUEST_UFO, true),
-    DEFINE_PROP_BIT("guest_announce", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("guest_announce", VirtIONet, host_features,
                     VIRTIO_NET_F_GUEST_ANNOUNCE, true),
-    DEFINE_PROP_BIT("host_tso4", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("host_tso4", VirtIONet, host_features,
                     VIRTIO_NET_F_HOST_TSO4, true),
-    DEFINE_PROP_BIT("host_tso6", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("host_tso6", VirtIONet, host_features,
                     VIRTIO_NET_F_HOST_TSO6, true),
-    DEFINE_PROP_BIT("host_ecn", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("host_ecn", VirtIONet, host_features,
                     VIRTIO_NET_F_HOST_ECN, true),
-    DEFINE_PROP_BIT("host_ufo", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("host_ufo", VirtIONet, host_features,
                     VIRTIO_NET_F_HOST_UFO, true),
-    DEFINE_PROP_BIT("mrg_rxbuf", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("mrg_rxbuf", VirtIONet, host_features,
                     VIRTIO_NET_F_MRG_RXBUF, true),
-    DEFINE_PROP_BIT("status", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("status", VirtIONet, host_features,
                     VIRTIO_NET_F_STATUS, true),
-    DEFINE_PROP_BIT("ctrl_vq", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("ctrl_vq", VirtIONet, host_features,
                     VIRTIO_NET_F_CTRL_VQ, true),
-    DEFINE_PROP_BIT("ctrl_rx", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("ctrl_rx", VirtIONet, host_features,
                     VIRTIO_NET_F_CTRL_RX, true),
-    DEFINE_PROP_BIT("ctrl_vlan", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("ctrl_vlan", VirtIONet, host_features,
                     VIRTIO_NET_F_CTRL_VLAN, true),
-    DEFINE_PROP_BIT("ctrl_rx_extra", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("ctrl_rx_extra", VirtIONet, host_features,
                     VIRTIO_NET_F_CTRL_RX_EXTRA, true),
-    DEFINE_PROP_BIT("ctrl_mac_addr", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("ctrl_mac_addr", VirtIONet, host_features,
                     VIRTIO_NET_F_CTRL_MAC_ADDR, true),
-    DEFINE_PROP_BIT("ctrl_guest_offloads", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("ctrl_guest_offloads", VirtIONet, host_features,
                     VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true),
-    DEFINE_PROP_BIT("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ, false),
+    DEFINE_PROP_BIT64("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ, false),
     DEFINE_NIC_PROPERTIES(VirtIONet, nic_conf),
     DEFINE_PROP_UINT32("x-txtimer", VirtIONet, net_conf.txtimer,
                        TX_TIMER_INTERVAL),
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index b81b6a4..e7634c9 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -67,7 +67,7 @@ typedef struct VirtIONet {
     uint32_t has_vnet_hdr;
     size_t host_hdr_len;
     size_t guest_hdr_len;
-    uint32_t host_features;
+    uint64_t host_features;
     uint8_t has_ufo;
     uint32_t mergeable_rx_bufs;
     uint8_t promisc;
-- 
2.6.1
