From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/4] virtio_net: return NETDEV_TX_BUSY instead of queueing
	an extra skb.
Date: Wed, 3 Jun 2009 12:47:04 +0930
Message-ID: <200906031247.05591.rusty__11267.2333642424$1243999079$gmane$org@rustcorp.com.au>
References: <200905292346.04815.rusty@rustcorp.com.au>
	<200906022325.57961.rusty@rustcorp.com.au>
	<20090602234532.GA5417@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090602234532.GA5417@gondor.apana.org.au>
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
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 3 Jun 2009 09:15:32 am Herbert Xu wrote:
> On Tue, Jun 02, 2009 at 11:25:57PM +0930, Rusty Russell wrote:
> > Or, we could just "return NETDEV_TX_BUSY;".  I like that :)
>
> No you should fix it so that you check the queue status after
> transmitting a packet so we never get into this state in the
> first place.

We could figure out if we can take the worst-case packet, and underutilize
our queue.  And fix the other *67* drivers.

Of course that doesn't even work, because we return NETDEV_TX_BUSY from dev.c!

"Hi, core netdevs here.  Don't use NETDEV_TX_BUSY.   Yeah, we can't figure out
how to avoid it either.  But y'know, just hack something together".

Herbert, we are *better* than this!

How's this?  Tested for the virtio_net driver here.


[RFC] net: fix double-tcpdump problem with NETDEV_TX_BUSY.

Herbert shares a distain for drivers returning TX_BUSY because
network taps see packets twice when it's used.  Unfortunately, it's
ubiquitous.

This patch marks packets by (ab)using the "peeked" bit in the skb.
This bit is currently used for packets queued in a socket; we reset it
in dev_queue_xmit and set it when we hand the packet to
dev_queue_xmit_nit.

We also reset it on incoming packets: this is safe, but it might be
sufficient to reset it only in the loopback driver?

diff --git a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1678,8 +1678,10 @@ int dev_hard_start_xmit(struct sk_buff *
 	int rc;
 
 	if (likely(!skb->next)) {
-		if (!list_empty(&ptype_all))
+		if (!list_empty(&ptype_all) && !skb->peeked) {
 			dev_queue_xmit_nit(skb, dev);
+			skb->peeked = true;
+		}
 
 		if (netif_needs_gso(dev, skb)) {
 			if (unlikely(dev_gso_segment(skb)))
@@ -1796,6 +1798,8 @@ int dev_queue_xmit(struct sk_buff *skb)
 	struct Qdisc *q;
 	int rc = -ENOMEM;
 
+	skb->peeked = false;
+
 	/* GSO will handle the following emulations directly. */
 	if (netif_needs_gso(dev, skb))
 		goto gso;
@@ -1942,6 +1946,8 @@ int netif_rx(struct sk_buff *skb)
 	if (!skb->tstamp.tv64)
 		net_timestamp(skb);
 
+	skb->peeked = false;
+
 	/*
 	 * The code is rearranged so that the path is the most
 	 * short when CPU is congested, but is still operating.
