Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414161D5CE8
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828399; cv=none; b=LOg5dLLGNRIDzxLRY430VdAfdSdpJ4vxVe2q9QxNUFd2qIUv2jmdC57QIe8FmNPVpf79IFi5jTbOJpDj7guGc3Z0+hSmFdQAM+sZYRiuGI4WqsKoO05oCaT+Xre4DYjomUO1jfIRBYoEt7vwnCCReCBdJg+2tP6qq5f4xjdCpvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828399; c=relaxed/simple;
	bh=r8HNSenv3i93seyFN/HkzRDH6Z+/x+ftOLEYrPEHFGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ll2EWH/x59XjaaU5okjkZFQf/sIU9ggjEo1kq3rx0wAntqxkb4Nk5B8cXo4K2hrORdH3NTJima385f53s7P+jx4WoUgBc+7evEvmvacy4ux6XD9qvVqX3/lPFfTnTE44DqiupFeupI6FHwE/phOGMsECsxY0dG9sYz8n/i0bkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYnE1KuV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYnE1KuV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752828397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rkeF+nsoMc+ORIFDqLpObr+hn2VFjp0dIELtxR6yL3M=;
	b=KYnE1KuVGqvGDlHgVXkgSkRq67WaBtprT47du9kQClmEDMCuWVkNRd98r1G+W1qy92JBXT
	9U7etjl18fZYfg0WrI/E8z2NhFXouagxbZnUAyAKJiFmetR1kCaPyW7SIWko2eQguRJpnk
	7NDUDaUzqfsbDzl2E5/QTGUeXobxc/o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-45xluW0tOSKiH4ZaZ5xffg-1; Fri, 18 Jul 2025 04:46:35 -0400
X-MC-Unique: 45xluW0tOSKiH4ZaZ5xffg-1
X-Mimecast-MFC-AGG-ID: 45xluW0tOSKiH4ZaZ5xffg_1752828394
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455e9daab1cso4442395e9.1
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 01:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752828394; x=1753433194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkeF+nsoMc+ORIFDqLpObr+hn2VFjp0dIELtxR6yL3M=;
        b=UXepY+97ME5IJOBmbTEiVs/EflJ6Q72q2dejTpvlddr2Yqjx6Als6khHNvd859mTpw
         O2LKCqb83/IA0nekPRKn6wHrrPCHt1WIkb5RtMjeTeRdKa1prAMTOC3IZ6mzSq44zWDm
         xt3RqsbqQkFiW2gZCU3cVJx03zbeEWa7sZ8PQ1vDh/cJ/pHT/RocvWdjHTDI5mufcXk1
         T+3ffSb1GvyhG5DOKI7feXaKN0lXK8LoEwkRD021/ZQRTcPHfAUSEbBBUuNgcyWLWt7Z
         fPbTECYz7OKUajfBeFwV9N0vfXeQKNq5tiHoaYv418KBvwUSyHztblF6NlVhpJznnJNG
         Y4bA==
X-Forwarded-Encrypted: i=1; AJvYcCXimHKlD5QCA0gZ3a1LvFCSuFGoeR6xYIGMJ2aLBbmQ7LDQSDuXkfenJr1Q+AkpcNE/EJ5fUwXI8hCabpSYww==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXOHmNVZLLgUMePsarjYdkEZ177NF44HDP9vvdl9qyrXVnlFJh
	/COw3VcT380AfPH4FAUd3LeoUEbuNEp69/PYldp4aHH2H0RNLObTnuq3NJbFtqYfWRZdlaggIIN
	2ZdUD+pKnC5UMrCsFelFJfL6j4jkqjPVqb7DT2t0KnxhBepoCYlGc9gZF0pPD5huATS5M
X-Gm-Gg: ASbGncv/gVBVDrxfGDXSLfiWE7KT2rXGYRVlRjLcBKBW6JQTqSgxmIHhFZF4q7iTsdq
	tr5TtsXGXbKYMUl9iv9CgOVOorzp5+UvT4U4tsgY10Fh5wXcQHj8bwK1x7ehkq3dCUnYkjmKNp8
	4+p6wVvOreqN7aueNIjL2C9p0MmN+0OxPgTCBJh9PfFu8n7hHgCqsBolpLR+mTnriovjSlakXgi
	6GVxI3OjajDaD9Q1OAvCVpAeddQxHSj4Hbk/wMuIyzBp0Ge+fsml1OAhjg53O1M7coR+mvWKQw+
	y+2JBG/2+xGBAHepiUybJqO4TCf3SUOY
X-Received: by 2002:a05:600c:858c:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-4562eb80e1amr73843945e9.18.1752828394209;
        Fri, 18 Jul 2025 01:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb0v+11O9uf8A2xcoCsT2S4EzSLGXQb/NNOjAvXhk/EXicJpFoz89yfB5M5Pnh1eYcicC6ww==
X-Received: by 2002:a05:600c:858c:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-4562eb80e1amr73843765e9.18.1752828393748;
        Fri, 18 Jul 2025 01:46:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886113sm73530615e9.23.2025.07.18.01.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:46:33 -0700 (PDT)
Date: Fri, 18 Jul 2025 04:46:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/9] virtio_ring: constify virtqueue pointer for DMA
 helpers
Message-ID: <20250718044623-mutt-send-email-mst@kernel.org>
References: <20250718023758.36866-1-jasowang@redhat.com>
 <20250718023758.36866-2-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250718023758.36866-2-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: osWoEuyul3RxwvbjJdipOZby3szc06OIgk039iixZTA_1752828394
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 18, 2025 at 10:37:50AM +0800, Jason Wang wrote:
> This patch consities virtqueue point for DMA helpers.

point -> pointer

> 
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
> 2.42.0

