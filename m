Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8CF3CDBD8
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710284; cv=pass; b=CWP53ank7XQozm4o9HVuAK+KMis4vYD8hlqQHNem3FT7FcZb9FoqEDcI7olnZ0BNpWAdK7Q7GGEETRm5+vxQY9Wby/GqprrZi+u3XVHxHAo/ncZLBDv6lZ9641V+up58hKemtgDZu31CCv7909rdfR36rrBIFQURJXrWDHglKF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710284; c=relaxed/simple;
	bh=/bqKGyIPeubYkSgZk34fsooAYDeCACSv3mGOGMDEtNY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NJFmtxtw3mV2337Fi5vsERhsugsavgDDzWnRMBj7/pDPnRbg3P8QwVTcaqq6U871BbTQ9OqfWU0RT3H8uwynozIxUB0wbAVwpmctuutTNvB+BnwyQcYphXyZofTJ9cyNBFR45CpoWBeP5X7ulxe9i+ZACTm3/S6BQ36QHlhbJLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=PhoABMFY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="PhoABMFY"
ARC-Seal: i=1; a=rsa-sha256; t=1778710254; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kFljbuvpV4epFUawsak7ZSItkFX5IsO3UR87Fh2IgaeBUxt2RVOrNp4SsGNarm1dn7U+cG38YoRdUUmQgd7QlfuF+hTuq5PA2enJ/oTmWDMgzP7VD6uHXTCS4fA7cCAp2pOlowm8UiQB3MKZ7mlgeKwKWqQ2BT/X0sn0JP3CqOU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778710254; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=H66DJfTkzSFXK5GN5OZ2jS7pJA/U3BZtWdfWJMHG7FI=; 
	b=RyF/UBmkk6rghU+EMzKrN8z75wv+tvR0nf7uZh33vaUo2UYk6KdpgRS4YVx3dMma2BBV/JC0rpmdKVyMj7h60wGtsL03Sy3xWBc/lSBi88RF3FBcMGJRb4XrGU/B0up41Nn9C1hEeszRbcS2j0rOBA+FoPjD5+VUmeb8MVMR4Rs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778710254;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=H66DJfTkzSFXK5GN5OZ2jS7pJA/U3BZtWdfWJMHG7FI=;
	b=PhoABMFYuXpDQjW/CK40/Km2TEebbMpr2Nb9mdG8XUKibnTQRRA2y54SyqIbid+z
	6jTCOHlZ41G/IgLuzcKpXpFjJVKvmVrTrseCPrv5esWDwGPkIwTJm6ExLAYdOFHfWme
	ahFFUN0izX/WkudQatSRGbat4TtguQ15BpiwB46s=
Received: by mx.zohomail.com with SMTPS id 1778710252955760.417482599686;
	Wed, 13 May 2026 15:10:52 -0700 (PDT)
Message-ID: <1efb8795-3345-46ae-8195-1b391159b90b@collabora.com>
Date: Thu, 14 May 2026 01:10:48 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: Extend blob UAPI with deferred-mapping
 hinting
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Nagapuri Ramesh <ram.nagapuri@gmail.com>
References: <20260501000043.2483678-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20260501000043.2483678-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 5/1/26 03:00, Dmitry Osipenko wrote:
> If userspace never maps GEM object, then BO wastes hostmem space
> because VirtIO-GPU driver maps VRAM BO at the BO's creating time.
> 
> Make mappings on-demand by adding new RESOURCE_CREATE_BLOB IOCTL/UAPI
> hinting flag telling that host mapping should be deferred until first
> mapping is made when the flag is set by userspace.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Reviewed-by: Rob Clark <robdclark@gmail.com>
> ---
> 
> Changelog:
> 
> v2: Rebased on recent kernel. Intel i915 native ctx landed to Mesa, lets to
>     proceed with merging the mapping hint as a first user of the feature.
> 
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  2 ++
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c |  1 +
>  drivers/gpu/drm/virtio/virtgpu_vram.c  | 30 +++++++++++++++++++++-----
>  include/uapi/drm/virtgpu_drm.h         |  4 ++++
>  4 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index f17660a71a3e..6f49213e23f8 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -84,6 +84,7 @@ struct virtio_gpu_object_params {
>  	uint32_t blob_mem;
>  	uint32_t blob_flags;
>  	uint64_t blob_id;
> +	uint32_t blob_hints;
>  };
>  
>  struct virtio_gpu_object {
> @@ -507,6 +508,7 @@ struct sg_table *virtio_gpu_vram_map_dma_buf(struct virtio_gpu_object *bo,
>  void virtio_gpu_vram_unmap_dma_buf(struct device *dev,
>  				   struct sg_table *sgt,
>  				   enum dma_data_direction dir);
> +void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
>  
>  /* virtgpu_submit.c */
>  int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index c33c057365f8..01daa72b1310 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -489,6 +489,7 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
>  	params->size = rc_blob->size;
>  	params->blob = true;
>  	params->blob_flags = rc_blob->blob_flags;
> +	params->blob_hints = rc_blob->blob_hints;
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
> index 084e80227433..4ae3cbc35dd3 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vram.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
> @@ -3,6 +3,8 @@
>  
>  #include <linux/dma-mapping.h>
>  
> +static DEFINE_MUTEX(map_lock);
> +
>  static void virtio_gpu_vram_free(struct drm_gem_object *obj)
>  {
>  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> @@ -42,6 +44,11 @@ static int virtio_gpu_vram_mmap(struct drm_gem_object *obj,
>  	if (!(bo->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE))
>  		return -EINVAL;
>  
> +	virtio_gpu_vram_map_deferred(vram);
> +
> +	if (vram->map_state == STATE_INITIALIZING)
> +		virtio_gpu_notify(vgdev);
> +
>  	wait_event(vgdev->resp_wq, vram->map_state != STATE_INITIALIZING);
>  	if (vram->map_state != STATE_OK)
>  		return -EINVAL;
> @@ -218,14 +225,27 @@ int virtio_gpu_vram_create(struct virtio_gpu_device *vgdev,
>  
>  	virtio_gpu_cmd_resource_create_blob(vgdev, &vram->base, params, NULL,
>  					    0);
> -	if (params->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE) {
> -		ret = virtio_gpu_vram_map(&vram->base);
> -		if (ret) {
> -			virtio_gpu_vram_free(obj);
> -			return ret;
> +	if (!(params->blob_hints & DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING)) {
> +		if (params->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE) {
> +			ret = virtio_gpu_vram_map(&vram->base);
> +			if (ret) {
> +				virtio_gpu_vram_free(obj);
> +				return ret;
> +			}
>  		}
>  	}
>  
>  	*bo_ptr = &vram->base;
>  	return 0;
>  }
> +
> +void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram)
> +{
> +	if (!(vram->base.blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE))
> +		return;
> +
> +	mutex_lock(&map_lock);
> +	if (!drm_mm_node_allocated(&vram->vram_node))
> +		virtio_gpu_vram_map(&vram->base);
> +	mutex_unlock(&map_lock);
> +}
> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> index 9debb320c34b..ba09a4ee3e77 100644
> --- a/include/uapi/drm/virtgpu_drm.h
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -200,6 +200,10 @@ struct drm_virtgpu_resource_create_blob {
>  	__u32 cmd_size;
>  	__u64 cmd;
>  	__u64 blob_id;
> +
> +#define DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING        0x0001
> +	__u32 blob_hints;
> +	__u32 pad2;
>  };
>  
>  #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001

Applied patch to misc-next

-- 
Best regards,
Dmitry
