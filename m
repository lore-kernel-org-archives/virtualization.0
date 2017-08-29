From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH RFC 2/2] virtio_net: enable probing for NEEDS_RESET support
Date: Tue, 29 Aug 2017 16:07:59 -0400
Message-ID: <20170829200759.13975-3-willemdebruijn.kernel__44771.8874588192$1504037358$gmane$org@gmail.com>
References: <20170829200759.13975-1-willemdebruijn.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170829200759.13975-1-willemdebruijn.kernel@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Willem de Bruijn <willemb@google.com>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Willem de Bruijn <willemb@google.com>

Implement a mechanism to signal that a virtio device implements the
VIRTIO_CONFIG_S_NEEDS_RESET command.

Testing for VIRTIO_CONFIG_S_NEEDS_RESET support by issuing the request
and verifying the reset state would require an expensive state change.

To avoid that, add a status bit to the feature register used during
feature negotiation between host and guest.

Set the bit for virtio-net, which supports the feature.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/virtio_net.c           | 2 ++
 include/uapi/linux/virtio_config.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5e349226f7c1..15483a982106 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2801,12 +2801,14 @@ static struct virtio_device_id id_table[] = {
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
+	VIRTIO_F_CAN_RESET,
 };
 
 static unsigned int features_legacy[] = {
 	VIRTNET_FEATURES,
 	VIRTIO_NET_F_GSO,
 	VIRTIO_F_ANY_LAYOUT,
+	VIRTIO_F_CAN_RESET,
 };
 
 static struct virtio_driver virtio_net_driver = {
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 308e2096291f..726be44a04d3 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -56,6 +56,9 @@
  * suppressed them? */
 #define VIRTIO_F_NOTIFY_ON_EMPTY	24
 
+/* Driver supports the VIRTIO_CONFIG_S_NEEDS_RESET command */
+#define VIRTIO_F_CAN_RESET		25
+
 /* Can the device handle any descriptor layout? */
 #define VIRTIO_F_ANY_LAYOUT		27
 #endif /* VIRTIO_CONFIG_NO_LEGACY */
-- 
2.14.1.342.g6490525c54-goog
