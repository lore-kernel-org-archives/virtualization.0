From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_net: document VIRTIO_NET_CTRL_GUEST_OFFLOADS
Date: Mon, 29 Jun 2015 11:19:47 +0200
Message-ID: <1435569574-28792-1-git-send-email-mst__43767.8933064037$1435569603$gmane$org@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Yan Vugenfirer <yan@daynix.com>, linux-api@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Document VIRTIO_NET_CTRL_GUEST_OFFLOADS and the
relevant feature bits.

Will allow ethtool control of the offloads down the road.

Reported-by: Yan Vugenfirer <yan@daynix.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_net.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 7bbee79..ec32293 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -34,6 +34,7 @@
 /* The feature bitmap for virtio net */
 #define VIRTIO_NET_F_CSUM	0	/* Host handles pkts w/ partial csum */
 #define VIRTIO_NET_F_GUEST_CSUM	1	/* Guest handles pkts w/ partial csum */
+#define VIRTIO_NET_F_CTRL_GUEST_OFFLOADS 2 /* Dynamic offload configuration. */
 #define VIRTIO_NET_F_MAC	5	/* Host has given MAC address. */
 #define VIRTIO_NET_F_GUEST_TSO4	7	/* Guest can handle TSOv4 in. */
 #define VIRTIO_NET_F_GUEST_TSO6	8	/* Guest can handle TSOv6 in. */
@@ -226,4 +227,19 @@ struct virtio_net_ctrl_mq {
  #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
  #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
 
+/*
+ * Control network offloads
+ *
+ * Reconfigures the network offloads that Guest can handle.
+ *
+ * Available with the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature bit.
+ *
+ * Command data format matches the feature bit mask exactly.
+ *
+ * See VIRTIO_NET_F_GUEST_* for the list of offloads
+ * that can be enabled/disabled.
+ */
+#define VIRTIO_NET_CTRL_GUEST_OFFLOADS   5
+#define VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET        0
+
 #endif /* _LINUX_VIRTIO_NET_H */
-- 
MST
