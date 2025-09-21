Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5E1400E
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758492074; cv=none; b=Ib4UPUT9fPK9aSAelNMSODu1C5H5VKxdJjjXDET+OPEzMLtIIBvbI+kXTYL6yAY4uI/OnisMZ49omyB15M2ND8y/bt8SWqutl6IuY45iYLrQ482Y4K6fxZdaDXltahATWMLkj3v1GzeimwZfoxn1ykZBUdhCoCEu0XFhC2nOkzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758492074; c=relaxed/simple;
	bh=wwy77FZjPzXVqSd8zCmLIZtd+51+rVaWEBmEBqoTVQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qdKqdeg4SftzVcGgruEOY5GsLhKTDZi+lpHCA0N4L93mDAUmU8hf04Uv6MD9eVSooYZIXARRXLKPKsLlti9EpdGrmrCrssgfhUk2VDhl5/4xY7JgPFT2dNv+yD1Gqi9YbcedEnfOW5pLeXyRNvEFbJv6atKFpzZqA9LGWEncxA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkvyEPlP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkvyEPlP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758492071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CUtv1hbbmUenUQSLaTNYzLLZIXYlWbdSgo+kRKCuxQE=;
	b=FkvyEPlPVFg0gYTBcNvTpVg6Ute/MZQHnjz3ARGTkMMOAKcLk+03V1sxP4jOK+2l2/TYNe
	5c09rhekR0qch17LmT5WVW0HAbuKEn4M0RX2StcxX9Q/DDfATpacgQ6LYmhbojzftBU8U/
	3g94C0CHpGdZsR8Nb6LKrXEsWDFLDMg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-qNUo_vusMoWShpNbKbvUXA-1; Sun, 21 Sep 2025 18:01:10 -0400
X-MC-Unique: qNUo_vusMoWShpNbKbvUXA-1
X-Mimecast-MFC-AGG-ID: qNUo_vusMoWShpNbKbvUXA_1758492069
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46d46692831so1404725e9.3
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 15:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758492069; x=1759096869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUtv1hbbmUenUQSLaTNYzLLZIXYlWbdSgo+kRKCuxQE=;
        b=vFCFKJ0scblKsGscebFqHagS7VVbIWAmDlj2v6pSxgxldzpWzAAsTM8K1yazEKjyFN
         PSZiadYSNTDDyNC0aXCFzheHF88TKS0venMCb48dgLl+21BKNKU005/puv96J1aRjd6D
         S0wPRgqI2DpLgBKW9pTKdVx/TqD3rO5TiDFAX2mjOOQ6Xj0LNJZpCXqFc9+osiqwQvP1
         zO9sxryk8KF5IW6U06aJZKL6il5h1CNDiMo9x4b6FU+fiRe79ReS7fwMiRwFspSOgJUd
         1hybSpCr6ksHUzYWe10haS/qdEsKlqHT0VSob3J4UjG81xR39Y/gB0p1Mv63Qnej8H8g
         Y6oA==
X-Forwarded-Encrypted: i=1; AJvYcCXaDpbtpYptfBCX975F/DTcb6bhDCvSX5LNNWT7ZvAQJwScSOMMIfs+pCpDt+L9fZrgV+CQTwt7wQv3w0uR0A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7B9HYErK+044skQCawUpl6zgnYD18dEFTZ9P8M1k1acEcyy1w
	ZVL28CnWdQs0PtAx7FNPod2a9q4SARmIwezudV2Edp0RH9e7nEr0wx4OO1QjyuxoK4Sswxz1K6+
	95r/vgAPTq5whNS9XLSbmJoQHFCW8o5QWmHZFXI7CvycaOw9oAS9+eO0QoHqZ6U84pNEuCDH5hc
	MU
X-Gm-Gg: ASbGncsoAWSw2JbsvDcm62YnfufigKMTmlqu24q3M6T89Pn281ezN5J6jqnE6aHLilL
	Jc8HFu+yAbdKedKECcJCIM+FYxMAoIhFZWu3lwWbFZypLPD9JbClVTVaBSeAPJ81dnQ9px5zTz6
	+HkJ6PbIGGVTcPFjqerFyc5AcL2+qGiqMNGfVtQZL/dCsQsbAq43D98sOuZo+atbaejmo6lcGUc
	RIo5dLetlK09wL7ssGZ2dOe9fEWe8H+dTTTIOr6MztiZht+t5wx/g+th2SvHGRFkvWjkHfURnT6
	VIU2GkaSUEJ3Onq2xzLwecHnH+RJW72sr+M=
