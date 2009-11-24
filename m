From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/4] veth: move loopback logic to common location
Date: Tue, 24 Nov 2009 00:56:03 +0000
Message-ID: <1259024166-28158-2-git-send-email-arnd__33506.350828293$1259024359$gmane$org@arndb.de>
References: <1259024166-28158-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259024166-28158-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Mark Smith <lk-netdev@lk-netdev.nosense.org>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

The veth driver contains code to forward an skb
from the start_xmit function of one network
device into the receive path of another device.

Moving that code into a common location lets us
reuse the code for direct forwarding of data
between macvlan ports, and possibly in other
drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/veth.c        |   17 +++--------------
 include/linux/netdevice.h |    2 ++
 net/core/dev.c            |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 2d657f2..6c4b5a2 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -155,8 +155,6 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct veth_net_stats *stats, *rcv_stats;
 	int length, cpu;
 
-	skb_orphan(skb);
-
 	priv = netdev_priv(dev);
 	rcv = priv->peer;
 	rcv_priv = netdev_priv(rcv);
@@ -168,20 +166,12 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (!(rcv->flags & IFF_UP))
 		goto tx_drop;
 
-	if (skb->len > (rcv->mtu + MTU_PAD))
-		goto rx_drop;
-
-        skb->tstamp.tv64 = 0;
-	skb->pkt_type = PACKET_HOST;
-	skb->protocol = eth_type_trans(skb, rcv);
 	if (dev->features & NETIF_F_NO_CSUM)
 		skb->ip_summed = rcv_priv->ip_summed;
 
-	skb->mark = 0;
-	secpath_reset(skb);
-	nf_reset(skb);
-
-	length = skb->len;
+	length = skb->len + ETH_HLEN;
+	if (dev_forward_skb(rcv, skb) != NET_RX_SUCCESS)
+		goto rx_drop;
 
 	stats->tx_bytes += length;
 	stats->tx_packets++;
@@ -189,7 +179,6 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	rcv_stats->rx_bytes += length;
 	rcv_stats->rx_packets++;
 
-	netif_rx(skb);
 	return NETDEV_TX_OK;
 
 tx_drop:
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 97873e3..9428793 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1562,6 +1562,8 @@ extern int		dev_set_mac_address(struct net_device *,
 extern int		dev_hard_start_xmit(struct sk_buff *skb,
 					    struct net_device *dev,
 					    struct netdev_queue *txq);
+extern int		dev_forward_skb(struct net_device *dev,
+					struct sk_buff *skb);
 
 extern int		netdev_budget;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index ccefa24..ba18e82 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -105,6 +105,7 @@
 #include <net/dst.h>
 #include <net/pkt_sched.h>
 #include <net/checksum.h>
+#include <net/xfrm.h>
 #include <linux/highmem.h>
 #include <linux/init.h>
 #include <linux/kmod.h>
@@ -1419,6 +1420,41 @@ static inline void net_timestamp(struct sk_buff *skb)
 		skb->tstamp.tv64 = 0;
 }
 
+/**
+ * dev_forward_skb - loopback an skb to another netif
+ *
+ * @dev: destination network device
+ * @skb: buffer to forward
+ *
+ * return values:
+ *	NET_RX_SUCCESS	(no congestion)
+ *	NET_RX_DROP     (packet was dropped)
+ *
+ * dev_forward_skb can be used for injecting an skb from the
+ * start_xmit function of one device into the receive queue
+ * of another device.
+ */
+int dev_forward_skb(struct net_device *dev, struct sk_buff *skb)
+{
+	skb_orphan(skb);
+
+	if (!(dev->flags & IFF_UP))
+		return NET_RX_DROP;
+
+	if (skb->len > (dev->mtu + dev->hard_header_len))
+		return NET_RX_DROP;
+
+	skb_dst_drop(skb);
+	skb->tstamp.tv64 = 0;
+	skb->pkt_type = PACKET_HOST;
+	skb->protocol = eth_type_trans(skb, dev);
+	skb->mark = 0;
+	secpath_reset(skb);
+	nf_reset(skb);
+	return netif_rx(skb);
+}
+EXPORT_SYMBOL_GPL(dev_forward_skb);
+
 /*
  *	Support routine. Sends outgoing frames to any network
  *	taps currently in use.
-- 
1.6.3.3
