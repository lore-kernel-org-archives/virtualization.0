Return-Path: <SRS0=HmZx=FP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6AEC433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 09:40:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A75E23ECD
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 09:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A75E23ECD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1326086FFC;
	Fri, 11 Dec 2020 09:40:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8HqPiCP5vI3B; Fri, 11 Dec 2020 09:40:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4D39E87009;
	Fri, 11 Dec 2020 09:40:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1504AC0893;
	Fri, 11 Dec 2020 09:40:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81C9BC013B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 09:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 73F3D27A61
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 09:40:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4vptrmH8jyTj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 09:40:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by silver.osuosl.org (Postfix) with ESMTPS id BFA7E274B3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 09:40:04 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id r3so8342482wrt.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 01:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BBMZYuvSnfgkVx6tBmK2Wiiqx5byRBrgyTEDwAs9l14=;
 b=aSB1BCyAvO7hF26iVhODkq39odRS+UoX+/oEfJ5VGJdVce5NUWDQckQodHcII5H1Hz
 21DgrIg7JZjbvmg9AEnvWFbJ2s0R6C40bwZyPc3tCuaNuWdPdXdnjGKsbpJaapYM9/Po
 Vn/VZ6zoqNPYXLPahQWHebojD//y9HM+P1Tjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BBMZYuvSnfgkVx6tBmK2Wiiqx5byRBrgyTEDwAs9l14=;
 b=MYM+SrfW8HrQfMOWX3NjetwNofW95VUbn6MPeIJSeOABuCLpKZS0HVS243CMZfqDor
 ulk5TiRDWNLRW3DINJ7P4xRZsFHK8xVZHbSTFhdwq2KAmOeK9Lycp5U+K5mrb8NnFBrF
 zSWI9SmanEbQ2H7ERFwGqwo8oVCAzLRbnFZ5YAdV3s/FJZrWSf4ft5Gfaeki42RyxIRc
 O5qBh3l19zRYWJL41hWxr8FyIszanjk7N3554NPqCsER5KPl0+vwIkiLkfJQBuHeL6bG
 S5IWtCPn/pX3Vk39SSXMmMkDEuQVdzfyfZEYgkaqIQUW2lIxoukLu0cIvA1z0xtoBKOj
 lplw==
X-Gm-Message-State: AOAM531iPgRjJjMntSH4QNvhSehBuRYSWyg4Z8XkOnu1teD7+l9CUNfn
 xikUNFzqNH1t3VNyRaL3U1Z5IA==
X-Google-Smtp-Source: ABdhPJz8bnteVuPWlqvUHmb5G+JjYIr75IXQFMqcJBKRq84zZqO9uSdVvytCN9HvAtL2Ocom3MmErQ==
X-Received: by 2002:adf:97ce:: with SMTP id t14mr13035615wrb.368.1607679603133; 
 Fri, 11 Dec 2020 01:40:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id h83sm15009761wmf.9.2020.12.11.01.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Dec 2020 01:40:02 -0800 (PST)
Date: Fri, 11 Dec 2020 10:40:00 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 5/8] drm/cma-helper: Provide a vmap function for
 short-term mappings
Message-ID: <20201211094000.GK401619@phenom.ffwll.local>
References: <20201209142527.26415-1-tzimmermann@suse.de>
 <20201209142527.26415-6-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209142527.26415-6-tzimmermann@suse.de>
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

