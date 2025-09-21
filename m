Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D31D5174
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488118; cv=none; b=sZIJbhFnT2wl93NccnhqAOk+Mjp8Y1hHmqgX3UXxes+aVv5Wzg365/WquUZwJiL1c/TI6ip5Mmbw/YSmmR+aB3z8ZfQr0AOXcXjS4umaUtA9G3Hu8wdF9Xn6xfbVwdi0EBdcRidOh4jDpuLEj0A9+8pO+4kcDzmzlQ/LVcibanY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488118; c=relaxed/simple;
	bh=4AlSV5FNl3xfiiNGKpdZkWwOu7672nh7Ock1VENKALQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E1QzeSQ9g5EEU1tYMA72PeCcq3i5D1VnuIBZxTlVe+ujqkKCPxbyMMDxqlOr+PRRaxH4ce8Aec97AQ41DXmOgFtUE2X0V2tAXIXwZuwvwLtPU44w697lbp5qyUhasqD+/ilM05fYIWV7tYs7KghEYxYqUj5LaeJjtoxv0KDsavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8s2UrY3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8s2UrY3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758488114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DGIv2+PY4/cKy7Q6ANJbQSVUVPSAlNn6jUMi82PwLeY=;
	b=C8s2UrY3aEyIcdmvFHGhEs8675OK26oW985GU2IYCLXTjF94uJyDuL68ATphLqws85SFWO
	P41eQ4vGcaLCcvYApqDh5zyPESTEUSmdtubaMUYZnbQD4BJlmVh419rUeBcAfnjpoznS/4
	Eny7pFcr8XMegO4SwKIsMElCEeoC7Fg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-j2NoWPhmMOusbbPCExHCZw-1; Sun, 21 Sep 2025 16:55:13 -0400
X-MC-Unique: j2NoWPhmMOusbbPCExHCZw-1
X-Mimecast-MFC-AGG-ID: j2NoWPhmMOusbbPCExHCZw_1758488111
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4612d068c47so26279385e9.3
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 13:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758488111; x=1759092911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGIv2+PY4/cKy7Q6ANJbQSVUVPSAlNn6jUMi82PwLeY=;
        b=qj/0rmhYRSrLgd3WaJcwxt2UvOUnr0rf4yMgnOS90C+A9LuZxl6tRJ/9zkLZPGXUM/
         STmom3UdUJ6lM/Ilqqn/HuJhsvZWjxcl3JgxC/p900WZ7VFtVqS3s1I7jDkHeyZj3PGN
         wrLJ95cIqgJFErqMP3V9uafHba3nefJQcHcLqazUqiCO9UFWx5VaXKbifdnz6uys4OVz
         6aCqYKaOOvhyB4VfHcyhBly+5BdllgIoijFJqEdo8re4e44WnFRrP8hK5pwlQNvJQRBs
         CspmUd0KVB//GHf4U9yJTazRrZ86poPBvyY5OWdLpGK+p1pohRz+xJ54WaRVf4dD61D0
         b2Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWHsV3QbrnjCrOOPd4/ZYLguT4blmhu/zjAKzEoy9gHcSI196ztCiSkjRTlwNzXrLcAsmkIYF6Ox/a8le3WeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOI9RIdluu1X1a6N0C7D1kXmqPOiU3ADfad8rAjmeReIeEbRW+
	P6AYE+A/mBfHAeFTJb+Qyyyl+uW7ISoFeTB4mXrDCdMN1wplPDx9KUyyFpfqHYLj9kvXO3eRdAn
	oQzl/sq4bwWw8akllkgS51VPZWEEWfIxuXA5wsJGw2P14ZId10SejgZcs4LzaGG2cruzp
X-Gm-Gg: ASbGnct9oWY9AXaDbaUBpnivS4oy6A6H4+GC6zBI5lr97MNKOjyho43VbzfCE6CUp9+
	E4TJErvMiKL1/drlPwz6+T0W8ZCTqyMwa0xSdSX/TjcPlFqhQAMd89tUBrmgrHCF0XjayBGrU76
	q5ubiXxJ4d/mTs2n8bozEC1+EO0H1xvt8DygTWM0nM0MLzebSYw/++/PlIaVg/DB7FYlXdadwqb
	kxXGhOs8Xxqo29+47OQVCjQpWrVnT7KXvfVkj2qCfn2tgFAsLNMIkg9MAGY0mmrRBSxbjGA/17e
	ubMuD7oJ5gj7+ouM22sfuj6CxMMXLsJ86qY=
