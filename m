From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 4/5] virtio_net: don't rely on virtqueue_add_buf()
	returning capacity.
Date: Tue, 16 Oct 2012 15:47:37 +0200
Message-ID: <20121016134737.GA12972@redhat.com>
References: <1350394252-23934-1-git-send-email-rusty@rustcorp.com.au>
	<1350394252-23934-4-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1350394252-23934-4-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 17, 2012 at 12:00:51AM +1030, Rusty Russell wrote:
> Now we can easily use vq->num_free to determine if there are descriptors
> left in the queue, we're about to change virtqueue_add_buf() to return 0
> on success.  The virtio_net driver is the only one which actually uses
> the return value, so change that.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/net/virtio_net.c |   33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6c094c8..7c7f5a9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -471,10 +471,11 @@ static bool try_fill_recv(struct virtnet_info *vi, gfp_t gfp)
>  			err = add_recvbuf_small(vi, gfp);
>  
>  		oom = err == -ENOMEM;
> -		if (err < 0)
> +		if (err)
>  			break;
>  		++vi->num;
> -	} while (err > 0);
> +	} while (vi->rvq->num_free);
> +
>  	if (unlikely(vi->num > vi->max))
>  		vi->max = vi->num;
>  	virtqueue_kick(vi->rvq);

I like this, it always bothered me that RX intentionally
triggers a failure path in virtqueue_add_buf.

> @@ -625,27 +626,20 @@ static int xmit_skb(struct virtnet_info *vi, struct sk_buff *skb)
>  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> -	int capacity;
> +	int err;
>  
>  	/* Free up any pending old buffers before queueing new ones. */
>  	free_old_xmit_skbs(vi);
>  
>  	/* Try to transmit */
> -	capacity = xmit_skb(vi, skb);
> +	err = xmit_skb(vi, skb);
>  
> -	/* This can happen with OOM and indirect buffers. */
> -	if (unlikely(capacity < 0)) {
> -		if (likely(capacity == -ENOMEM)) {
> -			if (net_ratelimit())
> -				dev_warn(&dev->dev,
> -					 "TX queue failure: out of memory\n");
> -		} else {
> -			dev->stats.tx_fifo_errors++;
> -			if (net_ratelimit())
> -				dev_warn(&dev->dev,
> -					 "Unexpected TX queue failure: %d\n",
> -					 capacity);
> -		}
> +	/* This should not happen! */
> +	if (unlikely(err < 0)) {
> +		dev->stats.tx_fifo_errors++;
> +		if (net_ratelimit())
> +			dev_warn(&dev->dev,
> +				 "Unexpected TX queue failure: %d\n", err);
>  		dev->stats.tx_dropped++;
>  		kfree_skb(skb);
>  		return NETDEV_TX_OK;
> @@ -658,13 +652,12 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	/* Apparently nice girls don't return TX_BUSY; stop the queue
>  	 * before it gets out of hand.  Naturally, this wastes entries. */
> -	if (capacity < 2+MAX_SKB_FRAGS) {
> +	if (vi->svq->num_free < 2+MAX_SKB_FRAGS) {
>  		netif_stop_queue(dev);
>  		if (unlikely(!virtqueue_enable_cb_delayed(vi->svq))) {
>  			/* More just got used, free them then recheck. */
>  			free_old_xmit_skbs(vi);
> -			capacity = vi->svq->num_free;
> -			if (capacity >= 2+MAX_SKB_FRAGS) {
> +			if (vi->svq->num_free >= 2+MAX_SKB_FRAGS) {
>  				netif_start_queue(dev);
>  				virtqueue_disable_cb(vi->svq);
>  			}
> -- 
> 1.7.9.5
