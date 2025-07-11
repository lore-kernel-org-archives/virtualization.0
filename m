Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A890C19AD8C
	for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232941; cv=none; b=YZIx0cJFPQTz+6esCnelYrJI5S1ZyNclyCHC+5fkSv0u1iGYTdh+g8iDwI1sqr6PE7pnqBcJR5fHy/FP7VmxF2uNg0HBBDpjCGrPIztsfbu8VS5yLHRqkidjv00LJeaG35z+hpk6TOa+eb1h+8HgDebEYlrdwjPBdVN54txaOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232941; c=relaxed/simple;
	bh=EDmmWXUfXuNxthN1QuvlVS1qJbrkm+HW9VjI0/9kWiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OU1jQqq1akUjO7RwZQzgynm6Cq/Pii5iov20/uj/2ZxIyESwpzEbjBO9Cb0S0mSeTIc3AfNFsu8SZ5ZIC8BHBM535dcNLbHE39fYabHeM7aWQ2U13Ec15cBrEwdWEy0rWgfRaQeglru3dBi6LzBajs710Duj8LwlrMk6yrSQn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=HrEh8ABv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HrEh8ABv"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-453643020bdso15185015e9.1
        for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 04:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752232938; x=1752837738; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WSZK2Iixe1rMLHZShReAs/1ul3nsWyDlpH+GAJ+K3sc=;
        b=HrEh8ABv7EQglAYS2yBSDARwa4e3kBeeX/MOv9CIBGB1iXG/CGwUVhIoNvQhyEMiO6
         d7HKvqvwcCdsWpFu+TnBcselZ9EhG1dh7rTxnfOrPx9KdPYOEvwuHqkpL7crHyEl6DM4
         /zsWhAyG4HkqLna7FR+860NAR+JZP0QOH+18E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752232938; x=1752837738;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSZK2Iixe1rMLHZShReAs/1ul3nsWyDlpH+GAJ+K3sc=;
        b=dl+UxBaudUng116vJsPIcfuWrkagMiF9F5hqGXTT7K7tRgP/bTfe6z9IbHyzrh2dtg
         Pfyhrq38kMh1OI4+I7yqgPZrXvMZzWUW/kZxoLWVCLvJis9L1RkBmFdFLeTwr8CqcfBm
         8K53aH2Ek3PTNbBvM+5oun3K2I/xlId6srEtXfZYD9uy9aV3EMmlsGAonAowqzb8opMF
         pmryoE+pl6SvachtLrh67kA6PkHWDRQxBU8kmhy2UCu7lR7lVfncCCpRJurJMYQa/N9P
         Oe98u14jxm2PWJ1rHfr6x/vnv6X0rt+B0CmFBaFJGE4+RKOWES1zaaaYlaX6Wz940GjH
         cGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyBy1PJnr/ltsNxldNANrWgCu0QLXzjB126catbITNISAE+MlWbNOc9MtGh7RZxYE5Ux6AfJb/JQCgrGd5fA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbjrisZbj8S6pXoDDgFuriUQHBxijMb16DSiH17IL5bSeFlqE9
	aNo0E6vgZLOeVX3/iPQXJXNCbiqRH4QP7NBqo+bSWKZEPz4nLhoGvsqPliBVQ0X/ndo=
X-Gm-Gg: ASbGncs1BtliQzHJeE0H9p6rmVR5a0/wTjKxHlgs5s2fOH25gYPcndfgeeYN/Tf4OT3
	WKBcmoMpuLu2QmSum/tnYaq1Qf4xiFqezMHNO1bi79TGUMSuJhAf2myU8nkjrA9M0aOWlCHZqRt
	Tdhzy6Cy4f4pq8+r0WUdkK+TC7X9R5yTAS7EEtqvOPX5IE40uEsai5RIda5TjkRvfgaUyj+yTpe
	b25dOrXpWDUYSaIGw9f3dawthvc4A9mHszmhXu5nx32eEb/7+cWPXp2WLeRLTZV9W1sFYg0M998
	37cimPBnQIeUJowOsPqLD6NEEDg2DxQEN35JdwWTwD84WEK0nT5cDtdYEw1gWMnvhErDZ7zbH2w
	RgD3XJiVShsUMD+RsFhf9pbOZ8NfWD0a64g==
