From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 2/2] virtio-net: fix the XDP truesize
 calculation for mergeable buffers
Date: Wed, 6 May 2020 03:37:42 -0400
Message-ID: <20200506033259-mutt-send-email-mst@kernel.org>
References: <20200506061633.16327-1-jasowang@redhat.com>
 <20200506061633.16327-2-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200506061633.16327-2-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 06, 2020 at 02:16:33PM +0800, Jason Wang wrote:
> We should not exclude headroom and tailroom when XDP is set. So this
> patch fixes this by initializing the truesize from PAGE_SIZE when XDP
> is set.
> 
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Seems too aggressive, we do not use up the whole page for the size.



> ---
>  drivers/net/virtio_net.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 98dd75b665a5..3f3aa8308918 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1184,7 +1184,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	char *buf;
>  	void *ctx;
>  	int err;
> -	unsigned int len, hole;
> +	unsigned int len, hole, truesize;
>  
>  	/* Extra tailroom is needed to satisfy XDP's assumption. This
>  	 * means rx frags coalescing won't work, but consider we've
> @@ -1194,6 +1194,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>  		return -ENOMEM;
>  
> +	truesize = headroom ? PAGE_SIZE : len;
>  	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
>  	buf += headroom; /* advance address leaving hole at front of pkt */
>  	get_page(alloc_frag->page);

Is this really just on the XDP path? Looks like a confusing way to
detect that.


> @@ -1205,11 +1206,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  		 * the current buffer.
>  		 */
>  		len += hole;
> +		truesize += hole;
>  		alloc_frag->offset += hole;
>  	}
>  
>  	sg_init_one(rq->sg, buf, len);
> -	ctx = mergeable_len_to_ctx(len, headroom);
> +	ctx = mergeable_len_to_ctx(truesize, headroom);
>  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>  	if (err < 0)
>  		put_page(virt_to_head_page(buf));
> -- 
> 2.20.1
