Return-Path: <SRS0=HmZx=FP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F68DC433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 10:01:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1602E23F2A
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 10:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1602E23F2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 92A8485FA2;
	Fri, 11 Dec 2020 10:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NoOnZ6-i7gP8; Fri, 11 Dec 2020 10:01:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B8EC685F9D;
	Fri, 11 Dec 2020 10:01:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0C4DC0893;
	Fri, 11 Dec 2020 10:01:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34D8AC013B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 10:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EE91B22C44
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 10:01:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Thsi2xw5wGL
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 10:01:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by silver.osuosl.org (Postfix) with ESMTPS id D8A0E21537
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 10:01:38 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id e25so8003981wme.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 02:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=jbjl1ZlExzCwMHGpPXNkC2g7mm31mtkBQeG1+wsOfxU=;
 b=LbzPRN+b+ddEAv23qlDjHVxf0JqjMCWjU4QB5uwn/vYN5jbVxfLguOAclpvcssSjhB
 DN8VKBDrLMWw+uj5Qb0y/5UQfUypYPDkXnrwsz1XxKC5DeLGuEOJ74oY8MUXBxVCKrwH
 vyH9zW8PlCDhU4uSpvqV2DMun43J/RZjOExzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jbjl1ZlExzCwMHGpPXNkC2g7mm31mtkBQeG1+wsOfxU=;
 b=sLJzRIqQ73ig4svbbBxv/ydMeG0S/TNdK1MfYRdhGt/5VOVmS1UEWTIvAdrUcpvEEb
 Pj26pIKMnHY+L4V5l9vYd9LmT1DYGAiHoTzBQg1miR2xxzix+B4bZ7rFBHcT5cAyfFwX
 qjb50H7wo7uDYQfSQsWnjaaVZe51HQoGR8fiRlIwTRpa/+O3pR7oG2UKqUnbdL90Jss7
 cSH2HbJJosoz1xivaJGEuui6gIHOWBjMylUX/ht4Z+1Hd6KYvk0UJTdRVrHeXoZR4Ja9
 HY+hxk3sq3t+zFdHN91UOINnkuJiYnShm4cZkcL50HPx4SCinShHq46HxexpvTS9+D9F
 XA0w==
X-Gm-Message-State: AOAM530bCJqC5eA3mEVizTnt5aflp4yin9q4M2sM4MotQ373p2DoEq92
 nYtnehWGQC432ovkNKfEkCjTag==
X-Google-Smtp-Source: ABdhPJyvz9U0jmBi+HnsMXiBPMv8k4UubH8hwjg3dAQP38t97jEtME+xUzC7ZmXJF0SkmmCevX9e0A==
X-Received: by 2002:a7b:cd91:: with SMTP id y17mr12278663wmj.171.1607680897299; 
 Fri, 11 Dec 2020 02:01:37 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id u3sm14184437wre.54.2020.12.11.02.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Dec 2020 02:01:36 -0800 (PST)
Date: Fri, 11 Dec 2020 11:01:34 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 8/8] drm/fb-helper: Move BO locking from DRM client to
 fbdev damage worker
Message-ID: <20201211100134.GN401619@phenom.ffwll.local>
References: <20201209142527.26415-1-tzimmermann@suse.de>
 <20201209142527.26415-9-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209142527.26415-9-tzimmermann@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: eric@anholt.net, airlied@linux.ie, sam@ravnborg.org,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, sumit.semwal@linaro.org, linaro-mm-sig@lists.linaro.org,
 hdegoede@redhat.com, daniel@ffwll.ch,
 virtualization@lists.linux-foundation.org, sean@poorly.run,
 christian.koenig@amd.com, linux-media@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Dec 09, 2020 at 03:25:27PM +0100, Thomas Zimmermann wrote:
> Fbdev emulation has to lock the BO into place while flushing the shadow
> buffer into the BO's memory. Remove any interference with pinning by
> using vmap_local functionality (instead of full vmap). This requires
> BO reservation locking in fbdev's damage worker.
> 
> The new DRM client functions for locking and vmap_local functionality
> are added for consistency with the existing style.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

The old vmap/vunmap in the client library aren't used anymore, please
delete. That will also make it clearer in the diff what's going on and
that it makes sense to have the client and fb-helper part in one patch.

With that: Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_client.c    | 91 +++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_fb_helper.c | 41 +++++++--------
>  include/drm/drm_client.h        |  4 ++
>  3 files changed, 116 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
> index ce45e380f4a2..795f5cb052ba 100644
> --- a/drivers/gpu/drm/drm_client.c
> +++ b/drivers/gpu/drm/drm_client.c
> @@ -288,6 +288,37 @@ drm_client_buffer_create(struct drm_client_dev *client, u32 width, u32 height, u
>  	return ERR_PTR(ret);
>  }
>  
> +/**
> + * drm_client_buffer_lock - Locks the DRM client buffer
> + * @buffer: DRM client buffer
> + *
> + * This function locks the client buffer by acquiring the buffer
> + * object's reservation lock.
> + *
> + * Unlock the buffer with drm_client_buffer_unlock().
> + *
> + * Returns:
> + *	0 on success, or a negative errno code otherwise.
> + */
> +int
> +drm_client_buffer_lock(struct drm_client_buffer *buffer)
> +{
> +	return dma_resv_lock(buffer->gem->resv, NULL);
> +}
> +EXPORT_SYMBOL(drm_client_buffer_lock);
> +
> +/**
> + * drm_client_buffer_unlock - Unlock DRM client buffer
> + * @buffer: DRM client buffer
> + *
> + * Unlocks a client buffer. See drm_client_buffer_lock().
> + */
> +void drm_client_buffer_unlock(struct drm_client_buffer *buffer)
> +{
> +	dma_resv_unlock(buffer->gem->resv);
> +}
> +EXPORT_SYMBOL(drm_client_buffer_unlock);
> +
>  /**
>   * drm_client_buffer_vmap - Map DRM client buffer into address space
>   * @buffer: DRM client buffer
> @@ -348,6 +379,66 @@ void drm_client_buffer_vunmap(struct drm_client_buffer *buffer)
>  }
>  EXPORT_SYMBOL(drm_client_buffer_vunmap);
>  
> +/**
> + * drm_client_buffer_vmap_local - Map DRM client buffer into address space
> + * @buffer: DRM client buffer
> + * @map_copy: Returns the mapped memory's address
> + *
> + * This function maps a client buffer into kernel address space. If the
> + * buffer is already mapped, it returns the existing mapping's address.
> + *
> + * Client buffer mappings are not ref'counted. Each call to
> + * drm_client_buffer_vmap_local() should be followed by a call to
> + * drm_client_buffer_vunmap_local(); or the client buffer should be mapped
> + * throughout its lifetime.
> + *
> + * The returned address is a copy of the internal value. In contrast to
> + * other vmap interfaces, you don't need it for the client's vunmap
> + * function. So you can modify it at will during blit and draw operations.
> + *
> + * Returns:
> + *	0 on success, or a negative errno code otherwise.
> + */
> +int
> +drm_client_buffer_vmap_local(struct drm_client_buffer *buffer, struct dma_buf_map *map_copy)
> +{
> +	struct dma_buf_map *map = &buffer->map;
> +	int ret;
> +
> +	/*
> +	 * FIXME: The dependency on GEM here isn't required, we could
> +	 * convert the driver handle to a dma-buf instead and use the
> +	 * backend-agnostic dma-buf vmap_local support instead. This would
> +	 * require that the handle2fd prime ioctl is reworked to pull the
> +	 * fd_install step out of the driver backend hooks, to make that
> +	 * final step optional for internal users.
> +	 */
> +	ret = drm_gem_vmap_local(buffer->gem, map);
> +	if (ret)
> +		return ret;
> +
> +	*map_copy = *map;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_client_buffer_vmap_local);
> +
> +/**
> + * drm_client_buffer_vunmap_local - Unmap DRM client buffer
> + * @buffer: DRM client buffer
> + *
> + * This function removes a client buffer's memory mapping. Calling this
> + * function is only required by clients that manage their buffer mappings
> + * by themselves.
> + */
> +void drm_client_buffer_vunmap_local(struct drm_client_buffer *buffer)
> +{
> +	struct dma_buf_map *map = &buffer->map;
> +
> +	drm_gem_vunmap_local(buffer->gem, map);
> +}
> +EXPORT_SYMBOL(drm_client_buffer_vunmap_local);
> +
>  static void drm_client_buffer_rmfb(struct drm_client_buffer *buffer)
>  {
>  	int ret;
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index e82db0f4e771..a56a7d9f7e35 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -399,28 +399,34 @@ static int drm_fb_helper_damage_blit(struct drm_fb_helper *fb_helper,
>  	int ret;
>  
>  	/*
> -	 * We have to pin the client buffer to its current location while
> -	 * flushing the shadow buffer. In the general case, concurrent
> -	 * modesetting operations could try to move the buffer and would
> -	 * fail. The modeset has to be serialized by acquiring the reservation
> -	 * object of the underlying BO here.
> -	 *
>  	 * For fbdev emulation, we only have to protect against fbdev modeset
>  	 * operations. Nothing else will involve the client buffer's BO. So it
>  	 * is sufficient to acquire struct drm_fb_helper.lock here.
>  	 */
>  	mutex_lock(&fb_helper->lock);
>  
> -	ret = drm_client_buffer_vmap(buffer, &map);
> +	/*
> +	 * We have to keep the client buffer at its current location while
> +	 * flushing the shadow buffer. Concurrent operations could otherwise
> +	 * try to move the buffer. Therefore acquiring the reservation
> +	 * object of the underlying BO here.
> +	 */
> +	ret = drm_client_buffer_lock(buffer);
> +	if (ret)
> +		goto out_mutex_unlock;
> +
> +	ret = drm_client_buffer_vmap_local(buffer, &map);
>  	if (ret)
> -		goto out;
> +		goto out_drm_client_buffer_unlock;
>  
>  	dst = map;
>  	drm_fb_helper_damage_blit_real(fb_helper, clip, &dst);
>  
> -	drm_client_buffer_vunmap(buffer);
> +	drm_client_buffer_vunmap_local(buffer);
>  
> -out:
> +out_drm_client_buffer_unlock:
> +	drm_client_buffer_unlock(buffer);
> +out_mutex_unlock:
>  	mutex_unlock(&fb_helper->lock);
>  
>  	return ret;
> @@ -946,15 +952,11 @@ static int setcmap_legacy(struct fb_cmap *cmap, struct fb_info *info)
>  	drm_modeset_lock_all(fb_helper->dev);
>  	drm_client_for_each_modeset(modeset, &fb_helper->client) {
>  		crtc = modeset->crtc;
> -		if (!crtc->funcs->gamma_set || !crtc->gamma_size) {
> -			ret = -EINVAL;
> -			goto out;
> -		}
> +		if (!crtc->funcs->gamma_set || !crtc->gamma_size)
> +			return -EINVAL;
>  
> -		if (cmap->start + cmap->len > crtc->gamma_size) {
> -			ret = -EINVAL;
> -			goto out;
> -		}
> +		if (cmap->start + cmap->len > crtc->gamma_size)
> +			return -EINVAL;
>  
>  		r = crtc->gamma_store;
>  		g = r + crtc->gamma_size;
> @@ -967,9 +969,8 @@ static int setcmap_legacy(struct fb_cmap *cmap, struct fb_info *info)
>  		ret = crtc->funcs->gamma_set(crtc, r, g, b,
>  					     crtc->gamma_size, NULL);
>  		if (ret)
> -			goto out;
> +			return ret;
>  	}
> -out:
>  	drm_modeset_unlock_all(fb_helper->dev);
>  
>  	return ret;
> diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
> index f07f2fb02e75..df61e339a11c 100644
> --- a/include/drm/drm_client.h
> +++ b/include/drm/drm_client.h
> @@ -156,8 +156,12 @@ struct drm_client_buffer *
>  drm_client_framebuffer_create(struct drm_client_dev *client, u32 width, u32 height, u32 format);
>  void drm_client_framebuffer_delete(struct drm_client_buffer *buffer);
>  int drm_client_framebuffer_flush(struct drm_client_buffer *buffer, struct drm_rect *rect);
> +int drm_client_buffer_lock(struct drm_client_buffer *buffer);
> +void drm_client_buffer_unlock(struct drm_client_buffer *buffer);
>  int drm_client_buffer_vmap(struct drm_client_buffer *buffer, struct dma_buf_map *map);
>  void drm_client_buffer_vunmap(struct drm_client_buffer *buffer);
> +int drm_client_buffer_vmap_local(struct drm_client_buffer *buffer, struct dma_buf_map *map);
> +void drm_client_buffer_vunmap_local(struct drm_client_buffer *buffer);
>  
>  int drm_client_modeset_create(struct drm_client_dev *client);
>  void drm_client_modeset_free(struct drm_client_dev *client);
> -- 
> 2.29.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
