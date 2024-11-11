Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AE22595
	for <virtualization@lists.linux.dev>; Mon, 11 Nov 2024 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731293995; cv=none; b=AjXsdy61paD0eC7MxhJ9OQ0vsiQZHnPWuv192Lm7S8JRia3KLC9HEmKReSMUimT6eSAKmAa3zRFpUB1usqYMlqD5qoyTunFFDHTGLqrtk8qQpCwWNQtFMXQg6WisJmuwnvS3KVRfl5yCymc1N5LIPTZeN4YQDZO8K7QErfOQ5L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731293995; c=relaxed/simple;
	bh=sCuJ92VB7/8VGm6pZdX1x4/K7oyFT31xytavwtn7Hno=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=QJKSdpMIbz0cPwUAxQ547ZcpNL8jtrLfUCURDZI/lMAVFMpPqUeCycgZ5J0VHv1q05kd5JRVJ+Xd2tQXzW4ivLWTb3l1nvhHZx1BueXP7t5NizBs5WAR03QhhqIw/RtFgguYfdGli9Czapz8o9Dt0WL2rchmcv8L7NJdKp1RzEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NlNN2KjW; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NlNN2KjW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731293989; h=Message-ID:Subject:Date:From:To;
	bh=D0HiFPS7RCuNDYOuBzuf/2eUC+oaWpRyl5+UecPwCB8=;
	b=NlNN2KjWj9BbWa4SYtHskz39qXdajKls+tMqRuUCK2cSb4N97ZCRyNkuJzjAo7MEmClxi5Ohb1vsJCpFSWkhx4rxqzCMezHN1DxxWr1hVjfXpV/E/Bouxrq/e98VQkKG764KFs7X/VZLL7olxyvRF2+MIzSy7ThAN4BDm5t6SX4=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WJ4C9Kh_1731293987 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 10:59:48 +0800
Message-ID: <1731293980.2695758-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_ring: skip cpu sync when mapping fails
Date: Mon, 11 Nov 2024 10:59:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241111025538.2837-1-jasowang@redhat.com>
In-Reply-To: <20241111025538.2837-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 11 Nov 2024 10:55:38 +0800, Jason Wang <jasowang@redhat.com> wrote:
> There's no need to sync DMA for CPU on mapping errors. So this patch
> skips the CPU sync in the error handling path of DMA mapping.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


