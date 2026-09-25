Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BA93C10B4;
	Fri, 25 Sep 2026 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790355871; cv=none; b=kBKT4B/9bUziBNUuS5jjQv/uPDRlA3yn5H/XPiI0sXIg/vk6NfaRDn2mEYTAXbUqXg8UwTSaQOSWTpD27t51wBTu/lOQkj7rQRMeG/YanNXEYl4r+BtNa8R83vNCWJsD8XwnSPLVIuKFcd94chW8RFGIJ+hS/Rzs/fsYnWQcFKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790355871; c=relaxed/simple;
	bh=jPLLY2BrYbgNqdqFARIQtvrfPnO5z4wvgcSZNOEkVQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ln0UcCJs/22O5W7DI4l0EjxUHydwf1DHumPwzurzWAhRRdo3fCg8GfMHqa6h26JmTdIGOrwkpChz+c7VAZdZIoDnqwPUr6x0/gzdwD3vW41W++qvkNbuPvIKezDFlyvSGfwkglaqFoTbQMh1IBzKTw9bxLbKu9QzDIx95Xqko4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KAfTxDax; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KAfTxDax"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFDB3169C;
	Fri, 25 Sep 2026 10:04:18 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF5643F86F;
	Fri, 25 Sep 2026 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790355862; bh=jPLLY2BrYbgNqdqFARIQtvrfPnO5z4wvgcSZNOEkVQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KAfTxDaxKQmkcBPHmSs7wQdRMXMBcC55T1LyUpYi7m5SXeGhjch0z54DLPAIKa/E/
	 FKETnmIIgGFBTAmxg5jyyllD9wx9563hJw2lKt4QuRM54F8E5D2BgiCy03BXjIBc1K
	 sRwOg3Cbo7jeOxOvUbqFuLm919Mk/KuTFKSPXdHs=
Message-ID: <741cd763-8c15-436f-9810-fbbdb78b4eb2@arm.com>
Date: Fri, 25 Sep 2026 18:03:59 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/12] remoteproc: virtio: add bounce buffering for
 data buffers
To: Francesco Valla <francesco@valla.it>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Mark Brown
 <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, virtualization@lists.linux.dev,
 imx@lists.linux.dev, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-6-dac8c5eb4aa9@valla.it>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260916-remoteproc_virtio_map-v1-6-dac8c5eb4aa9@valla.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/09/2026 10:10 pm, Francesco Valla wrote:
