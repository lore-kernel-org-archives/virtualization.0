Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1211A5BA4
	for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228511; cv=none; b=UEkfgUR4UeayDlTRRqGz+F6uc1Rs5eEeqtJ8uayHiyPPnClR29qa1+P6dnpTGWyI2jEYzlgpz/98TbWKvMx43waP2rurw5bnpFRzJFmgVijcSD9IQ3h5uUNA6St4s4OaMRjTlPSdRwWIBeKBCHQJDrYcX5RHZ2ct6Lf6OKNv3bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228511; c=relaxed/simple;
	bh=69xOFdWDwCk4S0gIn5uUtYXZXgrNc0zyjeE8VJoT9yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gc+VhKDE5uUX3A0E/CvHXufaSpzdWU+fCF6WTxQe+8Ms1eKWlR2kSb48XJf0I9xX+Y0NXuQeS6nUY63hWFkaoYXSCQ3R4vb+ajIsfzm2fRMLudq6/ploDvK7pHAt9aCdC0oHGhS9/iU7z7+aWm7pNP4h1Y0lvMS6fJHEFGAEn7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Ni1oiZSY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ni1oiZSY"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so17005965e9.1
        for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752228508; x=1752833308; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgqCaEUcHReYwP1+eVs6TgGyIVC7fVlC12ysVvFBg1c=;
        b=Ni1oiZSY3XWolAhbKP+iqCIX7ORw1+y66/JEcyjmnv6AI9eoSHFYlr/KGbV0AAOTmf
         1is6Zq20qAXeI3qysHJB7fQWpUhOpNUV7CoO2S8pWlRnu7Z81gHtOKicGrg6YoL31bSm
         sTT5fKU1iQRFq0j38jWqa2aSv0m/fBoauD2Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752228508; x=1752833308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgqCaEUcHReYwP1+eVs6TgGyIVC7fVlC12ysVvFBg1c=;
        b=PP7D7wjJhYmVINrCvXpDDfbIWsBCyz1MRf0OSZx9Si4dGkbOtSXl2/6FjgqGCVrR6c
         FDXBEoRWu4XvJnuupx56aUucvkcnOJFkFWkJgHQJOqOPhYoSvKupYn3llLYRXz6vZ/WR
         5bYzE21+ctWwy1R2PXPrtuv/PMuCdfnVmjQKs3UVCw8Owe2W2G4vOMF/Sdm291SxoVqD
         DqZ3Js6A6mJdj9lNSKthR9xnKu6hvLqHPPm948op0IcH93B5c5RTzC8x3wjFipaIu3hx
         81nzLpI1lkvKgdD7Cg2j868UGvxVHdyXgYa4FQd0wywF+wxMjYs4UrF+Ndm/r8qlE5gL
         YPPw==
X-Forwarded-Encrypted: i=1; AJvYcCUQYNSLtNfnSp5qtQIcXhjFSvZvoEICMdn2NJC0WZ8kgTbUJ1kT8aNzqeV216zECnBGagUC/AbNU9gkBzgngg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnC1jKEQRQQBfh11pW0ufUjcTXlFM4psXATCTzHR2yPebfwAX8
	K8hJO1mIz52zzPrcyH9WoK2DrKI/ewYLfHnex21nvRI5nhXmiXwGMii/gm49lTdePyI=
X-Gm-Gg: ASbGncsp15PpcUnPlqAUU9bjRij70Rn8Dph/KgSCk5CCvc/hn9r6wvIOymYEvTEUE4T
	yKo1ZD5Tqt5Ew35BMsDPngJaFJvT3eqS+Pso6m1ChEkVBoqo+/o4k/q71gV2RD8YJmwjjnQ9Vmn
	7JE/uqoMGZYPSE3BLqJlZWo85hXmoHIgTvFWSiN97GWiPyNbixSppZLpTPvidNEqfHIEzeR2p9T
	WEZUzSw22pOpxtk4I3pK6HLMCmCCEoh/Md2FfLGpOkaKNgWCCzR4KA8E6gM/UkmjwWSVrAH2VFo
	6fJ6N5QPIsREUFQzyamEvCXgZ+O3uxh5oBneO4wxdAgOmz6Vcqyad5/KUZXQ4DcrF+jm8d6VR1d
	SsexGrxQmTWP5YZZ9cVd2Mw/gwIVGVyC2iw==
