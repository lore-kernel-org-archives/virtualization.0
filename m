From: Mark McLoughlin <markmc@redhat.com>
Subject: [PATCH] virtio_net: large tx MTU support
Date: Wed, 26 Nov 2008 13:58:11 +0000
Message-ID: <1227707891.9579.44.camel__17608.5637569942$1227708203$gmane$org@blaa>
Reply-To: Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: netdev <netdev@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

We don't really have a max tx packet size limit, so allow configuring
the device with up to 64k tx MTU.

Signed-off-by: Mark McLoughlin <markmc@redhat.com>
---
 drivers/net/virtio_net.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e6b5d6e..71ca29c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -613,6 +613,17 @@ static struct ethtool_ops virtnet_ethtool_ops = {
 	.set_tso = ethtool_op_set_tso,
 };
 
+#define MIN_MTU 68
+#define MAX_MTU 65535
+
+static int virtnet_change_mtu(struct net_device *dev, int new_mtu)
+{
+	if (new_mtu < MIN_MTU || new_mtu > MAX_MTU)
+		return -EINVAL;
+	dev->mtu = new_mtu;
+	return 0;
+}
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int err;
@@ -628,6 +639,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	dev->open = virtnet_open;
 	dev->stop = virtnet_close;
 	dev->hard_start_xmit = start_xmit;
+	dev->change_mtu = virtnet_change_mtu;
 	dev->features = NETIF_F_HIGHDMA;
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	dev->poll_controller = virtnet_netpoll;
-- 
1.6.0.3
