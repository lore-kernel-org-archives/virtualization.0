Return-Path: <SRS0=HmZx=FP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E579FC4167B
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 09:29:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D84E23F37
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 09:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D84E23F37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DA07586FD2;
	Fri, 11 Dec 2020 09:29:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pK3WAbDqLKXr; Fri, 11 Dec 2020 09:29:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A253986FB8;
	Fri, 11 Dec 2020 09:29:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9155FC0893;
	Fri, 11 Dec 2020 09:29:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 017A2C013B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 09:29:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DBAC187271
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 09:29:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IIWjX2bdp9Ih
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 09:29:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A4A4087268
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 09:29:53 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id t16so8289668wra.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 01:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nFEF2mgC+Rn2Wc0pNzn/tnOs6sHnOKs8QYhmKDalNZ4=;
 b=hbONVG1yKLfcEGEJhYSenaLWC3u8SAxMzwmjHFtf28xmXgu7kJnbyB6V76zVlnmu3e
 otsusXvrpccg+Ssw4m0Yjs1DjplxRlaG459z8saoKxJ62Njg6hxMCPy8Y9lCxJKiFGKw
 3Qm54oqhC/HqqXVTtXqKeITDqaUqRdP7nhi38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nFEF2mgC+Rn2Wc0pNzn/tnOs6sHnOKs8QYhmKDalNZ4=;
 b=L+8hncFK3HiZAuZmb4LcIwDSPCcalpC0jBAPodmntj6u3QIIzPdXM7gd7v1lZjozIK
 wLKY6NdRK1nP1pMjCFjtFqkPNLKBGIeN9n+1Tk8eK7urQp7/I551+h2JUuani1vzWPhF
 6GWBHjM6XamfkQpzytR9/i8e+44Ua34qmgFjlkjBdLMK8uMuVl7tzWvHJTQ7rd0KP3N3
 Jobz9EAjq8vuSoyqQP86HSMXwX9nD696BKdv9KFIyFRMbb3Sf6jotM7pMMXLYmuEowIc
 zBxZgHbLDqI10Xiecb+sOgFwNWE7Z7Cx85c7D+2ZgJrv688gZi9krAlPfwWKztgTjOec
 rfzA==
X-Gm-Message-State: AOAM530qkKLS7+H9ugciVWTpT0dkbprJgVj7MD8UTzkKzP8mhe/E3Gbd
 +RfeOWvuXc/46S/2w+aMcjmACw==
X-Google-Smtp-Source: ABdhPJzS2sw1Ca/uzaHPWVajCEVBbdup9BR0G2+osmCm0g/pUyy+FsvXnfUqmDKrMpCAejbagLJwFA==
X-Received: by 2002:adf:a29d:: with SMTP id s29mr12698320wra.329.1607678992136; 
 Fri, 11 Dec 2020 01:29:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id k11sm13508000wmj.42.2020.12.11.01.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Dec 2020 01:29:51 -0800 (PST)
Date: Fri, 11 Dec 2020 10:29:49 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 4/8] drm/gem: Create infrastructure for GEM vmap_local
Message-ID: <20201211092949.GJ401619@phenom.ffwll.local>
References: <20201209142527.26415-1-tzimmermann@suse.de>
 <20201209142527.26415-5-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209142527.26415-5-tzimmermann@suse.de>
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

