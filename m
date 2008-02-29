From: "Amit Shah" <amitshah@gmx.net>
Subject: [PATCH] VIRTIO NET: Enable netpoll interface for netconsole logging
Date: Fri, 29 Feb 2008 16:24:50 +0530
Message-ID: <877aabc40802290254k2ecc559at2a3bc9740cd82ebc__26680.1229947761$1204301913$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Add a new poll_controller handler that the netpoll interface needs.

This enables netconsole logging from a kvm guest over the virtio
net interface.

Signed-off-by: Amit Shah <amitshah@gmx.net>
---
 drivers/net/virtio_net.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fdc2367..3f3d334 100644
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
@@ -336,6 +345,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	dev->stop = virtnet_close;
 	dev->hard_start_xmit = start_xmit;
 	dev->features = NETIF_F_HIGHDMA;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = virtnet_netpoll;
+#endif
 	SET_NETDEV_DEV(dev, &vdev->dev);

 	/* Do we support "hardware" checksums? */
-- 
1.5.2.5

-- 
Amit Shah
http://www.amitshah.net/
