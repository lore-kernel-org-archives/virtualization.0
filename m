Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B713CF963
	for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791663095; cv=pass; b=RNUgjzEhQnWA71af56rX6njSVD98Jd7j7UaixyseJOOFeAcx0YyaT99RfRbSwtEf08CRguxMMN+tUyuJxEQkkvlF4ixeg6bChdIUY2ppihzayiDdbnESeE4xjZMulf3WD3EDyewCLHmJjf+ITzloXrsiKQPt2JUHixBpZgP9nPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791663095; c=relaxed/simple;
	bh=w5fRRU3aj3jyVk5q7XtQZcWg+4yHTcFHtXjisa0N+Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mazbtjdZSS7mpTRBtA5LKNbhdA4syrKhaDxNYH0Y+dt8insYH9jX/wVXTe8xNDdpGP5GAwOWH0wFFND5tVx4PKec1mZSEiAf8ATuXyrMI2DYaocg+3ZJCKihY1G18oew5AhpcMRan+tJdUDWARR5iCIGrSurDizuzMAYfUQU4KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=S+JoghMs; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="S+JoghMs"
ARC-Seal: i=1; a=rsa-sha256; t=1791663075; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aqK4hrydh8m7R0nIlQ7V3e0KUCUZ3NHOTuKJ8DRts3KeYH1dOAmpL7v653rBKcaJ1xjK3YeBZRVWFB5rffnet4Q4qa4/1AVYkAwWyuqc594gEar84UQZ6XYCnMWRKGYQL4KR8e9YMeoiKCENknnlRPDM34Ikar1LdBdltc8lg8k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791663075; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fhpHISKN2ejdt1SYpWE67fgDiBtyNOwb9rbmi+vJp4M=; 
	b=a9aj72gXAIALOxhiEY/K/B3dG/Jy/xSDnN6xAmmudEpBUgxlgE1tPhpBEOi+sGdCtWet/YF4YC2aahmdSlNF4v36nDqTuzFk9Hd0wOCPZSVfKlkth4iHnM3oC1e3JVtPAHU7+K0B5ElHDJWp7xXeO7U3OQOfqXCe1Jw7Q1iD/YA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791663075;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fhpHISKN2ejdt1SYpWE67fgDiBtyNOwb9rbmi+vJp4M=;
	b=S+JoghMsC/PvKhW+b+nohiJEp2LDhQ6HM98POHR5tVPy9HTB6Ch9FJR0CkyHftAC
	F+YYpzYKZ2WifQw0pTuR1va/s0/Ks0s2nYtUvr6hWpJh594BitJqZNkDIh5KAX58LGe
	Q3WwNgCOp/GpCdBIfwDyk0WmkVbmSSxLq5RAsh9Y=
Received: by smtp.zohomail.com with SMTPS id 1791663075057635.7254755559173;
	Sat, 10 Oct 2026 13:11:15 -0700 (PDT)
Message-ID: <d459ced7-99f0-46c1-961c-0f6815163596@collabora.com>
Date: Sat, 10 Oct 2026 23:11:10 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/virtio: expose GEM memory statistics through
 fdinfo
To: shechenglong <shechenglong@xfusion.com>, airlied@redhat.com,
 kraxel@redhat.com, tzimmermann@suse.de
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stone.xulei@xfusion.com,
 chenjialong@xfusion.com
References: <ce72b2f5-1343-44e9-89fe-e2de4efb7e9c@collabora.com>
 <20261008164135.510-1-shechenglong@xfusion.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20261008164135.510-1-shechenglong@xfusion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/8/26 19:41, shechenglong wrote:
> On Thu, 8 Oct 2026 00:44:34 +0300, Dmitry Osipenko wrote:
>> Usefulness of this change is dubious. VirtIO-GPU has different types of
>> RAM, I'd expect them all represented properly instead of only shmem.
> 
> Hi Dmitry,
> 
> Thanks for the review.
> 
> Agreed that a generic memory collector does not map well onto
> virtio-gpu, given its different memory types. For v2, I plan to
> replace it with virtio-gpu-specific accounting and to document the
> semantics of each reported value explicitly:
> 
> - Guest shmem objects: reported under the "memory" region as
>   drm-total/drm-shared, based on the guest GEM object size. These
>   reflect the requested buffer size; drm-resident, if reported, would
>   be derived from the actual state of the guest backing pages.
> 
> - Host-only blobs (VIRTGPU_BLOB_MEM_HOST3D): reported under a separate
>   region, tentatively "host3d", using the requested blob size. These
>   values would be documented as logical sizes and not as actual host
>   RAM or VRAM consumption.
> 
> - Mixed blobs (VIRTGPU_BLOB_MEM_HOST3D_GUEST): the guest shadow
>   backing is accounted under "memory", while the logical blob size is
>   exposed through a separate, documented supplementary key. This
>   distinguishes mixed resources from guest-only ones without
>   presenting the supplementary value as additional measured host
>   memory.
> 
> - Imported dma-bufs: handled explicitly, without assuming that they
>   are backed by local shmem.
> 
> Usage of the host-visible memory region would be reported separately
> from the backing statistics and would not be used to infer host
> residency.
> 
> The actual host allocation size and residency, including legacy virgl
> resources and the host part of mixed blobs, are not available through
> the existing guest/host interface. Reporting them would require
> additional host/renderer support, so I propose leaving that out of
> this series unless you consider it a prerequisite.
> 
> Does this scope match your expectations for v2? Are there other
> memory types or accounting semantics you would like covered?
Sounds okay

-- 
Best regards,
Dmitry
