From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/5] virtio: fix virtio_net xmit of freed skb bug
Date: Mon, 14 Jul 2008 22:40:00 -0500
Message-ID: <20080715034003.467E7DDEF3__31090.4481368654$1216162210$gmane$org@ozlabs.org>
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
To: Jeff Garzik <jeff@garzik.org>
List-Id: virtualization@lists.linuxfoundation.org

[PATCH] virtio_net: Delay dropping tx skbs
Cc: Mark McLoughlin <markmc@redhat.com>,
 virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200807151340.00446.rusty@rustcorp.com.au>

From: Mark McLoughlin <markmc@redhat.com>

On Mon, 2008-05-26 at 17:42 +1000, Rusty Russell wrote:
> If we fail to transmit a packet, we assume the queue is full and put
> the skb into last_xmit_skb.  However, if more space frees up before we
> xmit it, we loop, and the result can be transmitting the same skb twice.
> 
> Fix is simple: set skb to NULL if we've used it in some way, and check
> before sending.
...
> diff -r 564237b31993 drivers/net/virtio_net.c
> --- a/drivers/net/virtio_net.c	Mon May 19 12:22:00 2008 +1000
> +++ b/drivers/net/virtio_net.c	Mon May 19 12:24:58 2008 +1000
> @@ -287,21 +287,25 @@ again:
>  	free_old_xmit_skbs(vi);
>  
>  	/* If we has a buffer left over from last time, send it now. */
> -	if (vi->last_xmit_skb) {
> +	if (unlikely(vi->last_xmit_skb)) {
>  		if (xmit_skb(vi, vi->last_xmit_skb) != 0) {
>  			/* Drop this skb: we only queue one. */
>  			vi->dev->stats.tx_dropped++;
>  			kfree_skb(skb);
> +			skb = NULL;
>  			goto stop_queue;
>  		}
>  		vi->last_xmit_skb = NULL;

With this, may drop an skb and then later in the function discover that
we could have sent it after all. Poor wee skb :)

How about the incremental patch below?

Cheers,
Mark.


Currently we drop the skb in start_xmit() if we have a
queued buffer and fail to transmit it.

However, if we delay dropping it until we've stopped the
queue and enabled the tx notification callback, then there
is a chance space might become available for it.

Signed-off-by: Mark McLoughlin <markmc@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/virtio_net.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d50f4fe..30af05c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -287,16 +287,11 @@ again:
 	free_old_xmit_skbs(vi);
 
 	/* If we has a buffer left over from last time, send it now. */
-	if (unlikely(vi->last_xmit_skb)) {
-		if (xmit_skb(vi, vi->last_xmit_skb) != 0) {
-			/* Drop this skb: we only queue one. */
-			vi->dev->stats.tx_dropped++;
-			kfree_skb(skb);
-			skb = NULL;
-			goto stop_queue;
-		}
-		vi->last_xmit_skb = NULL;
-	}
+	if (unlikely(vi->last_xmit_skb) &&
+	    xmit_skb(vi, vi->last_xmit_skb) != 0)
+		goto stop_queue;
+
+	vi->last_xmit_skb = NULL;
 
 	/* Put new one in send queue and do transmit */
 	if (likely(skb)) {
@@ -322,6 +317,11 @@ stop_queue:
 		netif_start_queue(dev);
 		goto again;
 	}
+	if (skb) {
+		/* Drop this skb: we only queue one. */
+		vi->dev->stats.tx_dropped++;
+		kfree_skb(skb);
+	}
 	goto done;
 }
