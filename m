Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4B18A93E;
	Fri, 24 Jan 2025 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759118; cv=pass; b=TTh6RaYogUvFoVAptsZ/8UYZLHSw53ykiF5KLwHrLjuNXyVyDE/+Jud0tPhl1K28LWDcjAydrLYgfDWsxVVo0sHVTpMG12oTknSBMhUnXQIAuIPgzIPziz61/jWf/6IAC/dA7PDEsLd7u2EOf0AsBrXQ9lz8MCYvPafD8ttRZy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759118; c=relaxed/simple;
	bh=DpIe5FML0ndENr2N2+8/Av1CROq3XuOH7EW+EhFhn3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKFdilPfj1GzZOagCk9UgZ+ULz/Eo//VLOBNMKjAAy+gdErGJ9+QgxpfX9Q2aoFp5zo7cBh/6dvzOzKdxDaIpF/VjzWSk3HVinc+9cW3esT6qxHhjUfMCy2Su+3Z/d0g6pvRiEoyT3/FRZwYnOJodw8Ta/KRrklmTj48wxinycw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=RaiT3Md+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="RaiT3Md+"
ARC-Seal: i=1; a=rsa-sha256; t=1737759107; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DHrqJFcCYIC2F68c5koScuqC+w5A8Hn1ao6G65APbedkp/qejB6dVvM0tutue9wmg6vsz2mErHkASwXxpgz2kDe6LkKcO/9xi2FskDHyzOxFgAeNId8BlBKZmSKR0Zec+VWP4wSjtkOulSE5pNTUsC0RAYnezdvO+HlDBzKSVN8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737759107; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vsH6KdBDkbxcP1unlzXH36KboZxuXUbClTnlVcEmrWY=; 
	b=A3l/keJmuXe3udOtmFOIooFY89QLHRHgEEo7otVyYhS82in3DKXiMGvih935qGyKZFjfgnSpaR2k8ps3lnEI1oMo1pKAfBK4xrTuxVI3PBXTslLSBCAqDEInfoC7wG9f8+h4HG+Aywib5cQq0+xTAFBhVZEgcZpZfncJtq+h4gI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737759107;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vsH6KdBDkbxcP1unlzXH36KboZxuXUbClTnlVcEmrWY=;
	b=RaiT3Md+izL17pyRDVUut81nVRaCXbMSkdD3QussEK1dv+zK9rAg9t2uR+XOUhmK
	boL1VzBZLQIdzsNDqk7cmKmhIpy4Rt97n6anB9DZj4i9CGXe1YmfLnGleozj/WwjN1B
	8POJso6xxErMZYrZS1InZnzz2L5Z6mOeLFStEjgk=
Received: by mx.zohomail.com with SMTPS id 1737759102504552.0030413992171;
	Fri, 24 Jan 2025 14:51:42 -0800 (PST)
Message-ID: <a55eecdc-76cc-432e-a4b3-90e8753088ac@collabora.com>
Date: Sat, 25 Jan 2025 01:51:36 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/virtio: Align host mapping request to maximum
 platform page size
To: fnkl.kernel@gmail.com, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Sergio Lopez <slp@redhat.com>,
 Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20250124-virtgpu-mixed-page-size-v1-1-480403790bac@gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250124-virtgpu-mixed-page-size-v1-1-480403790bac@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/25/25 01:01, Sasha Finkelstein via B4 Relay wrote:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
> 
> This allows running different page sizes between host and guest on
> platforms that support mixed page sizes.
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vram.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
> index 25df81c027837c248a746e41856b5aa7e216b8d5..8a0577c2170ec9c12cad12be57f9a41c14f04660 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vram.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
> @@ -138,6 +138,12 @@ bool virtio_gpu_is_vram(struct virtio_gpu_object *bo)
>  	return bo->base.base.funcs == &virtio_gpu_vram_funcs;
>  }
>  
> +#if defined(__powerpc64__) || defined(__aarch64__) || defined(__mips__) || defined(__loongarch__)
> +#define MAX_PAGE_SIZE 65536

#define MAX_PAGE_SIZE SZ_64K

for improved readability

> +#else
> +#define MAX_PAGE_SIZE PAGE_SIZE
> +#endif
> +
>  static int virtio_gpu_vram_map(struct virtio_gpu_object *bo)
>  {
>  	int ret;
> @@ -150,8 +156,8 @@ static int virtio_gpu_vram_map(struct virtio_gpu_object *bo)
>  		return -EINVAL;
>  
>  	spin_lock(&vgdev->host_visible_lock);
> -	ret = drm_mm_insert_node(&vgdev->host_visible_mm, &vram->vram_node,
> -				 bo->base.base.size);
> +	ret = drm_mm_insert_node_generic(&vgdev->host_visible_mm, &vram->vram_node,
> +					 bo->base.base.size, MAX_PAGE_SIZE, 0, 0);

This change only reserves extra space in the memory allocator, but
doesn't change actual size of allocated BO. Instead, you likely need to
replace all ALIGN(size, PAGE_SIZE) occurrences in the driver code with
ALIGN(args->size, MAX_PAGE_SIZE)

>  	spin_unlock(&vgdev->host_visible_lock);
>  
>  	if (ret)

Note, previously a new virtio-gpu parameter was proposed to expose
host's page size to guest [1], if you haven't seen it.

[1] https://lore.kernel.org/dri-devel/20240723114914.53677-1-slp@redhat.com/

Aligning GEM's size to 64K indeed could be a good enough immediate
solution. Don't see any obvious problems with that, other than the
potential size overhead for a small BOs.

We have been running into cases where a DXVK game allocates enormous
amounts of small BOs to the point that amount reaches max number of
mappings on QEMU with amdgpu native context. On the other hand, it
showed that adding internal sub-allocator to RADV might be a worthwhile
effort. We won't change alignment on x86 with this patch and on non-x86
likely the increased size won't be noticeable, hence the proposed change
might be acceptable.

Curious what Rob Clark thinks about it. Rob, WDYT?

-- 
Best regards,
Dmitry

