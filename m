From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH] virtio: don't always force a notification when ring is
	full
Date: Wed, 18 Jun 2008 19:40:26 -0500
Message-ID: <4859AAFA.9000808@us.ibm.com>
References: <200806190940.57083.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200806190940.57083.rusty@rustcorp.com.au>
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> We force notification when the ring is full, even if the host has
> indicated it doesn't want to know.  This seemed like a good idea at
> the time: if we fill the transmit ring, we should tell the host
> immediately.
>
> Unfortunately this logic also applies to the receiving ring, which is
> refilled constantly.  We should introduce real notification thesholds
> to replace this logic.  Meanwhile, removing the logic altogether breaks
> the heuristics which KVM uses, so we use a hack: only notify if there are
> outgoing parts of the new buffer.
>
> It even makes a difference with lguest's crappy network implementation:
> 	1GB guest->host before: 30.0844
> 	1GB guest->host after: 27.6167
>   

A little ugly, but no more performance regression in KVM, so

Acked-by: Anthony Liguori <aliguori@us.ibm.com>

Regards,

Anthony Liguori

> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>
> diff -r 89bf4894cc36 drivers/virtio/virtio_ring.c
> --- a/drivers/virtio/virtio_ring.c	Mon Jun 16 14:31:30 2008 +1000
> +++ b/drivers/virtio/virtio_ring.c	Wed Jun 18 16:15:49 2008 +1000
> @@ -87,8 +87,11 @@ static int vring_add_buf(struct virtqueu
>  	if (vq->num_free < out + in) {
>  		pr_debug("Can't add buf len %i - avail = %i\n",
>  			 out + in, vq->num_free);
> -		/* We notify *even if* VRING_USED_F_NO_NOTIFY is set here. */
> -		vq->notify(&vq->vq);
> +		/* FIXME: for historical reasons, we force a notify here if
> +		 * there are outgoing parts to the buffer.  Presumably the
> +		 * host should service the ring ASAP. */
> +		if (out)
> +			vq->notify(&vq->vq);
>  		END_USE(vq);
>  		return -ENOSPC;
>  	}
>   
