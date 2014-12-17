From: Vladislav Yasevich <vyasevich@gmail.com>
Subject: [PATCH 02/10] net:  Correctly mark IPv6 UFO offload type.
Date: Wed, 17 Dec 2014 13:20:47 -0500
Message-ID: <1418840455-22598-3-git-send-email-vyasevic__48573.4875467189$1418840535$gmane$org@redhat.com>
References: <1418840455-22598-1-git-send-email-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418840455-22598-1-git-send-email-vyasevic@redhat.com>
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
Cc: mst@redhat.com, ben@decadent.org.uk, stefanha@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

If the device supports UFO6 features, mark the offloaded ipv6 udp
traffic appropriately.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 net/ipv6/ip6_offload.c | 1 +
 net/ipv6/ip6_output.c  | 4 ++--
 net/ipv6/udp_offload.c | 3 ++-
 net/mpls/mpls_gso.c    | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 01e12d0..bd985d5 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -81,6 +81,7 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 		       SKB_GSO_UDP_TUNNEL_CSUM |
 		       SKB_GSO_MPLS |
 		       SKB_GSO_TCPV6 |
+		       SKB_GSO_UDP6 |
 		       0)))
 		goto out;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 8e950c2..83f5c04 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1089,7 +1089,7 @@ static inline int ip6_ufo_append_data(struct sock *sk,
 	 */
 	skb_shinfo(skb)->gso_size = (mtu - fragheaderlen -
 				     sizeof(struct frag_hdr)) & ~7;
-	skb_shinfo(skb)->gso_type = SKB_GSO_UDP;
+	skb_shinfo(skb)->gso_type = SKB_GSO_UDP6;
 	ipv6_select_ident(&fhdr, rt);
 	skb_shinfo(skb)->ip6_frag_id = fhdr.identification;
 
@@ -1296,7 +1296,7 @@ emsgsize:
 	if (((length > mtu) ||
 	     (skb && skb_is_gso(skb))) &&
 	    (sk->sk_protocol == IPPROTO_UDP) &&
-	    (rt->dst.dev->features & NETIF_F_UFO)) {
+	    (rt->dst.dev->features & NETIF_F_UFO6)) {
 		err = ip6_ufo_append_data(sk, getfrag, from, length,
 					  hh_len, fragheaderlen,
 					  transhdrlen, mtu, flags, rt);
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 6b8f543..00d723e 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -39,6 +39,7 @@ static struct sk_buff *udp6_ufo_fragment(struct sk_buff *skb,
 		int type = skb_shinfo(skb)->gso_type;
 
 		if (unlikely(type & ~(SKB_GSO_UDP |
+				      SKB_GSO_UDP6 |
 				      SKB_GSO_DODGY |
 				      SKB_GSO_UDP_TUNNEL |
 				      SKB_GSO_UDP_TUNNEL_CSUM |
@@ -47,7 +48,7 @@ static struct sk_buff *udp6_ufo_fragment(struct sk_buff *skb,
 				      SKB_GSO_IPIP |
 				      SKB_GSO_SIT |
 				      SKB_GSO_MPLS) ||
-			     !(type & (SKB_GSO_UDP))))
+			     !(type & (SKB_GSO_UDP | SKB_GSO_UDP6))))
 			goto out;
 
 		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(skb->len, mss);
diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
index e3545f2..27343f0 100644
--- a/net/mpls/mpls_gso.c
+++ b/net/mpls/mpls_gso.c
@@ -30,6 +30,7 @@ static struct sk_buff *mpls_gso_segment(struct sk_buff *skb,
 				~(SKB_GSO_TCPV4 |
 				  SKB_GSO_TCPV6 |
 				  SKB_GSO_UDP |
+				  SKB_GSO_UDP6 |
 				  SKB_GSO_DODGY |
 				  SKB_GSO_TCP_ECN |
 				  SKB_GSO_GRE |
-- 
1.9.3
