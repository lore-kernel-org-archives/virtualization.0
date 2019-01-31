From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] virtio_net: Account for tx bytes and packets on
	sending xdp_frames
Date: Thu, 31 Jan 2019 10:25:17 -0500
Message-ID: <20190131101516-mutt-send-email-mst__6362.95819874562$1548967655$gmane$org@kernel.org>
References: <1548934830-2389-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1548934830-2389-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 31, 2019 at 08:40:30PM +0900, Toshiaki Makita wrote:
> Previously virtnet_xdp_xmit() did not account for device tx counters,
> which caused confusions.
> To be consistent with SKBs, account them on freeing xdp_frames.
> 
> Reported-by: David Ahern <dsahern@gmail.com>
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

Well we count them on receive so I guess it makes sense for consistency

Acked-by: Michael S. Tsirkin <mst@redhat.com>

however, I really wonder whether adding more and more standard net stack
things like this will end up costing most of XDP its speed.

Should we instead make sure *not* to account XDP packets
in any counters at all? XDP programs can use maps
to do their own counting...


> ---
>  drivers/net/virtio_net.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2594481..4cfceb7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -503,6 +503,8 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	struct bpf_prog *xdp_prog;
>  	struct send_queue *sq;
>  	unsigned int len;
> +	int packets = 0;
> +	int bytes = 0;
>  	int drops = 0;
>  	int kicks = 0;
>  	int ret, err;
> @@ -526,10 +528,18 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  
>  	/* Free up any pending old buffers before queueing new ones. */
>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> -		if (likely(is_xdp_frame(ptr)))
> -			xdp_return_frame(ptr_to_xdp(ptr));
> -		else
> -			napi_consume_skb(ptr, false);
> +		if (likely(is_xdp_frame(ptr))) {
> +			struct xdp_frame *frame = ptr_to_xdp(ptr);
> +
> +			bytes += frame->len;
> +			xdp_return_frame(frame);
> +		} else {
> +			struct sk_buff *skb = ptr;
> +
> +			bytes += skb->len;
> +			napi_consume_skb(skb, false);
> +		}
> +		packets++;
>  	}
>  
>  	for (i = 0; i < n; i++) {
> @@ -549,6 +559,8 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	}
>  out:
>  	u64_stats_update_begin(&sq->stats.syncp);
> +	sq->stats.bytes += bytes;
> +	sq->stats.packets += packets;
>  	sq->stats.xdp_tx += n;
>  	sq->stats.xdp_tx_drops += drops;
>  	sq->stats.kicks += kicks;
> -- 
> 1.8.3.1
> 
