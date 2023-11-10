Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A63134A0
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ga1uUKYE"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E59260D58
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 10:08:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E59260D58
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Ga1uUKYE
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fgTFPMoE_831
	for <virtualization@lists.linux-foundation.org>;
	Fri, 10 Nov 2023 10:08:37 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D982060B73
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 10:08:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D982060B73
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id D67ED66073F9;
	Fri, 10 Nov 2023 10:08:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1699610911;
	bh=KCYQjuvBuxZp544n/rzQNo2zbiK+/sDsQ1UcXNqg44c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ga1uUKYEYCxW4M5uvTyMJDuwJVeGOEZ1DEQ98wI3oCLBEWy3cc8/mOKBCocZ5CuU+
	 +HNrw2nmDv1I60Kk7dZyOe1V60UfJx9TBu6TNhuh9jiC3cJ+Vcx+ThSpwkTq4poeUm
	 bj2JyogkeSVigN7Vyo35bL/Hi7djIgpLxgb6qWKPSnKITT4JeODZHplMr+aaFgQu0H
	 fsRTMlw5xC/jRBFTf9wF973yBzyhu0KrRXGjqPwb9Mu/dwdw28fKvxLLuABomhEoBt
	 fZtrxS16lXVRU3nK41IxD/cAYZg1hWSsaTZ2T/NzHAkBjSztxBR6qIRBnfNIwsY4Um
	 VVtL/U+4IFMwQ==
Date: Fri, 10 Nov 2023 11:08:27 +0100
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
Subject: Re: [PATCH v18 05/26] drm/shmem-helper: Remove obsoleted is_iomem
 test
Message-ID: <20231110110827.403bdbeb@collabora.com>
In-Reply-To: <20231029230205.93277-6-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
	<20231029230205.93277-6-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:01:44 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Everything that uses the mapped buffer should be agnostic to is_iomem.
> The only reason for the is_iomem test is that we're setting shmem->vaddr
> to the returned map->vaddr. Now that the shmem->vaddr code is gone, remove
> the obsoleted is_iomem test to clean up the code.
> 
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 154585ddae08..2cc0601865f6 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -315,12 +315,6 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
>  
>  	if (obj->import_attach) {
>  		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
> -		if (!ret) {
> -			if (drm_WARN_ON(obj->dev, map->is_iomem)) {
> -				dma_buf_vunmap(obj->import_attach->dmabuf, map);
> -				return -EIO;
> -			}
> -		}
>  	} else {
>  		pgprot_t prot = PAGE_KERNEL;
>  

