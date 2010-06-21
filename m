From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH for-2.6.35] virtio_net: fix oom handling on tx
Date: Mon, 21 Jun 2010 19:53:43 +0930
Message-ID: <201006211953.44724.rusty__27720.0283170261$1277115880$gmane$org@rustcorp.com.au>
References: <20100610152041.GA3480@redhat.com>
	<201006211213.49600.rusty@rustcorp.com.au>
	<20100621083315.GA8665@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100621083315.GA8665@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Shirley Ma <xma@us.ibm.com>, Jiri Pirko <jpirko@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stephen Hemminger <shemminger@vyatta.com>, Sridhar Samudrala <sri@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 21 Jun 2010 06:03:16 pm Michael S. Tsirkin wrote:
> On Mon, Jun 21, 2010 at 12:13:49PM +0930, Rusty Russell wrote:
> > -		return NETDEV_TX_BUSY;
> > +		kfree_skb(skb);
> > +		return NETDEV_TX_OK;
> 
> If we do so, let's increment the dropped counter and/or error counter?

Yep, here's the extra change:

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -571,14 +571,16 @@ static netdev_tx_t start_xmit(struct sk_
 	/* This can happen with OOM and indirect buffers. */
 	if (unlikely(capacity < 0)) {
 		if (net_ratelimit()) {
-			if (likely(capacity == -ENOMEM))
+			if (likely(capacity == -ENOMEM)) {
 				dev_warn(&dev->dev,
 					 "TX queue failure: out of memory\n");
-			else
+			} else {
+				dev->stats.tx_fifo_errors++;
 				dev_warn(&dev->dev,
 					 "Unexpected TX queue failure: %d\n",
 					 capacity);
 		}
+		dev->stats.tx_dropped++;
 		kfree_skb(skb);
 		return NETDEV_TX_OK;
 	}
