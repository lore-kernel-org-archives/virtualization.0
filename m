Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C60D4317C
	for <virtualization@lists.linux.dev>; Fri, 20 Sep 2024 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726825959; cv=none; b=TM7998kafY2XK5u/er4g4zSlKo6FpwVPqzRxXj5/Q+6MCkfiy9UU1aJCDQso4Y3AgdWAMuOwRvZkSNzBGl3R6lZ8s8AQQ6QbRabAtAXKBzzk3ISXwYjS4v7ReTMpWHpEtxa4/F85xceu1JPUaBBHo3CS0L3M++wjdiAxdemcC6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726825959; c=relaxed/simple;
	bh=3knfGQ28HBWzF38hxVGalPYVLQzc2PtkhZV6x1VdsHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPJjnI/mWzDdKX3Xby31WLve7jTOPEic9PS7a41qCdMdSQHGhx1OtL7VjIIc3Q27RjBLSXj2oTZXZKEBsclduJnVlHjJl6mPioLb0YnM/v3VDxGHbdV6uOdqA10rZ0ZC12p8sUfRL7v0HosKCkUWyzQqwytivQo0B3ebIj7fleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SV6zsi1q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SV6zsi1q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726825956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HX8u2zBRCYM4paozCCp3EeYVygSoVRU5xK8tdeNsBE=;
	b=SV6zsi1q7kUnXrPyngieYa9Mq4HrOuzyjr0AJvUVPaPS631k+ssL3K9Pn5QLqBWlm0TDGe
	6s7fV2O3U7CPH+AB2ip0AAcXK6Gv/rEmTSPl5VD1rEunS419+Kbpxl6At9rL7LCcMZUeXB
	LiDLWARjX3ndolG9weds9yDed5GlR24=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-3Irwu6opNBa_J4JMr-QbAA-1; Fri, 20 Sep 2024 05:52:34 -0400
X-MC-Unique: 3Irwu6opNBa_J4JMr-QbAA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb115566eso16355885e9.2
        for <virtualization@lists.linux.dev>; Fri, 20 Sep 2024 02:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726825952; x=1727430752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HX8u2zBRCYM4paozCCp3EeYVygSoVRU5xK8tdeNsBE=;
        b=nRtsIRGOKuWPjZ5VLsNSrSej85n8rwNbmLV9JVwccO8hByunVCqfyAyYgD72EJI4CU
         ohypIkHrDsZ4sd4jCMBaiXoo2APAN9bFJ2mrfOaTWoPvADrwOYEVReiaKgo3b6ol3XgW
         SD1kDefp8H3I0Lk4GS/44aPxNsCZzCZ7iMZG9hvmIFO35d+xjAUPU7zORUqVoVqs8wut
         S9Bek18q7x6XJXCmY5hl5RPF0IuuVAnhyvcJ5bhCMvtilb7HuFtVMDtQAB3RDu+pHpdf
         zPIqboryP0fDgg+sV9/ThWB/z7dSAWnm9aFpVInbDcsYWI3zE788U5h6Z+k4sEHg2bsu
         lePA==
X-Gm-Message-State: AOJu0YwJAiuTnjMh6X6b1yOpJTUNX2ulUx7YkliXHrjanXn0cM7xqi19
	nzFGXDsgzHIHyrvBB6Mk5Pj7t2kF92QPqpHePgefy0C1XexoXD1M2kjaw549UiDNeAu8lt0V7pr
	iTbgOrjb2fc4nedQMraiBh0HvsbWBUrHxvZCCZ0YnSelQy524KOgAAYJCvzD0gyLK
X-Received: by 2002:a05:600c:34c9:b0:42c:b187:bdd5 with SMTP id 5b1f17b1804b1-42e7adc1eedmr24466405e9.22.1726825952288;
        Fri, 20 Sep 2024 02:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGXa4YcRehopFY97Iczxq4Kz35injhgvYrb9MvqjpSRsIaupPvFZ0KCokY1JyKo/xZ+mEWKg==
X-Received: by 2002:a05:600c:34c9:b0:42c:b187:bdd5 with SMTP id 5b1f17b1804b1-42e7adc1eedmr24466075e9.22.1726825951781;
        Fri, 20 Sep 2024 02:52:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800067sm17286425f8f.77.2024.09.20.02.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 02:52:30 -0700 (PDT)