X-Received: by 2002:a05:600c:4508:b0:468:7a59:ee81 with SMTP id 5b1f17b1804b1-46b01de9a99mr50993525e9.3.1758488111241;
        Sun, 21 Sep 2025 13:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKE7DuLxQdyt3pMfbq/WNgwaNZF/sLVjWIZtLz7RXB3J32i3EvEFA8ob+6ULnHSJU6WHgLMA==
X-Received: by 2002:a05:600c:4508:b0:468:7a59:ee81 with SMTP id 5b1f17b1804b1-46b01de9a99mr50993415e9.3.1758488110751;
        Sun, 21 Sep 2025 13:55:10 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a281f1sm173879565e9.17.2025.09.21.13.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 13:55:10 -0700 (PDT)
Date: Sun, 21 Sep 2025 16:55:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 1/9] virtio_ring: constify virtqueue pointer for DMA
 helpers
Message-ID: <20250921165434-mutt-send-email-mst@kernel.org>
References: <20250813054831.25865-1-jasowang@redhat.com>
 <20250813054831.25865-2-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250813054831.25865-2-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UKl4GLHc9fd5dYm5bWQ-heK0RMDSlHclJk5sTY1tYcY_1758488111
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 13, 2025 at 01:48:23PM +0800, Jason Wang wrote:
> This patch consities virtqueue point for DMA helpers.

constifies the virtqueue pointer

> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 25 +++++++++++++------------
>  include/linux/virtio.h       | 12 ++++++------
>  2 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f5062061c408..103bad8cffff 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3149,12 +3149,12 @@ EXPORT_SYMBOL_GPL(virtqueue_get_vring);
>   *
>   * return DMA address. Caller should check that by virtqueue_dma_mapping_error().
>   */
> -dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
> +dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr,
>  					  size_t size,
>  					  enum dma_data_direction dir,
>  					  unsigned long attrs)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	if (!vq->use_dma_api) {
>  		kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), size, dir);
> @@ -3176,11 +3176,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
>   * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
>   *
>   */
> -void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
> +void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq,
> +				      dma_addr_t addr,
>  				      size_t size, enum dma_data_direction dir,
>  				      unsigned long attrs)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	if (!vq->use_dma_api)
>  		return;
> @@ -3196,9 +3197,9 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
>   *
>   * Returns 0 means dma valid. Other means invalid dma address.
>   */
> -int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
> +int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t addr)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	if (!vq->use_dma_api)
>  		return 0;
> @@ -3217,9 +3218,9 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
>   *
>   * return bool
>   */
> -bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr)
> +bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t addr)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	if (!vq->use_dma_api)
>  		return false;
> @@ -3240,12 +3241,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
>   * the DMA address really needs to be synchronized
>   *
>   */
> -void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
> +void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq,
>  					     dma_addr_t addr,
>  					     unsigned long offset, size_t size,
>  					     enum dma_data_direction dir)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  	struct device *dev = vring_dma_dev(vq);
>  
>  	if (!vq->use_dma_api)
> @@ -3266,12 +3267,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
>   * Before calling this function, use virtqueue_dma_need_sync() to confirm that
>   * the DMA address really needs to be synchronized
>   */
> -void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
> +void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *_vq,
>  						dma_addr_t addr,
>  						unsigned long offset, size_t size,
>  						enum dma_data_direction dir)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  	struct device *dev = vring_dma_dev(vq);
>  
>  	if (!vq->use_dma_api)
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 8b745ce0cf5f..cf8def717dfd 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -259,18 +259,18 @@ void unregister_virtio_driver(struct virtio_driver *drv);
>  	module_driver(__virtio_driver, register_virtio_driver, \
>  			unregister_virtio_driver)
>  
> -dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr, size_t size,
> +dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr, size_t size,
>  					  enum dma_data_direction dir, unsigned long attrs);
> -void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
> +void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq, dma_addr_t addr,
>  				      size_t size, enum dma_data_direction dir,
>  				      unsigned long attrs);
> -int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
> +int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t addr);
>  
> -bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
> -void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t addr,
> +bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t addr);
> +void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq, dma_addr_t addr,
>  					     unsigned long offset, size_t size,
>  					     enum dma_data_direction dir);
> -void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, dma_addr_t addr,
> +void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *_vq, dma_addr_t addr,
>  						unsigned long offset, size_t size,
>  						enum dma_data_direction dir);
>  
> -- 
> 2.31.1