X-Google-Smtp-Source: AGHT+IE5TItSXlf23oGbeyF4FaewGhF6yASU2LBkMEVSD2Q3b8XSKVVW/JglscVyYaFi0JUlwl6z9A==
X-Received: by 2002:a05:600c:3514:b0:442:d9f2:ded8 with SMTP id 5b1f17b1804b1-454f42873cdmr26738135e9.15.1752232937592;
        Fri, 11 Jul 2025 04:22:17 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26f45sm4214889f8f.92.2025.07.11.04.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 04:22:17 -0700 (PDT)
Date: Fri, 11 Jul 2025 13:22:15 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch,
	airlied@gmail.com, torvalds@linux-foundation.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
	kraxel@redhat.com, christian.gmeiner@gmail.com,
	dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
	olvaffe@gmail.com, zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/9] Revert "drm/gem: Acquire references on GEM handles
 for framebuffers"
Message-ID: <aHDz59OYxwZzDrsG@phenom.ffwll.local>
References: <20250711093744.120962-1-tzimmermann@suse.de>
 <20250711093744.120962-3-tzimmermann@suse.de>
 <aHDimRgOz3VPMw0I@phenom.ffwll.local>
 <f46837f2-bb04-4113-8d82-1701a4d45ac3@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f46837f2-bb04-4113-8d82-1701a4d45ac3@amd.com>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Fri, Jul 11, 2025 at 01:00:03PM +0200, Christian König wrote:
> On 11.07.25 12:08, Simona Vetter wrote:
> > On Fri, Jul 11, 2025 at 11:35:17AM +0200, Thomas Zimmermann wrote:
> >> This reverts commit 5307dce878d4126e1b375587318955bd019c3741.
> >>
> >> We're going to revert the dma-buf handle back to separating dma_buf
> >> and import_attach->dmabuf in struct drm_gem_object. Hence revert this
> >> fix for it.
> > 
> > I think we should add my reasons from the private thread here why I think
> > this is conceptually wrong:
> > 
> > handle_count is an uapi reference, and should have nothing to do with the
> > lifetime and consistency of the underlying gem_bo.
> 
> The problem is that we tied the lifetime of the DMA-buf reference to the
> handle count and I think that is not 100% clean.
> 
> The reason why that was done is to break the circle dependency GEM obj
> -> DMA-buf -> GEM obj, but what potentially should actually happen is
> that we distinct between a structure reference and an use count.
> 
> E.g. similar to what is done with mm_struct and mmgrab()/mmdrop() vs
> mmget()/mmput().

Yeah, I think I'm following. The issue I see here is that I think we're
free-wheeling, dont' have enough testcases, and break existing stuff way
too much. So back to square one, start over, probably with a lot of
kerneldoc patches first and more igt and kunit tests to hit all these
issues we've (re-)discovered.

> > And for imported bo the
> > link to the dma-buf really should be invariant, and hence
> > drm_gem_object_get/put() enough. The fact that this patch seems to have
> > helped at least in some cases indicates that our assumption that we can
> > replace gem_bo->import_attach.dmabuf with gem_bo->dma_buf was wrong,
> > because pretty obviously the latter can become NULL while the gem_bo is
> > still alive. Which means this was conceptually wrong and at best helped
> > hide a race condition somewhere.
> > 
> > This means that unlike the claim in the reverted commit that 1a148af06000
> > ("drm/gem-shmem: Use dma_buf from GEM object instance") started triggering
> > an existing condition the much more likely explanation is that it
> > introduced the regression itself. And hence we need to revert this entire
> > chain of commits.
> 
> The existing condition is still a problem I think. We ran into issues with that multiple times already.
> 
> Just imagine the following scenario:
> 1. GEM obj is exported, DMA-buf file descriptor created
> 2. GEM obj is used in a FB.
> 3. GEM obj is closed, handle_count goes from 1->0, DMA-buf reference is dropped, but file descriptor remains open, obj->dma_buf set to NULL
> 4. Userspace calls DRM_IOCTL_MODE_GETFB2, handle count goes 0->1 again, but obj->dma_buf is still NULL!
> 5. GEM obj is exported again, second DMA-buf is created.
> 
> The first time I stumbled over that it took me a week to figure out why
> we can have two DMA-bufs for the same GEM obj.  Especially you can
> trigger the "WARN_ON(obj->dma_buf != dma_buf);" in
> drm_gem_prime_fd_to_handle() with this.
> 
> For my particular use case it was just a broken unit test, but it allows
> userspace to mess up the kernel objects quite a bit and that is really
> not good.

