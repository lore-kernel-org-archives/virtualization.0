Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54517221F04
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830847; cv=none; b=ZlZMWBo1IgJZbNUeeVu3KwtdO8qRfX4IznzRnaGznHOvAV2pvzW+7SiU/Kr9vi43cq/B1eFncbGshCIwr+86EzqVdLV07Cntt2MOO6cOuqECCNxSLacJRJ5marAm6r8uNciPJWe2AgXLwsPJ0oYlPD/8sy7elAYxTBO1Jc9jjx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830847; c=relaxed/simple;
	bh=oCZ6j/+oewJR3TeAUqqapH3XhilPJ0UgVRP5c6QC4EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=a0JWCFPVpsfn6SyR2W0tPEvscLtsjIV/i68RubYxpp/q8KAqHcuhBrVbt639Fa93gWzZtRdM+uzqE250mMu+okz+dyNYuGu7TX7sPZBg/8XjllRRCIZTRLrGHnRs/+o/e/Mh9+usXkBJtOaU+P1/edIIuwUlIZ88XacV4GkVBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLtUxwCC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLtUxwCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752830844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Xd3Oc6PApOxnjDoiDbt9lJ/bVyVwXk4YmDm9fGSPjY=;
	b=JLtUxwCCYRzxXvVSHo2hZZZhRYn+NsXphoPHzEfyxqgbji8BYlCpq1TvpWABsDJFYJbKnQ
	2ss21HYgqglc2IzzV62hJB7/eJyj/K3WZ4kLxHTOn/1wADPEmYwOGJEIK3P3wmtuIur5/N
	mjoU8VlJP/SUI0Zr3Il4RIO6Cmd3eV0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-f3geul8PM5ykcahsZpd7Nw-1; Fri, 18 Jul 2025 05:27:23 -0400
X-MC-Unique: f3geul8PM5ykcahsZpd7Nw-1
X-Mimecast-MFC-AGG-ID: f3geul8PM5ykcahsZpd7Nw_1752830842
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a579058758so821315f8f.1
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 02:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830841; x=1753435641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Xd3Oc6PApOxnjDoiDbt9lJ/bVyVwXk4YmDm9fGSPjY=;
        b=p6J2MAWGztAvFJ3CQ6TtsEDIVMK0G6e22DTnMDCvhiMXq7goY50sjXSlYuStMOH3Gg
         u5Po84TzHJ+A8Xtc/ROQWYtzuh2E4KD4D7D10IlThgAxrA6falT5qVtAimheJeVOEUUE
         H7rSYS8PEaicl/EVRiGeJbSfSHAHcKSrX1OF9DvRxSOrSSUZwdZ3KvJtwrDt5R3Axa1M
         zoFcXjF6kfa2sUEzlIPszjIcLGFQKHgj6k0TAPHqnXTo4hSc11uuEmJ74jSy9/neAjWA
         jeoQeVjj9Y+ZfG036cT7tDXXVsbQ6lQGw2A4GFkJMY02sdyY9NJj4YvcUW48CCsL+70a
         F4nw==
X-Forwarded-Encrypted: i=1; AJvYcCWhr/K7BUuytozLJP4eMe1GPg7zu2/lQz6mE3ZW9l9LOoZIOQXirndEhCZcIGdJGnkM4kOWy4bD6vI5mul0ZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxU3O3tbDciLNW0i+SlN9Ej4WaVcJTcgiLwpsBRaUtGwRc7M+k7
	qLYnIRkwsDh7SKon+aEb5wnSFwjeuNiYz2c1tXfGCR3PGxfjsrKkbe0tzBrsrGnw0+4Py2ZvRt+
	e3z3JBgGIi7A3ni3UPRyhPR3x9LXHBpbOAFZF3pgFE2nZyqqIVKafg0dkt8AVehaTmWw6JkaHV4
	aZ
X-Gm-Gg: ASbGncsW7+GuPQnmfLYI9Dti9q4MPQTjoPI7aisOB5kunOjbFrgc/5qy421bLqGEjTy
	tShV6MdgwOLmIEgec/BnEhLw5sPP8PorOElTsGbOysFaPqbKjT9qpAbpjdl18rooHLsOaHj9i4F
	cDYdLhEcAvaFqWnzt+sO/VqivM6alFXQMsLnIkWB/PTOPBz8Z4lhIBjPYLo4ou11hurtT1+BLN5
	WRDK+uDyUgUi9ldrR2JgarKE49EkeS3tT3EKif1oCtfcT2uoNrsGFG796Y3Kd80hgs5uaV7oGWi
	wFbtvrELsAqJqIS1Y8RtHMxg7jDu/Ddm
X-Received: by 2002:a05:6000:4406:b0:3a5:3b93:be4b with SMTP id ffacd0b85a97d-3b60e4d4d6dmr6037148f8f.25.1752830841445;
        Fri, 18 Jul 2025 02:27:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmpMK2QesgCsQW45w2F2nsf0lub6Q294iCZNix5x2LtvnO92V6Bt+CEimqqsyWcFbbY6XzWA==
X-Received: by 2002:a05:6000:4406:b0:3a5:3b93:be4b with SMTP id ffacd0b85a97d-3b60e4d4d6dmr6037129f8f.25.1752830841003;
        Fri, 18 Jul 2025 02:27:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b5b7e6fsm15146765e9.10.2025.07.18.02.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 02:27:20 -0700 (PDT)
Date: Fri, 18 Jul 2025 05:27:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 1/9] virtio_ring: constify virtqueue pointer for DMA
 helpers
Message-ID: <20250718052707-mutt-send-email-mst@kernel.org>
References: <20250718091616.6140-1-jasowang@redhat.com>
 <20250718091616.6140-2-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250718091616.6140-2-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T6fIl6tzSemdcLtJuu85FMWTy3D8Ao_BzeezNULpm4w_1752830842
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 18, 2025 at 05:16:08PM +0800, Jason Wang wrote:
> This patch consities virtqueue point for DMA helpers.

point -> pointer

> Reviewed-by: Christoph Hellwig <hch@lst.de>
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
> index dd98cc2b8c18..f2dbd18a2b2e 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -264,18 +264,18 @@ void unregister_virtio_driver(struct virtio_driver *drv);
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
> 2.47.3

