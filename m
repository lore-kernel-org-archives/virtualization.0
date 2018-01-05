From: Jason Baron via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [PATCH net-next v4 1/3] virtio_net: propagate linkspeed/duplex
	settings from the hypervisor
Date: Fri,  5 Jan 2018 17:44:54 -0500
Message-ID: <718139aaea9a1ef032b29429af570fb171fdacac.1515190238.git.jbaron__33189.6616415635$1515606866$gmane$org@akamai.com>
References: <cover.1515190238.git.jbaron@akamai.com>
Reply-To: Jason Baron <jbaron@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1515190238.git.jbaron@akamai.com>
In-Reply-To: <cover.1515190238.git.jbaron@akamai.com>
References: <cover.1515190238.git.jbaron@akamai.com>
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
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

The ability to set speed and duplex for virtio_net is useful in various
scenarios as described here:

16032be virtio_net: add ethtool support for set and get of settings

However, it would be nice to be able to set this from the hypervisor,
such that virtio_net doesn't require custom guest ethtool commands.

Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
the hypervisor to export a linkspeed and duplex setting. The user can
subsequently overwrite it later if desired via: 'ethtool -s'.

Note that VIRTIO_NET_F_SPEED_DUPLEX is defined as bit 63, the intention
is that device feature bits are to grow down from bit 63, since the
transports are starting from bit 24 and growing up.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
---
 drivers/net/virtio_net.c        | 23 ++++++++++++++++++++++-
 include/uapi/linux/virtio_net.h | 13 +++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6fb7b65..4f27508 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1894,6 +1894,24 @@ static void virtnet_init_settings(struct net_device *dev)
 	vi->duplex = DUPLEX_UNKNOWN;
 }
 
+static void virtnet_update_settings(struct virtnet_info *vi)
+{
+	u32 speed;
+	u8 duplex;
+
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
+		return;
+
+	speed = virtio_cread32(vi->vdev, offsetof(struct virtio_net_config,
+						  speed));
+	if (ethtool_validate_speed(speed))
+		vi->speed = speed;
+	duplex = virtio_cread8(vi->vdev, offsetof(struct virtio_net_config,
+						  duplex));
+	if (ethtool_validate_duplex(duplex))
+		vi->duplex = duplex;
+}
+
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
@@ -2147,6 +2165,7 @@ static void virtnet_config_changed_work(struct work_struct *work)
 	vi->status = v;
 
 	if (vi->status & VIRTIO_NET_S_LINK_UP) {
+		virtnet_update_settings(vi);
 		netif_carrier_on(vi->dev);
 		netif_tx_wake_all_queues(vi->dev);
 	} else {
@@ -2695,6 +2714,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 		schedule_work(&vi->config_work);
 	} else {
 		vi->status = VIRTIO_NET_S_LINK_UP;
+		virtnet_update_settings(vi);
 		netif_carrier_on(dev);
 	}
 
@@ -2796,7 +2816,8 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
-	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
+	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
+	VIRTIO_NET_F_SPEED_DUPLEX
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index fc353b5..5de6ed3 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,8 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
+
 #ifndef VIRTIO_NET_NO_LEGACY
 #define VIRTIO_NET_F_GSO	6	/* Host handles pkts w/ any GSO type */
 #endif /* VIRTIO_NET_NO_LEGACY */
@@ -76,6 +78,17 @@ struct virtio_net_config {
 	__u16 max_virtqueue_pairs;
 	/* Default maximum transmit unit advice */
 	__u16 mtu;
+	/*
+	 * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
+	 * Any other value stands for unknown.
+	 */
+	__u32 speed;
+	/*
+	 * 0x00 - half duplex
+	 * 0x01 - full duplex
+	 * Any other value stands for unknown.
+	 */
+	__u8 duplex;
 } __attribute__((packed));
 
 /*
-- 
2.6.1
