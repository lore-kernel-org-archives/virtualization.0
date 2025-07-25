Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F99A272E5C
	for <virtualization@lists.linux.dev>; Fri, 25 Jul 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434704; cv=none; b=B+iWubMrUwG6lw6yxcUHp8eruPlM1AIXExHJnYLDJFWfG20Qd4HgVkdRQy9lHSgZRzYGLbpYsm4ord+fEReUilLqj4TCgyHSlKTUCIOaHoA9PYvHAlOAt++m0bqQhVl35B+LHJgCjErorA4OyueYQ27XvH3RxjO4zm5IzgRjN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434704; c=relaxed/simple;
	bh=cE535QPYJLr4721oTdexHpUIKgt3X3EOHzklQGAcWs4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Nd5QjX/pwCb5pnmjgEypAdYUEk0/ubPEi+soP/HVNZeMejgDbe0dsb5enN0t1IapkEE1N1W1bBZxrLKkMi+ui2Vg4OFFyKY7kOTtJJx+l2rblcrdYpJJk5jH63xtDBAswlCkFR4W2GGsBA7+sUcKYlozzEHfX5NzSITI4fUzZz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HqDFjfri; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HqDFjfri"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753434698; h=Message-ID:Subject:Date:From:To;
	bh=l4FswMrkQZ1XtP6dpYltgsZB9SmxP9BwnMUL2lQc/H8=;
	b=HqDFjfriLoHLqxkFvkK03LmPrOQ1F08pjeI/inGLBZuFfBd1ZIsmCTAN+3SX4nvWvpeQeH4sVMhq4Tczok+PWzii2RxgTu1zkHQa8Bl+iEfWvx390qsN/k75ncyh+VinieLvUGlxy7KU3AaLELTSVvl8FgcJxR4i7rND4usdkPI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wjx7GYR_1753434698 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 17:11:38 +0800
Message-ID: <1753434689.829312-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V4 5/9] virtio_ring: rename dma_handle to map_handle
Date: Fri, 25 Jul 2025 17:11:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 hch@infradead.org,
 Christoph Hellwig <hch@lst.de>,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com
References: <20250718091616.6140-1-jasowang@redhat.com>
 <20250718091616.6140-6-jasowang@redhat.com>
In-Reply-To: <20250718091616.6140-6-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

On Fri, 18 Jul 2025 17:16:12 +0800, Jason Wang <jasowang@redhat.com> wrote:
> Following patch will introduce virtio map opreations which means the
> address is not necessarily used for DMA. Let's rename the dma_handle
> to map_handle first.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 55dd68e71509..26ce8a3d6927 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -306,18 +306,18 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev)
>  EXPORT_SYMBOL_GPL(virtio_max_dma_size);
>
>  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> -			       dma_addr_t *dma_handle, gfp_t flag,
> +			       dma_addr_t *map_handle, gfp_t flag,
>  			       void *map_token)
>  {
>  	if (vring_use_map_api(vdev)) {
>  		return dma_alloc_coherent(map_token, size,
> -					  dma_handle, flag);
> +					  map_handle, flag);
>  	} else {
>  		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
>
>  		if (queue) {
>  			phys_addr_t phys_addr = virt_to_phys(queue);
> -			*dma_handle = (dma_addr_t)phys_addr;
> +			*map_handle = (dma_addr_t)phys_addr;
>
>  			/*
>  			 * Sanity check: make sure we dind't truncate
> @@ -330,7 +330,7 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
>  			 * warning and abort if we end up with an
>  			 * unrepresentable address.
>  			 */
> -			if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
> +			if (WARN_ON_ONCE(*map_handle != phys_addr)) {
>  				free_pages_exact(queue, PAGE_ALIGN(size));
>  				return NULL;
>  			}
> @@ -340,11 +340,11 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
>  }
>
>  static void vring_free_queue(struct virtio_device *vdev, size_t size,
> -			     void *queue, dma_addr_t dma_handle,
> +			     void *queue, dma_addr_t map_handle,
>  			     void *map_token)
>  {
>  	if (vring_use_map_api(vdev))
> -		dma_free_coherent(map_token, size, queue, dma_handle);
> +		dma_free_coherent(map_token, size, queue, map_handle);
>  	else
>  		free_pages_exact(queue, PAGE_ALIGN(size));
>  }
> --
> 2.47.3
>
