From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 4/4] virtio: Enable netpoll interface for netconsole logging
Date: Tue, 11 Mar 2008 23:06:30 +1100
Message-ID: <200803112306.30687.rusty__29235.747017856$1205237452$gmane$org@rustcorp.com.au>
References: <200803112303.22984.rusty@rustcorp.com.au>
	<200803112304.21680.rusty@rustcorp.com.au>
	<200803112305.23648.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803112305.23648.rusty@rustcorp.com.au>
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
Cc: Amit Shah <amitshah@gmx.net>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Amit Shah" <amitshah@gmx.net>

Add a new poll_controller handler that the netpoll interface needs.

This enables netconsole logging from a kvm guest over the virtio
net interface.

Signed-off-by: Amit Shah <amitshah@gmx.net>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/virtio_net.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -294,6 +294,15 @@ again:
 	return 0;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void virtnet_netpoll(struct net_device *dev)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	napi_schedule(&vi->napi);
+}
+#endif
+
 static int virtnet_open(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -336,6 +345,9 @@ static int virtnet_probe(struct virtio_d
 	dev->stop = virtnet_close;
 	dev->hard_start_xmit = start_xmit;
 	dev->features = NETIF_F_HIGHDMA;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = virtnet_netpoll;
+#endif
 	SET_NETDEV_DEV(dev, &vdev->dev);
 
 	/* Do we support "hardware" checksums? */
