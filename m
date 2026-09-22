Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC20556BB1
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092740; cv=none; b=Sxzf33aYT5RD7xGTTM8BKf/JK6YiQP4M3Hm7WCWD2NbJ/FxybbxxOl9jun/mvUtfqX2lPG3ssOki++anMSIe8h/eOKBYH36J88S5p3YUk14odRiCgm36p6/Rh933z0kpFId+rNxXxsVfY3/9edfBliUEqQDqbJJd9w6xLgFN59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092740; c=relaxed/simple;
	bh=gG7zDAdUxNJ/zpdch7xDafxgraNooHMFV+xhtJLfxfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuIX0pg5H2p01zECQ+DH21i1Vwp4+2wlCyLxC3WZZTU+c3ywIcmyY86MGl5S3yD6ArRxgtNHBJr3OzpF74rX0zJeD4Q1RgmC+ydq/q/GU5wUeQaVoRyH4WDWFNSzrpeXBd+DDMqmPf7WANHhooHpGh7wBb21ZvFJEYUoeG0yMxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IUkZ0Wlg; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUkZ0Wlg"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db18fe459dso26749225ad.3
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 08:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790092737; x=1790697537; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ne0KgVwwcVPPJwmaYq2AHxStqJShN32EZv44sO80Yy0=;
        b=IUkZ0WlgPiR8vVN/m6xnAVoKtQWEAzVo2+rGgNPPhl/ZVPGBVbJ21gwFJukOKWPqpz
         yKm5GVvhpq1geOautp+ImFdm3osrCTdWAttVoNF0pr3eLQR6jZackb21X7qgRaVSIfOO
         Ue/hCSqRGWP6bkY/7OXP008zweXHYDQlIMcrJ9B1Xz1J58niQXAW+LTQaju9ieVpKf8j
         IjvYHean9XdvMrHP3V4BYPf6sUX2lq/4GhPg5Iaq6mjnUCnL18nBcm5H64NY6C6Q1/Qy
         3wywbe3USXm7Bh4vslIMxwBNLoHpLv2Wx3FrK0LOotzIWuNvfacWHXci+48j5EBD5sAB
         SyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092737; x=1790697537;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ne0KgVwwcVPPJwmaYq2AHxStqJShN32EZv44sO80Yy0=;
        b=JXSOfb4kt0MQcNx1V5ySoPGAl8ZYu3bv+yWfOngCsf6D0BSCTmEP/hVpLv77D9gA/d
         udeSn58asKZb/z6OkliRwHKtG9pxqnYSZC2RQ17wroYh0vz68LoChTj0ITdW1UwXJbOR
         6VgdOJKtMBxRnGSsSd1U5GYRmpVRDw8ak2oOGfDXgC1B+XAWUqf5SrktRq3TC4b7xBW9
         f3qm9QAlAwIm9aR24tu7yjdyDwtkUm2sjo6yiYMEi240cOweQtET1q3yvBtyeJoW0MG7
         /kRqthzArAHPp1tDbgXPVf+fCpbe450OqWIXm1vH/3rb6oQNFXXnrGNpIFXmW2NK6PJL
         njBA==
X-Forwarded-Encrypted: i=1; AKwUvByPjlSpiQkAVfY+ahmRHuuXR6H57xCoauFb7REZqLLRGuPU/ddYsuy9BSGmh1n0wE06jdn0/VSgNdH2yWHqRA==@lists.linux.dev
X-Gm-Message-State: AFuF++ll8NBzcXuv3CyfKG36iNiBAX45Z1apWF/cIVe2l+lcfJ/GWmMR
	TabBHN1WugN6immp/sckw63+WiJzUIReW6PlNnK/lW0ZJqGmWhyyycBjB+qioWVR9ME=
X-Gm-Gg: AYBFou23/ofWd//ZNeuLQ0mjQNO8UM4KrISX0eQnxrHjwRisRP6yPI30tkdg1MgA5gT
	kYCvKXsqqVIpSBrgMX5EBS1reFRuTvn1AqdtJODTyateruwGeJ4RYXHJjN7Sz4T3TFPBD8obIhl
	5OWirmpjLYtV+jOq8qwOQlOCr/2JVTWsMeUvvriec9u3isqvKQOMilM3DPTzU9Imh5i1avn/ERO
	BYkT77WgW9+tKCTv/FIpESHsYvCSTL3b9scb9hOmsTTzADA0u4tJemDwp3SF4PJcxGJiV6WAlYk
	KxDib+QuO2qOvIeYd9LC4OJCm2+kN5OxF+qV2jiASi0vVdwVRFfZTwwNdPm4WFmRldX3YAwS6Rp
	9hWoyBQ0rJyGVdxDZzF+aHxccg9VzqxkQGpChvXOSAR+l2/ZyPtG+hoXxCSL6DQP0OiZ3CuyUn2
	lnYBFDfPYHrEpLTiC2bEC29PlJViDpxZVn72+DZMRvj2YPBImeRE6XB2Aj9LQDq/SOaTSn9QkR
X-Received: by 2002:a17:903:3886:b0:2dd:c053:d73e with SMTP id d9443c01a7336-2df60b31a8amr22799845ad.37.1790092736751;
        Tue, 22 Sep 2026 08:58:56 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:1046:ab8:737c:d2e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d055a1fsm12812715ad.64.2026.09.22.08.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:58:56 -0700 (PDT)
