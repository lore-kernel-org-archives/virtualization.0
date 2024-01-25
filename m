Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083B1BC26
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173800; cv=none; b=UoX20YW4zPhXnxjRCJQIL7Ol66SDXzuOx+vOLa4L4OKdw0ITlUHlcs7thDbV01AZHLhxw0Y+O5pXhoysWMSRUnCZSoTInXs1UOowWJYi5QArnxtcLxAf7uB0B+YnWALj1yOf8pqJCK4knzkpR8nBROyAeRvh3mfLStOU2NPh0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173800; c=relaxed/simple;
	bh=NHDMTimolpsRG953VM4h8IMbAP81NqnGQx5H5gz6gU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qc6brChNaF7Hrkd4dxTyPgr42qocg0371pD4d0KC8FS8HZTybp9bm4KSbKdU0QtWn7/ItPCz4Abb+B0WnQwSV7WYtESwnZH+0fNmucdkacrIl7d8Q/dPDvdMuH/9FQYuLS9QZevBkEbg6H6sT4Cc/YNqoRggIL85Ow8eMhSxgUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K0ZTZHJe; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K0ZTZHJe"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E0FE81E49
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 09:09:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E0FE81E49
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=K0ZTZHJe
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Tz8x3PcQfJk
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 09:09:57 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8445081E35
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 09:09:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8445081E35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706173795;
	bh=NHDMTimolpsRG953VM4h8IMbAP81NqnGQx5H5gz6gU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K0ZTZHJe5DZ9eZa4kY8kwa5c00th4E7Z2PjeeRbHuwJy+8xK/N6CC4lfGXky/r0OS
	 Ihti4C3jApFsg/nNsItAAgnCZVanT3LBCNg2G1sFAy51jNUrvge1o6Uwk5w6/oiK/z
	 x1YmGTJBGb7WpMkpwXmLkQtfGeMHxptiY+aPjYksvCVR5E9zFb9OZd13mHYsvnXwrF
	 gXt0zN7eYiCnXuUPVM3ZFmPRITxlhSAaclIA0JKi7W8W3qi6YSYvWwXufIkmmDQdj+
	 PUuRzQeWW1/1mxvg7r9NOM34GUFf7XYV2PARmb4wSE72XJpZhIXWU0JMvNviujWGvL
	 SOBFRw/I5nb8Q==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A788237813C4;
	Thu, 25 Jan 2024 09:09:54 +0000 (UTC)
Date: Thu, 25 Jan 2024 10:09:53 +0100
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
Subject: Re: [PATCH v19 23/30] drm/shmem-helper: Export
 drm_gem_shmem_get_pages_sgt_locked()
Message-ID: <20240125100953.34340d4f@collabora.com>
In-Reply-To: <20240105184624.508603-24-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-24-dmitry.osipenko@collabora.com>
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

On Fri,  5 Jan 2024 21:46:17 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Export drm_gem_shmem_get_pages_sgt_locked() that will be used by virtio-gpu
> shrinker during GEM swap-in operation done under the held reservation lock.
> 

Nit: I'd move that patch before "drm/shmem-helper: Add common memory
shrinker", because you'll need to call
drm_gem_shmem_get_pages_locked() and
drm_gem_shmem_get_pages_sgt_locked() if you want to repopulate the MMU
page table after when an eviction happened (see my comment on patch 22).

> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 22 +++++++++++++++++++++-
>  include/drm/drm_gem_shmem_helper.h     |  1 +
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 59cebd1e35af..8fd7851c088b 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -875,12 +875,31 @@ struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem)
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_get_sg_table);
>  
> -static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_object *shmem)
> +/**
> + * drm_gem_shmem_get_pages_sgt_locked - Provide a scatter/gather table of pinned
> + *                                      pages for a shmem GEM object
> + * @shmem: shmem GEM object
> + *
> + * This is a locked version of @drm_gem_shmem_get_sg_table that exports a
> + * scatter/gather table suitable for PRIME usage by calling the standard
> + * DMA mapping API.
> + *
> + * Drivers must hold GEM's reservation lock when using this function.
> + *
> + * Drivers who need to acquire an scatter/gather table for objects need to call
> + * drm_gem_shmem_get_pages_sgt() instead.
> + *
> + * Returns:
> + * A pointer to the scatter/gather table of pinned pages or error pointer on failure.
> + */
> +struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_object *shmem)
>  {
>  	struct drm_gem_object *obj = &shmem->base;
>  	int ret;
>  	struct sg_table *sgt;
>  
> +	dma_resv_assert_held(shmem->base.resv);
> +
>  	if (shmem->sgt)
>  		return shmem->sgt;
>  
> @@ -904,6 +923,7 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
>  	kfree(sgt);
>  	return ERR_PTR(ret);
>  }
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_get_pages_sgt_locked);
>  
>  /**
>   * drm_gem_shmem_get_pages_sgt - Pin pages, dma map them, and return a
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index df97c11fc99a..167f00f089de 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -149,6 +149,7 @@ void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem);
>  
>  struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem);
>  struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem);
> +struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_object *shmem);
>  
>  void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
>  			      struct drm_printer *p, unsigned int indent);

