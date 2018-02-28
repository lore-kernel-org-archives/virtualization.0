From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] virtio-net: disable NAPI only when enabled during
	XDP set
Date: Wed, 28 Feb 2018 17:27:44 +0200
Message-ID: <20180228172739-mutt-send-email-mst__15372.435496147$1519831584$gmane$org@kernel.org>
References: <1519813204-10002-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1519813204-10002-1-git-send-email-jasowang@redhat.com>
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

On Wed, Feb 28, 2018 at 06:20:04PM +0800, Jason Wang wrote:
> We try to disable NAPI to prevent a single XDP TX queue being used by
> multiple cpus. But we don't check if device is up (NAPI is enabled),
> this could result stall because of infinite wait in
> napi_disable(). Fixing this by checking device state through
> netif_running() before.
> 
> Fixes: 4941d472bf95b ("virtio-net: do not reset during XDP set")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9bb9e56..2d54123 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2185,8 +2185,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	}
>  
>  	/* Make sure NAPI is not using any XDP TX queues for RX. */
> -	for (i = 0; i < vi->max_queue_pairs; i++)
> -		napi_disable(&vi->rq[i].napi);
> +	if (netif_running(dev))
> +		for (i = 0; i < vi->max_queue_pairs; i++)
> +			napi_disable(&vi->rq[i].napi);
>  
>  	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
>  	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
> @@ -2205,7 +2206,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  		}
>  		if (old_prog)
>  			bpf_prog_put(old_prog);
> -		virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
> +		if (netif_running(dev))
> +			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
>  	}
>  
>  	return 0;
> -- 
> 2.7.4