Message-ID: <43b05945-4ff9-4782-822f-659b6c22effa@redhat.com>
Date: Fri, 20 Sep 2024 11:52:29 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/qxl: Add drm_panic support
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, airlied@redhat.com,
 kraxel@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, daniel@ffwll.ch
Cc: virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240919071230.840994-1-ryasuoka@redhat.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240919071230.840994-1-ryasuoka@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/09/2024 09:12, Ryosuke Yasuoka wrote:
> QXL supports the drm_panic module, which displays a message to the
> screen when a kernel panic occurs.

It looks good to me. I think you just need to adjust some functions 
argument indentation (tab size is 8), see below.

Best regards,

-- 

Jocelyn

> 
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
> v2
> In [1], Jocelyn gives me feedbacks and fix them.
> 1. Removing qxl_surface_evict(): It takes a mutex and it possibly
> causes deadlock in panic handler. As the panic handler works
> correctly without it and to make it simple, I remove it.
> 2. Update qxl_panic_ttm_bo_destory(): It deleted bo->list with taking
> mutex but it does not need to call because this list is not updated in
> panic handler.
> 3. Remove unnecessary args from panic functions: Some panic functions
> always take same values as args (e.g. kernel, pinned, domain etc in
> qxl_panic_bo_create()). So I remove them from panic functions and
> define them in each function.
> 
> [1] https://lore.kernel.org/dri-devel/89b55f6f-f462-4e84-b2e2-7f2edc0f1cc4@redhat.com/T/#t
> 
>   drivers/gpu/drm/qxl/qxl_cmd.c     | 29 ++++++++++
>   drivers/gpu/drm/qxl/qxl_display.c | 94 +++++++++++++++++++++++++++++++
>   drivers/gpu/drm/qxl/qxl_draw.c    | 57 ++++++++++++++++++-
>   drivers/gpu/drm/qxl/qxl_drv.h     | 22 ++++++++
>   drivers/gpu/drm/qxl/qxl_gem.c     |  9 +++
>   drivers/gpu/drm/qxl/qxl_image.c   | 25 ++++++++
>   drivers/gpu/drm/qxl/qxl_object.c  | 46 +++++++++++++++
>   drivers/gpu/drm/qxl/qxl_object.h  |  1 +
>   8 files changed, 282 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
> index d6ea01f3797b..895e41c1a567 100644
> --- a/drivers/gpu/drm/qxl/qxl_cmd.c
> +++ b/drivers/gpu/drm/qxl/qxl_cmd.c
> @@ -174,6 +174,35 @@ static bool qxl_ring_pop(struct qxl_ring *ring,
>   	return true;
>   }
>   
> +/* For drm panic */
> +int
> +qxl_push_command_ring_without_release(struct qxl_device *qdev,
> +		struct qxl_bo *bo, uint32_t offset)
> +{
> +	struct qxl_command cmd;
> +	struct qxl_ring *ring = qdev->command_ring;
> +	struct qxl_ring_header *header = &(ring->ring->header);
> +	uint8_t *elt;
> +	int idx;
> +
> +	cmd.type = QXL_CMD_DRAW;
> +	cmd.data = qxl_bo_physical_address(qdev, bo, offset);
> +
> +	idx = header->prod & (ring->n_elements - 1);
> +	elt = ring->ring->elements + idx * ring->element_size;
> +
> +	memcpy((void *)elt, &cmd, ring->element_size);
> +
> +	header->prod++;
> +
> +	mb();
> +
> +	if (header->prod == header->notify_on_prod)
> +		outb(0, ring->prod_notify);
> +
> +	return 0;
> +}
> +
>   int
>   qxl_push_command_ring_release(struct qxl_device *qdev, struct qxl_release *release,
>   			      uint32_t type, bool interruptible)
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index bc24af08dfcd..b80cb8879215 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -37,6 +37,7 @@
>   #include <drm/drm_probe_helper.h>
>   #include <drm/drm_simple_kms_helper.h>
>   #include <drm/drm_gem_atomic_helper.h>
> +#include <drm/drm_panic.h>
>   
>   #include "qxl_drv.h"
>   #include "qxl_object.h"
> @@ -889,6 +890,97 @@ static void qxl_plane_cleanup_fb(struct drm_plane *plane,
>   	}
>   }
>   
> +static int qxl_primary_plane_helper_get_scanout_buffer(struct drm_plane *plane,
> +							struct drm_scanout_buffer *sb)
> +{
> +	struct qxl_bo *bo;
> +
> +	if (!plane->state || !plane->state->fb)
> +		return -ENODEV;
> +
> +	bo = gem_to_qxl_bo(plane->state->fb->obj[0]);
> +
> +	if (!bo->map.vaddr) {
> +		int ret;
> +
> +		ret = qxl_bo_pin_and_vmap(bo, &sb->map[0]);
> +		if (ret)
> +			return ret;
> +	} else {
> +		iosys_map_set_vaddr(&sb->map[0], bo->map.vaddr);
> +	}
> +
> +	sb->format = plane->state->fb->format;
> +	sb->height = plane->state->fb->height;
> +	sb->width = plane->state->fb->width;
> +	sb->pitch[0] = plane->state->fb->pitches[0];
> +	return 0;
> +}
> +
> +static void qxl_panic_flush(struct drm_plane *plane)
> +{
> +	struct qxl_device *qdev = to_qxl(plane->dev);
> +	struct qxl_bo *_bo = gem_to_qxl_bo(plane->state->fb->obj[0]);
> +	uint8_t *surface_base = _bo->map.vaddr;
> +	struct drm_clip_rect rect = {
> +		.x1 = 0,
> +		.y1 = 0,
> +		.x2 = plane->state->fb->width,
> +		.y2 = plane->state->fb->height
> +	};
> +	unsigned int num_clips = 1;
> +	struct qxl_bo clips_bo = {};
> +	struct qxl_bo image_bo = {};
> +	struct qxl_bo chunk_bo = {};
> +	struct qxl_drm_image dimage;
> +	struct qxl_drm_chunk chunk;
> +	int width = rect.x2;
> +	int height = rect.y2;
> +	int stride = plane->state->fb->pitches[0];
> +	int depth = plane->state->fb->format->cpp[0] * 8;
> +	struct qxl_rect *rects;
> +	struct qxl_rect drawable_rect = {
> +		.left = 0,
> +		.right = width,
> +		.top = 0,
> +		.bottom = height,
> +	};
> +	int cur_idx = 0;
> +	int size = 256;
> +	struct qxl_bo *bo = qxl_bo_ref(qdev->current_release_bo[cur_idx]);
> +	uint32_t offset = qdev->current_release_bo_offset[cur_idx] * size;
> +	int ret;
> +
> +	qxl_panic_bo_create(qdev, sizeof(struct qxl_clip_rects) + sizeof(struct qxl_rect),
> +			&clips_bo);
> +
> +	ret = qxl_image_alloc_objects_without_release(qdev, &dimage, &chunk, &image_bo, &chunk_bo,
> +			surface_base, width, height, depth, stride);
> +	if (ret)
> +		return;
> +
> +	ret = make_drawable_without_release(qdev, &drawable_rect, bo, &clips_bo,
> +			&dimage, offset, height, width);
> +	if (ret)
> +		return;
> +
> +	rects = drawable_set_clipping(qdev, num_clips, &clips_bo);
> +	if (!rects)
> +		return;
> +	rects[0].left = 0;
> +	rects[0].right = width;
> +	rects[0].top = 0;
> +	rects[0].bottom = height;
> +
> +	qxl_push_command_ring_without_release(qdev, bo, offset);
> +
> +	qxl_panic_gem_object_free(&chunk_bo.tbo.base);
> +	qxl_panic_gem_object_free(&image_bo.tbo.base);
> +
> +	qxl_bo_vunmap_locked(&clips_bo);
> +	qxl_panic_gem_object_free(&clips_bo.tbo.base);
> +}
> +
>   static const uint32_t qxl_cursor_plane_formats[] = {
>   	DRM_FORMAT_ARGB8888,
>   };
> @@ -920,6 +1012,8 @@ static const struct drm_plane_helper_funcs primary_helper_funcs = {
>   	.atomic_disable = qxl_primary_atomic_disable,
>   	.prepare_fb = qxl_plane_prepare_fb,
>   	.cleanup_fb = qxl_plane_cleanup_fb,
> +	.get_scanout_buffer = qxl_primary_plane_helper_get_scanout_buffer,
> +	.panic_flush = qxl_panic_flush,
>   };
>   
>   static const struct drm_plane_funcs qxl_primary_plane_funcs = {
> diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
> index 3a3e127ce297..49fdc0162377 100644
> --- a/drivers/gpu/drm/qxl/qxl_draw.c
> +++ b/drivers/gpu/drm/qxl/qxl_draw.c
> @@ -41,7 +41,8 @@ static int alloc_clips(struct qxl_device *qdev,
>   /* returns a pointer to the already allocated qxl_rect array inside
>    * the qxl_clip_rects. This is *not* the same as the memory allocated
>    * on the device, it is offset to qxl_clip_rects.chunk.data */
> -static struct qxl_rect *drawable_set_clipping(struct qxl_device *qdev,
> +
> +struct qxl_rect *drawable_set_clipping(struct qxl_device *qdev,
>   					      unsigned int num_clips,
>   					      struct qxl_bo *clips_bo)

Function's arguments indentation should be adjusted here.

>   {
> @@ -74,6 +75,60 @@ free_drawable(struct qxl_device *qdev, struct qxl_release *release)
>   	qxl_release_free(qdev, release);
>   }
>   
> +/* For drm panic */
> +int
> +make_drawable_without_release(struct qxl_device *qdev,
> +		struct qxl_rect *drawable_rect,
> +		struct qxl_bo *bo,
> +		struct qxl_bo *clips_bo,
> +		struct qxl_drm_image *dimage,
> +		uint32_t offset, int height, int width)

Here too, they don't match the open parenthesis, like the other function 
in this file.

> +{
> +	struct qxl_drawable *drawable;
> +	union qxl_release_info *info;
> +	void *ptr;
> +	int i;
> +
> +	ptr = qxl_bo_kmap_atomic_page(qdev, bo, offset & PAGE_MASK);
> +	if (!ptr)
> +		return -ENOMEM;
> +	drawable = ptr + (offset & ~PAGE_MASK);
> +
> +	drawable->type = QXL_DRAW_COPY;
> +	drawable->surface_id = 0;
> +	drawable->effect = QXL_EFFECT_OPAQUE;
> +	drawable->self_bitmap = 0;
> +	drawable->self_bitmap_area.top = 0;
> +	drawable->self_bitmap_area.left = 0;
> +	drawable->self_bitmap_area.bottom = 0;
> +	drawable->self_bitmap_area.right = 0;
> +
> +	for (i = 0; i < 3; ++i)
> +		drawable->surfaces_dest[i] = -1;
> +
> +	drawable->bbox = *drawable_rect;
> +	drawable->mm_time = qdev->rom->mm_clock;
> +	drawable->clip.type = SPICE_CLIP_TYPE_RECTS;
> +	drawable->clip.data = qxl_bo_physical_address(qdev, clips_bo, 0);
> +	drawable->u.copy.src_area.top = 0;
> +	drawable->u.copy.src_area.bottom = height;
> +	drawable->u.copy.src_area.left = 0;
> +	drawable->u.copy.src_area.right = width;
> +	drawable->u.copy.rop_descriptor = SPICE_ROPD_OP_PUT;
> +	drawable->u.copy.scale_mode = 0;
> +	drawable->u.copy.mask.flags = 0;
> +	drawable->u.copy.mask.pos.x = 0;
> +	drawable->u.copy.mask.pos.y = 0;
> +	drawable->u.copy.mask.bitmap = 0;
> +	drawable->u.copy.src_bitmap = qxl_bo_physical_address(qdev, dimage->bo, 0);
> +
> +	info = &drawable->release_info;
> +	ptr = ((void *)info) - (offset & ~PAGE_MASK);
> +	qxl_bo_kunmap_atomic_page(qdev, bo, ptr);
> +
> +	return 0;
> +}
> +
>   /* release needs to be reserved at this point */
>   static int
>   make_drawable(struct qxl_device *qdev, int surface, uint8_t type,
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
> index 32069acd93f8..ffeafb5b73ef 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.h
> +++ b/drivers/gpu/drm/qxl/qxl_drv.h
> @@ -309,6 +309,7 @@ int qxl_gem_object_create_with_handle(struct qxl_device *qdev,
>   				      struct qxl_surface *surf,
>   				      struct drm_gem_object **gobj,
>   				      uint32_t *handle);
> +void qxl_panic_gem_object_free(struct drm_gem_object *gobj);
>   void qxl_gem_object_free(struct drm_gem_object *gobj);
>   int qxl_gem_object_open(struct drm_gem_object *obj, struct drm_file *file_priv);
>   void qxl_gem_object_close(struct drm_gem_object *obj,
> @@ -334,6 +335,13 @@ int qxl_image_init(struct qxl_device *qdev,
>   		   const uint8_t *data,
>   		   int x, int y, int width, int height,
>   		   int depth, int stride);
> +
> +int qxl_image_alloc_objects_without_release(struct qxl_device *qdev,
> +		struct qxl_drm_image *image, struct qxl_drm_chunk *chunk,
> +		struct qxl_bo *image_bo, struct qxl_bo *chunk_bo,
> +		uint8_t *surface_base, int width,
> +		int height, int depth, int stride);
> +
>   int
>   qxl_image_alloc_objects(struct qxl_device *qdev,
>   			struct qxl_release *release,
> @@ -376,6 +384,9 @@ int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
>   			       int type, struct qxl_release **release,
>   			       struct qxl_bo **rbo);
>   
> +int qxl_push_command_ring_without_release(struct qxl_device *qdev,
> +		struct qxl_bo *bo, uint32_t offset);
> +
>   int
>   qxl_push_command_ring_release(struct qxl_device *qdev, struct qxl_release *release,
>   			      uint32_t type, bool interruptible);
> @@ -387,6 +398,9 @@ int qxl_alloc_bo_reserved(struct qxl_device *qdev,
>   			  unsigned long size,
>   			  struct qxl_bo **_bo);
>   /* qxl drawing commands */
> +struct qxl_rect *drawable_set_clipping(struct qxl_device *qdev,
> +					      unsigned int num_clips,
> +					      struct qxl_bo *clips_bo);
>   
>   void qxl_draw_dirty_fb(struct qxl_device *qdev,
>   		       struct drm_framebuffer *fb,
> @@ -399,6 +413,14 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
>   void qxl_release_free(struct qxl_device *qdev,
>   		      struct qxl_release *release);
>   
> +int
> +make_drawable_without_release(struct qxl_device *qdev,
> +		struct qxl_rect *drawable_rect,
> +		struct qxl_bo *bo,
> +		struct qxl_bo *clips_bo,
> +		struct qxl_drm_image *dimage,
> +		uint32_t offset, int height, int width);
> +
>   /* used by qxl_debugfs_release */
>   struct qxl_release *qxl_release_from_id_locked(struct qxl_device *qdev,
>   						   uint64_t id);
> diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.c
> index fc5e3763c359..f140439c640a 100644
> --- a/drivers/gpu/drm/qxl/qxl_gem.c
> +++ b/drivers/gpu/drm/qxl/qxl_gem.c
> @@ -28,6 +28,15 @@
>   #include "qxl_drv.h"
>   #include "qxl_object.h"
>   
> +void qxl_panic_gem_object_free(struct drm_gem_object *gobj)
> +{
> +	struct qxl_bo *qobj = gem_to_qxl_bo(gobj);
> +	struct ttm_buffer_object *tbo;
> +
> +	tbo = &qobj->tbo;
> +	ttm_bo_put(tbo);
> +}
> +
>   void qxl_gem_object_free(struct drm_gem_object *gobj)
>   {
>   	struct qxl_bo *qobj = gem_to_qxl_bo(gobj);
> diff --git a/drivers/gpu/drm/qxl/qxl_image.c b/drivers/gpu/drm/qxl/qxl_image.c
> index ffff54e5fb31..064dfdc3f722 100644
> --- a/drivers/gpu/drm/qxl/qxl_image.c
> +++ b/drivers/gpu/drm/qxl/qxl_image.c
> @@ -52,6 +52,31 @@ qxl_allocate_chunk(struct qxl_device *qdev,
>   	return 0;
>   }
>   
> +/* For drm panic */
> +int
> +qxl_image_alloc_objects_without_release(struct qxl_device *qdev,
> +		struct qxl_drm_image *image, struct qxl_drm_chunk *chunk,
> +		struct qxl_bo *image_bo, struct qxl_bo *chunk_bo,
> +		uint8_t *surface_base, int width, int height,
> +		int depth, int stride)
> +{
> +	int ret;
> +	unsigned int chunk_size = sizeof(struct qxl_data_chunk) + stride * height;
> +
> +	INIT_LIST_HEAD(&image->chunk_list);
> +	qxl_panic_bo_create(qdev, sizeof(struct qxl_image), image_bo);
> +	image->bo = image_bo;
> +
> +	qxl_panic_bo_create(qdev, chunk_size, chunk_bo);
> +	chunk->bo = chunk_bo;
> +	list_add_tail(&chunk->head, &image->chunk_list);
> +
> +	ret = qxl_image_init(qdev, NULL, image, surface_base,
> +			     0, 0, width, height, depth, stride);
> +	return ret;
> +
> +}
> +
>   int
>   qxl_image_alloc_objects(struct qxl_device *qdev,
>   			struct qxl_release *release,
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
> index 66635c55cf85..22aa16ed0685 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -29,6 +29,16 @@
>   #include "qxl_drv.h"
>   #include "qxl_object.h"
>   
> +/* for drm panic */
> +static void qxl_panic_ttm_bo_destroy(struct ttm_buffer_object *tbo)
> +{
> +	struct qxl_bo *bo;
> +
> +	bo = to_qxl_bo(tbo);
> +	WARN_ON_ONCE(bo->map_count > 0);
> +	drm_gem_object_release(&bo->tbo.base);
> +}
> +
>   static void qxl_ttm_bo_destroy(struct ttm_buffer_object *tbo)
>   {
>   	struct qxl_bo *bo;
> @@ -101,6 +111,42 @@ static const struct drm_gem_object_funcs qxl_object_funcs = {
>   	.print_info = drm_gem_ttm_print_info,
>   };
>   
> +/* for drm_panic */
> +int qxl_panic_bo_create(struct qxl_device *qdev, unsigned long size, struct qxl_bo *bo)
> +{
> +	u32 domain = QXL_GEM_DOMAIN_VRAM;
> +	struct ttm_operation_ctx ctx = { true, false };
> +	enum ttm_bo_type type;
> +	int r;
> +
> +	type = ttm_bo_type_device;
> +
> +	size = roundup(size, PAGE_SIZE);
> +	r = drm_gem_object_init(&qdev->ddev, &bo->tbo.base, size);
> +	if (unlikely(r))
> +		return r;
> +	bo->tbo.base.funcs = &qxl_object_funcs;
> +	bo->type = domain;
> +	bo->surface_id = 0;
> +	INIT_LIST_HEAD(&bo->list);
> +
> +	qxl_ttm_placement_from_domain(bo, domain);
> +
> +	bo->tbo.priority = 0;
> +	r = ttm_bo_init_reserved(&qdev->mman.bdev, &bo->tbo, type,
> +				 &bo->placement, 0, &ctx, NULL, NULL,
> +				 &qxl_panic_ttm_bo_destroy);
> +	if (unlikely(r != 0)) {
> +		if (r != -ERESTARTSYS)
> +			dev_err(qdev->ddev.dev,
> +				"object_init failed for (%lu, 0x%08X)\n",
> +				size, domain);
> +		return r;
> +	}
> +	ttm_bo_unreserve(&bo->tbo);
> +	return 0;
> +}
> +
>   int qxl_bo_create(struct qxl_device *qdev, unsigned long size,
>   		  bool kernel, bool pinned, u32 domain, u32 priority,
>   		  struct qxl_surface *surf,
> diff --git a/drivers/gpu/drm/qxl/qxl_object.h b/drivers/gpu/drm/qxl/qxl_object.h
> index 875f63221074..d1dbf7a3dd5b 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.h
> +++ b/drivers/gpu/drm/qxl/qxl_object.h
> @@ -53,6 +53,7 @@ static inline unsigned long qxl_bo_size(struct qxl_bo *bo)
>   	return bo->tbo.base.size;
>   }
>   
> +extern int qxl_panic_bo_create(struct qxl_device *qdev, unsigned long size, struct qxl_bo *bo);
>   extern int qxl_bo_create(struct qxl_device *qdev,
>   			 unsigned long size,
>   			 bool kernel, bool pinned, u32 domain,

