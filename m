Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735071A5B5
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e2nUsO5N"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 00EA04047C
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 09:54:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 00EA04047C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=e2nUsO5N
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2aPkTU722iFR
	for <virtualization@lists.linux-foundation.org>;
	Mon, 13 Nov 2023 09:54:44 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CA4654013D
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 09:54:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA4654013D
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 0E5DB66071C9;
	Mon, 13 Nov 2023 09:54:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1699869282;
	bh=9bDqGXVfCHUlHc3hp7s0FADRMoSPM6UPpCOfpTvFpJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e2nUsO5N4mioF5D9r3oXlR2JsjGkqpom9d2RaVinEXcVe1eS4jchoB4tvp/1/zhJm
	 SxgoR/Ml0EK9e+jaGd7BU6CQq4MFvbdg5Uw2emYy3fqOMQJHk2GztiQ15rboQCvX4X
	 bBAVkLFm0XEe611DKwX4Jc/CGmJuoTNybITKl2drTSkZf5fgiHaBbDLVyZulRES/m0
	 QNRNUMGmpcPvp1WqhYl52AHwP2228zWuLvjaDSs0ND1GftAua1AEw2lxk+5cZolPOx
	 Miq8/zNSNNAXxlb1ckIBi3PMW2syUksnIxwu6BDbuXMDrrpHxjhm21Brza5nlwbLvL
	 RGXPxrky1YIGQ==
Date: Mon, 13 Nov 2023 10:54:38 +0100
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
Subject: Re: [PATCH v18 22/26] drm/shmem-helper: Don't free refcounted GEM
Message-ID: <20231113105438.60896fdf@collabora.com>
In-Reply-To: <20231029230205.93277-23-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
	<20231029230205.93277-23-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:02:01 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Don't free refcounted shmem object to prevent use-after-free bug that
> is worse than a memory leak.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 6dd087f19ea3..4253c367dc07 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -203,9 +203,10 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>  	if (obj->import_attach)
>  		drm_prime_gem_destroy(obj, shmem->sgt);
>  
> -	drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
> -	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count));
> -	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
> +	if (drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count)) ||
> +	    drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count)) ||
> +	    drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count)))
> +		return;

I guess you're worried about ->sgt being referenced by the driver after
the GEM is destroyed. If we assume drivers don't cache the sgt and
always call get_pages_sgt() when they need it that shouldn't be an
issue. What we really don't want to release is the pages themselves,
but the GPU MMU might still have active mappings pointing to these
pages.

In any case, I'm not against leaking the GEM object when any of these
counters are not zero, but can we at least have a comment in the
code explaining why we're doing that, so people don't have to go look
at the git history to figure it out.

>  
>  	drm_gem_object_release(obj);
>  	kfree(shmem);

