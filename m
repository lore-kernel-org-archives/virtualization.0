Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117D1DA4E
	for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236150; cv=pass; b=GaS/jd3RyG2aDKwr+AS242TBfBpkqh5Slhr/80Kc4i2BurAkINcZZCDBBYF2XXTtz0JT+gCgMU3IErl/s7l4UoO+HAexV/t6WcrBcUkUFxqGx375DTKbt0jOqZOvZlbmwXn5kpHGZuvijUalrY6Sy67pqrcp7rjBbjolfipPsiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236150; c=relaxed/simple;
	bh=hNRfGUkDSc4Wzy+v15885VMhg68Sq8erzw4PHv0+DpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsIorr3l3MAUkWoVfW6qPQ6LtXvhc68cVjfe0cozDe9Uh77Tyw6fSrda+P9SXWuniMrrJqvfZmF1pdIuXKXrW1WzYwyC2ivgTOD8b/KvvelNx1zJNV8APy1/7/18O9YJIZjQP+NqXCAKER+z1OvHHZMlNlpTU9kwTDQzXb9O/LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=hKncvze7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="hKncvze7"
ARC-Seal: i=1; a=rsa-sha256; t=1752236130; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c7TPol9sr2vfCUr1+1XxOTPn0bSJzMKA1Wjazrar/r65UimAroNuF/l6Pte1cHKK4K0TFgxQUbYae1jdeMGqPsg5qVYmmq9uazzB7k1KoSQr78OK4BneQSBdsKYuC3MsdWkabDWR3yVDdGtJWK+i0W/MU8eMnd7mrBju5XBkqPA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752236130; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MX3EMrC2wCw3c6tPXalwFeOqJh4nGBTcT3eAtOjHrNQ=; 
	b=Op5MCHyq49WmHZrM2/QSCVdeskr4N/18dGH1mQhZuWG4apmHNn5hexE+6Ent5Anyud2mqnlYx57JV39yn6w+oDIhtyKf2in50jyGeQu4o/vFVKQhm0Qdx2+li0WserNyeUk/fuGKZ/JgzFf3cLY+qW7bPgWtuilMEVtqeOkIK7U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752236130;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MX3EMrC2wCw3c6tPXalwFeOqJh4nGBTcT3eAtOjHrNQ=;
	b=hKncvze7Rn6FRDxRq2EM7eOR63O79Vvrppn2AUUHSw9VPk2fx3tW0cC/QQam+d+I
	/tKmDRpcC/dA/qaZ7t/HN7Zse5FW+cCjWAE3l+qsyPo+/SJ6t/ikkDiKGEGZ1ujhSWR
	lXEJW67kwoZgEsIIGEbJj2i43Cd/Lwk3Tb9Mil5g=
Received: by mx.zohomail.com with SMTPS id 1752236127624851.495473923201;
	Fri, 11 Jul 2025 05:15:27 -0700 (PDT)
Message-ID: <d279c5f9-c6b0-4c22-a9c8-8e3b427342ad@collabora.com>
Date: Fri, 11 Jul 2025 15:15:21 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] Revert "drm/virtio: Use dma_buf from GEM object
 instance"
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: simona@ffwll.ch, airlied@gmail.com, christian.koenig@amd.com,
 torvalds@linux-foundation.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
 kraxel@redhat.com, christian.gmeiner@gmail.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com, zack.rusin@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, virtualization@lists.linux.dev,
 intel-gfx@lists.freedesktop.org
References: <20250711093744.120962-1-tzimmermann@suse.de>
 <20250711093744.120962-4-tzimmermann@suse.de>
 <9058368a-0e5b-4cb5-a04f-6feaa80329a0@collabora.com>
 <aHD2LmTe238vh5BS@phenom.ffwll.local>
 <cf564056-ef21-409d-a37c-1a1f85c98a01@collabora.com>
 <15333dc0-a1bc-469f-9af3-865e2c836e1c@suse.de>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <15333dc0-a1bc-469f-9af3-865e2c836e1c@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 7/11/25 15:01, Thomas Zimmermann wrote:
> Hi
> 
> Am 11.07.25 um 13:49 schrieb Dmitry Osipenko:
>> On 7/11/25 14:31, Simona Vetter wrote:
>>> On Fri, Jul 11, 2025 at 02:29:04PM +0300, Dmitry Osipenko wrote:
>>>> On 7/11/25 12:35, Thomas Zimmermann wrote:
>>>>> This reverts commit 415cb45895f43015515473fbc40563ca5eec9a7c.
>>>>>
>>>>> Reverting because the fix-up commits are suspected to cause
>>>>> regressions.
>>>>>
>>>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>> Are the fixes and stable tags missing in the patches? AFAICT, the
>>>> intent
>>>> is to fix stable 6.15 kernel regression.
>>> Yes, I'll add them when merging to drm-fixes.
>> On a second look, I don't see the reverted commits in 6.15, so only
>> 6.16-rc should be affected.
>>
>>>>> ---
>>>>>   drivers/gpu/drm/virtio/virtgpu_prime.c | 5 +++--
>>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/
>>>>> drm/virtio/virtgpu_prime.c
>>>>> index 722cde5e2d86..97aaee26cb02 100644
>>>>> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
>>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
>>>>> @@ -204,15 +204,16 @@ static void virtgpu_dma_buf_free_obj(struct
>>>>> drm_gem_object *obj)
>>>>>   {
>>>>>       struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
>>>>>       struct virtio_gpu_device *vgdev = obj->dev->dev_private;
>>>>> +    struct dma_buf_attachment *attach = obj->import_attach;
>>>>>         if (drm_gem_is_imported(obj)) {
>>>>> -        struct dma_buf *dmabuf = bo->dma_buf;
>>>>> +        struct dma_buf *dmabuf = attach->dmabuf;
>>>> Nit: I'd write this as `dmabuf = obj->import_attach->dmabuf` for more
>>>> consistency with drm_gem_is_imported()
>>> Reverts shouldn't have any additional changes, even style nits imo, so
>>> I'll leave it as-is.
>> AFAICS, this patch is not a direct/clean revert, it reverts two commits
>> with manual edit. There is 44b6535d8ace on top of the reverted
>> 415cb45895f4 and final result isn't same as a revert of 415cb45895f4.
> 
> It's exactly the revert mentioned in the commit message. There was a
> conflict at
> 
> -        struct dma_buf *dmabuf = bo->dma_buf;
> +        struct dma_buf *dmabuf = attach->dmabuf;
> 
> 
> which I resolved.

Now I see that both commits are reverted properly by this patch, thanks.
Having two reverted commits without resolved conflicts would make it
clearer. Either way is okay to me as long as final result is correct.

-- 
Best regards,
Dmitry
