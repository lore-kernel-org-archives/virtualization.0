Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E8DC28B2B
	for <virtualization@archiver.kernel.org>; Thu, 18 Aug 2022 03:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D34BE41952;
	Thu, 18 Aug 2022 03:15:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D34BE41952
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NliTINWuQEqA; Thu, 18 Aug 2022 03:15:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2CD844191F;
	Thu, 18 Aug 2022 03:15:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CD844191F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCFC6C0033;
	Thu, 18 Aug 2022 03:15:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E271DC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 03:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE3EE83EF7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 03:15:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE3EE83EF7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ff0gh_brNOs
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 03:15:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A27B833CD
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A27B833CD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 03:15:51 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0VMYvRrq_1660792547; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VMYvRrq_1660792547) by smtp.aliyun-inc.com;
 Thu, 18 Aug 2022 11:15:47 +0800
Message-ID: <1660792318.4436166-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC v2 6/7] virtio: in order support for virtio_ring
Date: Thu, 18 Aug 2022 11:11:58 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>
References: <20220817135718.2553-1-qtxuning1999@sjtu.edu.cn>
 <20220817135718.2553-7-qtxuning1999@sjtu.edu.cn>
In-Reply-To: <20220817135718.2553-7-qtxuning1999@sjtu.edu.cn>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Guo Zhi <qtxuning1999@sjtu.edu.cn>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, 17 Aug 2022 21:57:17 +0800, Guo Zhi <qtxuning1999@sjtu.edu.cn> wrote:
> If in order feature negotiated, we can skip the used ring to get
> buffer's desc id sequentially.
>
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  drivers/virtio/virtio_ring.c | 53 ++++++++++++++++++++++++++++++------
>  1 file changed, 45 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 1c1b3fa376a2..143184ebb5a1 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -144,6 +144,9 @@ struct vring_virtqueue {
>  			/* DMA address and size information */
>  			dma_addr_t queue_dma_addr;
>  			size_t queue_size_in_bytes;
> +
> +			/* In order feature batch begin here */
> +			u16 next_desc_begin;
>  		} split;
>
>  		/* Available for packed ring */
> @@ -702,8 +705,13 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	}
>
>  	vring_unmap_one_split(vq, i);
> -	vq->split.desc_extra[i].next = vq->free_head;
> -	vq->free_head = head;
> +	/* In order feature use desc in order,
> +	 * that means, the next desc will always be free
> +	 */
> +	if (!virtio_has_feature(vq->vq.vdev, VIRTIO_F_IN_ORDER)) {

Call virtio_has_feature() here is not good.

Thanks.

> +		vq->split.desc_extra[i].next = vq->free_head;
> +		vq->free_head = head;
> +	}
>
>  	/* Plus final descriptor */
>  	vq->vq.num_free++;
> @@ -745,7 +753,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	void *ret;
> -	unsigned int i;
> +	unsigned int i, j;
>  	u16 last_used;
>
>  	START_USE(vq);
> @@ -764,11 +772,38 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	/* Only get used array entries after they have been exposed by host. */
>  	virtio_rmb(vq->weak_barriers);
>
> -	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
> -	i = virtio32_to_cpu(_vq->vdev,
> -			vq->split.vring.used->ring[last_used].id);
> -	*len = virtio32_to_cpu(_vq->vdev,
> -			vq->split.vring.used->ring[last_used].len);
> +	if (virtio_has_feature(_vq->vdev, VIRTIO_F_IN_ORDER)) {
> +		/* Skip used ring and get used desc in order*/
> +		i = vq->split.next_desc_begin;
> +		j = i;
> +		/* Indirect only takes one descriptor in descriptor table */
> +		while (!vq->indirect && (vq->split.desc_extra[j].flags & VRING_DESC_F_NEXT))
> +			j = (j + 1) % vq->split.vring.num;
> +		/* move to next */
> +		j = (j + 1) % vq->split.vring.num;
> +		/* Next buffer will use this descriptor in order */
> +		vq->split.next_desc_begin = j;
> +		if (!vq->indirect) {
> +			*len = vq->split.desc_extra[i].len;
> +		} else {
> +			struct vring_desc *indir_desc =
> +				vq->split.desc_state[i].indir_desc;
> +			u32 indir_num = vq->split.desc_extra[i].len, buffer_len = 0;
> +
> +			if (indir_desc) {
> +				for (j = 0; j < indir_num / sizeof(struct vring_desc); j++)
> +					buffer_len += indir_desc[j].len;
> +			}
> +
> +			*len = buffer_len;
> +		}
> +	} else {
> +		last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
> +		i = virtio32_to_cpu(_vq->vdev,
> +				    vq->split.vring.used->ring[last_used].id);
> +		*len = virtio32_to_cpu(_vq->vdev,
> +				       vq->split.vring.used->ring[last_used].len);
> +	}
>
>  	if (unlikely(i >= vq->split.vring.num)) {
>  		BAD_RING(vq, "id %u out of range\n", i);
> @@ -2236,6 +2271,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->split.avail_flags_shadow = 0;
>  	vq->split.avail_idx_shadow = 0;
>
> +	vq->split.next_desc_begin = 0;
> +
>  	/* No callback?  Tell other side not to bother us. */
>  	if (!callback) {
>  		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> --
> 2.17.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
