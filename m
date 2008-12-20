From: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [PATCH 2/3] virtio: indirect ring entries
	(VIRTIO_RING_F_INDIRECT_DESC)
Date: Sat, 20 Dec 2008 12:38:06 +0100
Message-ID: <200812201238.07510.ioe-lkml__11928.9518952884$1229961791$gmane$org@rameria.de>
References: <1229620222-22216-1-git-send-email-markmc@redhat.com>
	<1229620222-22216-2-git-send-email-markmc@redhat.com>
	<1229620222-22216-3-git-send-email-markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1229620222-22216-3-git-send-email-markmc@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: Avi Kivity <avi@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Mark,

On Thursday 18 December 2008, Mark McLoughlin wrote:
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 5777196..2330c4b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -70,6 +73,55 @@ struct vring_virtqueue
>  
>  #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
>  
> +/* Set up an indirect table of descriptors and add it to the queue. */
> +static int vring_add_indirect(struct vring_virtqueue *vq,
> +			      struct scatterlist sg[],
> +			      unsigned int out,
> +			      unsigned int in)
> +{
> +	struct vring_desc *desc;
> +	unsigned head;
> +	int i;
> +
> +	desc = kmalloc((out + in) * sizeof(struct vring_desc), GFP_ATOMIC);

kmalloc() returns ZERO_SIZE_PTR, if (out + in) == 0

> +	if (!desc)
> +		return vq->vring.num;
> +
> +	/* Transfer entries from the sg list into the indirect page */
> +	for (i = 0; i < out; i++) {
> +		desc[i].flags = VRING_DESC_F_NEXT;
> +		desc[i].addr = sg_phys(sg);
> +		desc[i].len = sg->length;
> +		desc[i].next = i+1;
> +		sg++;
> +	}
> +	for (; i < (out + in); i++) {
> +		desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
> +		desc[i].addr = sg_phys(sg);
> +		desc[i].len = sg->length;
> +		desc[i].next = i+1;
> +		sg++;
> +	}
> +
> +	/* Last one doesn't continue. */
> +	desc[i-1].flags &= ~VRING_DESC_F_NEXT;
> +	desc[i-1].next = 0;

So this array index can fail (be -1).
Please check and avoid within this function.


Best Regards

Ingo Oeser