> ---
>  drivers/virtio/virtio_ring.c | 98 +++++++++++++++++++++---------------
>  1 file changed, 57 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index be7309b1e860..b422b5fb22db 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -441,8 +441,10 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
>   */
>
>  static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
> -					   const struct vring_desc *desc)
> +					   const struct vring_desc *desc,
> +					   bool skip_sync)
>  {
> +	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
>  	u16 flags;
>
>  	if (!vq->do_unmap)
> @@ -450,16 +452,18 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
>
>  	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
>
> -	dma_unmap_page(vring_dma_dev(vq),
> -		       virtio64_to_cpu(vq->vq.vdev, desc->addr),
> -		       virtio32_to_cpu(vq->vq.vdev, desc->len),
> -		       (flags & VRING_DESC_F_WRITE) ?
> -		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +	dma_unmap_page_attrs(vring_dma_dev(vq),
> +			     virtio64_to_cpu(vq->vq.vdev, desc->addr),
> +			     virtio32_to_cpu(vq->vq.vdev, desc->len),
> +			     (flags & VRING_DESC_F_WRITE) ?
> +			     DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +			     attrs);
>  }
>
>  static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
> -					  unsigned int i)
> +					  unsigned int i, bool skip_sync)
>  {
> +	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
>  	struct vring_desc_extra *extra = vq->split.desc_extra;
>  	u16 flags;
>
> @@ -469,20 +473,22 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
>  		if (!vq->use_dma_api)
>  			goto out;
>
> -		dma_unmap_single(vring_dma_dev(vq),
> -				 extra[i].addr,
> -				 extra[i].len,
> -				 (flags & VRING_DESC_F_WRITE) ?
> -				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +		dma_unmap_single_attrs(vring_dma_dev(vq),
> +				       extra[i].addr,
> +				       extra[i].len,
> +				       (flags & VRING_DESC_F_WRITE) ?
> +				       DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +				       attrs);
>  	} else {
>  		if (!vq->do_unmap)
>  			goto out;
>
> -		dma_unmap_page(vring_dma_dev(vq),
> -			       extra[i].addr,
> -			       extra[i].len,
> -			       (flags & VRING_DESC_F_WRITE) ?
> -			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +		dma_unmap_page_attrs(vring_dma_dev(vq),
> +				     extra[i].addr,
> +				     extra[i].len,
> +				     (flags & VRING_DESC_F_WRITE) ?
> +				     DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +				     attrs);
>  	}
>
>  out:
> @@ -717,10 +723,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  		if (i == err_idx)
>  			break;
>  		if (indirect) {
> -			vring_unmap_one_split_indirect(vq, &desc[i]);
> +			vring_unmap_one_split_indirect(vq, &desc[i], true);
>  			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
>  		} else
> -			i = vring_unmap_one_split(vq, i);
> +			i = vring_unmap_one_split(vq, i, true);
>  	}
>
>  free_indirect:
> @@ -775,12 +781,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	i = head;
>
>  	while (vq->split.vring.desc[i].flags & nextflag) {
> -		vring_unmap_one_split(vq, i);
> +		vring_unmap_one_split(vq, i, false);
>  		i = vq->split.desc_extra[i].next;
>  		vq->vq.num_free++;
>  	}
>
> -	vring_unmap_one_split(vq, i);
> +	vring_unmap_one_split(vq, i, false);
>  	vq->split.desc_extra[i].next = vq->free_head;
>  	vq->free_head = head;
>
> @@ -804,7 +810,8 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>
>  		if (vq->do_unmap) {
>  			for (j = 0; j < len / sizeof(struct vring_desc); j++)
> -				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
> +				vring_unmap_one_split_indirect(vq,
> +							&indir_desc[j], false);
>  		}
>
>  		kfree(indir_desc);
> @@ -1221,8 +1228,10 @@ static u16 packed_last_used(u16 last_used_idx)
>  }
>
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> -				     const struct vring_desc_extra *extra)
> +				     const struct vring_desc_extra *extra,
> +				     bool skip_sync)
>  {
> +	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
>  	u16 flags;
>
>  	flags = extra->flags;
> @@ -1231,24 +1240,28 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>  		if (!vq->use_dma_api)
>  			return;
>
> -		dma_unmap_single(vring_dma_dev(vq),
> -				 extra->addr, extra->len,
> -				 (flags & VRING_DESC_F_WRITE) ?
> -				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +		dma_unmap_single_attrs(vring_dma_dev(vq),
> +				       extra->addr, extra->len,
> +				       (flags & VRING_DESC_F_WRITE) ?
> +				       DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +				       attrs);
>  	} else {
>  		if (!vq->do_unmap)
>  			return;
>
> -		dma_unmap_page(vring_dma_dev(vq),
> -			       extra->addr, extra->len,
> -			       (flags & VRING_DESC_F_WRITE) ?
> -			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +		dma_unmap_page_attrs(vring_dma_dev(vq),
> +				     extra->addr, extra->len,
> +				     (flags & VRING_DESC_F_WRITE) ?
> +				     DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +				     attrs);
>  	}
>  }
>
>  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> -				    const struct vring_packed_desc *desc)
> +				    const struct vring_packed_desc *desc,
> +				    bool skip_sync)
>  {
> +	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
>  	u16 flags;
>
>  	if (!vq->do_unmap)
> @@ -1256,11 +1269,12 @@ static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
>
>  	flags = le16_to_cpu(desc->flags);
>
> -	dma_unmap_page(vring_dma_dev(vq),
> -		       le64_to_cpu(desc->addr),
> -		       le32_to_cpu(desc->len),
> -		       (flags & VRING_DESC_F_WRITE) ?
> -		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +	dma_unmap_page_attrs(vring_dma_dev(vq),
> +			     le64_to_cpu(desc->addr),
> +			     le32_to_cpu(desc->len),
> +			     (flags & VRING_DESC_F_WRITE) ?
> +			     DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +			     attrs);
>  }
>
>  static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
> @@ -1389,7 +1403,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	err_idx = i;
>
>  	for (i = 0; i < err_idx; i++)
> -		vring_unmap_desc_packed(vq, &desc[i]);
> +		vring_unmap_desc_packed(vq, &desc[i], true);
>
>  free_desc:
>  	kfree(desc);
> @@ -1539,7 +1553,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	for (n = 0; n < total_sg; n++) {
>  		if (i == err_idx)
>  			break;
> -		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
> +		vring_unmap_extra_packed(vq,
> +					 &vq->packed.desc_extra[curr], true);
>  		curr = vq->packed.desc_extra[curr].next;
>  		i++;
>  		if (i >= vq->packed.vring.num)
> @@ -1619,7 +1634,8 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  		curr = id;
>  		for (i = 0; i < state->num; i++) {
>  			vring_unmap_extra_packed(vq,
> -						 &vq->packed.desc_extra[curr]);
> +						 &vq->packed.desc_extra[curr],
> +						 false);
>  			curr = vq->packed.desc_extra[curr].next;
>  		}
>  	}
> @@ -1636,7 +1652,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  			len = vq->packed.desc_extra[id].len;
>  			for (i = 0; i < len / sizeof(struct vring_packed_desc);
>  					i++)
> -				vring_unmap_desc_packed(vq, &desc[i]);
> +				vring_unmap_desc_packed(vq, &desc[i], false);
>  		}
>  		kfree(desc);
>  		state->indir_desc = NULL;
> --
> 2.31.1
>
