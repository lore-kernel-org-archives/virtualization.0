Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656621FC3
	for <virtualization@lists.linux.dev>; Fri, 25 Jul 2025 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434046; cv=none; b=Dh+Tr3lbu8bvOXuD6mOZa00UIxB+RtvFYgiI0pVxnDttnqo9qbM6re4FVYoZwvc49tcZp15c4H3z7N4vUbSdqxvSoe8mr25oRYlymivYCdLuiGufMKpcFcvAd2w+LYFAO3fW0STgzSQRaAP8jb9B9K/bdwR9MMBgOfnuOSLZZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434046; c=relaxed/simple;
	bh=uE+t3mdbsvzbXC9K/uN0eOJrG8zPFHyIK3xQOsrdJxM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=fk2aBIvENdhiq4hHCLXcJOK33thaKMmMNr9cFkkxDUlod/pEkgw9umdY2wuQbygdEWHaVr6DA/3xSLo3i/JA6x6fuwTv56EPzj+/8h1zDP1UOfDu8kPgqtJkLOmj/CKYzuvRshfFVM12H1m3MMX7Cfa9JwpJsiuF5j3ZkBDZglA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OGs47IiG; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OGs47IiG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753434041; h=Message-ID:Subject:Date:From:To;
	bh=r5Fl0XHQI8HuTgjmkjQ70JFjFCfeBwRckQgaAChGYbc=;
	b=OGs47IiGh3Ponxm4eEqomwmlV4jO14KJ+Q6pm2k4JNY3qfR3Pnn3no4VpKiowGHJh9hmIwY67ZE8Xexi7Nvu7177ZZHUJGSSiWCbKMdEiCSC/ULkbNT2X58sz4Bby+yy19ZBMSORJt0Lc+ZaZMe1XsiW5Oa7tgtGWQFnXPusQVE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wjx1wET_1753434039 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 17:00:40 +0800
Message-ID: <1753434030.858641-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V4 1/9] virtio_ring: constify virtqueue pointer for DMA helpers
Date: Fri, 25 Jul 2025 17:00:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 hch@infradead.org,
 Christoph Hellwig <hch@lst.de>,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com
References: <20250718091616.6140-1-jasowang@redhat.com>
 <20250718091616.6140-2-jasowang@redhat.com>
In-Reply-To: <20250718091616.6140-2-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

On Fri, 18 Jul 2025 17:16:08 +0800, Jason Wang <jasowang@redhat.com> wrote:
> This patch consities virtqueue point for DMA helpers.
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
> 2.47.3
>
