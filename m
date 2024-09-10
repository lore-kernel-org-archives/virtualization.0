Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7931A38EE
	for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006200; cv=pass; b=o8B8eoiBFTr54TXo2wRQ630TXgnx8j2W0hyiik56lm/WwOTMuUfhFTzA1uBfhs0h6fyGjRWhf+UT15AwlsVuyde+fM3m19tM0Q0SglfnxrtjLzImCR8SFSa1Wdt6C+qUhNAHg1HYLuLVxC3NsVUqhOlga3knKzB/MEiIPIZWtm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006200; c=relaxed/simple;
	bh=XBHjHgTsKvy/tpSrHqFIYKe8uMvqIUEyLJ74S0H/OAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T7fwKF70HRt9QRLqyXyUewGDswwh3VVYxnZO0c2HXSqbsEdyoWfOUq/U2Sa4zyUaV4DczWbI6KzI6TlPR39YPQ3mOOrCqXJs/AQ9ylQMqhIgZ4JgjR0DDec3c0CeKnMcFpOr+B33DrEEkFsWQq00ba2izpqjsI10Uq98gh54GxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=C/din1z5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="C/din1z5"
ARC-Seal: i=1; a=rsa-sha256; t=1726006191; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V2vIcpcIauuUp5+xPbBnNJLpD4oJamgM3B3c/BfWWjH3f1WrPnHdy9dFEVdzEBONBb5/9fQPtGkNmZXLYa07fcxzeNVuLciCx8UZvsOBk4bSrKm5CSHvRlJcdtkRTjEYxMLhCZTtKrLDSINek1pFuC5gQfzfONT1JyucVwsqJNo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726006191; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=xZrAGWr1vgflX2NJ6oEKbznz0eNRLLJeiY/3xI8KYt0=; 
	b=IR9GPDs7+Ft5mTARLTAxAy70I6IWAeLLIAO3Xf0duuZmwCuoSD9tzAWJSPD2EyRsN6RqnEVmZOp/NK8S5VCM7mj+4vjUPTuh4OH9iLNFkx/ubsi94/afhQ0KZASBJJ4rtrX6MzcjgpZ10sP0ibzY+XYf4eBwR8tTEVuG2fHiREM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726006191;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=xZrAGWr1vgflX2NJ6oEKbznz0eNRLLJeiY/3xI8KYt0=;
	b=C/din1z5WK8a0WJ56TVzsud50b3zdn0lazw8gBbx2Zgb3uMmFADHZ0apvGeFtYjG
	aGLsGJQtnmjfq9iHqEdyN+brZ4EqZCkEKNPbr7QJeTMzxAos/OTvwjDuKBGLcePcfbW
	9ZTtb0OM5UAe6CCx2PenIbSEWNV2cnF1kZqlaaVs=
Received: by mx.zohomail.com with SMTPS id 1726006189098665.9031583467041;
	Tue, 10 Sep 2024 15:09:49 -0700 (PDT)
