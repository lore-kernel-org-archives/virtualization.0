Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F51CAAC
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158557; cv=none; b=CZcRrrjxKRVYisoD+ijYmZO3DNACBWTFId5OXArTLNsOGEweOKdtP+WQorkOAgrZIju3lNzg+vIKsrCYK/usXCEA8pSEL16YvAMvYLIXjcAVSO6XmGc538Stn35d4mdcz7aqS52CbIw0rI8bcQKwN61R9VAU5m8rmJ9l0WLl3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158557; c=relaxed/simple;
	bh=s6ObYsZ2GI3TaSZJk4UU3v0DGTY7Ls17prsqpT+kilc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zs24NkOL96n01+8AnNV+RBP/iz8ebyuxBU34hLod/sXroNzoyxDGGkNRcG8G/56SNj54puc2klRvKnfeWF6+AjG1Rsu73opelHJh9+x+zltqEdhmY4s0UgmA4CnXIQB5nzVISMpcQbuqvYdjCijR1C8jNjTKGI1p69FJddTNcto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGw3hO6u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGw3hO6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724158554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//fa7C7uMUVCVHWhUhIMdsYVMveoAIZ7MNgXZX6SAJo=;
	b=QGw3hO6uoMrChXeDoeNd7bnNusZz47Q94rdE5ZOWwVpMYpbuwgTpT3mYKAbS/GQiYWodn0
	/OT22gaKB6ZdrZIyinMjCykAGSmiUejP6gk+wjjTFLzWSi+7MObkQC/0Dz7SBsHMhvt5OX
	vvBr5HoujRoDd+dxkyO5pUDlgOdfLJk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-1F4M_DVMPHul9S8rPGmW4g-1; Tue, 20 Aug 2024 08:55:51 -0400
X-MC-Unique: 1F4M_DVMPHul9S8rPGmW4g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428fc34f41bso47709745e9.3
        for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 05:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724158550; x=1724763350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//fa7C7uMUVCVHWhUhIMdsYVMveoAIZ7MNgXZX6SAJo=;
        b=n0eePzAbzQWmys9k/zN7lLLzmGnyRxwqsASoGbVeZLnABtYa4M4QYb62E0LvyZ3efb
         /M/bpJHEqnnXXw+qrVVuE9ithZcR/HN9ZVwfLp6Meh2eNiMhN20DqODGTl8bqJBSmhgb
         RAvXQzioybiSwtxVTjeTw0ZjjIexTjUPdYPHpTK0CF43D+VZJ30ofMxKidFLyelOsifl
         gakwEPPPQeJV+WM/iqy+DoCRCo4UlmAAbfpRtNh3O+U710y0TqTmGPxV1/La/SXipp1k
         t/JGpRnEfYh1IBdpXN8WjO8vKABnLNyLtkn1qp4sK29KeXLVFQ4QIThMoZykyQ2YpMqf
         rVhg==
X-Forwarded-Encrypted: i=1; AJvYcCWNxt0XRPNYkL152YgAxHEoSLlCNp3JfBIKL7Lo/UALknZdjzhwdCmZ2bMBelgfJoyGCZEzglkmR3r++RtbpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwT3ChXNfayPkb+0WgGgv3/EcigCM2tkXumo92qJkGd1zz6Llaj
	CUfCxYmAVPMhz7IMTgUXJ7WYSKtp7oLmH3cFo5F3SNeqi69Fv/Qx9qcohEc2TkR9mWWDZZr4oko
	UpEtHhYxKQxJuzs79gGC08XbnDG6tUK2gwdRaKkrITYwMRHgpQH6Osa/XydrRkgy1
X-Received: by 2002:a05:600c:4614:b0:428:17b6:bcf1 with SMTP id 5b1f17b1804b1-429ed7c1e45mr104694495e9.22.1724158549669;
        Tue, 20 Aug 2024 05:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjumzqQN3renhqWclB/aglpoU88Ng3amSrt4D+SOxfHAVEPfbsjMcBnxYIKTunPJ2lcZZ4Hw==
X-Received: by 2002:a05:600c:4614:b0:428:17b6:bcf1 with SMTP id 5b1f17b1804b1-429ed7c1e45mr104694295e9.22.1724158549180;
        Tue, 20 Aug 2024 05:55:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7d5a9sm194550555e9.43.2024.08.20.05.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 05:55:48 -0700 (PDT)
Message-ID: <ddd41844-1d3e-4755-9013-9ae4e751c501@redhat.com>
Date: Tue, 20 Aug 2024 14:55:47 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/virtio: Fix host color format for big endian
 guests
To: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Cc: Javier Martinez Canillas <javierm@redhat.com>
References: <20240820090908.151042-1-jfalempe@redhat.com>
 <20240820090908.151042-2-jfalempe@redhat.com>
 <efe083ed-b83b-45e8-a418-1861f535e31f@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <efe083ed-b83b-45e8-a418-1861f535e31f@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/08/2024 14:48, Thomas Zimmermann wrote:
> Hi
> 
> Am 20.08.24 um 11:07 schrieb Jocelyn Falempe:
>> The colors are inverted when testing a s390x VM on a s390x host.
>> Changing the conversion from DRM_FORMAT -> VIRTIO_GPU_FORMAT on big
>> endian guests fixes the colors. But it may break big-endian guest on
>> little-endian host. In this case, the fix should be in qemu, because
>> the host endianess is not known in the guest VM.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> Acked-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>   drivers/gpu/drm/virtio/virtgpu_plane.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c 
>> b/drivers/gpu/drm/virtio/virtgpu_plane.c
>> index 860b5757ec3fc..0ec6ecc96eb13 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
>> @@ -37,16 +37,24 @@ static const uint32_t virtio_gpu_cursor_formats[] = {
>>       DRM_FORMAT_ARGB8888,
>>   };
>> +#ifdef __BIG_ENDIAN
>> +#define VIRTIO_GPU_HOST_XRGB8888 VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM
>> +#define VIRTIO_GPU_HOST_ARGB8888 VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM
>> +#else
>> +#define VIRTIO_GPU_HOST_XRGB8888 VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM
>> +#define VIRTIO_GPU_HOST_ARGB8888 VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM
>> +#endif
> 
> As these defines are only used here, would it be beneficial to put the 
> __BIG_ENDIAN branch directly around the switch statement?

That was my first version, but I found it difficult to read, when I mix 
#ifdef in a switch case.


or maybe something like the following would be better ?


  	switch (drm_fourcc) {
#ifdef _BIG_ENDIAN
  	case DRM_FORMAT_XRGB8888:
		format = VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM;
  		break;
  	case DRM_FORMAT_ARGB8888:
		format = VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM;
  		break;
#else
  	case DRM_FORMAT_XRGB8888:
		format = VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM;
  		break;
  	case DRM_FORMAT_ARGB8888:
		format = VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM;
  		break;
#endif
> 
> Best regards
> Thomas
> 
>> +
>>   uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
>>   {
>>       uint32_t format;
>>       switch (drm_fourcc) {
>>       case DRM_FORMAT_XRGB8888:
>> -        format = VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM;
>> +        format = VIRTIO_GPU_HOST_XRGB8888;
>>           break;
>>       case DRM_FORMAT_ARGB8888:
>> -        format = VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM;
>> +        format = VIRTIO_GPU_HOST_ARGB8888;
>>           break;
>>       default:
>>           /*
> 

