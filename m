From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/4] macvlan: cleanup rx statistics
Date: Tue, 24 Nov 2009 00:56:04 +0000
Message-ID: <1259024166-28158-3-git-send-email-arnd__1645.69276753372$1259024270$gmane$org@arndb.de>
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

We have very similar code for rx statistics in
two places in the macvlan driver, with a third
one being added in the next patch.

Consolidate them into one function to improve
overall readability of the driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/macvlan.c |   63 +++++++++++++++++++++++++-----------------------
 1 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index ae2b5c7..a0dea23 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -116,42 +116,53 @@ static int macvlan_addr_busy(const struct macvlan_port *port,
 	return 0;
 }
 
+static inline void macvlan_count_rx(const struct macvlan_dev *vlan, int length,
+			     int success, int multicast)
+{
+	struct macvlan_rx_stats *rx_stats;
+
+	rx_stats = per_cpu_ptr(vlan->rx_stats, smp_processor_id());
+	rx_stats->rx_packets += success != 0;
+	rx_stats->rx_bytes   += success ? length : 0;
+	rx_stats->multicast  += success && multicast;
+	rx_stats->rx_errors  += !success;
+}
+
+static int macvlan_broadcast_one(struct sk_buff *skb, struct net_device *dev,
+				 const struct ethhdr *eth)
+{
+	if (!skb)
+		return NET_RX_DROP;
+
+	skb->dev = dev;
+	if (!compare_ether_addr_64bits(eth->h_dest,
+				       dev->broadcast))
+		skb->pkt_type = PACKET_BROADCAST;
+	else
+		skb->pkt_type = PACKET_MULTICAST;
+
+	return netif_rx(skb);
+}
+
 static void macvlan_broadcast(struct sk_buff *skb,
 			      const struct macvlan_port *port)
 {
 	const struct ethhdr *eth = eth_hdr(skb);
 	const struct macvlan_dev *vlan;
 	struct hlist_node *n;
-	struct net_device *dev;
 	struct sk_buff *nskb;
 	unsigned int i;
-	struct macvlan_rx_stats *rx_stats;
+	int err;
 
 	if (skb->protocol == htons(ETH_P_PAUSE))
 		return;
 
 	for (i = 0; i < MACVLAN_HASH_SIZE; i++) {
 		hlist_for_each_entry_rcu(vlan, n, &port->vlan_hash[i], hlist) {
-			dev = vlan->dev;
-			rx_stats = per_cpu_ptr(vlan->rx_stats, smp_processor_id());
-
 			nskb = skb_clone(skb, GFP_ATOMIC);
-			if (nskb == NULL) {
-				rx_stats->rx_errors++;
-				continue;
-			}
-
-			rx_stats->rx_bytes += skb->len + ETH_HLEN;
-			rx_stats->rx_packets++;
-			rx_stats->multicast++;
-
-			nskb->dev = dev;
-			if (!compare_ether_addr_64bits(eth->h_dest, dev->broadcast))
-				nskb->pkt_type = PACKET_BROADCAST;
-			else
-				nskb->pkt_type = PACKET_MULTICAST;
-
-			netif_rx(nskb);
+			err = macvlan_broadcast_one(nskb, vlan->dev, eth);
+			macvlan_count_rx(vlan, skb->len + ETH_HLEN,
+					 likely(err == NET_RX_SUCCESS), 1);
 		}
 	}
 }
@@ -163,7 +174,6 @@ static struct sk_buff *macvlan_handle_frame(struct sk_buff *skb)
 	const struct macvlan_port *port;
 	const struct macvlan_dev *vlan;
 	struct net_device *dev;
-	struct macvlan_rx_stats *rx_stats;
 
 	port = rcu_dereference(skb->dev->macvlan_port);
 	if (port == NULL)
@@ -183,15 +193,8 @@ static struct sk_buff *macvlan_handle_frame(struct sk_buff *skb)
 		kfree_skb(skb);
 		return NULL;
 	}
-	rx_stats = per_cpu_ptr(vlan->rx_stats, smp_processor_id());
 	skb = skb_share_check(skb, GFP_ATOMIC);
-	if (skb == NULL) {
-		rx_stats->rx_errors++;
-		return NULL;
-	}
-
-	rx_stats->rx_bytes += skb->len + ETH_HLEN;
-	rx_stats->rx_packets++;
+	macvlan_count_rx(vlan, skb->len + ETH_HLEN, likely(skb != NULL), 0);
 
 	skb->dev = dev;
 	skb->pkt_type = PACKET_HOST;
-- 
1.6.3.3