On Wed, Dec 09, 2020 at 03:25:24PM +0100, Thomas Zimmermann wrote:
> Implementations of the vmap/vunmap GEM callbacks may perform pinning
> of the BO and may acquire the associated reservation object's lock.
> Callers that only require a mapping of the contained memory can thus
> interfere with other tasks that require exact pinning, such as scanout.
> This is less of an issue with private CMA buffers, but may happen
> with imported ones.
> 
> Therefore provide the new interface drm_gem_cma_vmap_local(), which only
> performs the vmap operations. Callers have to hold the reservation lock
> while the mapping persists.
> 
> This patch also connects GEM CMA helpers to the GEM object function with
> equivalent functionality.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_gem_cma_helper.c | 35 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/vc4/vc4_bo.c         | 13 +++++++++++
>  drivers/gpu/drm/vc4/vc4_drv.h        |  1 +
>  include/drm/drm_gem_cma_helper.h     |  1 +
>  4 files changed, 50 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
> index 7942cf05cd93..40b3e8e3fc42 100644
> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
> @@ -38,6 +38,7 @@ static const struct drm_gem_object_funcs drm_gem_cma_default_funcs = {
>  	.print_info = drm_gem_cma_print_info,
>  	.get_sg_table = drm_gem_cma_get_sg_table,
>  	.vmap = drm_gem_cma_vmap,
> +	.vmap_local = drm_gem_cma_vmap_local,
>  	.mmap = drm_gem_cma_mmap,
>  	.vm_ops = &drm_gem_cma_vm_ops,
>  };
> @@ -471,6 +472,40 @@ int drm_gem_cma_vmap(struct drm_gem_object *obj, struct dma_buf_map *map)
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_cma_vmap);
>  
> +/**
> + * drm_gem_cma_vmap_local - map a CMA GEM object into the kernel's virtual
> + *     address space
> + * @obj: GEM object
> + * @map: Returns the kernel virtual address of the CMA GEM object's backing
> + *       store.
> + *
> + * This function maps a buffer into the kernel's
> + * virtual address space. Since the CMA buffers are already mapped into the
> + * kernel virtual address space this simply returns the cached virtual
> + * address. Drivers using the CMA helpers should set this as their DRM
> + * driver's &drm_gem_object_funcs.vmap_local callback.
> + *
> + * Returns:
> + * 0 on success, or a negative error code otherwise.
> + */
> +int drm_gem_cma_vmap_local(struct drm_gem_object *obj, struct dma_buf_map *map)
> +{
> +	struct drm_gem_cma_object *cma_obj = to_drm_gem_cma_obj(obj);
> +
> +	/*
> +	 * TODO: The code in drm_gem_cma_prime_import_sg_table_vmap()
> +	 *       establishes this mapping. The correct solution would
> +	 *       be to call dma_buf_vmap_local() here.
> +	 *
> +	 *       If we find a case where we absolutely have to call
> +	 *       dma_buf_vmap_local(), the code needs to be restructured.

dma_buf_vmap_local is only relevant for dynamic importers, pinning at
import time is actually what you get anyway. That's what Christian meant
with his comments for the ->pin hook. So the TODO here doesn't make sense
imo, just delete it. We're very far away from making cma dynamic :-)

> +	 */
> +	dma_buf_map_set_vaddr(map, cma_obj->vaddr);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(drm_gem_cma_vmap_local);
> +
>  /**
>   * drm_gem_cma_mmap - memory-map an exported CMA GEM object
>   * @obj: GEM object
> diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> index dc316cb79e00..ec57326c69c4 100644
> --- a/drivers/gpu/drm/vc4/vc4_bo.c
> +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> @@ -387,6 +387,7 @@ static const struct drm_gem_object_funcs vc4_gem_object_funcs = {
>  	.export = vc4_prime_export,
>  	.get_sg_table = drm_gem_cma_get_sg_table,
>  	.vmap = vc4_prime_vmap,
> +	.vmap_local = vc4_prime_vmap_local,
>  	.vm_ops = &vc4_vm_ops,
>  };
>  
> @@ -797,6 +798,18 @@ int vc4_prime_vmap(struct drm_gem_object *obj, struct dma_buf_map *map)
>  	return drm_gem_cma_vmap(obj, map);
>  }
>  
> +int vc4_prime_vmap_local(struct drm_gem_object *obj, struct dma_buf_map *map)
> +{
> +	struct vc4_bo *bo = to_vc4_bo(obj);
> +
> +	if (bo->validated_shader) {

This freaks me out. It should be impossible to export a validated shader
as a dma-buf, and indeed the check exists already.

All the wrapper functions here are imo pointless. Either we should remove
them, or replace the if with a BUG_ON here since if that ever happens we
have a security bug already. I'd go with removing, less code. Maybe throw
a patch on top?

Anyway this patch looks good, with the todo deleted:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>


> +		DRM_DEBUG("mmaping of shader BOs not allowed.\n");
> +		return -EINVAL;
> +	}
> +
> +	return drm_gem_cma_vmap_local(obj, map);
> +}
> +
>  struct drm_gem_object *
>  vc4_prime_import_sg_table(struct drm_device *dev,
>  			  struct dma_buf_attachment *attach,
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index 43a1af110b3e..efb6c47d318f 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -812,6 +812,7 @@ struct drm_gem_object *vc4_prime_import_sg_table(struct drm_device *dev,
>  						 struct dma_buf_attachment *attach,
>  						 struct sg_table *sgt);
>  int vc4_prime_vmap(struct drm_gem_object *obj, struct dma_buf_map *map);
> +int vc4_prime_vmap_local(struct drm_gem_object *obj, struct dma_buf_map *map);
>  int vc4_bo_cache_init(struct drm_device *dev);
>  int vc4_bo_inc_usecnt(struct vc4_bo *bo);
>  void vc4_bo_dec_usecnt(struct vc4_bo *bo);
> diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
> index 0a9711caa3e8..05122e71bc6d 100644
> --- a/include/drm/drm_gem_cma_helper.h
> +++ b/include/drm/drm_gem_cma_helper.h
> @@ -99,6 +99,7 @@ drm_gem_cma_prime_import_sg_table(struct drm_device *dev,
>  				  struct dma_buf_attachment *attach,
>  				  struct sg_table *sgt);
>  int drm_gem_cma_vmap(struct drm_gem_object *obj, struct dma_buf_map *map);
> +int drm_gem_cma_vmap_local(struct drm_gem_object *obj, struct dma_buf_map *map);
>  int drm_gem_cma_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
>  
>  /**
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