On Wed, Dec 09, 2020 at 03:25:23PM +0100, Thomas Zimmermann wrote:
> This patch adds vmap_local and vunmap_local to struct drm_gem_object_funcs;
> including the PRIME helpers to connect with dma-buf's related interfaces.
> 
> Besides the generic DRM core, this will become relevant for fbdev emulation
> with virtio, so we update it as well.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_gem.c              | 28 ++++++++++++++++++
>  drivers/gpu/drm/drm_internal.h         |  2 ++
>  drivers/gpu/drm/drm_prime.c            | 39 ++++++++++++++++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_prime.c |  2 ++
>  include/drm/drm_gem.h                  | 20 +++++++++++++
>  include/drm/drm_prime.h                |  2 ++
>  6 files changed, 93 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 92f89cee213e..6e131d9bb7bd 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1234,6 +1234,34 @@ void drm_gem_vunmap(struct drm_gem_object *obj, struct dma_buf_map *map)
>  	dma_buf_map_clear(map);
>  }
>  
> +int drm_gem_vmap_local(struct drm_gem_object *obj, struct dma_buf_map *map)
> +{
> +	int ret;
> +
> +	if (!obj->funcs->vmap_local)
> +		return -EOPNOTSUPP;
> +
> +	ret = obj->funcs->vmap_local(obj, map);
> +	if (ret)
> +		return ret;
> +	else if (dma_buf_map_is_null(map))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +void drm_gem_vunmap_local(struct drm_gem_object *obj, struct dma_buf_map *map)
> +{
> +	if (dma_buf_map_is_null(map))
> +		return;
> +
> +	if (obj->funcs->vunmap_local)
> +		obj->funcs->vunmap_local(obj, map);
> +
> +	/* Always set the mapping to NULL. Callers may rely on this. */
> +	dma_buf_map_clear(map);
> +}
> +
>  /**
>   * drm_gem_lock_reservations - Sets up the ww context and acquires
>   * the lock on an array of GEM objects.
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> index 81d386b5b92a..b0bf6aba763a 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -190,6 +190,8 @@ int drm_gem_pin(struct drm_gem_object *obj);
>  void drm_gem_unpin(struct drm_gem_object *obj);
>  int drm_gem_vmap(struct drm_gem_object *obj, struct dma_buf_map *map);
>  void drm_gem_vunmap(struct drm_gem_object *obj, struct dma_buf_map *map);
> +int drm_gem_vmap_local(struct drm_gem_object *obj, struct dma_buf_map *map);
> +void drm_gem_vunmap_local(struct drm_gem_object *obj, struct dma_buf_map *map);
>  
>  /* drm_debugfs.c drm_debugfs_crc.c */
>  #if defined(CONFIG_DEBUG_FS)
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 683aa29ecd3b..633edea76985 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -695,6 +695,43 @@ void drm_gem_dmabuf_vunmap(struct dma_buf *dma_buf, struct dma_buf_map *map)
>  }
>  EXPORT_SYMBOL(drm_gem_dmabuf_vunmap);
>  
> +/**
> + * drm_gem_dmabuf_vmap_local - dma_buf vmap_local implementation for GEM
> + * @dma_buf: buffer to be mapped
> + * @map: the virtual address of the buffer
> + *
> + * Sets up a kernel virtual mapping. This can be used as the &dma_buf_ops.vmap_local
> + * callback. Calls into &drm_gem_object_funcs.vmap_local for device specific handling.
> + * The kernel virtual address is returned in map.
> + *
> + * Returns:
> + * 0 on success or a negative errno code otherwise.
> + */
> +int drm_gem_dmabuf_vmap_local(struct dma_buf *dma_buf, struct dma_buf_map *map)
> +{
> +	struct drm_gem_object *obj = dma_buf->priv;
> +
> +	return drm_gem_vmap_local(obj, map);
> +}
> +EXPORT_SYMBOL(drm_gem_dmabuf_vmap_local);
> +
> +/**
> + * drm_gem_dmabuf_vunmap_local - dma_buf vunmap_local implementation for GEM
> + * @dma_buf: buffer to be unmapped
> + * @map: the virtual address of the buffer
> + *
> + * Releases a kernel virtual mapping. This can be used as the
> + * &dma_buf_ops.vunmap_local callback. Calls into &drm_gem_object_funcs.vunmap_local
> + * for device specific handling.
> + */
> +void drm_gem_dmabuf_vunmap_local(struct dma_buf *dma_buf, struct dma_buf_map *map)
> +{
> +	struct drm_gem_object *obj = dma_buf->priv;
> +
> +	drm_gem_vunmap_local(obj, map);
> +}
> +EXPORT_SYMBOL(drm_gem_dmabuf_vunmap_local);
> +
>  /**
>   * drm_gem_prime_mmap - PRIME mmap function for GEM drivers
>   * @obj: GEM object
> @@ -787,6 +824,8 @@ static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =  {
>  	.mmap = drm_gem_dmabuf_mmap,
>  	.vmap = drm_gem_dmabuf_vmap,
>  	.vunmap = drm_gem_dmabuf_vunmap,
> +	.vmap_local = drm_gem_dmabuf_vmap_local,
> +	.vunmap_local = drm_gem_dmabuf_vunmap_local,
>  };
>  
>  /**
> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> index 807a27a16365..fea11a53d8fc 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> @@ -54,6 +54,8 @@ static const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =  {
>  		.mmap = drm_gem_dmabuf_mmap,
>  		.vmap = drm_gem_dmabuf_vmap,
>  		.vunmap = drm_gem_dmabuf_vunmap,
> +		.vmap = drm_gem_dmabuf_vmap_local,
> +		.vunmap = drm_gem_dmabuf_vunmap_local,
>  	},
>  	.device_attach = drm_gem_map_attach,
>  	.get_uuid = virtgpu_virtio_get_uuid,
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 5e6daa1c982f..1281f26de494 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -151,6 +151,26 @@ struct drm_gem_object_funcs {
>  	 */
>  	void (*vunmap)(struct drm_gem_object *obj, struct dma_buf_map *map);
>  
> +	/**
> +	 * @vmap_local:
> +	 *
> +	 * Returns a virtual address for the buffer. Used by the
> +	 * drm_gem_dmabuf_vmap_local() helper.

I'd add "Callers will hold &drm_gem_object.resv already and only release
it after @vunmap is called" (and pls check I typed this correctly for the
linking).

Either way: Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +	 *
> +	 * This callback is optional.
> +	 */
> +	int (*vmap_local)(struct drm_gem_object *obj, struct dma_buf_map *map);
> +
> +	/**
> +	 * @vunmap_local:
> +	 *
> +	 * Releases the address previously returned by @vmap. Used by the
> +	 * drm_gem_dmabuf_vunmap_local() helper.
> +	 *
> +	 * This callback is optional.
> +	 */
> +	void (*vunmap_local)(struct drm_gem_object *obj, struct dma_buf_map *map);
> +
>  	/**
>  	 * @mmap:
>  	 *
> diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
> index 54f2c58305d2..fd2aef6966ef 100644
> --- a/include/drm/drm_prime.h
> +++ b/include/drm/drm_prime.h
> @@ -85,6 +85,8 @@ void drm_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
>  			   enum dma_data_direction dir);
>  int drm_gem_dmabuf_vmap(struct dma_buf *dma_buf, struct dma_buf_map *map);
>  void drm_gem_dmabuf_vunmap(struct dma_buf *dma_buf, struct dma_buf_map *map);
> +int drm_gem_dmabuf_vmap_local(struct dma_buf *dma_buf, struct dma_buf_map *map);
> +void drm_gem_dmabuf_vunmap_local(struct dma_buf *dma_buf, struct dma_buf_map *map);
>  
>  int drm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
>  int drm_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struct *vma);
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
