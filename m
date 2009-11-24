From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] macvlan: cleanup rx statistics
Date: Tue, 24 Nov 2009 09:28:43 +0000
Message-ID: <200911240928.43901.arnd__43264.9620612667$1259055040$gmane$org@arndb.de>
References: <1259024166-28158-1-git-send-email-arnd@arndb.de>
	<4B0B9639.4070607@gmail.com> <200911240845.14454.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200911240845.14454.arnd@arndb.de>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Mark Smith <lk-netdev@lk-netdev.nosense.org>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 24 November 2009 08:45:14 Arnd Bergmann wrote:
> On Tuesday 24 November 2009 08:15:53 Eric Dumazet wrote:
> > Arnd Bergmann a =E9crit :
> > I find following more readable, it probably generates more branches,
> > but avoid dirtying rx_errors if it is in another cache line.
> > =

> > if (likely(success)) {
> > 	rx_stats->rx_packets++;
> > 	rx_stats->rx_bytes +=3D length;
> > 	if (multicast)
> > 		rx_stats->multicast++;
> > } else {
> > 	rx_stats->rx_errors++;
> > }
> =

> Given that the structure only has four members and alloc_percpu requests
> cache aligned data, it is rather likely to be in the same cache line.
> =

> I'll have a look at what gcc generates on x86-64 for both versions
> and use the version you suggested unless it looks significantly more
> expensive.

Ok, that's what I got for trying to be clever. My version did not avoid
any branches, just created more code. I'll fold this update into my
patches then:
---
macvlan: cleanups

Use bool instead of int for flags, don't misoptimize rx counters,
avoid accessing a NULL skb.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 3db96b9..ff5f0b0 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -119,19 +119,23 @@ static int macvlan_addr_busy(const struct macvlan_por=
t *port,
 }
 =

 static inline void macvlan_count_rx(const struct macvlan_dev *vlan, int le=
ngth,
-			     int success, int multicast)
+			     bool success, bool multicast)
 {
 	struct macvlan_rx_stats *rx_stats;
 =

 	rx_stats =3D per_cpu_ptr(vlan->rx_stats, smp_processor_id());
-	rx_stats->rx_packets +=3D success !=3D 0;
-	rx_stats->rx_bytes   +=3D success ? length : 0;
-	rx_stats->multicast  +=3D success && multicast;
-	rx_stats->rx_errors  +=3D !success;
+	if (likely(success)) {
+		rx_stats->rx_packets++;;
+		rx_stats->rx_bytes +=3D length;
+		if (multicast)
+			rx_stats->multicast++;
+	} else {
+		rx_stats->rx_errors++;
+	}
 }
 =

 static int macvlan_broadcast_one(struct sk_buff *skb, struct net_device *d=
ev,
-				 const struct ethhdr *eth, int local)
+				 const struct ethhdr *eth, bool local)
 {
 	if (!skb)
 		return NET_RX_DROP;
@@ -173,7 +177,7 @@ static void macvlan_broadcast(struct sk_buff *skb,
 			err =3D macvlan_broadcast_one(nskb, vlan->dev, eth,
 					 mode =3D=3D MACVLAN_MODE_BRIDGE);
 			macvlan_count_rx(vlan, skb->len + ETH_HLEN,
-					 likely(err =3D=3D NET_RX_SUCCESS), 1);
+					 err =3D=3D NET_RX_SUCCESS, 1);
 		}
 	}
 }
@@ -186,6 +190,7 @@ static struct sk_buff *macvlan_handle_frame(struct sk_b=
uff *skb)
 	const struct macvlan_dev *vlan;
 	const struct macvlan_dev *src;
 	struct net_device *dev;
+	int len;
 =

 	port =3D rcu_dereference(skb->dev->macvlan_port);
 	if (port =3D=3D NULL)
@@ -218,8 +223,11 @@ static struct sk_buff *macvlan_handle_frame(struct sk_=
buff *skb)
 		kfree_skb(skb);
 		return NULL;
 	}
+	len =3D skb->len + ETH_HLEN;
 	skb =3D skb_share_check(skb, GFP_ATOMIC);
-	macvlan_count_rx(vlan, skb->len + ETH_HLEN, likely(skb !=3D NULL), 0);
+	macvlan_count_rx(vlan, len, skb !=3D NULL, 0);
+	if (!skb)
+		return NULL;
 =

 	skb->dev =3D dev;
 	skb->pkt_type =3D PACKET_HOST;
@@ -248,7 +256,7 @@ static int macvlan_queue_xmit(struct sk_buff *skb, stru=
ct net_device *dev)
 			int length =3D skb->len + ETH_HLEN;
 			int ret =3D dev_forward_skb(dest->dev, skb);
 			macvlan_count_rx(dest, length,
-					 likely(ret =3D=3D NET_RX_SUCCESS), 0);
+					 ret =3D=3D NET_RX_SUCCESS, 0);
 =

 			return NET_XMIT_SUCCESS;
 		}