Message-ID: <dc88e7b9-ff0d-4405-88d1-bd94df550ae7@collabora.com>
Date: Wed, 11 Sep 2024 01:09:44 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/virtio: Defer the host dumb buffer creation
To: Jocelyn Falempe <jfalempe@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
References: <20240903075414.297622-1-jfalempe@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240903075414.297622-1-jfalempe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/3/24 10:48, Jocelyn Falempe wrote:
> The host dumb buffer command needs a format, but the
> DRM_IOCTL_MODE_CREATE_DUMB only provides a buffer size.
> So wait for the DRM_IOCTL_MODE_ADDFB(2), to get the format, and create
> the host resources at this time.
> 
> This will allow virtio-gpu to support multiple pixel formats.
> 
> This problem was noticed in commit 42fd9e6c29b39 ("drm/virtio: fix
> DRM_FORMAT_* handling")
> 
> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
> 
> v2:
>  * Move virtio_gpu_object deferred field to its own block (Geerd Hoffmann)
>  * Check that the size of the dumb buffer can hold the framebuffer (Geerd Hoffmann)
> 
>  drivers/gpu/drm/virtio/virtgpu_display.c | 33 ++++++++++++++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_drv.h     |  5 ++++
>  drivers/gpu/drm/virtio/virtgpu_gem.c     |  1 -
>  drivers/gpu/drm/virtio/virtgpu_object.c  | 13 +++++++---
>  4 files changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 64baf2f22d9f0..5e8ca742c6d00 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -290,6 +290,30 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
>  	return 0;
>  }
>  
> +static int virtio_gpu_deferred_create(struct virtio_gpu_object *bo,
> +				      struct virtio_gpu_device *vgdev,
> +				      const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	struct virtio_gpu_object_params params = { 0 };
> +
> +	params.format = virtio_gpu_translate_format(mode_cmd->pixel_format);
> +	params.dumb = true;
> +	params.width = mode_cmd->width;
> +	params.height = mode_cmd->height;
> +	params.size = params.height * params.width * 4;
> +	params.size = ALIGN(params.size, PAGE_SIZE);
> +
> +	if (params.size > bo->base.base.size)
> +		return -EINVAL;
> +
> +	virtio_gpu_cmd_create_resource(vgdev, bo, &params, NULL, NULL);
> +	virtio_gpu_object_attach(vgdev, bo, bo->ents, bo->nents);
> +
> +	bo->deferred = false;
> +	bo->ents = NULL;
> +	return 0;
> +}
> +
>  static struct drm_framebuffer *
>  virtio_gpu_user_framebuffer_create(struct drm_device *dev,
>  				   struct drm_file *file_priv,
> @@ -297,6 +321,8 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
>  {
>  	struct drm_gem_object *obj = NULL;
>  	struct virtio_gpu_framebuffer *virtio_gpu_fb;
> +	struct virtio_gpu_device *vgdev = dev->dev_private;
> +	struct virtio_gpu_object *bo;
>  	int ret;
>  
>  	if (mode_cmd->pixel_format != DRM_FORMAT_HOST_XRGB8888 &&
> @@ -308,6 +334,13 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
>  	if (!obj)
>  		return ERR_PTR(-EINVAL);
>  
> +	bo = gem_to_virtio_gpu_obj(obj);
> +	if (bo->deferred) {
> +		ret = virtio_gpu_deferred_create(bo, vgdev, mode_cmd);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
>  	virtio_gpu_fb = kzalloc(sizeof(*virtio_gpu_fb), GFP_KERNEL);
>  	if (virtio_gpu_fb == NULL) {
>  		drm_gem_object_put(obj);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 64c236169db88..4302933e5067c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -95,6 +95,11 @@ struct virtio_gpu_object {
>  	bool host3d_blob, guest_blob;
>  	uint32_t blob_mem, blob_flags;
>  
> +	/* For deferred dumb buffer creation */
> +	bool deferred;
> +	struct virtio_gpu_mem_entry *ents;
> +	unsigned int nents;
> +
>  	int uuid_state;
>  	uuid_t uuid;
>  };
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index 7db48d17ee3a8..33ad15fed30f6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -75,7 +75,6 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
>  	args->size = pitch * args->height;
>  	args->size = ALIGN(args->size, PAGE_SIZE);
>  
> -	params.format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);

This will break the guest blob code path in virtio_gpu_object_create(),
AFAICT.

>  	params.width = args->width;
>  	params.height = args->height;
>  	params.size = args->size;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index c7e74cf130221..b5a537a761294 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -67,6 +67,8 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
>  
>  	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
>  	if (virtio_gpu_is_shmem(bo)) {
> +		if (bo->deferred)
> +			kvfree(bo->ents);
>  		drm_gem_shmem_free(&bo->base);
>  	} else if (virtio_gpu_is_vram(bo)) {
>  		struct virtio_gpu_object_vram *vram = to_virtio_gpu_vram(bo);
> @@ -228,10 +230,13 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  		virtio_gpu_cmd_resource_create_3d(vgdev, bo, params,
>  						  objs, fence);
>  		virtio_gpu_object_attach(vgdev, bo, ents, nents);
> -	} else {
> -		virtio_gpu_cmd_create_resource(vgdev, bo, params,
> -					       objs, fence);
> -		virtio_gpu_object_attach(vgdev, bo, ents, nents);
> +	} else if (params->dumb) {
> +		/* Create the host resource in virtio_gpu_user_framebuffer_create()
> +		 * because the pixel format is not specified yet
> +		 */
> +		bo->ents = ents;
> +		bo->nents = nents;
> +		bo->deferred = true;
>  	}

AFAICS, the "params.dumb = true" should be set in
virtio_gpu_mode_dumb_create() and not in virtio_gpu_deferred_create().
Was this patch tested?

Overall, this deferred resource creation doesn't look robust. Could be
better to either add SET_SCANOUT2 with the format info or add cmd that
overrides the res fmt.

