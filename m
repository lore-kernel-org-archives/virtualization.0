Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF6D1F941;
	Sun, 19 Jan 2025 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737287424; cv=pass; b=UFHpDeauc1gPxdTIH1P/IRh0UQWIaAQk0eXDEbh+Jy+wJmReekPJprqeXmvrmrSc11ZDjphFYBX89WWQfj5PZSt2Y+kT4AfqzJcoCjRP7bZfqqOdFw6b1U13rCEOg6dlrkGwsj9bv+/iEM0boNriGtJcZRNcjCIc6VbET9HWloQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737287424; c=relaxed/simple;
	bh=/yXE+gln6X+vRVAoJ2zpXCCs+a1FmRlkPZClz0jTXME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFkH8JoO9gcPu7BW12H/ysEaz0q/KTOLYH0gaT3M5Hu8w75LXMAkAYhPHEFSIzYK9Zq5U2KF9F7QKB2Vl36XLJ0GovoVKi0dCOvEUhxKtLOYVsNqE3cBucuqm9yJ2rJnLxh6RhYUEiQ7MIkvOV8xsMVBCZne2Q8pPLQu/2wL2ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=V6J9IOss; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="V6J9IOss"
ARC-Seal: i=1; a=rsa-sha256; t=1737287415; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bi7Y0DJIuxhsfuxA8Nj8+4gXie9/EDv6whpLe5Ul7JHG8aEwuiWJAGwsOdZojWpI56TXjwi0yDuJD7/Gn6xPXv1C0ZhAnQW2exNjl4rERvV5jOwzzftDTbGETSlzG2BkaXg7zLzuQNrxV1KZMvEo/jUcWhvHOhNo3zKMIgFOF60=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737287415; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NX14ZjnOfcW9Ml3QJ940u0wzQc8hfZoz4ZMPmB9xgXE=; 
	b=aH/PZ4Y5t4blNxCSbDkPvWdVWizsFbDgpVkzYicl+11EGaUOIwFUgssQpNQzi8ktWkOkCEM/SvuYvcXR+vXMrO76SpfFv+f2Vej9HSqpxbwpr3bHWQiNbHiqpXFdelTb6NCKdRqrdUwWHdAHm0UVKhym6/U3V8fQi1vP3+TXC8Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737287414;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NX14ZjnOfcW9Ml3QJ940u0wzQc8hfZoz4ZMPmB9xgXE=;
	b=V6J9IOssEG5THySGrmk8fOdw89rfPVO18SSRRwZy4PhQvuyUM3vWuX0EuDQVWNis
	M6dlnTw7Qn0YQf+zabBGyXPHq+d+LAae+5LXFsio6qiEjyKjk7Q4AB6swjy35BQdUZt
	J04ixhgXVka0HOzwtkzuvUCtcCZomqfdGpks3CY8=
Received: by mx.zohomail.com with SMTPS id 1737287411991335.1037660613164;
	Sun, 19 Jan 2025 03:50:11 -0800 (PST)
Message-ID: <2f51584c-0590-432b-a4db-7a2af99cde15@collabora.com>
Date: Sun, 19 Jan 2025 14:50:07 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Support partial maps of GEM objects
To: fnkl.kernel@gmail.com, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20250109-virtgpu-gem-partial-map-v1-1-a914b48776bd@gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20250109-virtgpu-gem-partial-map-v1-1-a914b48776bd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi,

On 1/10/25 00:45, Sasha Finkelstein via B4 Relay wrote:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
> 
> Those are useful to implement coherent cross-vm mmap.
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vram.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
> index 25df81c027837c248a746e41856b5aa7e216b8d5..64e2c6dbdd678ac4c0da89fdd4c9dbf937c2c335 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vram.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
> @@ -56,12 +56,11 @@ static int virtio_gpu_vram_mmap(struct drm_gem_object *obj,
>  	else if (vram->map_info == VIRTIO_GPU_MAP_CACHE_UNCACHED)
>  		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  
> -	/* Partial mappings of GEM buffers don't happen much in practice. */
> -	if (vm_size != vram->vram_node.size)
> +	if (vm_size > vram->vram_node.size)
>  		return -EINVAL;
>  
>  	ret = io_remap_pfn_range(vma, vma->vm_start,
> -				 vram->vram_node.start >> PAGE_SHIFT,
> +				 (vram->vram_node.start >> PAGE_SHIFT) + vma->vm_pgoff,
>  				 vm_size, vma->vm_page_prot);
>  	return ret;
>  }

The vma->vm_pgoff is fake in DRM, it's used for looking up DRM GEM
object based on the vma->vm_pgoff value when mmap is invoked. The
vma->vm_pgoff should be treated as zero here. Hence we can map a part of
GEM, but only from its start. See drm_gem_mmap().

BTW, partial mapping is wanted by Intel native context that I work on.
The intent of this patch is correct. There are practical uses for
partial mappings.

Please correct vma->vm_pgoff in v2.

-- 
Best regards,
Dmitry

