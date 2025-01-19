Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1F1974FE;
	Sun, 19 Jan 2025 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737318227; cv=pass; b=mqVSej4WfvXM21JWnWlk3vNdMK/p9xDZT+38EGXYZ5u9/wkeEJMwrEjnuwn87O3TdIuBIrdjFA/Q1L2qU1khLq2nkvNQz5BftzFccXRdZXHeoEXbIn6ucaUuohsIfCdO4WaMbW/VSJCC98GsaYx1ieuUzs+gu3UZhzxj91jolyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737318227; c=relaxed/simple;
	bh=tWfSI+1MtUACMBfnv4RFYgj8AtEb/70TFPYM8QfC13U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b54/tFjBs2/OPtzg5nn+P4YVAeaN3mt8yNrU5FzdkFvUJiwWqUaUrkVUJi6CjIZIZXexj7NqAo0S2pD1Y2b0SwtecY4+hxiPWKaIXPGkpiklsDGPekbSpEbfUR4cWGxcmOLYVT04LQXqAdhMzYAypgH1A1BhasxjNXo7gluP6W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=P3C4eoQQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="P3C4eoQQ"
ARC-Seal: i=1; a=rsa-sha256; t=1737318217; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FcVt7sT55FRfJnB7hDpCceMyLgXI6PVICfZtYwJVkQz7FG8zkQ3pH/cw22u5+cqY4MCqarQPX/j4Pw6/U08oJUKVwZ/IQ5vz8jmKUxrny6grkPp3MvGJcREbUuogE8IM5X4JahjxaDSqB3+l8n9E5+sUiym+cX2D2QmeZBPPngk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737318217; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UPtfCtUKIAnqCQybAVHnv01lXRb06TK7ijHh2KLOKpk=; 
	b=QLyDDeQzWVmPkipHItdkWgXSEjyJez6LsV5kHK32jNeu/pFZK3gTBcXX+Mau9EQNL2VZNJUwCX2NMTOr3Y3ce0VJiuPHqY6aSeixCGNPYktysV2jWK00TsNh5kVNc+sT6jnnRMX4IZHttStq0v2axsJFCAwbyExVi8mshKHpn7c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737318217;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=UPtfCtUKIAnqCQybAVHnv01lXRb06TK7ijHh2KLOKpk=;
	b=P3C4eoQQZOIsO+77wHpza70B2I5iAoJtkIEYKhtBrRp4mn6L5IqcwdxR0B7MG3w6
	63xUpCIPNfPlm7Q6BDiPYN15kJuLXgbV4vFTPZWEYW9LRkjxD40C22KaE0tc0DgwpG1
	HRYedFS/q1ASzNpgD/AfVtQzWtYcdTGN3yLdcTiM=
Received: by mx.zohomail.com with SMTPS id 1737318215647463.5943389283731;
	Sun, 19 Jan 2025 12:23:35 -0800 (PST)
Message-ID: <0820162d-f6d2-400e-b14b-86954d475d37@collabora.com>
Date: Sun, 19 Jan 2025 23:23:31 +0300
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
Content-Language: en-US
In-Reply-To: <a6b7a3a1-e6f9-4da7-96b3-62aefb82dced@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/19/25 23:02, Dmitry Osipenko wrote:
> On 1/19/25 19:18, Sasha Finkelstein wrote:
>> On Sun, 19 Jan 2025 at 12:50, Dmitry Osipenko
>> <dmitry.osipenko@collabora.com> wrote:
>>>>       ret = io_remap_pfn_range(vma, vma->vm_start,
>>>> -                              vram->vram_node.start >> PAGE_SHIFT,
>>>> +                              (vram->vram_node.start >> PAGE_SHIFT) + vma->vm_pgoff,
>>>>                                vm_size, vma->vm_page_prot);
>>>>       return ret;
>>>>  }
>>>
>>> The vma->vm_pgoff is fake in DRM, it's used for looking up DRM GEM
>>> object based on the vma->vm_pgoff value when mmap is invoked.
>>
>> If my understanding is correct, vm_pgoff gets "unfaked" by
>> https://elixir.bootlin.com/linux/v6.12.6/source/drivers/gpu/drm/virtio/virtgpu_vram.c#L48
>>
>>> vma->vm_pgoff should be treated as zero here. Hence we can map a part of
>>> GEM, but only from its start. See drm_gem_mmap().
>>
>> I've had a "v0" (not on ml) of this patch that always treated vma->vm_pgoff as
>> zero. This broke when anything tried to mmap with a non-zero offset. Adding
>> vm_pgoff made it work correctly.
> 
> I've tested this patch. Partial mapping with a non-zero offset doesn't
> work because drm_gem_mmap() rejects it. I'd want to see your sample code
> that performs mmaping, maybe I'm missing something.
> 
>>> Please correct vma->vm_pgoff in v2.
>>
>> I need apps to be able to mmap with a non-zero offset for my usecase.
>> While the correct value may be something else other than what is in
>> the current patch, 0 is definitely incorrect for at least some workloads.
> 
> drm_gem_mmap() uses drm_vma_offset_exact_lookup_locked() that doesn't
> allow vma->vm_pgoff != node.start. AFAICT, no one driver supports
> mapping with a non-zero offset, perhaps for a reason that I don't know
> about.

See now that a non-zero mapping of a dmabuf might work. Will test it.

-- 
Best regards,
Dmitry
