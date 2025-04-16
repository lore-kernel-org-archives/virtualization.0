Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F3222AE7F
	for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786964; cv=pass; b=QwJlm2rrf1ao5Dk2pqE4Ko35H5dltE4LjRKfeEopa2/j6qvku4rJf8zPNIheJBdKuN/J2TFe9MrpY17BIdZypDylHuHVbAhSTAEEo/fhQwavAfjggNlBDmLfprMZ45pC1FSHXczipwpYcqFvxnJTF+iQx89P9SYmN5JnfzX7CVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786964; c=relaxed/simple;
	bh=pRKbzkJxgaqHMdybzBo+PJJQ4rGQsm4NkYN/wWKehzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9As5Ub+F/EYzyDahqeckR76Uf43LItnj82DPp9GWcbGQR4sMi5mt/mTut8+Oc+nD0pZjOKQFbPeNUxlAhQ2RXQ49+fXCXcO/EOm1qKjxUjwWwTGVQ5J7EvTL7x0Bi10tyMnmAp83H4icSttmrPirX/BKMGAXwnh3E6axYulgU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=flMM80qI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="flMM80qI"
ARC-Seal: i=1; a=rsa-sha256; t=1744786951; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KYpUsSPZ08iV51WhMV5+Xvn3HsAGdqJDQsETqTLpmBYNJw31QKIyPeO75zM7BJewStjtxUSoD6aGOrMABb+DbWMfl/xB9ka40GjtYpJgO2/duARK9xmOvz3q/+TyvnFr+PXcQIsmCZZvPznD4dtC4vpuhwZZDfrqAVPmRdUfmzg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744786951; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VvHdLu/1DjYBRDNdGpthOoaX7QDWeZcIa++hyBZ9pYY=; 
	b=OOadFqAvLhRG4wDZ2tnanPtbbPPLpuzT446gOOIfmR7M/Yzw0ukM5G8w7R7SqIsHnFwM1yXWfjnYB2hGQRbnKWmiFTLlXi+YJxtteuOdGT4E17XY0OhiggGLTc8OU96mJDYC7CDetlEpXawLBn59jqEv8ER4Z1hVy1AMMrvADw0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744786950;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VvHdLu/1DjYBRDNdGpthOoaX7QDWeZcIa++hyBZ9pYY=;
	b=flMM80qI3DjCZqkNdx1/fJw3XELhl1+/EjzFzW5hVP+oevRtvV1BnANfG7ZX9Uex
	MpzEDkW8nD3BPKJuzyQN0Aj2MYY1foyC2SgEEcq5u7k3yqgvHWusLd2Z3xDRNDPrGda
	TfA67VPdGD55zMOP9y2miUW6ZvPMMqHCI3N6EwX0=
Received: by mx.zohomail.com with SMTPS id 1744786949579725.8412945424827;
	Wed, 16 Apr 2025 00:02:29 -0700 (PDT)
Message-ID: <a48864f2-ff81-4b03-9de7-3d4959a9b301@collabora.com>
Date: Wed, 16 Apr 2025 10:02:15 +0300
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
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
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

Works well!

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
