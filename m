From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio: Work around frames incorrectly marked as gso
Date: Mon, 24 Feb 2020 07:46:27 -0500
Message-ID: <20200224074516-mutt-send-email-mst@kernel.org>
References: <20200224101912.14074-1-anton.ivanov@cambridgegreys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200224101912.14074-1-anton.ivanov@cambridgegreys.com>
Sender: netdev-owner@vger.kernel.org
To: anton.ivanov@cambridgegreys.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-um@lists.infradead.org, jasowang@redhat.com, eric.dumazet@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 24, 2020 at 10:19:12AM +0000, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Some of the locally generated frames marked as GSO which
> arrive at virtio_net_hdr_from_skb() have no GSO_TYPE, no
> fragments (data_len = 0) and length significantly shorter
> than the MTU (752 in my experiments).
> 
> This is observed on raw sockets reading off vEth interfaces
> in all 4.x and 5.x kernels I tested.

A bit more info on how to reproduce couldn't hurt here.

> 
> These frames are reported as invalid while they are in fact
> gso-less frames.
> 
> This patch marks the vnet header as no-GSO for them instead
> of reporting it as invalid.
> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Eric - as you looked at this in the past, would you mind acking please?

> ---
>  include/linux/virtio_net.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 0d1fe9297ac6..94fb78c3a2ab 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -100,8 +100,8 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  {
>  	memset(hdr, 0, sizeof(*hdr));   /* no info leak */
>  
> -	if (skb_is_gso(skb)) {
> -		struct skb_shared_info *sinfo = skb_shinfo(skb);
> +	struct skb_shared_info *sinfo = skb_shinfo(skb);
> +	if (skb_is_gso(skb) && sinfo->gso_type) {
>  
>  		/* This is a hint as to how much should be linear. */
>  		hdr->hdr_len = __cpu_to_virtio16(little_endian,
> -- 
> 2.20.1
