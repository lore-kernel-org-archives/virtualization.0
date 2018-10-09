From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next V3] virtio_net: ethtool tx napi configuration
Date: Tue,  9 Oct 2018 10:06:26 +0800
Message-ID: <20181009020626.31723-1-jasowang@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Implement ethtool .set_coalesce (-C) and .get_coalesce (-c) handlers.
Interrupt moderation is currently not supported, so these accept and
display the default settings of 0 usec and 1 frame.

Toggle tx napi through setting tx-frames. So as to not interfere
with possible future interrupt moderation, value 1 means tx napi while
value 0 means not.

Only allow the switching when device is down for simplicity.

Link: https://patchwork.ozlabs.org/patch/948149/
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes from V2:
- only allow the switching when device is done
- remove unnecessary global variable and initialization
Changes from V1:
- try to synchronize with datapath to allow changing mode when
  interface is up.
- use tx-frames 0 as to disable tx napi while tx-frames 1 to enable tx napi
---
 drivers/net/virtio_net.c | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 765920905226..751f385f4e0a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2181,6 +2181,54 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
 	return 0;
 }
 
+static int virtnet_set_coalesce(struct net_device *dev,
+				struct ethtool_coalesce *ec)
+{
+	struct ethtool_coalesce ec_default = {
+		.cmd = ETHTOOL_SCOALESCE,
+		.rx_max_coalesced_frames = 1,
+	};
+	struct virtnet_info *vi = netdev_priv(dev);
+	int i, napi_weight;
+	bool running = netif_running(dev);
+
+	if (ec->tx_max_coalesced_frames > 1)
+		return -EINVAL;
+
+	ec_default.tx_max_coalesced_frames = ec->tx_max_coalesced_frames;
+	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
+
+	/* disallow changes to fields not explicitly tested above */
+	if (memcmp(ec, &ec_default, sizeof(ec_default)))
+		return -EINVAL;
+
+	if (napi_weight ^ vi->sq[0].napi.weight) {
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			vi->sq[i].napi.weight = napi_weight;
+	}
+
+	return 0;
+}
+
+static int virtnet_get_coalesce(struct net_device *dev,
+				struct ethtool_coalesce *ec)
+{
+	struct ethtool_coalesce ec_default = {
+		.cmd = ETHTOOL_GCOALESCE,
+		.rx_max_coalesced_frames = 1,
+	};
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	memcpy(ec, &ec_default, sizeof(ec_default));
+
+	if (vi->sq[0].napi.weight)
+		ec->tx_max_coalesced_frames = 1;
+
+	return 0;
+}
+
 static void virtnet_init_settings(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -2219,6 +2267,8 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_ts_info = ethtool_op_get_ts_info,
 	.get_link_ksettings = virtnet_get_link_ksettings,
 	.set_link_ksettings = virtnet_set_link_ksettings,
+	.set_coalesce = virtnet_set_coalesce,
+	.get_coalesce = virtnet_get_coalesce,
 };
 
 static void virtnet_freeze_down(struct virtio_device *vdev)
-- 
2.17.1
