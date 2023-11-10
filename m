Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102D12B75
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Hbb8LDTQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42C3C60F97
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 11:01:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42C3C60F97
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Hbb8LDTQ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ZTcyfSpXgeN
	for <virtualization@lists.linux-foundation.org>;
	Fri, 10 Nov 2023 11:01:29 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6DF0260E6F
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 11:01:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DF0260E6F
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 8A25A66073EB;
	Fri, 10 Nov 2023 11:01:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1699614087;
	bh=M7g15Ds3YB0rAZrwMqFqhvf/l8gr3sjjjFteM0C28zs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hbb8LDTQq4RSYvyQKXhwzEaFY3S/PSmM2XeVj8XNi5/pmEFm+CXppTiuTj7QD4CZx
	 8co2y4KUpNxbre2QFzUUcxRA8sCPdl2Z+jxgtbG+80PTAsE9BoMeC5F14w0W1jgmz/
	 OV5w1DJ/ocBfKg7xRQQelCeq/r68xhZxMOmsrL02W9qe9LuCWJhmbL6HHGAUD/0Ttf
	 gHYguXb0/fxr81PZJhFrPt7GM8DXDF0KWVIHuuXNSLRCIbzrQHP/Aq36d0BSVXWFpV
	 IZTIsIKBR0jzOw9XBpgwo9WUTuSuRdYKExb716IYVxzMjqPM6sGpodGY933J8AqFLT
	 c9mLE9lfwOacw==
Date: Fri, 10 Nov 2023 12:01:23 +0100
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
Subject: Re: [PATCH v18 17/26] drm/v3d: Explicitly get and put drm-shmem
 pages
Message-ID: <20231110120123.65f399af@collabora.com>
In-Reply-To: <20231029230205.93277-18-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
	<20231029230205.93277-18-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:01:56 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> To simplify the drm-shmem refcnt handling, we're moving away from
> the implicit get_pages() that is used by get_pages_sgt(). From now on
> drivers will have to pin pages while they use sgt. V3D driver doesn't
> support shrinker, hence pages are pinned and sgt is valid as long as
> pages' use-count > 0.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/v3d/v3d_bo.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index 42cd874f6810..0597c6b01b6c 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -47,6 +47,9 @@ void v3d_free_object(struct drm_gem_object *obj)
>  	/* GPU execution may have dirtied any pages in the BO. */
>  	bo->base.pages_mark_dirty_on_put = true;
>  
> +	if (!obj->import_attach)
> +		drm_gem_shmem_put_pages(&bo->base);
> +
>  	drm_gem_shmem_free(&bo->base);
>  }
>  
> @@ -135,12 +138,18 @@ struct v3d_bo *v3d_bo_create(struct drm_device *dev, struct drm_file *file_priv,
>  		return ERR_CAST(shmem_obj);
>  	bo = to_v3d_bo(&shmem_obj->base);
>  
> -	ret = v3d_bo_create_finish(&shmem_obj->base);
> +	ret = drm_gem_shmem_get_pages(shmem_obj);
>  	if (ret)
>  		goto free_obj;
>  
> +	ret = v3d_bo_create_finish(&shmem_obj->base);
> +	if (ret)
> +		goto put_pages;
> +
>  	return bo;
>  
> +put_pages:
> +	drm_gem_shmem_put_pages(shmem_obj);
>  free_obj:
>  	drm_gem_shmem_free(shmem_obj);
>  	return ERR_PTR(ret);

