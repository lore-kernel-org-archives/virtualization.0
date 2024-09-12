Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38DE17DFF5
	for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726180420; cv=none; b=H1Qp1eR+3DLOE+enmmJTmgPe60BxdYo9kyo7Wb/l03aXPjNuQnjbs0GC30sLJqCHZszEvV6FPaSuoL9ypwaCBH5twsZoHMbvK/BA8ME4ZXcTZs7hcqOlhycjPwIMuAf4QJCYkllPVrw/PDdU1xre5Tpr+lQLWxTT2oaFRs8Ynwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726180420; c=relaxed/simple;
	bh=u8Slg3KTL8RqyWu/DaAAc7Er53ufMBkqCZro6FXPm04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAouvlbAxDKbVWU9bR3svd8cC7HhjDdlb40x6ub/YFN3mkTYhREZ1xmxMb3jzeQU6HQ84FXOphO7TVPkHJAvYdVvFU3sXRA8vbnKRY5gAnhJBlBGW9nRoz7nKQCfT/jrqiTTmG9U6bqzqzI4r+PmqSeLAbV5CsuaZKSF+1crALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBOF3mbp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBOF3mbp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726180416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSco5FHgL7se8dgu4QfULMlQ/zF8R9+5LSuJG3cYoyI=;
	b=HBOF3mbpQHNNPBbg8s/37r3KU6+tYgQAbPGmpMi2YXfEKtDT8hhfeoZRp0HiFFw7mEDTx5
	t3hOIy/219xDbgIKIXXOfDBDiSyJ1z84sBHvTROtcYfVQ9gpNJUXLj9e1If4nGM3kqgUmP
	2SF26Zo+rVEAoPLfImyVqUdi6kkzo+s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-gPKqfW0yP7-CXYH-mZGijg-1; Thu, 12 Sep 2024 18:33:33 -0400
X-MC-Unique: gPKqfW0yP7-CXYH-mZGijg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cdeac2da6so9757075e9.2
        for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 15:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726180412; x=1726785212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSco5FHgL7se8dgu4QfULMlQ/zF8R9+5LSuJG3cYoyI=;
        b=dIBpZSDZn8xyweDNReOGqEQv2sRaD3K654JSf/eTyZQrCCSSaKafFCelz3hcr6oc7d
         FLAfCf519Dcc4BrbVIKh0cwpE+Mk1pQ9r/UZULCl+iyqLnZo/XcykBxYju4dkiZLByul
         ui80I9ua1V2mg8F/RzQdO843xnVbetJ9tdaI2iHtgM1xatd84gy3mOb1m7fRw/C/GcZL
         gK3+U6Ddb9WYe0U5bwm3s8xj2gC/+dcLoSLc13nCm3pBmJLaVJ/U87Lj0BeDBHHOFywR
         YUxtlIkjSeUPyTeSYYOVL0egSdxb5/l7PG30oss2seYSLVk5yyWFVT4ArP00UJytFPTK
         L1Nw==
X-Gm-Message-State: AOJu0Yx3sbiAF/FKv8NUQXoq0ulvUycaSNVLu+meED6Tu6DaNG2FSsVZ
	N+ZRA5OT4YcDGjx/7zt0ZvDQq2XqocKfpKOT5GybVJWl1nN5aNe7Wd02nHsyPSkzlPI0KKjG9Eg
	MAWwljuQ1TD8GcvtTZ3Dz9j8fxjjtXsmyCcPXOx08kmqVlHFwRuZb5Gv5oG6XY7xo
X-Received: by 2002:a7b:c394:0:b0:42c:df54:18ec with SMTP id 5b1f17b1804b1-42cdf541c13mr30226025e9.28.1726180412005;
        Thu, 12 Sep 2024 15:33:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmdIhSdmXtYVIoWYdE8/Hcsa3vnU6dyUFU+jpebvq0opR/rB3J+ska5bMZSTTBLgIsaRLSew==
X-Received: by 2002:a7b:c394:0:b0:42c:df54:18ec with SMTP id 5b1f17b1804b1-42cdf541c13mr30225835e9.28.1726180411384;
        Thu, 12 Sep 2024 15:33:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675c1dsm15337153f8f.58.2024.09.12.15.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 15:33:30 -0700 (PDT)
Message-ID: <89b55f6f-f462-4e84-b2e2-7f2edc0f1cc4@redhat.com>
Date: Fri, 13 Sep 2024 00:33:29 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/qxl: Add drm_panic support
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, airlied@redhat.com,
 kraxel@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, daniel@ffwll.ch