X-Google-Smtp-Source: AGHT+IFhCZJ47IcyOYT/ucI3ECEF+Ab1sZvRV6pgr8844GO4AhYos7iyzZjZjDJLFfEkY94fWChkcA==
X-Received: by 2002:a05:600c:a31b:b0:455:efd7:17dc with SMTP id 5b1f17b1804b1-455efd7194cmr5606095e9.11.1752228507556;
        Fri, 11 Jul 2025 03:08:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5f32ed100sm1238699f8f.0.2025.07.11.03.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 03:08:27 -0700 (PDT)
Date: Fri, 11 Jul 2025 12:08:25 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, airlied@gmail.com, christian.koenig@amd.com,
	torvalds@linux-foundation.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, l.stach@pengutronix.de,
	linux+etnaviv@armlinux.org.uk, kraxel@redhat.com,
	christian.gmeiner@gmail.com, dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org, olvaffe@gmail.com,
	zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/9] Revert "drm/gem: Acquire references on GEM handles
 for framebuffers"
Message-ID: <aHDimRgOz3VPMw0I@phenom.ffwll.local>
References: <20250711093744.120962-1-tzimmermann@suse.de>
 <20250711093744.120962-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711093744.120962-3-tzimmermann@suse.de>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Fri, Jul 11, 2025 at 11:35:17AM +0200, Thomas Zimmermann wrote:
> This reverts commit 5307dce878d4126e1b375587318955bd019c3741.
> 
> We're going to revert the dma-buf handle back to separating dma_buf
> and import_attach->dmabuf in struct drm_gem_object. Hence revert this
> fix for it.

I think we should add my reasons from the private thread here why I think
this is conceptually wrong:

handle_count is an uapi reference, and should have nothing to do with the
lifetime and consistency of the underlying gem_bo. And for imported bo the
link to the dma-buf really should be invariant, and hence
drm_gem_object_get/put() enough. The fact that this patch seems to have
helped at least in some cases indicates that our assumption that we can
replace gem_bo->import_attach.dmabuf with gem_bo->dma_buf was wrong,
because pretty obviously the latter can become NULL while the gem_bo is
still alive. Which means this was conceptually wrong and at best helped
hide a race condition somewhere.

This means that unlike the claim in the reverted commit that 1a148af06000
("drm/gem-shmem: Use dma_buf from GEM object instance") started triggering
an existing condition the much more likely explanation is that it
introduced the regression itself. And hence we need to revert this entire
chain of commits.

I'll also add all the Fixes: lines as needed when merging these to
drm-fixes, since some of the patches reverted in this series have landed
in 6.15 already.

I plan to merge them all to drm-fixes once intel-gfx-ci has approved it
all.

