Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D2B12B8E
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hCwmaf1/"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 38D4640292
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 10:59:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38D4640292
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hCwmaf1/
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AK8dhFDzc1Gs
	for <virtualization@lists.linux-foundation.org>;
	Fri, 10 Nov 2023 10:59:20 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 29C5D40556
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 10:59:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 29C5D40556
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 45E7066073F9;
	Fri, 10 Nov 2023 10:59:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1699613958;
	bh=ZwpoO39PwAcjfL9GkpofbSRYEQHZvFcfLJvO8dVtaOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hCwmaf1/GH2BOD+QU8ObZlILAodHTzNOczSmHflRumj1efPx3yYxSSS9u67/DiPc9
	 akCQp8c8oTOmR8KC+mUyP97IXWHGAnBWXdAyB2TqgNfS5I+YUO0ix490jHP7+jz5c2
	 H+2AkWtC8sXPXWLw+FbbyF2to86qEcIqtFjO/qNOkrVZq5xsZ+GX7TVYtFtRQSN6+O
	 qdC7dMsQMct6JEA0CziZ7/54ZwAM2TtiWCQ6Sm5T78vZBA/A3AgfvN97u3kJLBlmWq
	 MFuCUM9UOE59hK9dNfyWC+XWCy9ivT0Au5UIlH8rH9uluauoeexGSdEr/4/wj5O3Z/
	 Yry6w8sobEgdg==
Date: Fri, 10 Nov 2023 11:59:13 +0100
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
Subject: Re: [PATCH v18 16/26] drm/virtio: Explicitly get and put drm-shmem
 pages
Message-ID: <20231110115913.48f5672b@collabora.com>
In-Reply-To: <20231029230205.93277-17-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
	<20231029230205.93277-17-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:01:55 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> We're moving away from implicit get_pages() that is done by
> get_pages_sgt() to simplify the refcnt handling. Drivers will have
> to pin pages while they use sgt. VirtIO-GPU doesn't support shrinker,
> hence pages are pinned and sgt is valid as long as pages' use-count > 0.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index ee5d2a70656b..998f8b05ceb1 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -67,6 +67,7 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
>  
>  	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
>  	if (virtio_gpu_is_shmem(bo)) {
> +		drm_gem_shmem_put_pages(&bo->base);
>  		drm_gem_shmem_free(&bo->base);
>  	} else if (virtio_gpu_is_vram(bo)) {
>  		struct virtio_gpu_object_vram *vram = to_virtio_gpu_vram(bo);
> @@ -196,9 +197,13 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  		return PTR_ERR(shmem_obj);
>  	bo = gem_to_virtio_gpu_obj(&shmem_obj->base);
>  
> +	ret = drm_gem_shmem_get_pages(shmem_obj);
> +	if (ret)
> +		goto err_free_gem;
> +
>  	ret = virtio_gpu_resource_id_get(vgdev, &bo->hw_res_handle);
>  	if (ret < 0)
> -		goto err_free_gem;
> +		goto err_put_pages;
>  
>  	bo->dumb = params->dumb;
>  
> @@ -243,6 +248,8 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  	kvfree(ents);
>  err_put_id:
>  	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
> +err_put_pages:
> +	drm_gem_shmem_put_pages(shmem_obj);
>  err_free_gem:
>  	drm_gem_shmem_free(shmem_obj);
>  	return ret;

