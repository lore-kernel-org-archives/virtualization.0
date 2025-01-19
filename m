Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B60417FAC2;
	Sun, 19 Jan 2025 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737316971; cv=pass; b=H2sam4T11uC5ZqHLn1aFvK/OXvYal+3FRGASfYbNTEOlnI7EX8iKg8R/OFfBK7/GOhYHMHM+GIfm1f7XJ8D0tz3D9XWg+cJqXMT4KJru8zfyJTNFtoNpgRduWzLEjL0h+wkaR0Py4C5ILKQ0YkOIZA9p22pKdaAX7hdc+Qx/vH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737316971; c=relaxed/simple;
	bh=RJ+3cRaTkGyhecAZDEypx2kwtVQdcRkh4OpxZ+cDuwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNXGJWlYJpaya6ZSM4nGWMmcUOoiO8yRLS1TbGrHvrhhhF70lm3Y58QXXbxS18WlS7HSuKert4RTDvA37Jg5rHRvt1EOCiT7Nc2+G8PtmzLVObEpCODa1E0k2ku8/aB6Xp12U1t7QyrZtJxF3yeCSYzMQ64xckIanwmvjFabB8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=OJS8KahW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="OJS8KahW"
ARC-Seal: i=1; a=rsa-sha256; t=1737316961; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=beC1LHora5gXzb8vQYKjgV/Mg3lYljFtC6KIAFumDxOYl/0w4g70Zm2aDJ4sDULZUcTPpibGegkT81KgXf/cw7w0y8ATcWd9Xnv6FuYzFOGYKc9Nb/GkFPtnurFWCeeX/U3dg0/pVqNOrSglz8tSs1Bs1NbuPC5B4fNJoRcyTz8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737316961; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D4dwcubPkPtRrLkzyOZzR4BzI+5nrXqEN7ot+ch3GgI=; 
	b=bC02UkPjjn03yS8NXjDQiUhpFhKExdRYqOeJsLe/0BXpOH3WcRBhV9Y9KkYl7uvCy/EQZ/wMWEofIs4AErYWsqou9rpArjHeDkm9ErMKFT0Vj4SAxBsS/oLIO+kBkadjHZk4hS0NrzBOJgT3AEnDy9xl1jFfk9DQu5UrNMU5BKE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737316961;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=D4dwcubPkPtRrLkzyOZzR4BzI+5nrXqEN7ot+ch3GgI=;
	b=OJS8KahWiV2S6XGSS013rEhxhfDIE1BeK5SgdTA0LcQqh79i1pNIgW2UEMwX+aRu
	3AcyK1XVn+Bm0vF21nISupYMFvZVUFEOs39Druanb7wXbiik9cXUlcScZpS9hx3P/Z+
	z1782qT1EHMWnvetK3mio5M+Mwu8EtHYQocuNtnE=
Received: by mx.zohomail.com with SMTPS id 1737316958659120.36088823874036;
	Sun, 19 Jan 2025 12:02:38 -0800 (PST)
Message-ID: <a6b7a3a1-e6f9-4da7-96b3-62aefb82dced@collabora.com>
Date: Sun, 19 Jan 2025 23:02:34 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Support partial maps of GEM objects
To: Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev
References: <20250109-virtgpu-gem-partial-map-v1-1-a914b48776bd@gmail.com>
 <2f51584c-0590-432b-a4db-7a2af99cde15@collabora.com>
 <CAMT+MTT11xg-14KrcqUTx3DxF=1NnYZAMY8RoZFoTesc0zEiVA@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CAMT+MTT11xg-14KrcqUTx3DxF=1NnYZAMY8RoZFoTesc0zEiVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/19/25 19:18, Sasha Finkelstein wrote:
> On Sun, 19 Jan 2025 at 12:50, Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>>       ret = io_remap_pfn_range(vma, vma->vm_start,
>>> -                              vram->vram_node.start >> PAGE_SHIFT,
>>> +                              (vram->vram_node.start >> PAGE_SHIFT) + vma->vm_pgoff,
>>>                                vm_size, vma->vm_page_prot);
>>>       return ret;
>>>  }
>>
>> The vma->vm_pgoff is fake in DRM, it's used for looking up DRM GEM
>> object based on the vma->vm_pgoff value when mmap is invoked.
> 
> If my understanding is correct, vm_pgoff gets "unfaked" by
> https://elixir.bootlin.com/linux/v6.12.6/source/drivers/gpu/drm/virtio/virtgpu_vram.c#L48
> 
>> vma->vm_pgoff should be treated as zero here. Hence we can map a part of
>> GEM, but only from its start. See drm_gem_mmap().
> 
> I've had a "v0" (not on ml) of this patch that always treated vma->vm_pgoff as
> zero. This broke when anything tried to mmap with a non-zero offset. Adding
> vm_pgoff made it work correctly.

I've tested this patch. Partial mapping with a non-zero offset doesn't
work because drm_gem_mmap() rejects it. I'd want to see your sample code
that performs mmaping, maybe I'm missing something.

>> Please correct vma->vm_pgoff in v2.
> 
> I need apps to be able to mmap with a non-zero offset for my usecase.
> While the correct value may be something else other than what is in
> the current patch, 0 is definitely incorrect for at least some workloads.

drm_gem_mmap() uses drm_vma_offset_exact_lookup_locked() that doesn't
allow vma->vm_pgoff != node.start. AFAICT, no one driver supports
mapping with a non-zero offset, perhaps for a reason that I don't know
about.

-- 
Best regards,
Dmitry
