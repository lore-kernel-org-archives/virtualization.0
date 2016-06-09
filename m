From: Aaron Conole <aconole@redhat.com>
Subject: [PATCH -next] virtio_net: Update the feature bit to comply with spec
Date: Thu,  9 Jun 2016 13:41:15 -0400
Message-ID: <1465494075-31170-1-git-send-email-aconole__8666.78576353497$1465494101$gmane$org@redhat.com>
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
To: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

A draft version of the MTU Advice feature bit was specified as 25.  This
bit is not within the allowed range for network device feature bits, and
should be changed to be feature bit 3 to fully comply with the spec.

Fixes 14de9d114a82 ('virtio-net: Add initial MTU advice feature')
Signed-off-by: Aaron Conole <aconole@redhat.com>
Suggested-by: "Michael S. Tsirkin" <mst@redhat.com>
---
 include/uapi/linux/virtio_net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 1ab4ea6..0da0e3a 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -35,6 +35,7 @@
 #define VIRTIO_NET_F_CSUM	0	/* Host handles pkts w/ partial csum */
 #define VIRTIO_NET_F_GUEST_CSUM	1	/* Guest handles pkts w/ partial csum */
 #define VIRTIO_NET_F_CTRL_GUEST_OFFLOADS 2 /* Dynamic offload configuration. */
+#define VIRTIO_NET_F_MTU	3	/* Initial MTU advice */
 #define VIRTIO_NET_F_MAC	5	/* Host has given MAC address. */
 #define VIRTIO_NET_F_GUEST_TSO4	7	/* Guest can handle TSOv4 in. */
 #define VIRTIO_NET_F_GUEST_TSO6	8	/* Guest can handle TSOv6 in. */
@@ -55,7 +56,6 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
-#define VIRTIO_NET_F_MTU 25	/* Initial MTU advice */
 
 #ifndef VIRTIO_NET_NO_LEGACY
 #define VIRTIO_NET_F_GSO	6	/* Host handles pkts w/ any GSO type */
-- 
2.5.5