Date: Tue, 22 Sep 2026 09:58:53 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	imx@lists.linux.dev, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 06/12] remoteproc: virtio: add bounce buffering for
 data buffers
Message-ID: <arKlvZGqu2nt6Ci0@p14s>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-6-dac8c5eb4aa9@valla.it>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-remoteproc_virtio_map-v1-6-dac8c5eb4aa9@valla.it>

On Wed, Sep 16, 2026 at 11:10:51PM +0200, Francesco Valla wrote:
> Depending on the driver originating them, data buffers used for virtio
> communication can either:
> 
>   - already be allocated from the coherent memory area that is
>     accessible by the remote processor; this is the case of rpmsg
>     and the rproc flavor of virtio-console;
>   - be allocated from generic kmem, and thus not accessible directly by
>     the remote processor.
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

Is this _necessary_ for the imx93 platform you are implementing feature for?

> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 182 +++++++++++++++++++++++++++++++--
>  include/linux/remoteproc.h             |  14 +++
>  2 files changed, 190 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index cfd66d9d1c9e..d21b3b8044df 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -241,7 +241,14 @@ static void rproc_virtio_reset(struct virtio_device *vdev)
>  	dev_dbg(&vdev->dev, "reset !\n");
>  }
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
>  static u64 rproc_virtio_get_features(struct virtio_device *vdev)
>  {
>  	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
> @@ -249,7 +256,7 @@ static u64 rproc_virtio_get_features(struct virtio_device *vdev)
>  
>  	rsc = (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
>  
> -	return rsc->dfeatures | (1ULL << VIRTIO_F_VERSION_1);
> +	return rsc->dfeatures | RPROC_VIRTIO_STATIC_FEATURES;
>  }
>  
>  static void rproc_transport_features(struct virtio_device *vdev)
> @@ -275,16 +282,16 @@ static int rproc_virtio_finalize_features(struct virtio_device *vdev)
>  	/* Give virtio_rproc a chance to accept features. */
>  	rproc_transport_features(vdev);
>  
> -	/* Make sure we don't have any features > 32 bits except VIRTIO_F_VERSION_1 */
> +	/* Make sure we don't have any features > 32 bits */
>  	if (WARN_ON_ONCE((u32)vdev->features !=
> -			 (vdev->features & ~(1ULL << VIRTIO_F_VERSION_1))))
> +			 (vdev->features & ~RPROC_VIRTIO_STATIC_FEATURES)))
>  		return -1;
>  
>  	/*
>  	 * Remember the finalized features of our vdev, and provide it
>  	 * to the remote processor once it is powered on.
>  	 */
> -	rsc->gfeatures = vdev->features & ~(1ULL << VIRTIO_F_VERSION_1);
> +	rsc->gfeatures = vdev->features & ~RPROC_VIRTIO_STATIC_FEATURES;
>  
>  	return 0;
>  }
> @@ -337,6 +344,151 @@ static const struct virtio_config_ops rproc_virtio_config_ops = {
>  	.set		= rproc_virtio_set,
>  };
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
>  /*
>   * This function is called whenever vdev is released, and is responsible
>   * to decrement the remote processor's refcount which was taken when vdev was
> @@ -355,6 +507,8 @@ static void rproc_virtio_dev_release(struct device *dev)
>  	of_reserved_mem_device_release(&rvdev->pdev->dev);
>  	dma_release_coherent_memory(&rvdev->pdev->dev);
>  
> +	kvfree(rvdev->map_records);
> +
>  	put_device(&rvdev->pdev->dev);
>  }
>  
> @@ -429,13 +583,29 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>  		of_reserved_mem_device_init_by_idx(dev, np, 0);
>  	}
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
>  	/* Allocate virtio device */
>  	vdev = kzalloc_obj(*vdev);
> -	if (!vdev)
> +	if (!vdev) {
> +		kvfree(rvdev->map_records);
>  		return -ENOMEM;
> +	}
>  
>  	vdev->id.device = id;
>  	vdev->config = &rproc_virtio_config_ops;
> +	vdev->map = &rproc_virtio_map_ops;
>  	vdev->dev.parent = dev;
>  	vdev->dev.release = rproc_virtio_dev_release;
>  
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index c3ba51fe9e54..2ff48b505ac0 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -339,10 +339,23 @@ struct rproc_vring {
>  	struct virtqueue *vq;
>  };
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
>  /**
>   * struct rproc_vdev - remoteproc state for a supported virtio device
>   * @subdev: handle for registering the vdev as a rproc subdevice
>   * @pdev: remoteproc virtio platform device
> + * @map_records: array of map records
>   * @id: virtio device id (as in virtio_ids.h)
>   * @node: list node
>   * @rproc: the rproc handle
> @@ -358,6 +371,7 @@ struct rproc_vdev {
>  	unsigned int id;
>  	struct list_head node;
>  	struct rproc *rproc;
> +	struct rproc_map_record *map_records;
>  	u32 rsc_offset;
>  	u32 index;
>  	unsigned int num_vrings;
> 
> -- 
> 2.55.0
> 
