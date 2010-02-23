From: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 1/3] vhost: logging math fix
Date: Tue, 23 Feb 2010 20:26:21 +0100
Message-ID: <m3bpffwy76.fsf@trasno.mitica>
References: <cover.1266943453.git.mst@redhat.com>
	<51e0f786b06c198ab355abab19f0bd11ac6a167b.1266943453.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <51e0f786b06c198ab355abab19f0bd11ac6a167b.1266943453.git.mst@redhat.com>
	(Michael S. Tsirkin's message of "Tue, 23 Feb 2010 18:57:43 +0200")
Sender: netdev-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kvm@vger.kernel.org, virtualization@lists.osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, markmc@redhat.com, gleb@redhat.com, herbert.xu@redhat.com, dlaor@redhat.com, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> wrote:
> vhost was dong some complex math to get
> offset to log at, and got it wrong by a couple of bytes,
> while in fact it's simple: get address where we write,
> subtract start of buffer, add log base.
>
> Do it this way.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

> ---
>  drivers/vhost/vhost.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 6eb1525..c767279 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1004,10 +1004,12 @@ int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int len)
>  	if (unlikely(vq->log_used)) {
>  		/* Make sure data is seen before log. */

We explain what smp_wmb() does.

>  		smp_wmb();
> -		log_write(vq->log_base, vq->log_addr + sizeof *vq->used->ring *
> -			  (vq->last_used_idx % vq->num),
> -			  sizeof *vq->used->ring);
> -		log_write(vq->log_base, vq->log_addr, sizeof *vq->used->ring);
> +		log_write(vq->log_base,
> +			  vq->log_addr + ((void *)used - (void *)vq->used),
> +			  sizeof *used);
> +		log_write(vq->log_base,
> +			  vq->log_addr + offsetof(struct vring_used, idx),
> +			  sizeof vq->used->idx);

Once here, can we add a comment explaining _what_ are we trying to write
to the log?  michael explains that t is the used element and the index,
but nothing states that.

>  		if (vq->log_ctx)
>  			eventfd_signal(vq->log_ctx, 1);
>  	}
