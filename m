From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 1/2] virtio-net: correctly update XDP_TX counters
Date: Tue, 31 Jul 2018 14:22:26 +0300
Message-ID: <20180731142219-mutt-send-email-mst@kernel.org>
References: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 31, 2018 at 05:43:38PM +0800, Jason Wang wrote:
> Commit 5b8f3c8d30a6 ("virtio_net: Add XDP related stats") tries to
> count TX XDP stats in virtnet_receive(). This will cause several
> issues:
> 
> - virtnet_xdp_sq() was called without checking whether or not XDP is
>   set. This may cause out of bound access when there's no enough txq
>   for XDP.
> - Stats were updated even if there's no XDP/XDP_TX.
> 
> Fixing this by reusing virtnet_xdp_xmit() for XDP_TX which can counts
> TX XDP counter itself and remove the unnecessary tx stats embedded in
> rx stats.
> 
> Reported-by: syzbot+604f8271211546f5b3c7@syzkaller.appspotmail.com
> Fixes: 5b8f3c8d30a6 ("virtio_net: Add XDP related stats")
> Cc: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 39 ++++-----------------------------------
>  1 file changed, 4 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1880c86..72d3f68 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -105,10 +105,6 @@ struct virtnet_rq_stats {
>  
>  struct virtnet_rx_stats {
>  	struct virtnet_rq_stat_items rx;
> -	struct {
> -		unsigned int xdp_tx;
> -		unsigned int xdp_tx_drops;
> -	} tx;
>  };
>  
>  #define VIRTNET_SQ_STAT(m)	offsetof(struct virtnet_sq_stats, m)
> @@ -485,22 +481,6 @@ static struct send_queue *virtnet_xdp_sq(struct virtnet_info *vi)
>  	return &vi->sq[qp];
>  }
>  
> -static int __virtnet_xdp_tx_xmit(struct virtnet_info *vi,
> -				   struct xdp_frame *xdpf)
> -{
> -	struct xdp_frame *xdpf_sent;
> -	struct send_queue *sq;
> -	unsigned int len;
> -
> -	sq = virtnet_xdp_sq(vi);
> -
> -	/* Free up any pending old buffers before queueing new ones. */
> -	while ((xdpf_sent = virtqueue_get_buf(sq->vq, &len)) != NULL)
> -		xdp_return_frame(xdpf_sent);
> -
> -	return __virtnet_xdp_xmit_one(vi, sq, xdpf);
> -}
> -
>  static int virtnet_xdp_xmit(struct net_device *dev,
>  			    int n, struct xdp_frame **frames, u32 flags)
>  {
> @@ -707,10 +687,8 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  			xdpf = convert_to_xdp_frame(&xdp);
>  			if (unlikely(!xdpf))
>  				goto err_xdp;
> -			stats->tx.xdp_tx++;
> -			err = __virtnet_xdp_tx_xmit(vi, xdpf);
> -			if (unlikely(err)) {
> -				stats->tx.xdp_tx_drops++;
> +			err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
> +			if (unlikely(err < 0)) {
>  				trace_xdp_exception(vi->dev, xdp_prog, act);
>  				goto err_xdp;
>  			}
> @@ -879,10 +857,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  			xdpf = convert_to_xdp_frame(&xdp);
>  			if (unlikely(!xdpf))
>  				goto err_xdp;
> -			stats->tx.xdp_tx++;
> -			err = __virtnet_xdp_tx_xmit(vi, xdpf);
> -			if (unlikely(err)) {
> -				stats->tx.xdp_tx_drops++;
> +			err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
> +			if (unlikely(err < 0)) {
>  				trace_xdp_exception(vi->dev, xdp_prog, act);
>  				if (unlikely(xdp_page != page))
>  					put_page(xdp_page);
> @@ -1315,7 +1291,6 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  {
>  	struct virtnet_info *vi = rq->vq->vdev->priv;
>  	struct virtnet_rx_stats stats = {};
> -	struct send_queue *sq;
>  	unsigned int len;
>  	void *buf;
>  	int i;
> @@ -1351,12 +1326,6 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  	}
>  	u64_stats_update_end(&rq->stats.syncp);
>  
> -	sq = virtnet_xdp_sq(vi);
> -	u64_stats_update_begin(&sq->stats.syncp);
> -	sq->stats.xdp_tx += stats.tx.xdp_tx;
> -	sq->stats.xdp_tx_drops += stats.tx.xdp_tx_drops;
> -	u64_stats_update_end(&sq->stats.syncp);
> -
>  	return stats.rx.packets;
>  }
>  
> -- 
> 2.7.4
