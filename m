From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [5/6] [VIRTIO] net: Add ethtool ops for SG/GSO
Date: Fri, 18 Apr 2008 11:21:42 +0800
Message-ID: <20080418032142.GD18071@gondor.apana.org.au>
References: <20080418031257.GA17993@gondor.apana.org.au>
	<20080418031444.GA18041@gondor.apana.org.au>
	<20080418031554.GA18071@gondor.apana.org.au>
	<20080418031722.GB18071@gondor.apana.org.au>
	<20080418031939.GC18071@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080418031939.GC18071@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

This patch adds some basic ethtool operations to virtio_net so
I could test SG without GSO (which was really useful because TSO
turned out to be buggy :)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b58472c..0b508bb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -19,6 +19,7 @@
 //#define DEBUG
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
 #include <linux/virtio_net.h>
@@ -333,6 +334,33 @@ static int virtnet_close(struct net_device *dev)
 	return 0;
 }
 
+static int virtnet_set_tx_csum(struct net_device *dev, u32 data)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtio_device *vdev = vi->vdev;
+
+	if (data && !vdev->config->feature(vdev, VIRTIO_NET_F_CSUM))
+		return -ENOSYS;
+
+	return ethtool_op_set_tx_hw_csum(dev, data);
+}
+
+static struct ethtool_ops virtnet_ethtool_ops =
+{
+	.set_tx_csum = virtnet_set_tx_csum,
+	.set_sg = ethtool_op_set_sg,
+};
+
+static int virtnet_change_mtu(struct net_device *dev, int mtu)
+{
+	int max = 65535 - ETH_HLEN;
+
+	if (mtu > max)
+		return -EINVAL;
+	dev->mtu = mtu;
+	return 0;
+}
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int err;
@@ -348,10 +376,12 @@ static int virtnet_probe(struct virtio_device *vdev)
 	dev->open = virtnet_open;
 	dev->stop = virtnet_close;
 	dev->hard_start_xmit = start_xmit;
+	dev->change_mtu = virtnet_change_mtu;
 	dev->features = NETIF_F_HIGHDMA;
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	dev->poll_controller = virtnet_netpoll;
 #endif
+	SET_ETHTOOL_OPS(dev, &virtnet_ethtool_ops);
 	SET_NETDEV_DEV(dev, &vdev->dev);
 
 	/* Do we support "hardware" checksums? */
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
