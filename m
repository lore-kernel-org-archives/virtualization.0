From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2 10/14] virtio_net: limit xmit polling
Date: Sat, 21 May 2011 11:49:59 +0930
Message-ID: <877h9kvlps.fsf__17996.8818826184$1305945762$gmane$org@rustcorp.com.au>
References: <cover.1305846412.git.mst@redhat.com>
	<aced8619c07018b5495f9ceb2c02d4fbf897a098.1305846412.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <aced8619c07018b5495f9ceb2c02d4fbf897a098.1305846412.git.mst@redhat.com>
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
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 20 May 2011 02:11:56 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> Current code might introduce a lot of latency variation
> if there are many pending bufs at the time we
> attempt to transmit a new one. This is bad for
> real-time applications and can't be good for TCP either.

Do we have more than speculation to back that up, BTW?

This patch is pretty sloppy; the previous ones were better polished.

> -static void free_old_xmit_skbs(struct virtnet_info *vi)
> +static bool free_old_xmit_skbs(struct virtnet_info *vi, int capacity)
>  {

A comment here indicating it returns true if it frees something?

>  	struct sk_buff *skb;
>  	unsigned int len;
> -
> -	while ((skb = virtqueue_get_buf(vi->svq, &len)) != NULL) {
> +	bool c;
> +	int n;
> +
> +	/* We try to free up at least 2 skbs per one sent, so that we'll get
> +	 * all of the memory back if they are used fast enough. */
> +	for (n = 0;
> +	     ((c = virtqueue_get_capacity(vi->svq) < capacity) || n < 2) &&
> +	     ((skb = virtqueue_get_buf(vi->svq, &len)));
> +	     ++n) {
>  		pr_debug("Sent skb %p\n", skb);
>  		vi->dev->stats.tx_bytes += skb->len;
>  		vi->dev->stats.tx_packets++;
>  		dev_kfree_skb_any(skb);
>  	}
> +	return !c;

This is for() abuse :)

Why is the capacity check in there at all?  Surely it's simpler to try
to free 2 skbs each time around?

   for (n = 0; n < 2; n++) {
        skb = virtqueue_get_buf(vi->svq, &len);
        if (!skb)
                break;
	pr_debug("Sent skb %p\n", skb);
	vi->dev->stats.tx_bytes += skb->len;
	vi->dev->stats.tx_packets++;
	dev_kfree_skb_any(skb);
   }

>  static int xmit_skb(struct virtnet_info *vi, struct sk_buff *skb)
> @@ -574,8 +582,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int capacity;
>  
> -	/* Free up any pending old buffers before queueing new ones. */
> -	free_old_xmit_skbs(vi);
> +	/* Free enough pending old buffers to enable queueing new ones. */
> +	free_old_xmit_skbs(vi, 2+MAX_SKB_FRAGS);
>  
>  	/* Try to transmit */
>  	capacity = xmit_skb(vi, skb);
> @@ -609,9 +617,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		netif_stop_queue(dev);
>  		if (unlikely(!virtqueue_enable_cb_delayed(vi->svq))) {
>  			/* More just got used, free them then recheck. */
> -			free_old_xmit_skbs(vi);
> -			capacity = virtqueue_get_capacity(vi->svq);
> -			if (capacity >= 2+MAX_SKB_FRAGS) {
> +			if (!likely(free_old_xmit_skbs(vi, 2+MAX_SKB_FRAGS))) {

This extra argument to free_old_xmit_skbs seems odd, unless you have
future plans?

Thanks,
Rusty.
