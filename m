From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH qemu] virtio-net: add feature bit for any header s/g
Date: Fri, 28 Sep 2012 11:31:10 +0200
Message-ID: <20120928093110.GA6935@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Lendacky <tahm@linux.vnet.ibm.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, avi@redhat.com, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Old qemu versions required that 1st s/g entry is the header.

My recent patchset titled "virtio-net: iovec handling cleanup"
removed this limitation but a feature
bit is needed so guests know it's safe to lay out
header differently.

This patch applies on top and adds such a feature bit.
virtio net header inline with the data is beneficial
for latency and small packet bandwidth.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio-net.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio-net.h b/hw/virtio-net.h
index 36aa463..e7187e4 100644
--- a/hw/virtio-net.h
+++ b/hw/virtio-net.h
@@ -44,6 +44,7 @@
 #define VIRTIO_NET_F_CTRL_RX    18      /* Control channel RX mode support */
 #define VIRTIO_NET_F_CTRL_VLAN  19      /* Control channel VLAN filtering */
 #define VIRTIO_NET_F_CTRL_RX_EXTRA 20   /* Extra RX mode control support */
+#define VIRTIO_NET_F_ANY_HEADER_SG 22   /* Host can handle any header s/g */
 
 #define VIRTIO_NET_S_LINK_UP    1       /* Link is up */
 
@@ -186,5 +187,6 @@ struct virtio_net_ctrl_mac {
         DEFINE_PROP_BIT("ctrl_vq", _state, _field, VIRTIO_NET_F_CTRL_VQ, true), \
         DEFINE_PROP_BIT("ctrl_rx", _state, _field, VIRTIO_NET_F_CTRL_RX, true), \
         DEFINE_PROP_BIT("ctrl_vlan", _state, _field, VIRTIO_NET_F_CTRL_VLAN, true), \
-        DEFINE_PROP_BIT("ctrl_rx_extra", _state, _field, VIRTIO_NET_F_CTRL_RX_EXTRA, true)
+        DEFINE_PROP_BIT("ctrl_rx_extra", _state, _field, VIRTIO_NET_F_CTRL_RX_EXTRA, true), \
+        DEFINE_PROP_BIT("any_header_sg", _state, _field, VIRTIO_NET_F_ANY_HEADER_SG, true)
 #endif
-- 
MST
