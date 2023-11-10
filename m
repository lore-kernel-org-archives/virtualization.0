Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30A12B75
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GUde9qeo"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2E8A82269
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 10:54:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2E8A82269
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=GUde9qeo
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E4WizZPU13kR
	for <virtualization@lists.linux-foundation.org>;
	Fri, 10 Nov 2023 10:54:02 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B284882263
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 10:54:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B284882263
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 7507266073E5;
	Fri, 10 Nov 2023 10:53:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1699613639;
	bh=7zX1VEgiMUv93VPzTl7ntimr/mmmRRrBd4yOYvFZgw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GUde9qeoRMAqb2soKoAU2Sc+G067iLuAB0lGwLT2YtUX5rujIXF6eSzPXtzjMfipR
	 Z4FXCU/AjXv1hkE7VbaU8S9Ch0s2SMO+DcKXEtg6ja9wPomqMSbdPPhT4anyZOZb1B
	 XqQdljSwKx8pv0ha2ZKddptU2VzkXLTg9HQYnGDoJ+lge2IbiMY3MEhof0atyKwyq7
	 9ToH3OK/CnHj3YKv8hCIKIyFo0TqB7om/P5E0ZIXQa/qAueGRYU3GFb5m7RYW6hxnV
	 69IQJuMjrsVoknd5TitRYxRHiDaBj1DVT4Q/SOHHsrAZZsDV1D2kxOG+3BbViet9rW
	 lGcqj1IVUrMjw==
Date: Fri, 10 Nov 2023 11:53:54 +0100
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
Subject: Re: [PATCH v18 15/26] drm/panfrost: Explicitly get and put
 drm-shmem pages
Message-ID: <20231110115354.356c87f7@collabora.com>
In-Reply-To: <20231029230205.93277-16-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
	<20231029230205.93277-16-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Oct 2023 02:01:54 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> To simplify the drm-shmem refcnt handling, we're moving away from
> the implicit get_pages() that is used by get_pages_sgt(). From now on
> drivers will have to pin pages while they use sgt. Panfrost's shrinker
> doesn't support swapping out BOs, hence pages are pinned and sgt is valid
> as long as pages' use-count > 0.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 17 +++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_mmu.c |  6 ++----
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index 6b77d8cebcb2..bb9d43cf7c3c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -47,8 +47,13 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
>  			}
>  		}
>  		kvfree(bo->sgts);
> +
> +		drm_gem_shmem_put_pages(&bo->base);
>  	}
>  
> +	if (!bo->is_heap && !obj->import_attach)
> +		drm_gem_shmem_put_pages(&bo->base);
> +
>  	drm_gem_shmem_free(&bo->base);
>  }
>  
> @@ -269,6 +274,7 @@ panfrost_gem_create(struct drm_device *dev, size_t size, u32 flags)
>  {
>  	struct drm_gem_shmem_object *shmem;
>  	struct panfrost_gem_object *bo;
> +	int err;
>  
>  	/* Round up heap allocations to 2MB to keep fault handling simple */
>  	if (flags & PANFROST_BO_HEAP)
> @@ -282,7 +288,18 @@ panfrost_gem_create(struct drm_device *dev, size_t size, u32 flags)
>  	bo->noexec = !!(flags & PANFROST_BO_NOEXEC);
>  	bo->is_heap = !!(flags & PANFROST_BO_HEAP);
>  
> +	if (!bo->is_heap) {
> +		err = drm_gem_shmem_get_pages(shmem);

Hm, there was no drm_gem_shmem_get_pages_sgt() call here, why should we
add a drm_gem_shmem_get_pages()? What we should do instead is add a
drm_gem_shmem_get_pages() for each drm_gem_shmem_get_pages_sgt() we
have in the driver (in panfrost_mmu_map()), and add
drm_gem_shmem_put_pages() calls where they are missing
(panfrost_mmu_unmap()).

> +		if (err)
> +			goto err_free;
> +	}
> +
>  	return bo;
> +
> +err_free:
> +	drm_gem_shmem_free(&bo->base);
> +
> +	return ERR_PTR(err);
>  }
>  
>  struct drm_gem_object *
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 770dab1942c2..ac145a98377b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -504,7 +504,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>  		if (IS_ERR(pages[i])) {
>  			ret = PTR_ERR(pages[i]);
>  			pages[i] = NULL;
> -			goto err_pages;
> +			goto err_unlock;
>  		}
>  	}
>  
> @@ -512,7 +512,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>  	ret = sg_alloc_table_from_pages(sgt, pages + page_offset,
>  					NUM_FAULT_PAGES, 0, SZ_2M, GFP_KERNEL);
>  	if (ret)
> -		goto err_pages;
> +		goto err_unlock;

Feels like the panfrost_gem_mapping object should hold a ref on the BO
pages, not the BO itself, because, ultimately, the user of the BO is
the GPU. This matches what I was saying about moving get/put_pages() to
panfrost_mmu_map/unmap(): everytime a panfrost_gem_mapping becomes
active, to want to take a pages ref, every time it becomes inactive,
you should release the pages ref.

>  
>  	ret = dma_map_sgtable(pfdev->dev, sgt, DMA_BIDIRECTIONAL, 0);
>  	if (ret)
> @@ -535,8 +535,6 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>  
>  err_map:
>  	sg_free_table(sgt);
> -err_pages:
> -	drm_gem_shmem_put_pages_locked(&bo->base);
>  err_unlock:
>  	dma_resv_unlock(obj->resv);
>  err_bo:

