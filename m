From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 09/18] virtio: use avail_event index
Date: Mon, 09 May 2011 14:03:26 +0930
Message-ID: <874o54h4rt.fsf__47993.6987082057$1304920521$gmane$org@rustcorp.com.au>
References: <cover.1304541918.git.mst@redhat.com>
	<8bba6a0a8eee17e741c5155b04ff1b1c9f34bf94.1304541919.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8bba6a0a8eee17e741c5155b04ff1b1c9f34bf94.1304541919.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 4 May 2011 23:51:47 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> Use the new avail_event feature to reduce the number
> of exits from the guest.

Figures here would be nice :)

> @@ -228,6 +237,12 @@ add_head:
>  	 * new available array entries. */
>  	virtio_wmb();
>  	vq->vring.avail->idx++;
> +	/* If the driver never bothers to kick in a very long while,
> +	 * avail index might wrap around. If that happens, invalidate
> +	 * kicked_avail index we stored. TODO: make sure all drivers
> +	 * kick at least once in 2^16 and remove this. */
> +	if (unlikely(vq->vring.avail->idx == vq->kicked_avail))
> +		vq->kicked_avail_valid = true;

If they don't, they're already buggy.  Simply do:
        WARN_ON(vq->vring.avail->idx == vq->kicked_avail);

> +static bool vring_notify(struct vring_virtqueue *vq)
> +{
> +	u16 old, new;
> +	bool v;
> +	if (!vq->event)
> +		return !(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY);
> +
> +	v = vq->kicked_avail_valid;
> +	old = vq->kicked_avail;
> +	new = vq->kicked_avail = vq->vring.avail->idx;
> +	vq->kicked_avail_valid = true;
> +	if (unlikely(!v))
> +		return true;

This is the only place you actually used kicked_avail_valid.  Is it
possible to initialize it in such a way that you can remove this?

> @@ -482,6 +517,8 @@ void vring_transport_features(struct virtio_device *vdev)
>  			break;
>  		case VIRTIO_RING_F_USED_EVENT_IDX:
>  			break;
> +		case VIRTIO_RING_F_AVAIL_EVENT_IDX:
> +			break;
>  		default:
>  			/* We don't understand this bit. */
>  			clear_bit(i, vdev->features);

Does this belong in a prior patch?

Thanks,
Rusty.