X-Received: by 2002:a05:600c:46c9:b0:45d:d68c:2a36 with SMTP id 5b1f17b1804b1-467f0b4f285mr77878325e9.27.1758492068970;
        Sun, 21 Sep 2025 15:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFARQGsNmwzo0hZB/ZVHOpYNQflHhubYUlS6mksZnqSfz0dWAidK0Js/jSMb2ClcdRjsyK7wg==
X-Received: by 2002:a05:600c:46c9:b0:45d:d68c:2a36 with SMTP id 5b1f17b1804b1-467f0b4f285mr77878205e9.27.1758492068506;
        Sun, 21 Sep 2025 15:01:08 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fc00a92sm17265950f8f.63.2025.09.21.15.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 15:01:07 -0700 (PDT)
Date: Sun, 21 Sep 2025 18:01:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: Re: [PATCH V6 6/9] virtio: introduce map ops in virtio core
Message-ID: <20250921175933-mutt-send-email-mst@kernel.org>
References: <20250821064641.5025-1-jasowang@redhat.com>
 <20250821064641.5025-7-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250821064641.5025-7-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Un65cyU6GVyv6vuef5yijpNjZZpgXqcgB1XFejQRWQw_1758492069
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 21, 2025 at 02:46:38PM +0800, Jason Wang wrote:
> This patch introduces map operations for virtio device. Virtio use to
> use DMA API which is not necessarily the case since some devices
> doesn't do DMA. Instead of using tricks and abusing DMA API, let's
> simply abstract the current mapping logic into a virtio specific
> mapping operations. For the device or transport that doesn't do DMA,
> they can implement their own mapping logic without the need to trick
> DMA core. In this case the mapping metadata is opaque to the virtio
> core that will be passed back to the transport or device specific map
> operations. For other devices, DMA API will still be used, so map
> token will still be the dma device to minimize the changeset and
> performance impact.
> 
> The mapping operations are abstracted as a independent structure
> instead of reusing virtio_config_ops. This allows the transport can
> simply reuse the structure for lower layers like vDPA.
> 
> A set of new mapping helpers were introduced for the device that want
> to do mapping by themselves.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c  | 211 +++++++++++++++++++++++++++-------
>  drivers/virtio/virtio_vdpa.c  |   3 +
>  include/linux/virtio.h        |  25 ++++
>  include/linux/virtio_config.h |  72 ++++++++++++
>  4 files changed, 269 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 46515b017ccb..f91a432b3e53 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -297,8 +297,14 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev)
>  {
>  	size_t max_segment_size = SIZE_MAX;
>  
> -	if (vring_use_map_api(vdev))
> -		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
> +	if (vring_use_map_api(vdev)) {
> +		if (vdev->map) {
> +			max_segment_size =
> +				vdev->map->max_mapping_size(vdev->vmap);
> +		} else
> +			max_segment_size =
> +				dma_max_mapping_size(vdev->dev.parent);

Not good, either user braces in both branches or none.
In this instance - none. It can be ? actually.


> +	}


>  
>  	return max_segment_size;
>  }
> @@ -309,8 +315,8 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
>  			       union virtio_map map)
>  {
>  	if (vring_use_map_api(vdev)) {
> -		return dma_alloc_coherent(map.dma_dev, size,
> -					  map_handle, flag);
> +		return virtqueue_map_alloc_coherent(vdev, map, size,
> +						    map_handle, flag);
>  	} else {
>  		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
>  
> @@ -343,7 +349,8 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
>  			     union virtio_map map)
>  {
>  	if (vring_use_map_api(vdev))
> -		dma_free_coherent(map.dma_dev, size, queue, map_handle);
> +		virtqueue_map_free_coherent(vdev, map, size,
> +					    queue, map_handle);
>  	else
>  		free_pages_exact(queue, PAGE_ALIGN(size));
>  }
> @@ -358,6 +365,20 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
>  	return vq->map.dma_dev;
>  }
>  
> +static int vring_mapping_error(const struct vring_virtqueue *vq,
> +			       dma_addr_t addr)
> +{
> +	struct virtio_device *vdev = vq->vq.vdev;
> +
> +	if (!vq->use_map_api)
> +		return 0;
> +
> +	if (vdev->map)
> +		return vdev->map->mapping_error(vq->map, addr);
> +	else
> +		return dma_mapping_error(vring_dma_dev(vq), addr);
> +}
> +
>  /* Map one sg entry. */
>  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
>  			    enum dma_data_direction direction, dma_addr_t *addr,
> @@ -387,11 +408,11 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
>  	 * the way it expects (we don't guarantee that the scatterlist
>  	 * will exist for the lifetime of the mapping).
>  	 */
> -	*addr = dma_map_page(vring_dma_dev(vq),
> -			    sg_page(sg), sg->offset, sg->length,
> -			    direction);
> +	*addr = virtqueue_map_page_attrs(&vq->vq, sg_page(sg),
> +					 sg->offset, sg->length,
> +					 direction, 0);
>  
> -	if (dma_mapping_error(vring_dma_dev(vq), *addr))
> +	if (vring_mapping_error(vq, *addr))
>  		return -ENOMEM;
>  
>  	return 0;
> @@ -408,15 +429,6 @@ static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
>  					  size, direction, 0);
>  }
>  
> -static int vring_mapping_error(const struct vring_virtqueue *vq,
> -			       dma_addr_t addr)
> -{
> -	if (!vq->use_map_api)
> -		return 0;
> -
> -	return dma_mapping_error(vring_dma_dev(vq), addr);
> -}
> -
>  static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
>  {
>  	vq->vq.num_free = num;
> @@ -453,11 +465,12 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
>  	} else if (!vring_need_unmap_buffer(vq, extra))
>  		goto out;
>  
> -	dma_unmap_page(vring_dma_dev(vq),
> -		       extra->addr,
> -		       extra->len,
> -		       (flags & VRING_DESC_F_WRITE) ?
> -		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +	virtqueue_unmap_page_attrs(&vq->vq,
> +				   extra->addr,
> +				   extra->len,
> +				   (flags & VRING_DESC_F_WRITE) ?
> +				   DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +				   0);
>  
>  out:
>  	return extra->next;
> @@ -1271,10 +1284,11 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>  	} else if (!vring_need_unmap_buffer(vq, extra))
>  		return;
>  
> -	dma_unmap_page(vring_dma_dev(vq),
> -		       extra->addr, extra->len,
> -		       (flags & VRING_DESC_F_WRITE) ?
> -		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +	virtqueue_unmap_page_attrs(&vq->vq,
> +				   extra->addr, extra->len,
> +				   (flags & VRING_DESC_F_WRITE) ?
> +				   DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +				   0);
>  }
>  
>  static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
> @@ -2433,7 +2447,7 @@ struct device *virtqueue_dma_dev(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	if (vq->use_map_api)
> +	if (vq->use_map_api && !_vq->vdev->map)
>  		return vq->map.dma_dev;
>  	else
>  		return NULL;
> @@ -3123,6 +3137,107 @@ const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
>  
> +/**
> + * virtqueue_map_alloc_coherent - alloc coherent mapping
> + * @vdev: the virtio device we are talking to
> + * @map: metadata for performing mapping
> + * @size: the size of the buffer
> + * @map_handle: the pointer to the mapped address
> + * @gfp: allocation flag (GFP_XXX)
> + *
> + * return virtual address or NULL on error
> + */
> +void *virtqueue_map_alloc_coherent(struct virtio_device *vdev,
> +				   union virtio_map map,
> +				   size_t size, dma_addr_t *map_handle,
> +				   gfp_t gfp)
> +{
> +	if (vdev->map)
> +		return vdev->map->alloc(map, size,
> +					map_handle, gfp);
> +	else
> +		return dma_alloc_coherent(map.dma_dev, size,
> +					  map_handle, gfp);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_map_alloc_coherent);
> +
> +/**
> + * virtqueue_map_free_coherent - free coherent mapping
> + * @vdev: the virtio device we are talking to
> + * @map: metadata for performing mapping
> + * @size: the size of the buffer
> + * @map_handle: the mapped address that needs to be freed
> + *
> + */
> +void virtqueue_map_free_coherent(struct virtio_device *vdev,
> +				 union virtio_map map, size_t size, void *vaddr,
> +				 dma_addr_t map_handle)
> +{
> +	if (vdev->map)
> +		vdev->map->free(map, size, vaddr,
> +				map_handle, 0);
> +	else
> +		dma_free_coherent(map.dma_dev, size, vaddr, map_handle);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_map_free_coherent);
> +
> +/**
> + * virtqueue_map_page_attrs - map a page to the device
> + * @_vq: the virtqueue we are talking to
> + * @page: the page that will be mapped by the device
> + * @offset: the offset in the page for a buffer
> + * @size: the buffer size
> + * @dir: mapping direction
> + * @attrs: mapping attributes
> + *
> + * Returns mapped address. Caller should check that by virtqueue_mapping_error().
> + */
> +dma_addr_t virtqueue_map_page_attrs(const struct virtqueue *_vq,
> +				    struct page *page,
> +				    unsigned long offset,
> +				    size_t size,
> +				    enum dma_data_direction dir,
> +				    unsigned long attrs)
> +{
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
> +	struct virtio_device *vdev = _vq->vdev;
> +
> +	if (vdev->map)
> +		return vdev->map->map_page(vq->map,
> +					   page, offset, size,
> +					   dir, attrs);
> +
> +	return dma_map_page_attrs(vring_dma_dev(vq),
> +				  page, offset, size,
> +				  dir, attrs);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_map_page_attrs);
> +
> +/**
> + * virtqueue_unmap_page_attrs - map a page to the device
> + * @_vq: the virtqueue we are talking to
> + * @map_handle: the mapped address
> + * @size: the buffer size
> + * @dir: mapping direction
> + * @attrs: unmapping attributes
> + */
> +void virtqueue_unmap_page_attrs(const struct virtqueue *_vq,
> +				dma_addr_t map_handle,
> +				size_t size, enum dma_data_direction dir,
> +				unsigned long attrs)
> +{
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
> +	struct virtio_device *vdev = _vq->vdev;
> +
> +	if (vdev->map)
> +		vdev->map->unmap_page(vq->map,
> +				      map_handle, size, dir, attrs);
> +	else
> +		dma_unmap_page_attrs(vring_dma_dev(vq), map_handle,
> +				     size, dir, attrs);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_unmap_page_attrs);
> +
>  /**
>   * virtqueue_map_single_attrs - map DMA for _vq
>   * @_vq: the struct virtqueue we're talking about.
> @@ -3134,7 +3249,7 @@ EXPORT_SYMBOL_GPL(virtqueue_get_vring);
>   * The caller calls this to do dma mapping in advance. The DMA address can be
>   * passed to this _vq when it is in pre-mapped mode.
>   *
> - * return DMA address. Caller should check that by virtqueue_mapping_error().
> + * return mapped address. Caller should check that by virtqueue_mapping_error().
>   */
>  dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void *ptr,
>  				      size_t size,
> @@ -3153,8 +3268,8 @@ dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void *ptr,
>  			  "rejecting DMA map of vmalloc memory\n"))
>  		return DMA_MAPPING_ERROR;
>  
> -	return dma_map_page_attrs(vring_dma_dev(vq), virt_to_page(ptr),
> -				  offset_in_page(ptr), size, dir, attrs);
> +	return virtqueue_map_page_attrs(&vq->vq, virt_to_page(ptr),
> +					offset_in_page(ptr), size, dir, attrs);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_map_single_attrs);
>  
> @@ -3179,12 +3294,12 @@ void virtqueue_unmap_single_attrs(const struct virtqueue *_vq,
>  	if (!vq->use_map_api)
>  		return;
>  
> -	dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
> +	virtqueue_unmap_page_attrs(_vq, addr, size, dir, attrs);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_unmap_single_attrs);
>  
>  /**
> - * virtqueue_map_mapping_error - check dma address
> + * virtqueue_mapping_error - check dma address
>   * @_vq: the struct virtqueue we're talking about.
>   * @addr: DMA address
>   *
> @@ -3194,10 +3309,7 @@ int virtqueue_map_mapping_error(const struct virtqueue *_vq, dma_addr_t addr)
>  {
>  	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	if (!vq->use_map_api)
> -		return 0;
> -
> -	return dma_mapping_error(vring_dma_dev(vq), addr);
> +	return vring_mapping_error(vq, addr);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_map_mapping_error);
>  
> @@ -3214,11 +3326,15 @@ EXPORT_SYMBOL_GPL(virtqueue_map_mapping_error);
>  bool virtqueue_map_need_sync(const struct virtqueue *_vq, dma_addr_t addr)
>  {
>  	const struct vring_virtqueue *vq = to_vvq(_vq);
> +	struct virtio_device *vdev = _vq->vdev;
>  
>  	if (!vq->use_map_api)
>  		return false;
>  
> -	return dma_need_sync(vring_dma_dev(vq), addr);
> +	if (vdev->map)
> +		return vdev->map->need_sync(vq->map, addr);
> +	else
> +		return dma_need_sync(vring_dma_dev(vq), addr);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_map_need_sync);
>  
> @@ -3240,12 +3356,17 @@ void virtqueue_map_sync_single_range_for_cpu(const struct virtqueue *_vq,
>  					     enum dma_data_direction dir)
>  {
>  	const struct vring_virtqueue *vq = to_vvq(_vq);
> -	struct device *dev = vring_dma_dev(vq);
> +	struct virtio_device *vdev = _vq->vdev;
>  
>  	if (!vq->use_map_api)
>  		return;
>  
> -	dma_sync_single_range_for_cpu(dev, addr, offset, size, dir);
> +	if (vdev->map)
> +		vdev->map->sync_single_for_cpu(vq->map,
> +					       addr + offset, size, dir);
> +	else
> +		dma_sync_single_range_for_cpu(vring_dma_dev(vq),
> +					      addr, offset, size, dir);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_cpu);
>  
> @@ -3266,12 +3387,18 @@ void virtqueue_map_sync_single_range_for_device(const struct virtqueue *_vq,
>  						enum dma_data_direction dir)
>  {
>  	const struct vring_virtqueue *vq = to_vvq(_vq);
> -	struct device *dev = vring_dma_dev(vq);
> +	struct virtio_device *vdev = _vq->vdev;
>  
>  	if (!vq->use_map_api)
>  		return;
>  
> -	dma_sync_single_range_for_device(dev, addr, offset, size, dir);
> +	if (vdev->map)
> +		vdev->map->sync_single_for_device(vq->map,
> +						  addr + offset,
> +						  size, dir);
> +	else
> +		dma_sync_single_range_for_device(vring_dma_dev(vq), addr,
> +						 offset, size, dir);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_device);
>  
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index dc557aa7c825..d4be689e3626 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -195,6 +195,9 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>  		goto error_new_virtqueue;
>  	}
>  
> +	if (index == 0)
> +		vdev->vmap = map;
> +
>  	vq->num_max = max_num;
>  
>  	/* Setup virtqueue callback */
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b4ba1a99e5ab..3386a4a8d06b 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -166,9 +166,11 @@ struct virtio_device {
>  	struct virtio_device_id id;
>  	const struct virtio_config_ops *config;
>  	const struct vringh_config_ops *vringh_config;
> +	const struct virtio_map_ops *map;
>  	struct list_head vqs;
>  	VIRTIO_DECLARE_FEATURES(features);
>  	void *priv;
> +	union virtio_map vmap;
>  #ifdef CONFIG_VIRTIO_DEBUG
>  	struct dentry *debugfs_dir;
>  	u64 debugfs_filter_features[VIRTIO_FEATURES_DWORDS];
> @@ -267,6 +269,29 @@ void unregister_virtio_driver(struct virtio_driver *drv);
>  	module_driver(__virtio_driver, register_virtio_driver, \
>  			unregister_virtio_driver)
>  
> +
> +void *virtqueue_map_alloc_coherent(struct virtio_device *vdev,
> +				   union virtio_map mapping_token,
> +				   size_t size, dma_addr_t *dma_handle,
> +				   gfp_t gfp);
> +
> +void virtqueue_map_free_coherent(struct virtio_device *vdev,
> +				 union virtio_map mapping_token,
> +				 size_t size, void *vaddr,
> +				 dma_addr_t dma_handle);
> +
> +dma_addr_t virtqueue_map_page_attrs(const struct virtqueue *_vq,
> +				    struct page *page,
> +				    unsigned long offset,
> +				    size_t size,
> +				    enum dma_data_direction dir,
> +				    unsigned long attrs);
> +
> +void virtqueue_unmap_page_attrs(const struct virtqueue *_vq,
> +				dma_addr_t dma_handle,
> +				size_t size, enum dma_data_direction dir,
> +				unsigned long attrs);
> +
>  dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void *ptr, size_t size,
>  					  enum dma_data_direction dir, unsigned long attrs);
>  void virtqueue_unmap_single_attrs(const struct virtqueue *_vq, dma_addr_t addr,
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 8bf156dde554..52319dc5d5e0 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -139,6 +139,78 @@ struct virtio_config_ops {
>  	int (*enable_vq_after_reset)(struct virtqueue *vq);
>  };
>  
> +/**
> + * struct virtio_map_ops - operations for mapping buffer for a virtio device
> + * Note: For transport that has its own mapping logic it must
> + * implements all of the operations
> + * @map_page: map a buffer to the device
> + *      map: metadata for performing mapping
> + *      page: the page that will be mapped by the device
> + *      offset: the offset in the page for a buffer
> + *      size: the buffer size
> + *      dir: mapping direction
> + *      attrs: mapping attributes
> + *      Returns: the mapped address
> + * @unmap_page: unmap a buffer from the device
> + *      map: device specific mapping map
> + *      map_handle: the mapped address
> + *      size: the buffer size
> + *      dir: mapping direction
> + *      attrs: unmapping attributes
> + * @sync_single_for_cpu: sync a single buffer from device to cpu
> + *      map: metadata for performing mapping
> + *      map_handle: the mapping address to sync
> + *      size: the size of the buffer
> + *      dir: synchronization direction
> + * @sync_single_for_device: sync a single buffer from cpu to device
> + *      map: metadata for performing mapping
> + *      map_handle: the mapping address to sync
> + *      size: the size of the buffer
> + *      dir: synchronization direction
> + * @alloc: alloc a coherent buffer mapping
> + *      map: metadata for performing mapping
> + *      size: the size of the buffer
> + *      map_handle: the mapping address to sync
> + *      gfp: allocation flag (GFP_XXX)
> + *      Returns: virtual address of the allocated buffer
> + * @free: free a coherent buffer mapping
> + *      map: metadata for performing mapping
> + *      size: the size of the buffer
> + *      vaddr: virtual address of the buffer
> + *      map_handle: the mapping address to sync
> + *      attrs: unmapping attributes
> + * @need_sync: if the buffer needs synchronization
> + *      map: metadata for performing mapping
> + *      map_handle: the mapped address
> + *      Returns: whether the buffer needs synchronization
> + * @mapping_error: if the mapping address is error
> + *      map: metadata for performing mapping
> + *      map_handle: the mapped address
> + * @max_mapping_size: get the maximum buffer size that can be mapped
> + *      map: metadata for performing mapping
> + *      Returns: the maximum buffer size that can be mapped
> + */
> +struct virtio_map_ops {
> +	dma_addr_t (*map_page)(union virtio_map map, struct page *page,
> +			       unsigned long offset, size_t size,
> +			       enum dma_data_direction dir, unsigned long attrs);
> +	void (*unmap_page)(union virtio_map map, dma_addr_t map_handle,
> +			   size_t size, enum dma_data_direction dir,
> +			   unsigned long attrs);
> +	void (*sync_single_for_cpu)(union virtio_map map, dma_addr_t map_handle,
> +				    size_t size, enum dma_data_direction dir);
> +	void (*sync_single_for_device)(union virtio_map map,
> +				       dma_addr_t map_handle, size_t size,
> +				       enum dma_data_direction dir);
> +	void *(*alloc)(union virtio_map map, size_t size,
> +		       dma_addr_t *map_handle, gfp_t gfp);
> +	void (*free)(union virtio_map map, size_t size, void *vaddr,
> +		     dma_addr_t map_handle, unsigned long attrs);
> +	bool (*need_sync)(union virtio_map map, dma_addr_t map_handle);
> +	int (*mapping_error)(union virtio_map map, dma_addr_t map_handle);
> +	size_t (*max_mapping_size)(union virtio_map map);
> +};
> +
>  /* If driver didn't advertise the feature, it will never appear. */
>  void virtio_check_driver_offered_feature(const struct virtio_device *vdev,
>  					 unsigned int fbit);
> -- 
> 2.31.1

