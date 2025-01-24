Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E431DC070;
	Fri, 24 Jan 2025 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737753760; cv=pass; b=s3qvcNKEXZ4ZVXYe6WoCVJTZ49RwYpCkByZaWC9XMR+PDmS+AfDGiXyfeIXfeGSZO88vd/0CemHpG/xdY287oSmt+92kkdY1JlJQKssC5GsaaV21p4KZmR+1lrExNRhuqf4FF4E69ab1dEvSPPYIRPQ2HMd1LaykicBIf1xnUqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737753760; c=relaxed/simple;
	bh=ZSXYCAx63KBePMxzMzkOIYseQp94hmBjWSOVrhKXQ3Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fvGbms4yxDCK5FhTx/7CmcvX4spZN5D9OAoPm7A1y/8fTjquhku9XXpx5Rw2b2zwhAAJ0ogRhZ3i27qex4HZwD/2++/EFXrzikUrm8JtBU0rxx2WTP4jhBZyNCWVcoDlNvRascuDhvtZ8/08Q90/9TY59TFxf2l0vKLMsNCjaMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=XSQxdd5B; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="XSQxdd5B"
ARC-Seal: i=1; a=rsa-sha256; t=1737753750; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FbgQss/NobniMMQvk64Bl/H5wyA34SGs6W8hqbk87TCK+6cwatFJc0E3YkgC14GPGcX00zOSSEAqUbgpk2TOopsunOFXZBaA7zkYg+CPPngIZfyZvVwhEJe4ZWV9ZmMZ42W7GPxsYeK5P/FSakJZl6ER9KS/ixP8oRQ33ekfve8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737753750; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZphL/nVDXXxptFKQ3WhrtUhWpTJM+Xq6IVCVjMbirJI=; 
	b=J7WSv1+kL54nN6FuxUy9JwR5gvDCbb0+UUZz5s18t6o1zO06t7mTilexq2+U1yB5O1fFS5j8bTJVc0n3fit0bcpbLAhhtjNYKM/T96luukUd4pSC1EN8ObCe/y7GFxzV/X4vBP/6emPAdSYCkZd3vqaNJuzXn4mgYPN1Zy+b5Uk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737753750;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZphL/nVDXXxptFKQ3WhrtUhWpTJM+Xq6IVCVjMbirJI=;
	b=XSQxdd5BdyYK/QrzaTyD9Kxij7SN7LgKexyIvrwiPokftVM2PJbNE6akPh4/WXK7
	s9Bf02yEI8Juqk1b9pCbVlo2P+KNvtc0oakERH8p+o0CKuKfYU6IKHFVRWnaIhuCwM/
	sr8vbVsCS7HXuY3XfmkgAHoN7vMxsfFm0DUHWSxE=
Received: by mx.zohomail.com with SMTPS id 1737753746497953.961903016498;
	Fri, 24 Jan 2025 13:22:26 -0800 (PST)
Message-ID: <1a4386bf-a707-45fb-a699-ee3847a98aec@collabora.com>
Date: Sat, 25 Jan 2025 00:22:21 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Support partial maps of GEM objects
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
 <a6b7a3a1-e6f9-4da7-96b3-62aefb82dced@collabora.com>
 <0820162d-f6d2-400e-b14b-86954d475d37@collabora.com>
Content-Language: en-US
In-Reply-To: <0820162d-f6d2-400e-b14b-86954d475d37@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/19/25 23:23, Dmitry Osipenko wrote:
> On 1/19/25 23:02, Dmitry Osipenko wrote:
>> On 1/19/25 19:18, Sasha Finkelstein wrote:
>>> On Sun, 19 Jan 2025 at 12:50, Dmitry Osipenko
>>> <dmitry.osipenko@collabora.com> wrote:
>>>>>       ret = io_remap_pfn_range(vma, vma->vm_start,
>>>>> -                              vram->vram_node.start >> PAGE_SHIFT,
>>>>> +                              (vram->vram_node.start >> PAGE_SHIFT) + vma->vm_pgoff,
>>>>>                                vm_size, vma->vm_page_prot);
>>>>>       return ret;
>>>>>  }
>>>>
>>>> The vma->vm_pgoff is fake in DRM, it's used for looking up DRM GEM
>>>> object based on the vma->vm_pgoff value when mmap is invoked.
>>>
>>> If my understanding is correct, vm_pgoff gets "unfaked" by
>>> https://elixir.bootlin.com/linux/v6.12.6/source/drivers/gpu/drm/virtio/virtgpu_vram.c#L48
>>>
>>>> vma->vm_pgoff should be treated as zero here. Hence we can map a part of
>>>> GEM, but only from its start. See drm_gem_mmap().
>>>
>>> I've had a "v0" (not on ml) of this patch that always treated vma->vm_pgoff as
>>> zero. This broke when anything tried to mmap with a non-zero offset. Adding
>>> vm_pgoff made it work correctly.
>>
>> I've tested this patch. Partial mapping with a non-zero offset doesn't
>> work because drm_gem_mmap() rejects it. I'd want to see your sample code
>> that performs mmaping, maybe I'm missing something.
>>
>>>> Please correct vma->vm_pgoff in v2.
>>>
>>> I need apps to be able to mmap with a non-zero offset for my usecase.
>>> While the correct value may be something else other than what is in
>>> the current patch, 0 is definitely incorrect for at least some workloads.
>>
>> drm_gem_mmap() uses drm_vma_offset_exact_lookup_locked() that doesn't
>> allow vma->vm_pgoff != node.start. AFAICT, no one driver supports
>> mapping with a non-zero offset, perhaps for a reason that I don't know
>> about.
> 
> See now that a non-zero mapping of a dmabuf might work. Will test it.

Works for dmabuf

> 
> -	/* Partial mappings of GEM buffers don't happen much in practice. */
> -	if (vm_size != vram->vram_node.size)
> +	if (vm_size > vram->vram_node.size)
>  		return -EINVAL;

This check should include the vm_pgoff, like that:

if (check_add_overflow(vma->vm_pgoff << PAGE_SHIFT, vm_size, &vm_end))
	return -EINVAL;

if (vm_end > vram->vram_node.size)
	return -EINVAL;

The size and offset are actually validated before this code is reached,
but doesn't hurt to keep the check around.

I corrected the check and applied patch to misc-next, thanks!

-- 
Best regards,
Dmitry