Cc: virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240912093024.661498-1-ryasuoka@redhat.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240912093024.661498-1-ryasuoka@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/09/2024 11:30, Ryosuke Yasuoka wrote:
> QXL supports the drm_panic module, which displays a message to the
> screen when a kernel panic occurs.

Thanks a lot for this work, one more driver that will handle drm_panic.

I have a few comments below, but from drm_panic point of view, it looks 
already pretty good.

-- 

Jocelyn

> 
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
> Sorry for sending similar mails again and again. Please ignore the
> following my mails. Let me add dri-devel mailing list and Jocelyn who
> developped a drm_panic core and look forward to your comments on this
> mail.
> 
> https://lore.kernel.org/all/20240911094644.616280-1-ryasuoka@redhat.com/T/#u
> https://lore.kernel.org/all/20240911101043.618043-1-ryasuoka@redhat.com/T/#u
> 
>   
>   drivers/gpu/drm/qxl/qxl_cmd.c     | 29 ++++++++++
>   drivers/gpu/drm/qxl/qxl_display.c | 94 +++++++++++++++++++++++++++++++
>   drivers/gpu/drm/qxl/qxl_draw.c    | 57 ++++++++++++++++++-
>   drivers/gpu/drm/qxl/qxl_drv.h     | 21 +++++++
>   drivers/gpu/drm/qxl/qxl_image.c   | 27 +++++++++
>   drivers/gpu/drm/qxl/qxl_object.c  | 62 ++++++++++++++++++++
>   drivers/gpu/drm/qxl/qxl_object.h  |  4 ++
>   7 files changed, 293 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
> index d6ea01f3797b..c70041ce55c0 100644
> --- a/drivers/gpu/drm/qxl/qxl_cmd.c
> +++ b/drivers/gpu/drm/qxl/qxl_cmd.c
> @@ -174,6 +174,35 @@ static bool qxl_ring_pop(struct qxl_ring *ring,
>   	return true;
>   }
>   
> +/* For drm panic */
> +int
> +qxl_push_command_ring_without_release(struct qxl_device *qdev,
> +		struct qxl_bo *bo, uint32_t type, uint32_t offset)
> +{
> +	struct qxl_command cmd;
> +	struct qxl_ring *ring = qdev->command_ring;
> +	struct qxl_ring_header *header = &(ring->ring->header);
> +	uint8_t *elt;
> +	int idx;
> +
> +	cmd.type = type;
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
> index bc24af08dfcd..b5f2ddfe71a9 100644
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
> +			false, false, QXL_GEM_DOMAIN_VRAM, 0, NULL, &clips_bo);
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
> +	qxl_push_command_ring_without_release(qdev, bo, QXL_CMD_DRAW, offset);
> +
> +	qxl_gem_object_free(&chunk_bo.tbo.base);
> +	qxl_gem_object_free(&image_bo.tbo.base);
> +
> +	qxl_bo_vunmap_locked(&clips_bo);
> +	qxl_gem_object_free(&clips_bo.tbo.base);
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
> index 32069acd93f8..93dd0de06c23 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.h
> +++ b/drivers/gpu/drm/qxl/qxl_drv.h
> @@ -334,6 +334,13 @@ int qxl_image_init(struct qxl_device *qdev,
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
> @@ -376,6 +383,9 @@ int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
>   			       int type, struct qxl_release **release,
>   			       struct qxl_bo **rbo);
>   
> +int qxl_push_command_ring_without_release(struct qxl_device *qdev,
> +		struct qxl_bo *bo, uint32_t type, uint32_t offset);
> +
>   int
>   qxl_push_command_ring_release(struct qxl_device *qdev, struct qxl_release *release,
>   			      uint32_t type, bool interruptible);
> @@ -387,6 +397,9 @@ int qxl_alloc_bo_reserved(struct qxl_device *qdev,
>   			  unsigned long size,
>   			  struct qxl_bo **_bo);
>   /* qxl drawing commands */
> +struct qxl_rect *drawable_set_clipping(struct qxl_device *qdev,
> +					      unsigned int num_clips,
> +					      struct qxl_bo *clips_bo);
>   
>   void qxl_draw_dirty_fb(struct qxl_device *qdev,
>   		       struct drm_framebuffer *fb,
> @@ -399,6 +412,14 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
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
> diff --git a/drivers/gpu/drm/qxl/qxl_image.c b/drivers/gpu/drm/qxl/qxl_image.c
> index ffff54e5fb31..2efe0cf133a6 100644
> --- a/drivers/gpu/drm/qxl/qxl_image.c
> +++ b/drivers/gpu/drm/qxl/qxl_image.c
> @@ -52,6 +52,33 @@ qxl_allocate_chunk(struct qxl_device *qdev,
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
> +	qxl_panic_bo_create(qdev, sizeof(struct qxl_image), false, false,
> +			QXL_GEM_DOMAIN_VRAM, 0, NULL, image_bo);
> +	image->bo = image_bo;
> +
> +	qxl_panic_bo_create(qdev, chunk_size, false, false,
> +			QXL_GEM_DOMAIN_VRAM, 0, NULL, chunk_bo);
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
> index 66635c55cf85..9e00700f8f03 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -29,6 +29,23 @@
>   #include "qxl_drv.h"
>   #include "qxl_object.h"
>   
> +/* for drm panic */
> +static void qxl_panic_ttm_bo_destroy(struct ttm_buffer_object *tbo)
> +{
> +	struct qxl_bo *bo;
> +	struct qxl_device *qdev;
> +
> +	bo = to_qxl_bo(tbo);
> +	qdev = to_qxl(bo->tbo.base.dev);
> +
> +	qxl_surface_evict(qdev, bo, false);

qxl_surface_evict() takes a mutex, so we should avoid to call it.
It may leak things, but it's still better than deadlocking in the panic 
handler.

> +	WARN_ON_ONCE(bo->map_count > 0);
> +	mutex_lock(&qdev->gem.mutex);
> +	list_del_init(&bo->list);
> +	mutex_unlock(&qdev->gem.mutex);

I think you don't need to remove it from the list. It's added in 
qxl_gem_object_create(), which I don't see it being called in the panic 
flush function. (But this is something you can check to make sure).

> +	drm_gem_object_release(&bo->tbo.base);
> +}
> +
>   static void qxl_ttm_bo_destroy(struct ttm_buffer_object *tbo)
>   {
>   	struct qxl_bo *bo;
> @@ -101,6 +118,51 @@ static const struct drm_gem_object_funcs qxl_object_funcs = {
>   	.print_info = drm_gem_ttm_print_info,
>   };
>   
> +/* for drm_panic */
> +int qxl_panic_bo_create(struct qxl_device *qdev, unsigned long size,
> +		  bool kernel, bool pinned, u32 domain, u32 priority,
> +		  struct qxl_surface *surf, struct qxl_bo *bo)
> +{

All caller to qxl_panic_bo_create() have a priority of 0, and surf set 
to NULL, they also have kernel and pinned set to false.
So you can remove them from the argument list, and simplify this 
function a bit. There are probably other parameters that can be omitted 
like this, in the other "panic" functions.


> +	struct ttm_operation_ctx ctx = { !kernel, false };
> +	enum ttm_bo_type type;
> +	int r;
> +
> +	if (kernel)
> +		type = ttm_bo_type_kernel;
> +	else
> +		type = ttm_bo_type_device;
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
> +	if (surf)
> +		bo->surf = *surf;
> +
> +	qxl_ttm_placement_from_domain(bo, domain);
> +
> +	bo->tbo.priority = priority;
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
> +	if (pinned)
> +		ttm_bo_pin(&bo->tbo);
> +	ttm_bo_unreserve(&bo->tbo);
> +	return 0;
> +}
> +
>   int qxl_bo_create(struct qxl_device *qdev, unsigned long size,
>   		  bool kernel, bool pinned, u32 domain, u32 priority,
>   		  struct qxl_surface *surf,
> diff --git a/drivers/gpu/drm/qxl/qxl_object.h b/drivers/gpu/drm/qxl/qxl_object.h
> index 875f63221074..4debb8ce6d08 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.h
> +++ b/drivers/gpu/drm/qxl/qxl_object.h
> @@ -53,6 +53,10 @@ static inline unsigned long qxl_bo_size(struct qxl_bo *bo)
>   	return bo->tbo.base.size;
>   }
>   
> +extern int qxl_panic_bo_create(struct qxl_device *qdev, unsigned long size,
> +		  bool kernel, bool pinned, u32 domain, u32 priority,
> +		  struct qxl_surface *surf,
> +		  struct qxl_bo *bo);
>   extern int qxl_bo_create(struct qxl_device *qdev,
>   			 unsigned long size,
>   			 bool kernel, bool pinned, u32 domain,

