From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_net: Add schedule check to napi_enable call
Date: Thu, 10 Feb 2011 19:57:26 +0200
Message-ID: <20110210175725.GA9674__17799.5702637874$1297360725$gmane$org@redhat.com>
References: <201102101232.50526.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201102101232.50526.rusty@rustcorp.com.au>
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
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 10, 2011 at 12:32:50PM +1030, Rusty Russell wrote:
> From: "Bruce Rogers" <brogers@novell.com>
> 
> Under harsh testing conditions, including low memory, the guest would
> stop receiving packets. With this patch applied we no longer see any
> problems in the driver while performing these tests for extended periods
> of time.
> 
> Make sure napi is scheduled subsequent to each napi_enable.
> 
> Signed-off-by: Bruce Rogers <brogers@novell.com>
> Signed-off-by: Olaf Kirch <okir@suse.de>
> Cc: stable@kernel.org
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Rusty, so this is 2.6.38 material - you'll send this to Linus? Or DaveM?

> ---
>  drivers/net/virtio_net.c |   27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -446,6 +446,20 @@ static void skb_recv_done(struct virtque
>  	}
>  }
>  
> +static void virtnet_napi_enable(struct virtnet_info *vi)
> +{
> +	napi_enable(&vi->napi);
> +
> +	/* If all buffers were filled by other side before we napi_enabled, we
> +	 * won't get another interrupt, so process any outstanding packets
> +	 * now.  virtnet_poll wants re-enable the queue, so we disable here.
> +	 * We synchronize against interrupts via NAPI_STATE_SCHED */
> +	if (napi_schedule_prep(&vi->napi)) {
> +		virtqueue_disable_cb(vi->rvq);
> +		__napi_schedule(&vi->napi);
> +	}
> +}
> +
>  static void refill_work(struct work_struct *work)
>  {
>  	struct virtnet_info *vi;
> @@ -454,7 +468,7 @@ static void refill_work(struct work_stru
>  	vi = container_of(work, struct virtnet_info, refill.work);
>  	napi_disable(&vi->napi);
>  	still_empty = !try_fill_recv(vi, GFP_KERNEL);
> -	napi_enable(&vi->napi);
> +	virtnet_napi_enable(vi);
>  
>  	/* In theory, this can happen: if we don't get any buffers in
>  	 * we will *never* try to fill again. */
> @@ -638,16 +652,7 @@ static int virtnet_open(struct net_devic
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
>  
> -	napi_enable(&vi->napi);
> -
> -	/* If all buffers were filled by other side before we napi_enabled, we
> -	 * won't get another interrupt, so process any outstanding packets
> -	 * now.  virtnet_poll wants re-enable the queue, so we disable here.
> -	 * We synchronize against interrupts via NAPI_STATE_SCHED */
> -	if (napi_schedule_prep(&vi->napi)) {
> -		virtqueue_disable_cb(vi->rvq);
> -		__napi_schedule(&vi->napi);
> -	}
> +	virtnet_napi_enable(vi);
>  	return 0;
>  }
>  
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
