Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946262DFA4E
	for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788565; cv=pass; b=GzDj4vp4XS6NVhyuJGyhYy0tn/ZaAL0pzMeHaRSTicpgCv2Wxtf4kZKwUjZXzA5Iag56tzMN38JGiCAmjGuNt5N1BdSmskGAwm68jy4b87NOT8RPaSL4sHm89OHkWnZzcQJ8VvAS9sS8e/PfG5Vz5dr5IHNxu/xNYUkX7T/oT98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788565; c=relaxed/simple;
	bh=z15lyLnxg9/V2EfHigBqjb8bejX9Y6AnQ2hc3y4917s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZSPTRxlbxkX0BnIz+7fP72z0Q5LYfisjW/6sJ6gMu/79ccCoyCvP0M9zRCUC/g5Y0/g1Yh5kztrCyoMKcijzkx5A/uqV5w1rpwLvBHlW7elJKd/MzNwjntIAPKNAqgKx0iTJxh93ADEEwke321kcevBCFexf+4bjgZXmbe0LlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=HqrJaexa; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="HqrJaexa"
ARC-Seal: i=1; a=rsa-sha256; t=1744788555; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=APaSB62EEZIT1HWumU4kzfmkspUWrlnz/Awae+k8Pwgrd2dEIH9F+Uj43oDBfOql4neIKA7BADILAPF6xC7DsxrRtZFRSYvVj/01pR3FQNJfEx2sxMyCv5yPpWcSXXMdaVx70iUy3qDp5nY31xjeuUPrt2Nr66/t33S4pP4J1dE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744788555; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PUkANMCN8iIkMKObPT/LBcWsJXo1g4Bf7rqvaDJs4NM=; 
	b=L2DgJX8naGiCehpemZ0uL+giOd9jeHr4lpkwXSL0Vhnmt4jpeSi80Xk3+bdrwX/7jdCQ/CKkb/4uCwm5XF/qRatagfD2B65BJRIY9oDuVtXN0DsJrrSUf5b1TpmoVcsKX0JsBR3kbBVBsRWLUKgFXMIeaza1cvD6RtfzF78/wtM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744788555;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PUkANMCN8iIkMKObPT/LBcWsJXo1g4Bf7rqvaDJs4NM=;
	b=HqrJaexa50S+DeYKYufChcDxobhDsrXp3jB6QQAugQjgXadgJALFjlZ06IF/Hl/0
	cyjnOLkhCdHle/vvFUyo+xx7nheWySK9tANgqaE6/NsZ5Q7yBzbdIcEHr3z76Z7MkYk
	atMbT3Bf7FIp1Bur5mceheeprcOtKXbPA22kP4Po=
Received: by mx.zohomail.com with SMTPS id 1744788552850792.253352752949;
	Wed, 16 Apr 2025 00:29:12 -0700 (PDT)
Message-ID: <d36c2ba7-52b6-4688-bb2b-70b8bd4d33c0@collabora.com>
Date: Wed, 16 Apr 2025 10:29:08 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Support drm_panic with non-vmapped shmem BO
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch, jfalempe@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250412132012.291837-1-ryasuoka@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20250412132012.291837-1-ryasuoka@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 4/12/25 16:20, Ryosuke Yasuoka wrote:
> Pass array of pages of the scanout buffer [1] to shmem BO, allowing
> drm_panic to work even if the BO is not vmapped.
> 
> [1] https://lore.kernel.org/all/20250407140138.162383-3-jfalempe@redhat.com/
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index a6f5a78f436a..2ff57d559c86 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -500,11 +500,19 @@ static int virtio_drm_get_scanout_buffer(struct drm_plane *plane,
>  
>  	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
>  
> -	/* Only support mapped shmem bo */
> -	if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach || !bo->base.vaddr)
> +	if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach)
>  		return -ENODEV;
>  
> -	iosys_map_set_vaddr(&sb->map[0], bo->base.vaddr);
> +	if (bo->base.vaddr)
> +		iosys_map_set_vaddr(&sb->map[0], bo->base.vaddr);
> +	else {
> +		struct drm_gem_shmem_object *shmem = &bo->base;
> +
> +		if (!shmem->pages)
> +			return -ENODEV;
> +		/* map scanout buffer later */
> +		sb->pages = shmem->pages;
> +	}
>  
>  	sb->format = plane->state->fb->format;
>  	sb->height = plane->state->fb->height;
> 
> base-commit: e7bb7d44c3b97aea1f0e354c6499900154ac67f2

Rebased on top of [1], fixed checkpatch warning about braces and applied
to misc-next. Thanks!

[1] https://lore.kernel.org/all/20250414131507.566072-1-tzimmermann@suse.de/

-- 
Best regards,
Dmitry
