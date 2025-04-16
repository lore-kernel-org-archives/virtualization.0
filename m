Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951DD224248
	for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 07:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744787332; cv=pass; b=BXMB1Tev2GnkcmId/8XzZOQxrxPVtKNqMJoNrQlpwZ8jBx+f+vGjFqB1x1eVU0eCoU8s0V/ZePjSgymjUbGr/4gOYWKcgFPxIQAp6JlH/W/RPDhQF3SPOk5W/d0vXDhWoIQJnYAxFhhT3c97AQ4KhLIQDsCnTj5rBLxzBfKcLJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744787332; c=relaxed/simple;
	bh=3ncHg8KqeUz1vIVKm8juv8oGSQXXnORd6y7pLVlgK70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+pdWDM/6r0rPF5SatUIVUQKPQvFS/JX9HRDHm+2OkeVlUKmfOhekZYML2arUggbBmH2g4XsSypOVgEH8h/vq84pJqp/vfLvalMklohW6Rq+THf31oaBr1NRyLBEWqabbTufPiyu0bRqws1DiLiqPhifWEWwAuJHfNczxOTlx6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=K3Af9Mcx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="K3Af9Mcx"
ARC-Seal: i=1; a=rsa-sha256; t=1744787320; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HHBvq0NGJ2eF770FU5GG/1dSU+Pp8UiR1V3orbxWCnR456v1wGZdqQPu08DMBYtgXHPZM7KqbIhyF6SpVGfl83XumFeEBW5SMgm+dhKehcMXXHq+KpRtJWmTEw3ZCm5XHCF2Zs3GFXToI8iGjMfOp5wmwwsi+PD5Ryry+v3jFKU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744787320; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/yqJ8y8KREoexVbGgiSv3lKFcw87irrL9VHeHd+VyMs=; 
	b=KrFL5bLqjy/JjTDRHQ3oMlLx3eX4ydsyXWT4Puew+ooPC7O5/SkNV0t37NyRuLWBzycVU4+YRObTRGS2xRUDE064M1QP5qLMDDge0XcPYLZkZu5a3pLAlLnQHiXzw4jqYlPGJFiG6Ypz/lW/0SgkTnZKqGtls+ixvbEGroMYLQM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744787320;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/yqJ8y8KREoexVbGgiSv3lKFcw87irrL9VHeHd+VyMs=;
	b=K3Af9McxCyi8UkTNdrSryMDyNSwYOwjXytmbQqbxoygNoh4Eru+zkoEkV0ZDR8fR
	6Q2NH2QUyLMxr+vI1E8sEmK4NMhO3Q9Mbd4WYZC/2c/u4kFFc4CqT6pgYxqmItsl6SV
	kWeLSh6hMa5H3n+pEVnQrYeYmppoAKcFg+DgSnQ0=
Received: by mx.zohomail.com with SMTPS id 1744787318494319.03897271462245;
	Wed, 16 Apr 2025 00:08:38 -0700 (PDT)
Message-ID: <24bc034d-45fd-4d1c-bed7-216a2592f633@collabora.com>
Date: Wed, 16 Apr 2025 10:08:34 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Support drm_panic with non-vmapped shmem BO
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Ryosuke Yasuoka <ryasuoka@redhat.com>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 jfalempe@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250412132012.291837-1-ryasuoka@redhat.com>
 <82de8253-7be6-40ed-b4a7-c840b3b46362@suse.de>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <82de8253-7be6-40ed-b4a7-c840b3b46362@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 4/16/25 10:05, Thomas Zimmermann wrote:
> Hi
> 
> Am 12.04.25 um 15:20 schrieb Ryosuke Yasuoka:
>> Pass array of pages of the scanout buffer [1] to shmem BO, allowing
>> drm_panic to work even if the BO is not vmapped.
>>
>> [1] https://lore.kernel.org/all/20250407140138.162383-3-
>> jfalempe@redhat.com/
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>> ---
>>   drivers/gpu/drm/virtio/virtgpu_plane.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/
>> virtio/virtgpu_plane.c
>> index a6f5a78f436a..2ff57d559c86 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
>> @@ -500,11 +500,19 @@ static int virtio_drm_get_scanout_buffer(struct
>> drm_plane *plane,
>>         bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
>>   -    /* Only support mapped shmem bo */
>> -    if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach || !bo-
>> >base.vaddr)
>> +    if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach)
> 
> Please adopt drm_gem_is_imported() instead of testing import_attach
> directly. The helper is available in v6.15-rc1 and later.

Hi, I rebased this patch locally on top of your drm_gem_is_imported()
changes and will merge it all soon.

-- 
Best regards,
Dmitry
