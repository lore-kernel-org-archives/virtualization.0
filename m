Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3961F130E2E
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203452; cv=none; b=J410XXQLSsrm/0sEyQKaXvzxlF/S/Qn9xNUy2Tq7mMfoGWXb/w7n5iWtEcMRNQCP5UiqtBDRDvDWTwI6TVyufxE4O+dYA3maE9q0WI+e0ufrFOFgBFPU9nSQ5grzQkyCv83+ET38fqUDQ59IGvLsR9oxbI4wiyL0W2DCs7rbT5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203452; c=relaxed/simple;
	bh=pN+3JLvgZuxWpzfCdjXsvEeAJE25pFqQJfq6WIwGZes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sR0EC09Z3t3dbkhgSPl29JfWXLYLjJjgo2nKwTIcHXsAM8h4OP4J+j0+8F7cPcMB77secm7qCSwNT25TmvpgA4xXk2ExACxxlZatqlNlBxZa8jS+67RkU9bBvHNJpF9SQ3fACxrK0RyZrgugKJfHGHkxZbrpiopno1Nf7DgW+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=QYZQoZxR; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QYZQoZxR"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6AFAA42EE8
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 17:24:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6AFAA42EE8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=QYZQoZxR
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.998
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u1_fh30ryu4P
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 17:24:09 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 00A8C401D8
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 17:24:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 00A8C401D8
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a3169f46d73so29112166b.1
        for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 09:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706203447; x=1706808247; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYX/oCAVtAPg69GHLfdJ2n+S0oxX9mTXkx6MsR4rCD4=;
        b=QYZQoZxRJlMvhFLBIEzK4MDadzZihItjCgRAQoB0yqPkWwXjDzjo+BcV3MPFxIQ3m2
         e6dmz10HtPbLpW7ivyWhONIPMqHPUONMGL42LSXGybMH/8Sr3+Sz1lQ/2bTxsAtknzlL
         B0bqrXX+SsA9wHZfiBqEY3kASSi2l7Sue+NN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706203447; x=1706808247;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYX/oCAVtAPg69GHLfdJ2n+S0oxX9mTXkx6MsR4rCD4=;
        b=WsO962e8DF1TtZbr0p4IJehKa7Q7k85toVFGYfKmhejzFcUrzVI8kUnp4IrGaM+KMF
         oZp/9nVIUNTeu519bq0jdoUpR9xfmjFN6lUOVaG2zB7AygjBXQK1sNR6xUyAUEkIvazQ
         yUgeCSwsi0mm3YoO1PMPBhBRliNNjewYjM5PseJT02COOlok/aJI+8Lzf31bhDHMfGFq
         UyEeF5IhIdAL2HJ2N+fVuaYLJsRavW7Zj+Py9jEoLIFYv6QObs05t6x+njdDZlB0D/M6
         5lliDlqAN0g9jpHOUckqr6zG/A4j76khdb+vMjp14zTZ5ZxDhXM1J+AEP9CbaBoUMTpG
         z5tA==
X-Gm-Message-State: AOJu0Yx/w3uL4xfEfBP2EaZ4bm+WEqF7dlChmki6u9RprlVHpBIGfgoz
	MQ/dJnPKaihCNBgLzukHmeuEtljXR8+30RtdHJ88gknXGfGMWoP/99R3M4IQBiE=
X-Google-Smtp-Source: AGHT+IF3318fNOR+ap3x+yUcMMLZkmzP+Galesm9kpVsUuEFWjctO0BMvGCKCtmYfQFhZl2XpoFOgg==
X-Received: by 2002:a17:906:16c4:b0:a2a:6916:60de with SMTP id t4-20020a17090616c400b00a2a691660demr1634893ejd.4.1706203446668;
        Thu, 25 Jan 2024 09:24:06 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o10-20020a17090608ca00b00a2eb648cdc5sm1222102eje.156.2024.01.25.09.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:24:06 -0800 (PST)
Date: Thu, 25 Jan 2024 18:24:04 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v19 09/30] drm/shmem-helper: Add and use lockless
 drm_gem_shmem_get_pages()
Message-ID: <ZbKZNCbZoV4ovWTH@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-10-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105184624.508603-10-dmitry.osipenko@collabora.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Fri, Jan 05, 2024 at 09:46:03PM +0300, Dmitry Osipenko wrote:
> Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
> lock if pages_use_count is non-zero, leveraging from atomicity of the
> refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index cacf0f8c42e2..1c032513abf1 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -226,6 +226,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
>  
> +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
> +{
> +	int ret;

Just random drive-by comment: a might_lock annotation here might be good,
or people could hit some really interesting bugs that are rather hard to
reproduce ...
-Sima

> +
> +	if (refcount_inc_not_zero(&shmem->pages_use_count))
> +		return 0;
> +
> +	dma_resv_lock(shmem->base.resv, NULL);
> +	ret = drm_gem_shmem_get_pages_locked(shmem);
> +	dma_resv_unlock(shmem->base.resv);
> +
> +	return ret;
> +}
> +
>  static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
>  {
>  	int ret;
> @@ -609,10 +623,7 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
>  		return ret;
>  	}
>  
> -	dma_resv_lock(shmem->base.resv, NULL);
> -	ret = drm_gem_shmem_get_pages_locked(shmem);
> -	dma_resv_unlock(shmem->base.resv);
> -
> +	ret = drm_gem_shmem_get_pages(shmem);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.43.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
