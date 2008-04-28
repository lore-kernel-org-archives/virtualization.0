From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/4] virtio: net: Add ethtool ops for SG/GSO
Date: Tue, 29 Apr 2008 01:19:16 +1000
Message-ID: <200804290119.17180.rusty__7350.96478970281$1209396324$gmane$org@rustcorp.com.au>
References: <200804290116.05951.rusty@rustcorp.com.au>
	<200804290117.45010.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804290117.45010.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: virtualization@lists.linuxfoundation.org

Date: Fri, 18 Apr 2008 11:21:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>

This patch adds some basic ethtool operations to virtio_net so
I could test SG without GSO (which was really useful because TSO
turned out to be buggy :)

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (remove MTU setting)
---
 drivers/net/virtio_net.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
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
@@ -352,6 +353,22 @@ static int virtnet_close(struct net_devi
 	return 0;
 }
 
+static int virtnet_set_tx_csum(struct net_device *dev, u32 data)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtio_device *vdev = vi->vdev;
+
+	if (data && !virtio_has_feature(vdev, VIRTIO_NET_F_CSUM))
+		return -ENOSYS;
+
+	return ethtool_op_set_tx_hw_csum(dev, data);
+}
+
+static struct ethtool_ops virtnet_ethtool_ops = {
+	.set_tx_csum = virtnet_set_tx_csum,
+	.set_sg = ethtool_op_set_sg,
+};
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int err;
@@ -371,6 +389,7 @@ static int virtnet_probe(struct virtio_d
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	dev->poll_controller = virtnet_netpoll;
 #endif
+	SET_ETHTOOL_OPS(dev, &virtnet_ethtool_ops);
 	SET_NETDEV_DEV(dev, &vdev->dev);
 
 	/* Do we support "hardware" checksums? */
