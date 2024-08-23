Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5001D186E33
	for <virtualization@lists.linux.dev>; Fri, 23 Aug 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427349; cv=none; b=ZCpyWfaWOAMAQYvK8gGu3BxqolhqYAveD8I1s31O7AvezECDocUmMCB3y4Tlat2+jM2uXftdkj9aP4WlxOQkPiW34jdOxVes2Ho5GSZJW79B3zgkjy2NhD9sfz0V1KawAo363yJ8EhYRg1tCJDW/T50Cdh85gLvML8GWTHfBloo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427349; c=relaxed/simple;
	bh=5bllkR8in5L4La8s4XIhsC/QfjzihC7MVi7DWXi85a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxvDBm2vLQkbbbv1VC7oZgBaUOT8ioFyuOi9DcOGxpJ1X7wmSlu2wFySkfvEkNVKdyV5irP8mgxMQMBAUblEL4DLCyPvjrewERpRmH9nDkb+qQZuN4qvIJtgyquNqc88mMUxRQu/LZ0IoFUdtjkcPDdRCsLMqs17PQg6a/dsbAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aliBDYJM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aliBDYJM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724427347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3rLYGJgK6z9fhn+qYuQPwIKQkobSIo3O9qdPTM0OPg=;
	b=aliBDYJMOxQTQL/P9PeEbzQbX4nSuM7pLHInbApOHcDr68fO8UrrtUmIwFjuUlPzDns5Bq
	NX8SDGwjuJq6o+Jrva+0yn0KjNsevPoxPJtFE7OGNGQMX9cup/e4iqCwMXtRvBPmU4KyPu
	oAu6iy1oQgmUX1jQRXJ7xhrRLJDA5K0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-0Z40nA3mP0mJs0e9iFfKFg-1; Fri, 23 Aug 2024 11:35:43 -0400
X-MC-Unique: 0Z40nA3mP0mJs0e9iFfKFg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280c0b3017so18439405e9.1
        for <virtualization@lists.linux.dev>; Fri, 23 Aug 2024 08:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427342; x=1725032142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3rLYGJgK6z9fhn+qYuQPwIKQkobSIo3O9qdPTM0OPg=;
        b=ec21Sk1D6k8h9gsUUqQftfG0hI9y6HYOi/zgZSqHjlXBh2RUeoQ+bNtFTXD+Ygin9U
         48sNl5naOPCpsAj3TdUPbjsi2hBeHlhmuuaSXIoT5YVymGvapkpm3HATMNIXtXfaKCrT
         SXOneNhVmx9Hk+lghrYqkz47zGAEpX3gT/6x77/mgrk6AyZmTB37no9ofPpnx20G5/M/
         Ru56MBZEdZhJy+SGK0aQP8j2VssuF8szTiwd28Md340gVOJMJmdiBy7UheBYNMQawnO0
         42mqIcxTXrr3mglscL/4U6s13+gL6iJS1TcIr7y/DvSbcsvVRU82H+QDAJaX64/Z5W27
         VPuw==
X-Forwarded-Encrypted: i=1; AJvYcCUi2TIWQu1B9El83AyIVygfh46IEsAczOLbzoIpqHOoi5UsJL87r/2TZUm4qL3xmKHTKmCs22qAw2MmmJaDkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzKIWelGVyeWpTAoRTGIMnn8yYSv1TRQLsnoBz5gWdAXpIuOpW
	51Jc78EAslyUDt4v2xBi97/Ww/7XUobMdNY66isrsoE2ZNC8G4ibX5qGd1V08h7gzvJdaImSO6C
	9mvd1fKdGhLbI7D2DEKQ/fiuvcjhl2wUV/XQhebuA3E/1KJrdKDa+SdFqPFGwUTwi
X-Received: by 2002:a05:600c:354b:b0:428:c0a:27ea with SMTP id 5b1f17b1804b1-42acc8dc557mr18724175e9.12.1724427341988;
        Fri, 23 Aug 2024 08:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQm2FCaknjRgK8aLmW41cDwSvcHK2xRo53SrzU02DJUIR/S6S0b/YsrbuHurrpfHMGWC2T6A==
X-Received: by 2002:a05:600c:354b:b0:428:c0a:27ea with SMTP id 5b1f17b1804b1-42acc8dc557mr18723885e9.12.1724427341447;
        Fri, 23 Aug 2024 08:35:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162609sm63072885e9.27.2024.08.23.08.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 08:35:40 -0700 (PDT)
Message-ID: <6496591e-fa98-49ed-b85e-c76734c25568@redhat.com>
Date: Fri, 23 Aug 2024 17:35:39 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/virtio: Defer the host dumb buffer creation
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
References: <20240822172338.698922-1-jfalempe@redhat.com>
 <mlqofcqa2yki43bkcl2kq6wfwchmkisnybbadd32khln5tv4ux@u4xuf6gumcqa>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <mlqofcqa2yki43bkcl2kq6wfwchmkisnybbadd32khln5tv4ux@u4xuf6gumcqa>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/08/2024 09:04, Gerd Hoffmann wrote:
>> +static void virtio_gpu_deferred_create(struct virtio_gpu_object *bo,
>> +				       struct virtio_gpu_device *vgdev,
>> +				       const struct drm_mode_fb_cmd2 *mode_cmd)
>> +{
>> +	struct virtio_gpu_object_params params = { 0 };
>> +
>> +	params.format = virtio_gpu_translate_format(mode_cmd->pixel_format);
>> +	params.width = mode_cmd->width;
>> +	params.height = mode_cmd->height;
>> +	params.size = params.height * params.width * 4;
>> +	params.size = ALIGN(params.size, PAGE_SIZE);
>> +	params.dumb = true;
> 
> I'd suggest to simply store the complete virtio_gpu_object_params struct
> in virtio_gpu_object instead of re-creating it here.

The struct params is much bigger than the struct virtio_gpu_object, so I 
though it would waste too much memory. Using a pointer would add an 
alloc/free pair, and a potential source of memleak. And as we have the 
required parameters in struct drm_mode_fb_cmd2, I found it better this way.

> 
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
>> index 64c236169db88..8d1e8dcfa8c15 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
>> @@ -93,6 +93,9 @@ struct virtio_gpu_object {
>>   	bool dumb;
>>   	bool created;
>>   	bool host3d_blob, guest_blob;
>> +	bool deferred;
>> +	struct virtio_gpu_mem_entry *ents;
>> +	unsigned int nents;
>>   	uint32_t blob_mem, blob_flags;
> 
> Put them into a new block separated by newline, add a comment saying
> those are needed for virtio_gpu_deferred_create?
Yes, I will do that in v2

> 
>> @@ -229,9 +231,14 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>>   						  objs, fence);
>>   		virtio_gpu_object_attach(vgdev, bo, ents, nents);
>>   	} else {
>> -		virtio_gpu_cmd_create_resource(vgdev, bo, params,
>> -					       objs, fence);
>> -		virtio_gpu_object_attach(vgdev, bo, ents, nents);
>> +		/* Fence is used only with blob or virgl */
>> +		WARN_ONCE(fence != NULL, "deferred doesn't support fence\n");
> 
> Additionally check for param->dumb to take the deferred code path?  That
> should make sure there is no fence.

I think I can also duplicate virtio_gpu_object_create(), and have one 
version only for deferred dumb buffer. I will see if that doesn't make 
too much code duplication.

> 
> take care,
>    Gerd
> 

Thanks for the review,

-- 

Jocelyn