Thanks, Sima

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_gem.c                    | 44 ++------------------
>  drivers/gpu/drm/drm_gem_framebuffer_helper.c | 16 ++++---
>  drivers/gpu/drm/drm_internal.h               |  2 -
>  3 files changed, 11 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 3a99e4a5d303..db44c40e307f 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -213,35 +213,6 @@ void drm_gem_private_object_fini(struct drm_gem_object *obj)
>  }
>  EXPORT_SYMBOL(drm_gem_private_object_fini);
>  
> -static void drm_gem_object_handle_get(struct drm_gem_object *obj)
> -{
> -	struct drm_device *dev = obj->dev;
> -
> -	drm_WARN_ON(dev, !mutex_is_locked(&dev->object_name_lock));
> -
> -	if (obj->handle_count++ == 0)
> -		drm_gem_object_get(obj);
> -}
> -
> -/**
> - * drm_gem_object_handle_get_unlocked - acquire reference on user-space handles
> - * @obj: GEM object
> - *
> - * Acquires a reference on the GEM buffer object's handle. Required
> - * to keep the GEM object alive. Call drm_gem_object_handle_put_unlocked()
> - * to release the reference.
> - */
> -void drm_gem_object_handle_get_unlocked(struct drm_gem_object *obj)
> -{
> -	struct drm_device *dev = obj->dev;
> -
> -	guard(mutex)(&dev->object_name_lock);
> -
> -	drm_WARN_ON(dev, !obj->handle_count); /* first ref taken in create-tail helper */
> -	drm_gem_object_handle_get(obj);
> -}
> -EXPORT_SYMBOL(drm_gem_object_handle_get_unlocked);
> -
>  /**
>   * drm_gem_object_handle_free - release resources bound to userspace handles
>   * @obj: GEM object to clean up.
> @@ -272,14 +243,8 @@ static void drm_gem_object_exported_dma_buf_free(struct drm_gem_object *obj)
>  	}
>  }
>  
> -/**
> - * drm_gem_object_handle_put_unlocked - releases reference on user-space handles
> - * @obj: GEM object
> - *
> - * Releases a reference on the GEM buffer object's handle. Possibly releases
> - * the GEM buffer object and associated dma-buf objects.
> - */
> -void drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
> +static void
> +drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
>  {
>  	struct drm_device *dev = obj->dev;
>  	bool final = false;
> @@ -304,7 +269,6 @@ void drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
>  	if (final)
>  		drm_gem_object_put(obj);
>  }
> -EXPORT_SYMBOL(drm_gem_object_handle_put_unlocked);
>  
>  /*
>   * Called at device or object close to release the file's
> @@ -429,8 +393,8 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
>  	int ret;
>  
>  	WARN_ON(!mutex_is_locked(&dev->object_name_lock));
> -
> -	drm_gem_object_handle_get(obj);
> +	if (obj->handle_count++ == 0)
> +		drm_gem_object_get(obj);
>  
>  	/*
>  	 * Get the user-visible handle using idr.  Preload and perform
> diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> index c60d0044d036..618ce725cd75 100644
> --- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> +++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> @@ -100,7 +100,7 @@ void drm_gem_fb_destroy(struct drm_framebuffer *fb)
>  	unsigned int i;
>  
>  	for (i = 0; i < fb->format->num_planes; i++)
> -		drm_gem_object_handle_put_unlocked(fb->obj[i]);
> +		drm_gem_object_put(fb->obj[i]);
>  
>  	drm_framebuffer_cleanup(fb);
>  	kfree(fb);
> @@ -183,10 +183,8 @@ int drm_gem_fb_init_with_funcs(struct drm_device *dev,
>  		if (!objs[i]) {
>  			drm_dbg_kms(dev, "Failed to lookup GEM object\n");
>  			ret = -ENOENT;
> -			goto err_gem_object_handle_put_unlocked;
> +			goto err_gem_object_put;
>  		}
> -		drm_gem_object_handle_get_unlocked(objs[i]);
> -		drm_gem_object_put(objs[i]);
>  
>  		min_size = (height - 1) * mode_cmd->pitches[i]
>  			 + drm_format_info_min_pitch(info, i, width)
> @@ -196,22 +194,22 @@ int drm_gem_fb_init_with_funcs(struct drm_device *dev,
>  			drm_dbg_kms(dev,
>  				    "GEM object size (%zu) smaller than minimum size (%u) for plane %d\n",
>  				    objs[i]->size, min_size, i);
> -			drm_gem_object_handle_put_unlocked(objs[i]);
> +			drm_gem_object_put(objs[i]);
>  			ret = -EINVAL;
> -			goto err_gem_object_handle_put_unlocked;
> +			goto err_gem_object_put;
>  		}
>  	}
>  
>  	ret = drm_gem_fb_init(dev, fb, mode_cmd, objs, i, funcs);
>  	if (ret)
> -		goto err_gem_object_handle_put_unlocked;
> +		goto err_gem_object_put;
>  
>  	return 0;
>  
> -err_gem_object_handle_put_unlocked:
> +err_gem_object_put:
>  	while (i > 0) {
>  		--i;
> -		drm_gem_object_handle_put_unlocked(objs[i]);
> +		drm_gem_object_put(objs[i]);
>  	}
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> index f921cc73f8b8..9078504e789c 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -161,8 +161,6 @@ void drm_sysfs_lease_event(struct drm_device *dev);
>  
>  /* drm_gem.c */
>  int drm_gem_init(struct drm_device *dev);
> -void drm_gem_object_handle_get_unlocked(struct drm_gem_object *obj);
> -void drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj);
>  int drm_gem_handle_create_tail(struct drm_file *file_priv,
>  			       struct drm_gem_object *obj,
>  			       u32 *handlep);
> -- 
> 2.50.0
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
