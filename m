From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/3] lguest: 2.6.21-mm1 update: lguest-net-stats-inline.patch
Date: Mon, 07 May 2007 11:12:10 +1000
Message-ID: <1178500330.7731.30.camel__27256.7559419715$1178500393$gmane$org@localhost.localdomain>
References: <1178500168.7731.23.camel@localhost.localdomain>
	<1178500252.7731.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1178500252.7731.26.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Now inline net_device_stats is upstream, we can use it in the lguest
net driver.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/lguest_net.c |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

===================================================================
--- a/drivers/net/lguest_net.c
+++ b/drivers/net/lguest_net.c
@@ -38,8 +38,6 @@ struct lguestnet_info
 	/* My peerid. */
 	unsigned int me;
 
-	struct net_device_stats stats;
-
 	/* Receive queue. */
 	struct sk_buff *skb[NUM_SKBS];
 	struct lguest_dma dma[NUM_SKBS];
@@ -120,13 +118,13 @@ static void transfer_packet(struct net_d
 
 	hcall(LHCALL_SEND_DMA, peer_key(info,peernum), __pa(&dma), 0);
 	if (dma.used_len != skb->len) {
-		info->stats.tx_carrier_errors++;
+		dev->stats.tx_carrier_errors++;
 		pr_debug("Bad xfer to peer %i: %i of %i (dma %p/%i)\n",
 			 peernum, dma.used_len, skb->len,
 			 (void *)dma.addr[0], dma.len[0]);
 	} else {
-		info->stats.tx_bytes += skb->len;
-		info->stats.tx_packets++;
+		dev->stats.tx_bytes += skb->len;
+		dev->stats.tx_packets++;
 	}
 }
 
@@ -212,8 +210,8 @@ static irqreturn_t lguestnet_rcv(int irq
 		pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
 			 ntohs(skb->protocol), skb->len, skb->pkt_type);
 
-		info->stats.rx_bytes += skb->len;
-		info->stats.rx_packets++;
+		dev->stats.rx_bytes += skb->len;
+		dev->stats.rx_packets++;
 		netif_rx(skb);
 	}
 	return done ? IRQ_HANDLED : IRQ_NONE;
@@ -258,13 +256,6 @@ static int lguestnet_close(struct net_de
 	for (i = 0; i < ARRAY_SIZE(info->dma); i++)
 		dev_kfree_skb(info->skb[i]);
 	return 0;
-}
-
-static struct net_device_stats *lguestnet_get_stats(struct net_device *dev)
-{
-	struct lguestnet_info *info = dev->priv;
-
-	return &info->stats;
 }
 
 static int lguestnet_probe(struct lguest_device *lgdev)
@@ -295,7 +286,6 @@ static int lguestnet_probe(struct lguest
 	dev->open = lguestnet_open;
 	dev->stop = lguestnet_close;
 	dev->hard_start_xmit = lguestnet_start_xmit;
-	dev->get_stats = lguestnet_get_stats;
 
 	/* Turning on/off promisc will call dev->set_multicast_list.
 	 * We don't actually support multicast yet */
