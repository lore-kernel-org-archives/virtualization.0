From: akong@redhat.com
Subject: [QEMU PATCH v2] virtio-net: introduce a new macaddr control
Date: Wed, 16 Jan 2013 14:16:47 +0800
Message-ID: <1358317007-29972-1-git-send-email-akong__7771.89581790498$1358317029$gmane$org@redhat.com>
References: <1358315821-29519-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358315821-29519-1-git-send-email-akong@redhat.com>
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
a new control command to set MAC address in one time.

VIRTIO_NET_F_CTRL_MAC_ADDR is a new feature bit for compatibility.

Signed-off-by: Amos Kong <akong@redhat.com>
---
V2: check guest's iov_len before memcpy
---
 hw/virtio-net.c | 10 ++++++++++
 hw/virtio-net.h |  9 ++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index dc7c6d6..d05f98f 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -247,6 +247,7 @@ static uint32_t virtio_net_get_features(VirtIODevice *vdev, uint32_t features)
     VirtIONet *n = to_virtio_net(vdev);
 
     features |= (1 << VIRTIO_NET_F_MAC);
+    features |= (1 << VIRTIO_NET_F_CTRL_MAC_ADDR);
 
     if (!peer_has_vnet_hdr(n)) {
         features &= ~(0x1 << VIRTIO_NET_F_CSUM);
@@ -282,6 +283,7 @@ static uint32_t virtio_net_bad_features(VirtIODevice *vdev)
     /* Linux kernel 2.6.25.  It understood MAC (as everyone must),
      * but also these: */
     features |= (1 << VIRTIO_NET_F_MAC);
+    features |= (1 << VIRTIO_NET_F_CTRL_MAC_ADDR);
     features |= (1 << VIRTIO_NET_F_CSUM);
     features |= (1 << VIRTIO_NET_F_HOST_TSO4);
     features |= (1 << VIRTIO_NET_F_HOST_TSO6);
@@ -349,6 +351,14 @@ static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
 {
     struct virtio_net_ctrl_mac mac_data;
 
+    if (cmd == VIRTIO_NET_CTRL_MAC_ADDR_SET && elem->out_num == 2 &&
+        elem->out_sg[1].iov_len == ETH_ALEN) {
+        /* Set MAC address */
+        memcpy(n->mac, elem->out_sg[1].iov_base, elem->out_sg[1].iov_len);
+        qemu_format_nic_info_str(&n->nic->nc, n->mac);
+        return VIRTIO_NET_OK;
+    }
+
     if (cmd != VIRTIO_NET_CTRL_MAC_TABLE_SET || elem->out_num != 3 ||
         elem->out_sg[1].iov_len < sizeof(mac_data) ||
         elem->out_sg[2].iov_len < sizeof(mac_data))
diff --git a/hw/virtio-net.h b/hw/virtio-net.h
index d46fb98..9394cc0 100644
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
-- 
1.7.11.7
