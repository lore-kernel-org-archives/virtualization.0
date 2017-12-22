From: Jason Baron via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [PATCH net-next v2 1/3] virtio_net: propagate linkspeed/duplex
	settings from the hypervisor
Date: Fri, 22 Dec 2017 16:54:01 -0500
Message-ID: <44da522ecee60792ec918234ee4d61a84e4574f0.1513974243.git.jbaron__8617.99333147264$1515606560$gmane$org@akamai.com>
References: <1513979641-7999-1-git-send-email-jbaron@akamai.com>
Reply-To: Jason Baron <jbaron@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1513979641-7999-1-git-send-email-jbaron@akamai.com>
In-Reply-To: <cover.1513974243.git.jbaron@akamai.com>
References: <cover.1513974243.git.jbaron@akamai.com>
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

The ability to set speed and duplex for virtio_net in useful in various
scenarios as described here:

16032be virtio_net: add ethtool support for set and get of settings

However, it would be nice to be able to set this from the hypervisor,
such that virtio_net doesn't require custom guest ethtool commands.

Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
the hypervisor to export a linkspeed and duplex setting. The user can
subsequently overwrite it later if desired via: 'ethtool -s'.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c        | 17 ++++++++++++++++-
 include/uapi/linux/virtio_net.h |  5 +++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 511f833..4168d82 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2621,6 +2621,20 @@ static int virtnet_probe(struct virtio_device *vdev)
 	netif_set_real_num_rx_queues(dev, vi->curr_queue_pairs);
 
 	virtnet_init_settings(dev);
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_SPEED_DUPLEX)) {
+		u32 speed;
+		u8 duplex;
+
+		speed = virtio_cread32(vdev, offsetof(struct virtio_net_config,
+				       speed));
+		if (ethtool_validate_speed(speed))
+			vi->speed = speed;
+		duplex = virtio_cread8(vdev,
+				       offsetof(struct virtio_net_config,
+				       duplex));
+		if (ethtool_validate_duplex(duplex))
+			vi->duplex = duplex;
+	}
 
 	err = register_netdev(dev);
 	if (err) {
@@ -2746,7 +2760,8 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
-	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
+	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
+	VIRTIO_NET_F_SPEED_DUPLEX
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index fc353b5..0f1548e 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,8 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Host set linkspeed and duplex */
+
 #ifndef VIRTIO_NET_NO_LEGACY
 #define VIRTIO_NET_F_GSO	6	/* Host handles pkts w/ any GSO type */
 #endif /* VIRTIO_NET_NO_LEGACY */
@@ -76,6 +78,9 @@ struct virtio_net_config {
 	__u16 max_virtqueue_pairs;
 	/* Default maximum transmit unit advice */
 	__u16 mtu;
+	/* Host exported linkspeed and duplex */
+	__u32 speed;
+	__u8 duplex;
 } __attribute__((packed));
 
 /*
-- 
2.6.1
