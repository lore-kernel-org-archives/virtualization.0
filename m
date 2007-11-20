From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] virtio: fix net driver loop case where we fail to
	restart
Date: Tue, 20 Nov 2007 16:20:55 +0900
Message-ID: <20071120072053.GF10490__17172.0506776639$1195581618$gmane$org@verge.net.au>
References: <200711191120.15596.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200711191120.15596.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 19, 2007 at 11:20:15AM +1100, Rusty Russell wrote:
> skb is only NULL the first time around: it's more correct to test for
> being under-budget.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

That looks better to me.

Acked-by: Simon Horman <horms@verge.net.au>

> diff -r 2a94425ac7d5 drivers/net/virtio_net.c
> --- a/drivers/net/virtio_net.c	Thu Nov 15 13:47:28 2007 +1100
> +++ b/drivers/net/virtio_net.c	Thu Nov 15 23:10:44 2007 +1100
> @@ -198,8 +198,8 @@ again:
>  	if (vi->num < vi->max / 2)
>  		try_fill_recv(vi);
>  
> -	/* All done? */
> -	if (!skb) {
> +	/* Out of packets? */
> +	if (received < budget) {
>  		netif_rx_complete(vi->dev, napi);
>  		if (unlikely(!vi->rvq->vq_ops->restart(vi->rvq))
>  		    && netif_rx_reschedule(vi->dev, napi))
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Horms