Yeah that's not good, but I think something we should sort out with adding
testcases first and figuring out fixes in -next, not in late -rc kernels.
I think the minimal fix for this corner case would be to add a flag to
gem_bo that they've had GETFB/2 called on them, and in that case disable
that WARN_ON and just quietly bail out instead. Userspace gets to keep the
pieces.

I'm not sure whether making the entire lifetime stuff even more
complicated by elevating handle_count to a more general usage count is the
right approach.

Cheers, Sima

> 
> Regards,
> Christian.
> 
> > 
> > I'll also add all the Fixes: lines as needed when merging these to
> > drm-fixes, since some of the patches reverted in this series have landed
> > in 6.15 already.
> > 
> > I plan to merge them all to drm-fixes once intel-gfx-ci has approved it
> > all.
> > 
> > Thanks, Sima
> > 
> >> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> ---
> >>  drivers/gpu/drm/drm_gem.c                    | 44 ++------------------
> >>  drivers/gpu/drm/drm_gem_framebuffer_helper.c | 16 ++++---
> >>  drivers/gpu/drm/drm_internal.h               |  2 -
> >>  3 files changed, 11 insertions(+), 51 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> >> index 3a99e4a5d303..db44c40e307f 100644
> >> --- a/drivers/gpu/drm/drm_gem.c
> >> +++ b/drivers/gpu/drm/drm_gem.c
> >> @@ -213,35 +213,6 @@ void drm_gem_private_object_fini(struct drm_gem_object *obj)
> >>  }
> >>  EXPORT_SYMBOL(drm_gem_private_object_fini);
> >>  
> >> -static void drm_gem_object_handle_get(struct drm_gem_object *obj)
> >> -{
> >> -	struct drm_device *dev = obj->dev;
> >> -
> >> -	drm_WARN_ON(dev, !mutex_is_locked(&dev->object_name_lock));
> >> -
> >> -	if (obj->handle_count++ == 0)
> >> -		drm_gem_object_get(obj);
> >> -}
> >> -
> >> -/**
> >> - * drm_gem_object_handle_get_unlocked - acquire reference on user-space handles
> >> - * @obj: GEM object
> >> - *
> >> - * Acquires a reference on the GEM buffer object's handle. Required
> >> - * to keep the GEM object alive. Call drm_gem_object_handle_put_unlocked()
> >> - * to release the reference.
> >> - */
> >> -void drm_gem_object_handle_get_unlocked(struct drm_gem_object *obj)
> >> -{
> >> -	struct drm_device *dev = obj->dev;
> >> -
> >> -	guard(mutex)(&dev->object_name_lock);
> >> -
> >> -	drm_WARN_ON(dev, !obj->handle_count); /* first ref taken in create-tail helper */
> >> -	drm_gem_object_handle_get(obj);
> >> -}
> >> -EXPORT_SYMBOL(drm_gem_object_handle_get_unlocked);
> >> -
> >>  /**
> >>   * drm_gem_object_handle_free - release resources bound to userspace handles
> >>   * @obj: GEM object to clean up.
> >> @@ -272,14 +243,8 @@ static void drm_gem_object_exported_dma_buf_free(struct drm_gem_object *obj)
> >>  	}
> >>  }
> >>  
> >> -/**
> >> - * drm_gem_object_handle_put_unlocked - releases reference on user-space handles
> >> - * @obj: GEM object
> >> - *
> >> - * Releases a reference on the GEM buffer object's handle. Possibly releases
> >> - * the GEM buffer object and associated dma-buf objects.
> >> - */
> >> -void drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
> >> +static void
> >> +drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
> >>  {
> >>  	struct drm_device *dev = obj->dev;
> >>  	bool final = false;
> >> @@ -304,7 +269,6 @@ void drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
> >>  	if (final)
> >>  		drm_gem_object_put(obj);
> >>  }
> >> -EXPORT_SYMBOL(drm_gem_object_handle_put_unlocked);
> >>  
> >>  /*
> >>   * Called at device or object close to release the file's
> >> @@ -429,8 +393,8 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
> >>  	int ret;
> >>  
> >>  	WARN_ON(!mutex_is_locked(&dev->object_name_lock));
> >> -
> >> -	drm_gem_object_handle_get(obj);
> >> +	if (obj->handle_count++ == 0)
> >> +		drm_gem_object_get(obj);
> >>  
> >>  	/*
> >>  	 * Get the user-visible handle using idr.  Preload and perform
> >> diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> >> index c60d0044d036..618ce725cd75 100644
> >> --- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> >> +++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> >> @@ -100,7 +100,7 @@ void drm_gem_fb_destroy(struct drm_framebuffer *fb)
> >>  	unsigned int i;
> >>  
> >>  	for (i = 0; i < fb->format->num_planes; i++)
> >> -		drm_gem_object_handle_put_unlocked(fb->obj[i]);
> >> +		drm_gem_object_put(fb->obj[i]);
> >>  
> >>  	drm_framebuffer_cleanup(fb);
> >>  	kfree(fb);
> >> @@ -183,10 +183,8 @@ int drm_gem_fb_init_with_funcs(struct drm_device *dev,
> >>  		if (!objs[i]) {
> >>  			drm_dbg_kms(dev, "Failed to lookup GEM object\n");
> >>  			ret = -ENOENT;
> >> -			goto err_gem_object_handle_put_unlocked;
> >> +			goto err_gem_object_put;
> >>  		}
> >> -		drm_gem_object_handle_get_unlocked(objs[i]);
> >> -		drm_gem_object_put(objs[i]);
> >>  
> >>  		min_size = (height - 1) * mode_cmd->pitches[i]
> >>  			 + drm_format_info_min_pitch(info, i, width)
> >> @@ -196,22 +194,22 @@ int drm_gem_fb_init_with_funcs(struct drm_device *dev,
> >>  			drm_dbg_kms(dev,
> >>  				    "GEM object size (%zu) smaller than minimum size (%u) for plane %d\n",
> >>  				    objs[i]->size, min_size, i);
> >> -			drm_gem_object_handle_put_unlocked(objs[i]);
> >> +			drm_gem_object_put(objs[i]);
> >>  			ret = -EINVAL;
> >> -			goto err_gem_object_handle_put_unlocked;
> >> +			goto err_gem_object_put;
> >>  		}
> >>  	}
> >>  
> >>  	ret = drm_gem_fb_init(dev, fb, mode_cmd, objs, i, funcs);
> >>  	if (ret)
> >> -		goto err_gem_object_handle_put_unlocked;
> >> +		goto err_gem_object_put;
> >>  
> >>  	return 0;
> >>  
> >> -err_gem_object_handle_put_unlocked:
> >> +err_gem_object_put:
> >>  	while (i > 0) {
> >>  		--i;
> >> -		drm_gem_object_handle_put_unlocked(objs[i]);
> >> +		drm_gem_object_put(objs[i]);
> >>  	}
> >>  	return ret;
> >>  }
> >> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> >> index f921cc73f8b8..9078504e789c 100644
> >> --- a/drivers/gpu/drm/drm_internal.h
> >> +++ b/drivers/gpu/drm/drm_internal.h
> >> @@ -161,8 +161,6 @@ void drm_sysfs_lease_event(struct drm_device *dev);
> >>  
> >>  /* drm_gem.c */
> >>  int drm_gem_init(struct drm_device *dev);
> >> -void drm_gem_object_handle_get_unlocked(struct drm_gem_object *obj);
> >> -void drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj);
> >>  int drm_gem_handle_create_tail(struct drm_file *file_priv,
> >>  			       struct drm_gem_object *obj,
> >>  			       u32 *handlep);
> >> -- 
> >> 2.50.0
> >>
> > 
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
