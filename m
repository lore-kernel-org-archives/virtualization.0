From: akong@redhat.com
Subject: [QEMU PATCH v3] virtio-net: introduce a new macaddr control
Date: Thu, 17 Jan 2013 18:30:46 +0800
Message-ID: <1358418646-29626-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, stefanha@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Amos Kong <akong@redhat.com>

In virtio-net guest driver, currently we write MAC address to
pci config space byte by byte, this means that we have an
intermediate step where mac is wrong. This patch introduced
a new control command to set MAC address, it's atomic.

VIRTIO_NET_F_CTRL_MAC_ADDR is a new feature bit for compatibility.

"mac" field will be set to read-only when VIRTIO_NET_F_CTRL_MAC_ADDR
is acked.

Signed-off-by: Amos Kong <akong@redhat.com>
---
V2: check guest's iov_len
V3: fix of migration compatibility
    make mac field in config space read-only when new feature is acked
---
 hw/pc_piix.c    |  4 ++++
 hw/virtio-net.c | 10 +++++++++-
 hw/virtio-net.h | 12 ++++++++++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/hw/pc_piix.c b/hw/pc_piix.c
index 7268dcd..66606b9 100644
--- a/hw/pc_piix.c
+++ b/hw/pc_piix.c
@@ -295,6 +295,10 @@ static QEMUMachine pc_machine_v1_4 = {
             .driver   = "usb-tablet",\
             .property = "usb_version",\
             .value    = stringify(1),\
+        },{\
+            .driver   = "virtio-net-pci",\
+            .property = "ctrl_mac_addr",\
+            .value    = "off",      \
         }
 
 static QEMUMachine pc_machine_v1_3 = {
diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index dc7c6d6..941d782 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -93,7 +93,8 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
 
     memcpy(&netcfg, config, sizeof(netcfg));
 
-    if (memcmp(netcfg.mac, n->mac, ETH_ALEN)) {
+    if (!(n->vdev.guest_features >> VIRTIO_NET_F_CTRL_MAC_ADDR & 1) &&
+        memcmp(netcfg.mac, n->mac, ETH_ALEN)) {
         memcpy(n->mac, netcfg.mac, ETH_ALEN);
         qemu_format_nic_info_str(&n->nic->nc, n->mac);
     }
@@ -349,6 +350,13 @@ static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
 {
     struct virtio_net_ctrl_mac mac_data;
 
+    if (cmd == VIRTIO_NET_CTRL_MAC_ADDR_SET && elem->out_num == 2 &&
+        elem->out_sg[1].iov_len == ETH_ALEN) {
+        memcpy(n->mac, elem->out_sg[1].iov_base, elem->out_sg[1].iov_len);
+        qemu_format_nic_info_str(&n->nic->nc, n->mac);
+        return VIRTIO_NET_OK;
+    }
+
     if (cmd != VIRTIO_NET_CTRL_MAC_TABLE_SET || elem->out_num != 3 ||
         elem->out_sg[1].iov_len < sizeof(mac_data) ||
         elem->out_sg[2].iov_len < sizeof(mac_data))
diff --git a/hw/virtio-net.h b/hw/virtio-net.h
index d46fb98..1ec632f 100644
--- a/hw/virtio-net.h
+++ b/hw/virtio-net.h
@@ -44,6 +44,8 @@
 #define VIRTIO_NET_F_CTRL_VLAN  19      /* Control channel VLAN filtering */
 #define VIRTIO_NET_F_CTRL_RX_EXTRA 20   /* Extra RX mode control support */
 
+#define VIRTIO_NET_F_CTRL_MAC_ADDR   23 /* Set MAC address */
+
 #define VIRTIO_NET_S_LINK_UP    1       /* Link is up */
 
 #define TX_TIMER_INTERVAL 150000 /* 150 us */
@@ -106,7 +108,7 @@ typedef uint8_t virtio_net_ctrl_ack;
  #define VIRTIO_NET_CTRL_RX_MODE_NOBCAST      5
 
 /*
- * Control the MAC filter table.
+ * Control the MAC
  *
  * The MAC filter table is managed by the hypervisor, the guest should
  * assume the size is infinite.  Filtering should be considered
@@ -119,6 +121,10 @@ typedef uint8_t virtio_net_ctrl_ack;
  * first sg list contains unicast addresses, the second is for multicast.
  * This functionality is present if the VIRTIO_NET_F_CTRL_RX feature
  * is available.
+ *
+ * The ADDR_SET command requests one out scatterlist, it contains a
+ * 6 bytes MAC address. This functionality is present if the
+ * VIRTIO_NET_F_CTRL_MAC_ADDR feature is available.
  */
 struct virtio_net_ctrl_mac {
     uint32_t entries;
@@ -126,6 +132,7 @@ struct virtio_net_ctrl_mac {
 };
 #define VIRTIO_NET_CTRL_MAC    1
  #define VIRTIO_NET_CTRL_MAC_TABLE_SET        0
+ #define VIRTIO_NET_CTRL_MAC_ADDR_SET         1
 
 /*
  * Control VLAN filtering
@@ -158,5 +165,6 @@ struct virtio_net_ctrl_mac {
         DEFINE_PROP_BIT("ctrl_vq", _state, _field, VIRTIO_NET_F_CTRL_VQ, true), \
         DEFINE_PROP_BIT("ctrl_rx", _state, _field, VIRTIO_NET_F_CTRL_RX, true), \
         DEFINE_PROP_BIT("ctrl_vlan", _state, _field, VIRTIO_NET_F_CTRL_VLAN, true), \
-        DEFINE_PROP_BIT("ctrl_rx_extra", _state, _field, VIRTIO_NET_F_CTRL_RX_EXTRA, true)
+        DEFINE_PROP_BIT("ctrl_rx_extra", _state, _field, VIRTIO_NET_F_CTRL_RX_EXTRA, true), \
+        DEFINE_PROP_BIT("ctrl_mac_addr", _state, _field, VIRTIO_NET_F_CTRL_MAC_ADDR, true)
 #endif
-- 
1.7.11.7
