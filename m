From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [PATCH net-next 2/2] virtio-net: get rid of unnecessary container
	of rq stats
Date: Tue, 31 Jul 2018 19:02:19 +0900
Message-ID: <da012c13-e438-f45e-5c41-2f159e791f00@lab.ntt.co.jp>
References: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
	<1533030219-9904-2-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1533030219-9904-2-git-send-email-jasowang@redhat.com>
Content-Language: en-US
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 2018/07/31 18:43, Jason Wang wrote:
> We don't maintain tx counters in rx stats any more. There's no need
> for an extra container of rq stats.
> 
> Cc: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 80 ++++++++++++++++++++++--------------------------
>  1 file changed, 36 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d3f68..14f661c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -87,7 +87,8 @@ struct virtnet_sq_stats {
>  	u64 kicks;
>  };
>  
> -struct virtnet_rq_stat_items {
> +struct virtnet_rq_stats {
> +	struct u64_stats_sync syncp;
>  	u64 packets;
>  	u64 bytes;
>  	u64 drops;
> @@ -98,17 +99,8 @@ struct virtnet_rq_stat_items {
>  	u64 kicks;
>  };
>  
> -struct virtnet_rq_stats {
> -	struct u64_stats_sync syncp;
> -	struct virtnet_rq_stat_items items;
> -};

I'm not thinking removing sq stat is needed but even if it is I want to
keep virtnet_rq_stats to avoid allocating unnecessary u64_stats_syncp on
stack in virtnet_receive. I would just remove virtnet_rx_stats if necessary.

> -
> -struct virtnet_rx_stats {
> -	struct virtnet_rq_stat_items rx;
> -};
> -

-- 
Toshiaki Makita