> Depending on the driver originating them, data buffers used for virtio
> communication can either:
> 
>    - already be allocated from the coherent memory area that is
>      accessible by the remote processor; this is the case of rpmsg
>      and the rproc flavor of virtio-console;
>    - be allocated from generic kmem, and thus not accessible directly by
>      the remote processor.
> 
> Exploiting the map operations, which are used by the virtio framework
> when VIRTIO_F_ACCESS_PLATFORM is part of a vdev's feature flags, add
> bounce buffering for the second case: when the map() callback is called
> for a buffer, one or more pages of coherent memory are allocated and
> data is copied to them, then they are exposed to the remote processor;
> the data is  then bounced back on unmap().
> 
> The first case is not impacted, since buffers already suitable for
> remote transmission are passed through.
> 
> With the bounce buffering in place, any kind of virtio device can be
> supported through the remoteproc-virtio transport, at least from a
> data exchange standpoint.
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>   drivers/remoteproc/remoteproc_virtio.c | 182 +++++++++++++++++++++++++++++++--
>   include/linux/remoteproc.h             |  14 +++
>   2 files changed, 190 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index cfd66d9d1c9e..d21b3b8044df 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -241,7 +241,14 @@ static void rproc_virtio_reset(struct virtio_device *vdev)
>   	dev_dbg(&vdev->dev, "reset !\n");
>   }
>   
> -/* provide the vdev features as retrieved from the firmware */
> +/* Provide the vdev features as retrieved from the firmware, plus the following
> + * additional ones:
> + *   - VIRTIO_F_VERSION_1 that is required by some non-rpmsg virtio devices
> + *   - VIRTIO_F_ACCESS_PLATFORM to force usage of the map operations
> + */
> +#define RPROC_VIRTIO_STATIC_FEATURES \
> +	((1ULL << VIRTIO_F_VERSION_1) | (1ULL << VIRTIO_F_ACCESS_PLATFORM))
> +
>   static u64 rproc_virtio_get_features(struct virtio_device *vdev)
>   {
>   	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
> @@ -249,7 +256,7 @@ static u64 rproc_virtio_get_features(struct virtio_device *vdev)
>   
>   	rsc = (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
>   
> -	return rsc->dfeatures | (1ULL << VIRTIO_F_VERSION_1);
> +	return rsc->dfeatures | RPROC_VIRTIO_STATIC_FEATURES;
>   }
>   
>   static void rproc_transport_features(struct virtio_device *vdev)
> @@ -275,16 +282,16 @@ static int rproc_virtio_finalize_features(struct virtio_device *vdev)
>   	/* Give virtio_rproc a chance to accept features. */
>   	rproc_transport_features(vdev);
>   
> -	/* Make sure we don't have any features > 32 bits except VIRTIO_F_VERSION_1 */
> +	/* Make sure we don't have any features > 32 bits */
>   	if (WARN_ON_ONCE((u32)vdev->features !=
> -			 (vdev->features & ~(1ULL << VIRTIO_F_VERSION_1))))
> +			 (vdev->features & ~RPROC_VIRTIO_STATIC_FEATURES)))
>   		return -1;
>   
>   	/*
>   	 * Remember the finalized features of our vdev, and provide it
>   	 * to the remote processor once it is powered on.
>   	 */
> -	rsc->gfeatures = vdev->features & ~(1ULL << VIRTIO_F_VERSION_1);
> +	rsc->gfeatures = vdev->features & ~RPROC_VIRTIO_STATIC_FEATURES;
>   
>   	return 0;
>   }
> @@ -337,6 +344,151 @@ static const struct virtio_config_ops rproc_virtio_config_ops = {
>   	.set		= rproc_virtio_set,
>   };
>   
> +static inline unsigned int rproc_virtio_bounce_slot(struct device *dma_dev,
> +						    dma_addr_t dma_handle)
> +{
> +	const dma_addr_t dma_base = dma_dev_coherent_base(dma_dev);
> +
> +	return (dma_handle - dma_base) >> PAGE_SHIFT;
> +}
> +
> +static dma_addr_t rproc_virtio_map_page(union virtio_map map, struct page *page,
> +					unsigned long offset, size_t size,
> +					enum dma_data_direction dir,
> +					unsigned long attrs)
> +{
> +	struct device *dev = map.dma_dev;
> +	struct rproc_vdev *rvdev = dev_get_drvdata(dev);
> +	dma_addr_t dma_base = dma_dev_coherent_base(dev);
> +	size_t dma_size = dma_dev_coherent_size(dev);
> +	phys_addr_t paddr = page_to_phys(page) + offset;
> +	void *vaddr = page_to_virt(page) + offset;
> +	struct rproc_map_record *record;
> +	dma_addr_t map_handle;
> +	void *bounce;
> +
> +	// No need to allocate a bounce buffer if the memory to map is already
> +	// part of the device's coherent pool.
> +	if (paddr >= dma_base && paddr < (dma_base + dma_size)) {
> +		// The allocation details will be recorded also in this case,
> +		// indicating that no bounce buffer was allocated.
> +		map_handle = (dma_addr_t)paddr;
> +		bounce = NULL;
> +	} else {
> +		// Allocate bounce buffer from device coherent memory
> +		bounce = dma_alloc_coherent(dev, size, &map_handle, GFP_KERNEL | __GFP_ZERO);
> +		if (!bounce)
> +			return DMA_MAPPING_ERROR;
> +
> +		// Copy data to bounce buffer
> +		memcpy(bounce, vaddr, size);
> +	}
> +
> +	// Save bounce details
> +	record = &rvdev->map_records[rproc_virtio_bounce_slot(dev, map_handle)];
> +
> +	record->original = vaddr;
> +	record->size = size;
> +	record->bounce = bounce;
> +
> +	return map_handle;
> +}
> +
> +static void rproc_virtio_unmap_page(union virtio_map map, dma_addr_t map_handle,
> +				    size_t size, enum dma_data_direction dir,
> +				    unsigned long attrs)
> +{
> +	struct device *dev = map.dma_dev;
> +	struct rproc_vdev *rvdev = dev_get_drvdata(dev);
> +	unsigned int slot = rproc_virtio_bounce_slot(dev, map_handle);
> +	struct rproc_map_record *record = &rvdev->map_records[slot];
> +
> +	WARN_ON(size != record->size);
> +
> +	// If a bounce buffer was used, copy data back to original one
> +	if (record->bounce) {
> +		memcpy(record->original, record->bounce, record->size);
> +
> +		dma_free_coherent(dev, record->size, record->bounce, map_handle);
> +	}
> +
> +	record->original = NULL;
> +	record->size = 0;
> +	record->bounce = NULL;
> +}
> +
> +static void rproc_virtio_sync_single_for_cpu(union virtio_map map,
> +					     dma_addr_t map_handle,
> +					     size_t size,
> +					     enum dma_data_direction dir)
> +{
> +	struct device *dev = map.dma_dev;
> +
> +	dma_sync_single_range_for_cpu(dev, (map_handle & PAGE_MASK),
> +				      offset_in_page(map_handle), size, dir);

Also note that this seems massively wrong anyway - it's invalid to call 
dma_sync_* on sometning that hasn't come from the corresponding 
dma_map_* operation; it's defintiely invalid to use any streaming DMA 
operation at all on remapped non-kernel memory; but above all else, this 
clearly *isn't* copying any data from your bounce buffer to the original 
location (or vice verse in for_device), which is what the sync ops would 
actually need to do.

Letting the existing restricted DMA code do all the hard work for you is 
definitely the way to go...

Thanks,
Robin.

> +}
> +
> +static void rproc_virtio_sync_single_for_device(union virtio_map map,
> +						dma_addr_t map_handle,
> +						size_t size,
> +						enum dma_data_direction dir)
> +{
> +	struct device *dev = map.dma_dev;
> +
> +	dma_sync_single_range_for_device(dev, (map_handle & PAGE_MASK),
> +					 offset_in_page(map_handle), size, dir);
> +}
> +
> +static void *rproc_virtio_alloc(union virtio_map map, size_t size,
> +				dma_addr_t *map_handle, gfp_t gfp)
> +{
> +	struct device *dev = map.dma_dev;
> +
> +	return dma_alloc_coherent(dev, size, map_handle, gfp);
> +}
> +
> +static void rproc_virtio_free(union virtio_map map, size_t size, void *vaddr,
> +			      dma_addr_t map_handle, unsigned long attrs)
> +{
> +	struct device *dev = map.dma_dev;
> +
> +	dma_free_coherent(dev, size, vaddr, map_handle);
> +}
> +
> +static bool rproc_virtio_need_sync(union virtio_map map, dma_addr_t map_handle)
> +{
> +	struct device *dev = map.dma_dev;
> +
> +	return dma_need_sync(dev, map_handle);
> +}
> +
> +static int rproc_virtio_mapping_error(union virtio_map map, dma_addr_t map_handle)
> +{
> +	if (unlikely(map_handle == DMA_MAPPING_ERROR))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static inline size_t rproc_virtio_max_mapping_size(union virtio_map map)
> +{
> +	struct device *dev = map.dma_dev;
> +
> +	return dma_dev_coherent_size(dev);
> +}
> +
> +static const struct virtio_map_ops rproc_virtio_map_ops = {
> +	.map_page = rproc_virtio_map_page,
> +	.unmap_page = rproc_virtio_unmap_page,
> +	.sync_single_for_cpu = rproc_virtio_sync_single_for_cpu,
> +	.sync_single_for_device = rproc_virtio_sync_single_for_device,
> +	.alloc = rproc_virtio_alloc,
> +	.free = rproc_virtio_free,
> +	.need_sync = rproc_virtio_need_sync,
> +	.mapping_error = rproc_virtio_mapping_error,
> +	.max_mapping_size = rproc_virtio_max_mapping_size,
> +};
> +
>   /*
>    * This function is called whenever vdev is released, and is responsible
>    * to decrement the remote processor's refcount which was taken when vdev was
> @@ -355,6 +507,8 @@ static void rproc_virtio_dev_release(struct device *dev)
>   	of_reserved_mem_device_release(&rvdev->pdev->dev);
>   	dma_release_coherent_memory(&rvdev->pdev->dev);
>   
> +	kvfree(rvdev->map_records);
> +
>   	put_device(&rvdev->pdev->dev);
>   }
>   
> @@ -429,13 +583,29 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>   		of_reserved_mem_device_init_by_idx(dev, np, 0);
>   	}
>   
> +	/* Allocate one tracking record for each page of the device reserved
> +	 * memory. Contiguous memory is not required for this array, which can
> +	 * also be quite big (depending on the size of the coherent memory), so
> +	 * let's use vmalloc for this allocation.
> +	 */
> +	rvdev->map_records = kvcalloc(dma_dev_coherent_size(dev) >> PAGE_SHIFT,
> +				      sizeof(*rvdev->map_records),
> +				      GFP_KERNEL);
> +	if (!rvdev->map_records) {
> +		dev_err(dev, "failed to allocate memory for map records\n");
> +		return -ENOMEM;
> +	}
> +
>   	/* Allocate virtio device */
>   	vdev = kzalloc_obj(*vdev);
> -	if (!vdev)
> +	if (!vdev) {
> +		kvfree(rvdev->map_records);
>   		return -ENOMEM;
> +	}
>   
>   	vdev->id.device = id;
>   	vdev->config = &rproc_virtio_config_ops;
> +	vdev->map = &rproc_virtio_map_ops;
>   	vdev->dev.parent = dev;
>   	vdev->dev.release = rproc_virtio_dev_release;
>   
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index c3ba51fe9e54..2ff48b505ac0 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -339,10 +339,23 @@ struct rproc_vring {
>   	struct virtqueue *vq;
>   };
>   
> +/**
> + * struct rproc_map_record - remoteproc map record
> + * @original:	original virtual address
> + * @num: allocation size
> + * @bounce: bounce buffer virtual address (NULL if not used)
> + */
> +struct rproc_map_record {
> +	void *original;
> +	size_t size;
> +	void *bounce;
> +};
> +
>   /**
>    * struct rproc_vdev - remoteproc state for a supported virtio device
>    * @subdev: handle for registering the vdev as a rproc subdevice
>    * @pdev: remoteproc virtio platform device
> + * @map_records: array of map records
>    * @id: virtio device id (as in virtio_ids.h)
>    * @node: list node
>    * @rproc: the rproc handle
> @@ -358,6 +371,7 @@ struct rproc_vdev {
>   	unsigned int id;
>   	struct list_head node;
>   	struct rproc *rproc;
> +	struct rproc_map_record *map_records;
>   	u32 rsc_offset;
>   	u32 index;
>   	unsigned int num_vrings;
> 

