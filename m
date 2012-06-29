From: Jiri Pirko <jpirko@redhat.com>
Subject: [patch net-next v2 4/4] dummy: use IFF_LIVE_ADDR_CHANGE priv_flag
Date: Fri, 29 Jun 2012 17:10:08 +0200
Message-ID: <1340982608-897-5-git-send-email-jpirko__194.029257591133$1340982663$gmane$org@redhat.com>
References: <1340982608-897-1-git-send-email-jpirko@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1340982608-897-1-git-send-email-jpirko@redhat.com>
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
Cc: mst@redhat.com, shimoda.hiroaki@gmail.com, virtualization@lists.linux-foundation.org, danny.kukawka@bisect.de, edumazet@google.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jiri Pirko <jpirko@redhat.com>
---
 drivers/net/dummy.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index bab0158..9d6a067 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -40,18 +40,6 @@
 
 static int numdummies = 1;
 
-static int dummy_set_address(struct net_device *dev, void *p)
-{
-	struct sockaddr *sa = p;
-
-	if (!is_valid_ether_addr(sa->sa_data))
-		return -EADDRNOTAVAIL;
-
-	dev->addr_assign_type &= ~NET_ADDR_RANDOM;
-	memcpy(dev->dev_addr, sa->sa_data, ETH_ALEN);
-	return 0;
-}
-
 /* fake multicast ability */
 static void set_multicast_list(struct net_device *dev)
 {
@@ -118,7 +106,7 @@ static const struct net_device_ops dummy_netdev_ops = {
 	.ndo_start_xmit		= dummy_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_rx_mode	= set_multicast_list,
-	.ndo_set_mac_address	= dummy_set_address,
+	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_get_stats64	= dummy_get_stats64,
 };
 
@@ -134,6 +122,7 @@ static void dummy_setup(struct net_device *dev)
 	dev->tx_queue_len = 0;
 	dev->flags |= IFF_NOARP;
 	dev->flags &= ~IFF_MULTICAST;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	dev->features	|= NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_TSO;
 	dev->features	|= NETIF_F_HW_CSUM | NETIF_F_HIGHDMA | NETIF_F_LLTX;
 	eth_hw_addr_random(dev);
-- 
1.7.10.4
