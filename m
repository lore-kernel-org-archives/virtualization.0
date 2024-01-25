Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B717552
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169710; cv=none; b=r8gUAJ/hqMmYZHL2lesEtLsS00M1JCFPHJsVhCJP5UMlWGf5QgivA1uyoKriCisvSjhS8T7yej5BRfZJqjy7x9LGzAOauMTUrv1oIgAtxBZoPkeMDbUUcTpxENQ2RVWPxgoIx4B5JL6C5kApY78UCGuG1U7sg8Jc72QG/LLBGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169710; c=relaxed/simple;
	bh=bgYrY710zE0n7NaiomkjGwNqYaJh8yofMt9szROI5qc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTGVoZIdvyo7fMhUUTGQXsBiHSF/dpQlaLXCDNWFhR/9BAWwDXo6OCi1uo2fNava4dnBYbq78jamNXH6Y9rHU976CSeUdKidc6DF/c3O+MXfKm4ChB+kWBVI41b2168IhgUM4YUqTEnngRVuZlmn7UvNUqOoJIvQsB69FH+x84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CB11jswu; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CB11jswu"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05F8D41D86
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 08:01:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05F8D41D86
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=CB11jswu
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5qYHnROoKIwl
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 08:01:48 +0000 (UTC)
X-Greylist: delayed 400 seconds by postgrey-1.37 at util1.osuosl.org; Thu, 25 Jan 2024 08:01:48 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2368641D7C
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2368641D7C
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 08:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706169704;
	bh=bgYrY710zE0n7NaiomkjGwNqYaJh8yofMt9szROI5qc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CB11jswucIzbhJbBtZc3wkQYu5HWz8rE9Xyc0rQ/HRP2PNlZHsY+nX68ekWlmzUFY
	 zc4t07YHF7fB48DJjJSYcOJam38/InXT1Iea+YaN7+xkcVN8Yk58OBB5BTDS7bQg0C
	 pYiHpSHj2ttYcbeWStbOV1R5iTSiqWamVARXGLbKxNkKhG40pKIMjoj1xqQ9bDKTDh
	 4CiBLfA73FhEnPIRPAIel9cfOJtF7YV4cXaxYGBpV032AzeyyvS8zCu15fuH1Fg261
	 Pjypmy1q5BGeshI4evFF0rKew5zzNLy2Io/BxOAYoFXc512VK8JcW3sdQ8V3AsT7Ft
	 lLyQD9fjZ/2Cg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4CCB437820AF;
	Thu, 25 Jan 2024 08:01:43 +0000 (UTC)
Date: Thu, 25 Jan 2024 09:01:41 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Qiang Yu <yuq825@gmail.com>, Steven Price
 <steven.price@arm.com>, Emma Anholt <emma@anholt.net>, Melissa Wen
 <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v19 12/30] drm/shmem-helper: Prepare
 drm_gem_shmem_free() to shrinker addition
Message-ID: <20240125090141.4e193d19@collabora.com>
In-Reply-To: <20240105184624.508603-13-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-13-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jan 2024 21:46:06 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Prepare drm_gem_shmem_free() to addition of memory shrinker support
> to drm-shmem by adding and using variant of put_pages() that doesn't
> touch reservation lock. Reservation shouldn't be touched because lockdep
> will trigger a bogus warning about locking contention with fs_reclaim
> code paths that can't happen during the time when GEM is freed and
> lockdep doesn't know about that.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 40 ++++++++++++++------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 3403700780c3..799a3c5015ad 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -128,6 +128,22 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_create);
>  
> +static void
> +drm_gem_shmem_free_pages(struct drm_gem_shmem_object *shmem)
> +{
> +	struct drm_gem_object *obj = &shmem->base;
> +
> +#ifdef CONFIG_X86
> +	if (shmem->map_wc)
> +		set_pages_array_wb(shmem->pages, obj->size >> PAGE_SHIFT);
> +#endif
> +
> +	drm_gem_put_pages(obj, shmem->pages,
> +			  shmem->pages_mark_dirty_on_put,
> +			  shmem->pages_mark_accessed_on_put);
> +	shmem->pages = NULL;
> +}
> +
>  /**
>   * drm_gem_shmem_free - Free resources associated with a shmem GEM object
>   * @shmem: shmem GEM object to free
> @@ -142,8 +158,6 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>  	if (obj->import_attach) {
>  		drm_prime_gem_destroy(obj, shmem->sgt);
>  	} else {
> -		dma_resv_lock(shmem->base.resv, NULL);
> -
>  		drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
>  
>  		if (shmem->sgt) {
> @@ -152,13 +166,12 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>  			sg_free_table(shmem->sgt);
>  			kfree(shmem->sgt);
>  		}
> -		if (shmem->pages)
> -			drm_gem_shmem_put_pages_locked(shmem);
> +		if (shmem->pages &&
> +		    refcount_dec_and_test(&shmem->pages_use_count))
> +			drm_gem_shmem_free_pages(shmem);
>  
>  		drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count));
>  		drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
> -
> -		dma_resv_unlock(shmem->base.resv);
>  	}
>  
>  	drm_gem_object_release(obj);
> @@ -208,21 +221,10 @@ static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
>   */
>  void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
>  {
> -	struct drm_gem_object *obj = &shmem->base;
> -
>  	dma_resv_assert_held(shmem->base.resv);
>  
> -	if (refcount_dec_and_test(&shmem->pages_use_count)) {
> -#ifdef CONFIG_X86
> -		if (shmem->map_wc)
> -			set_pages_array_wb(shmem->pages, obj->size >> PAGE_SHIFT);
> -#endif
> -
> -		drm_gem_put_pages(obj, shmem->pages,
> -				  shmem->pages_mark_dirty_on_put,
> -				  shmem->pages_mark_accessed_on_put);
> -		shmem->pages = NULL;
> -	}
> +	if (refcount_dec_and_test(&shmem->pages_use_count))
> +		drm_gem_shmem_free_pages(shmem);
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
>  

