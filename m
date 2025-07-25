Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DC27380A
	for <virtualization@lists.linux.dev>; Fri, 25 Jul 2025 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434633; cv=none; b=Lj4baTQY9Cz6RiNsC9nnofDwBGZDR/BYpkZc2jrhcuXXFar5eceEpNjgn28jRwEWGzs7k2dmGr0HHpeO6AK+EZwQHS4F9ZTZxn+selcJY69SgbNjrC0NayudRkJ2RXI4ZbpM/stPM+rkRCYDkObq4v/LVamo81JWtOWRTm+0jVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434633; c=relaxed/simple;
	bh=YW+aU/GMA85cHK6aas1SrfLHUX6hfJ2F+ELf8k2ut/c=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=W07rASgjVXxw+s6kef+ta6T2HGaZyLPz1XqWY/M/C2iSRQX2kuqb+oYhhNMMVd0HTxWLNBaPmENRh3fjWKrLRD6A898ABLC8+qa+B4BHoFQEZ18uwjofu4t4eD+OKtL+3fJ39/Cd5lHxjOPoFXdcAgWf7qMcas7wWDTECwopD/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F3tUhEvQ; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F3tUhEvQ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753434624; h=Message-ID:Subject:Date:From:To;
	bh=JFGiPWoMODvZEl9kko98w5paCQwOVbnNEGMF0klu88w=;
	b=F3tUhEvQV8Hvon06f6k08itGf26paDnZLRYzqN3iWtk63PHI64rfBOiTu7Bc3EQrxcrxEqTfFeK1SOFF7+unErWUxWxKWXewaSIRDKhmi4kDXy1C1AJsb9vd0tYzTLYKF1tCn+LbQi4uv/pyNsUM8kM7wDIA/JQ13jKiQhapI00=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wjx7G4-_1753434623 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 17:10:24 +0800
Message-ID: <1753434567.220294-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V4 2/9] virtio_ring: switch to use dma_{map|unmap}_page()
Date: Fri, 25 Jul 2025 17:09:27 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 hch@infradead.org,
 Christoph Hellwig <hch@lst.de>,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com
References: <20250718091616.6140-1-jasowang@redhat.com>
 <20250718091616.6140-3-jasowang@redhat.com>
In-Reply-To: <20250718091616.6140-3-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 18 Jul 2025 17:16:09 +0800, Jason Wang <jasowang@redhat.com> wrote:
> This patch switches to use dma_{map|unmap}_page() to reduce the
> coverage of DMA operations. This would help for the following rework
> on the virtio map operations.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 55 +++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 103bad8cffff..75e5f6336c8d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -405,8 +405,8 @@ static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
>  	if (!vq->use_dma_api)
>  		return (dma_addr_t)virt_to_phys(cpu_addr);
>
> -	return dma_map_single(vring_dma_dev(vq),
> -			      cpu_addr, size, direction);
> +	return virtqueue_dma_map_single_attrs(&vq->vq, cpu_addr,
> +					      size, direction, 0);
>  }
>
>  static int vring_mapping_error(const struct vring_virtqueue *vq,
> @@ -451,22 +451,14 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
>  	if (flags & VRING_DESC_F_INDIRECT) {
>  		if (!vq->use_dma_api)
>  			goto out;
> +	} else if (!vring_need_unmap_buffer(vq, extra))
> +		goto out;
>
> -		dma_unmap_single(vring_dma_dev(vq),
> -				 extra->addr,
> -				 extra->len,
> -				 (flags & VRING_DESC_F_WRITE) ?
> -				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -	} else {
> -		if (!vring_need_unmap_buffer(vq, extra))
> -			goto out;
> -
> -		dma_unmap_page(vring_dma_dev(vq),
> -			       extra->addr,
> -			       extra->len,
> -			       (flags & VRING_DESC_F_WRITE) ?
> -			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -	}
> +	dma_unmap_page(vring_dma_dev(vq),
> +		       extra->addr,
> +		       extra->len,
> +		       (flags & VRING_DESC_F_WRITE) ?
> +		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
>
>  out:
>  	return extra->next;
> @@ -1276,20 +1268,13 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>  	if (flags & VRING_DESC_F_INDIRECT) {
>  		if (!vq->use_dma_api)
>  			return;
> +	} else if (!vring_need_unmap_buffer(vq, extra))
> +		return;
>
> -		dma_unmap_single(vring_dma_dev(vq),
> -				 extra->addr, extra->len,
> -				 (flags & VRING_DESC_F_WRITE) ?
> -				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -	} else {
> -		if (!vring_need_unmap_buffer(vq, extra))
> -			return;
> -
> -		dma_unmap_page(vring_dma_dev(vq),
> -			       extra->addr, extra->len,
> -			       (flags & VRING_DESC_F_WRITE) ?
> -			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -	}
> +	dma_unmap_page(vring_dma_dev(vq),
> +		       extra->addr, extra->len,
> +		       (flags & VRING_DESC_F_WRITE) ?
> +		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
>  }
>
>  static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
> @@ -3161,7 +3146,13 @@ dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr
>  		return (dma_addr_t)virt_to_phys(ptr);
>  	}
>
> -	return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, attrs);
> +	/* DMA must never operate on areas that might be remapped. */
> +	if (dev_WARN_ONCE(&_vq->vdev->dev, is_vmalloc_addr(ptr),
> +			  "rejecting DMA map of vmalloc memory\n"))
> +		return DMA_MAPPING_ERROR;


Why add this check, we never use the vmalloc address?

Thanks.


> +
> +	return dma_map_page_attrs(vring_dma_dev(vq), virt_to_page(ptr),
> +				  offset_in_page(ptr), size, dir, attrs);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
>
> @@ -3186,7 +3177,7 @@ void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq,
>  	if (!vq->use_dma_api)
>  		return;
>
> -	dma_unmap_single_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
> +	dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
>
> --
> 2.47.3
>
