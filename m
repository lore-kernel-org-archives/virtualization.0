From: Jiri Pirko <jpirko@redhat.com>
Subject: [patch net-next] virtio_net: allow to change mac when iface is running
Date: Wed, 27 Jun 2012 17:27:46 +0200
Message-ID: <1340810866-1017-1-git-send-email-jpirko__15265.7588049353$1340810992$gmane$org@redhat.com>
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
To: netdev@vger.kernel.org
Cc: brouer@redhat.com, virtualization@lists.linux-foundation.org, davem@davemloft.net, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jiri Pirko <jpirko@redhat.com>
---
 drivers/net/virtio_net.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f18149a..36a16d5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -679,11 +679,12 @@ static int virtnet_set_mac_address(struct net_device *dev, void *p)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct virtio_device *vdev = vi->vdev;
-	int ret;
+	struct sockaddr *addr = p;
 
-	ret = eth_mac_addr(dev, p);
-	if (ret)
-		return ret;
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
+	dev->addr_assign_type &= ~NET_ADDR_RANDOM;
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC))
 		vdev->config->set(vdev, offsetof(struct virtio_net_config, mac),
-- 
1.7.10.4
