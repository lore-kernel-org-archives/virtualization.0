From: akong@redhat.com
Subject: [QEMU PATCH v4 1/3] virtio-net: remove layout assumptions for ctrl vq
Date: Sat, 19 Jan 2013 09:54:26 +0800
Message-ID: <1358560468-10865-2-git-send-email-akong@redhat.com>
References: <1358560468-10865-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358560468-10865-1-git-send-email-akong@redhat.com>
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

From: "Michael S. Tsirkin" <mst@redhat.com>

Virtio-net code makes assumption about virtqueue descriptor layout
(e.g. sg[0] is the header, sg[1] is the data buffer).

This patch makes code not rely on the layout of descriptors.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Amos Kong <akong@redhat.com>
---
 hw/virtio-net.c | 128 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 74 insertions(+), 54 deletions(-)

diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index 3bb01b1..113e194 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -315,44 +315,44 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint32_t features)
 }
 
 static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
-                                     VirtQueueElement *elem)
+                                     struct iovec *iov, unsigned int iov_cnt)
 {
     uint8_t on;
+    size_t s;
 
-    if (elem->out_num != 2 || elem->out_sg[1].iov_len != sizeof(on)) {
-        error_report("virtio-net ctrl invalid rx mode command");
-        exit(1);
+    s = iov_to_buf(iov, iov_cnt, 0, &on, sizeof(on));
+    if (s != sizeof(on)) {
+        return VIRTIO_NET_ERR;
     }
 
-    on = ldub_p(elem->out_sg[1].iov_base);
-
-    if (cmd == VIRTIO_NET_CTRL_RX_MODE_PROMISC)
+    if (cmd == VIRTIO_NET_CTRL_RX_MODE_PROMISC) {
         n->promisc = on;
-    else if (cmd == VIRTIO_NET_CTRL_RX_MODE_ALLMULTI)
+    } else if (cmd == VIRTIO_NET_CTRL_RX_MODE_ALLMULTI) {
         n->allmulti = on;
-    else if (cmd == VIRTIO_NET_CTRL_RX_MODE_ALLUNI)
+    } else if (cmd == VIRTIO_NET_CTRL_RX_MODE_ALLUNI) {
         n->alluni = on;
-    else if (cmd == VIRTIO_NET_CTRL_RX_MODE_NOMULTI)
+    } else if (cmd == VIRTIO_NET_CTRL_RX_MODE_NOMULTI) {
         n->nomulti = on;
-    else if (cmd == VIRTIO_NET_CTRL_RX_MODE_NOUNI)
+    } else if (cmd == VIRTIO_NET_CTRL_RX_MODE_NOUNI) {
         n->nouni = on;
-    else if (cmd == VIRTIO_NET_CTRL_RX_MODE_NOBCAST)
+    } else if (cmd == VIRTIO_NET_CTRL_RX_MODE_NOBCAST) {
         n->nobcast = on;
-    else
+    } else {
         return VIRTIO_NET_ERR;
+    }
 
     return VIRTIO_NET_OK;
 }
 
 static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
-                                 VirtQueueElement *elem)
+                                 struct iovec *iov, unsigned int iov_cnt)
 {
     struct virtio_net_ctrl_mac mac_data;
+    size_t s;
 
-    if (cmd != VIRTIO_NET_CTRL_MAC_TABLE_SET || elem->out_num != 3 ||
-        elem->out_sg[1].iov_len < sizeof(mac_data) ||
-        elem->out_sg[2].iov_len < sizeof(mac_data))
+    if (cmd != VIRTIO_NET_CTRL_MAC_TABLE_SET) {
         return VIRTIO_NET_ERR;
+    }
 
     n->mac_table.in_use = 0;
     n->mac_table.first_multi = 0;
@@ -360,54 +360,71 @@ static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
     n->mac_table.multi_overflow = 0;
     memset(n->mac_table.macs, 0, MAC_TABLE_ENTRIES * ETH_ALEN);
 
-    mac_data.entries = ldl_p(elem->out_sg[1].iov_base);
+    s = iov_to_buf(iov, iov_cnt, 0, &mac_data.entries,
+                   sizeof(mac_data.entries));
 
-    if (sizeof(mac_data.entries) +
-        (mac_data.entries * ETH_ALEN) > elem->out_sg[1].iov_len)
+    if (s != sizeof(mac_data.entries)) {
         return VIRTIO_NET_ERR;
+    }
+    iov_discard_front(&iov, &iov_cnt, s);
+
+    if (mac_data.entries * ETH_ALEN > iov_size(iov, iov_cnt)) {
+        return VIRTIO_NET_ERR;
+    }
 
     if (mac_data.entries <= MAC_TABLE_ENTRIES) {
-        memcpy(n->mac_table.macs, elem->out_sg[1].iov_base + sizeof(mac_data),
-               mac_data.entries * ETH_ALEN);
+        s = iov_to_buf(iov, iov_cnt, 0, n->mac_table.macs,
+                       mac_data.entries * ETH_ALEN);
+        if (s != mac_data.entries * ETH_ALEN) {
+            return VIRTIO_NET_OK;
+        }
         n->mac_table.in_use += mac_data.entries;
     } else {
         n->mac_table.uni_overflow = 1;
     }
 
+    iov_discard_front(&iov, &iov_cnt, mac_data.entries * ETH_ALEN);
+
     n->mac_table.first_multi = n->mac_table.in_use;
 
-    mac_data.entries = ldl_p(elem->out_sg[2].iov_base);
+    s = iov_to_buf(iov, iov_cnt, 0, &mac_data.entries,
+                   sizeof(mac_data.entries));
 
-    if (sizeof(mac_data.entries) +
-        (mac_data.entries * ETH_ALEN) > elem->out_sg[2].iov_len)
+    if (s != sizeof(mac_data.entries)) {
         return VIRTIO_NET_ERR;
+    }
 
-    if (mac_data.entries) {
-        if (n->mac_table.in_use + mac_data.entries <= MAC_TABLE_ENTRIES) {
-            memcpy(n->mac_table.macs + (n->mac_table.in_use * ETH_ALEN),
-                   elem->out_sg[2].iov_base + sizeof(mac_data),
-                   mac_data.entries * ETH_ALEN);
-            n->mac_table.in_use += mac_data.entries;
-        } else {
-            n->mac_table.multi_overflow = 1;
+    iov_discard_front(&iov, &iov_cnt, s);
+
+    if (mac_data.entries * ETH_ALEN != iov_size(iov, iov_cnt)) {
+        return VIRTIO_NET_ERR;
+    }
+
+    if (n->mac_table.in_use + mac_data.entries <= MAC_TABLE_ENTRIES) {
+        s = iov_to_buf(iov, iov_cnt, 0, n->mac_table.macs,
+                       mac_data.entries * ETH_ALEN);
+        if (s != mac_data.entries * ETH_ALEN) {
+            return VIRTIO_NET_OK;
         }
+        n->mac_table.in_use += mac_data.entries;
+    } else {
+        n->mac_table.multi_overflow = 1;
     }
 
     return VIRTIO_NET_OK;
 }
 
 static int virtio_net_handle_vlan_table(VirtIONet *n, uint8_t cmd,
-                                        VirtQueueElement *elem)
+                                        struct iovec *iov, unsigned int iov_cnt)
 {
     uint16_t vid;
+    size_t s;
 
-    if (elem->out_num != 2 || elem->out_sg[1].iov_len != sizeof(vid)) {
-        error_report("virtio-net ctrl invalid vlan command");
+    s = iov_to_buf(iov, iov_cnt, 0, &vid, sizeof(vid));
+    if (s != sizeof(vid)) {
         return VIRTIO_NET_ERR;
     }
 
-    vid = lduw_p(elem->out_sg[1].iov_base);
-
     if (vid >= MAX_VLAN)
         return VIRTIO_NET_ERR;
 
@@ -427,30 +444,33 @@ static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
     struct virtio_net_ctrl_hdr ctrl;
     virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
     VirtQueueElement elem;
+    size_t s;
+    struct iovec *iov;
+    unsigned int iov_cnt;
 
     while (virtqueue_pop(vq, &elem)) {
-        if ((elem.in_num < 1) || (elem.out_num < 1)) {
+        if (iov_size(elem.in_sg, elem.in_num) < sizeof(status) ||
+            iov_size(elem.out_sg, elem.out_num) < sizeof(ctrl)) {
             error_report("virtio-net ctrl missing headers");
             exit(1);
         }
 
-        if (elem.out_sg[0].iov_len < sizeof(ctrl) ||
-            elem.in_sg[elem.in_num - 1].iov_len < sizeof(status)) {
-            error_report("virtio-net ctrl header not in correct element");
-            exit(1);
+        iov = elem.out_sg;
+        iov_cnt = elem.out_num;
+        s = iov_to_buf(iov, iov_cnt, 0, &ctrl, sizeof(ctrl));
+        iov_discard_front(&iov, &iov_cnt, sizeof(ctrl));
+        if (s != sizeof(ctrl)) {
+            status = VIRTIO_NET_ERR;
+        } else if (ctrl.class == VIRTIO_NET_CTRL_RX_MODE) {
+            status = virtio_net_handle_rx_mode(n, ctrl.cmd, iov, iov_cnt);
+        } else if (ctrl.class == VIRTIO_NET_CTRL_MAC) {
+            status = virtio_net_handle_mac(n, ctrl.cmd, iov, iov_cnt);
+        } else if (ctrl.class == VIRTIO_NET_CTRL_VLAN) {
+            status = virtio_net_handle_vlan_table(n, ctrl.cmd, iov, iov_cnt);
         }
 
-        ctrl.class = ldub_p(elem.out_sg[0].iov_base);
-        ctrl.cmd = ldub_p(elem.out_sg[0].iov_base + sizeof(ctrl.class));
-
-        if (ctrl.class == VIRTIO_NET_CTRL_RX_MODE)
-            status = virtio_net_handle_rx_mode(n, ctrl.cmd, &elem);
-        else if (ctrl.class == VIRTIO_NET_CTRL_MAC)
-            status = virtio_net_handle_mac(n, ctrl.cmd, &elem);
-        else if (ctrl.class == VIRTIO_NET_CTRL_VLAN)
-            status = virtio_net_handle_vlan_table(n, ctrl.cmd, &elem);
-
-        stb_p(elem.in_sg[elem.in_num - 1].iov_base, status);
+        s = iov_from_buf(elem.in_sg, elem.in_num, 0, &status, sizeof(status));
+        assert(s == sizeof(status));
 
         virtqueue_push(vq, &elem, sizeof(status));
         virtio_notify(vdev, vq);
-- 
1.7.11.7
