Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB251F0E37
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047057; cv=none; b=gHJRqnrdBNEtwA7t0FKTjBplrU3O9ofhQ1m1OV1dRFY+90Tr+WlU0LlM7dMgjq36BGAX/tUX1l7grpjH1mWHpgQcWcKu9zNDGdBzZBzMV7KxtZ57OAVG8pNwKfU05th3oFHoVHbX40+rjVcqcmf8/V5pYquo6tgNtLv/0JV9BFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047057; c=relaxed/simple;
	bh=RikVMgwNlogdSzT23fODXi0t9zjQvH0kEweEh095GcE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3hjvvT4eDiDITVRFRy+UiTReYHQ4eiEnvtfIf2OyktM50MJEVdnPvJyANGl+wgcDHmyXdGshs0ov/rvW1+75C0F39IAJAOTSTwC9aCkBbE1VwqSp8zrjTXb6a27WjsilAr/dVRHf549QtY/4oEk0000I++k8Hwi1TYDcJxDYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQladiNX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQladiNX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740047055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PCfNk2irYZhiAVEAeMF3jzWLVhPjMhVSnPe0uvp0LKw=;
	b=WQladiNX3kmGPXs7DkYsk/LemS+Koi5CQvbK3ZRxhAG35j0e+QQxUxOGC01mhOPPTwzU1U
	GBGtyV/PQvRs0Fw8ulI6loCUNh75jSKYnkw9lDSXYwY04A2PVhl18HLF3D4R4Qkmwuhsb5
	KcPXBXMHUdMKRlA6ur6SIvX9SJ7tsWU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549--FyIGBOuPz27Lg6wsvceKQ-1; Thu, 20 Feb 2025 05:24:11 -0500
X-MC-Unique: -FyIGBOuPz27Lg6wsvceKQ-1
X-Mimecast-MFC-AGG-ID: -FyIGBOuPz27Lg6wsvceKQ_1740047051
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220d9d98ea6so25025155ad.3
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 02:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047050; x=1740651850;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCfNk2irYZhiAVEAeMF3jzWLVhPjMhVSnPe0uvp0LKw=;
        b=YbGEnUZvPLht73HZ5WPu9AIrQ86ulOfUEKooiasW5MBjWsAQrUzlEp1g8FtPrfmhbn
         JLAkGlkqvVESCPV8r2P7cTBVd4zWFCxsyUPooSQ/kIUAQqo0S+My6JOMU/kIwk3IB7Nn
         kiSg9+/xFLmYUt5Ewc/AVLPWBCowE0B/EMnRJePs5Q3eF6f5A/Gu6Wdxqj0Q+JkRVF08
         HuGyG22R47bjN05rrImaQTiwxr6Mjk4C5Fjpkd4m7Ezq0hBE1/EXNRZdJKav0ZoapYPd
         IHa0di+p+xuR9HjsGLNARyKKflWfE4CjtzrYr+1lUuZfGFJf4JpS3qCjfCbPK9AvoX5/
         Nlsw==
X-Gm-Message-State: AOJu0Yy5Qgl4e79XRVUjU0vsSAg8O52By35/6qjWimj4E2EkIVxn//wA
	knFEwJ6Of79jzZ1hBUkB/YuVq6abL0ozOfsXJw0c8kUy1yynVw4rfv0Z7UU+ClhigTHWyfnvy8A
	+Btz+NVXf5ll2VZ9b8gtJxN3qVHDOr7io3nkKgVi7l4XUS00EfewV4jwKdQXDVqpfTuJMfR82yp
	NrPOB73ERHK3UIAIHr55GVQbdPhC651gSbAeWbiAw=
X-Gm-Gg: ASbGncukm+YzBbr+0l320bkhOZFW+phdVjUOCMcIEB/olmopORmONydSTrHncr4MKe0
	z/NNheUkxEmLvaRjFgt6dIFEfmVj3dqDjo7pJVcY67pm1V+SVBLPwvzON2w==
X-Received: by 2002:a17:902:e803:b0:216:1543:196c with SMTP id d9443c01a7336-221040620b2mr340108585ad.27.1740047050652;
        Thu, 20 Feb 2025 02:24:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhBmKY/Jd/FJcL0J0umaKdIJTK407yNESWW6lHPZ4yPs84G32nsvPhs1j0n5aPenBrC+US2evK7mAnibRfM8Q=
X-Received: by 2002:a17:902:e803:b0:216:1543:196c with SMTP id
 d9443c01a7336-221040620b2mr340108255ad.27.1740047050275; Thu, 20 Feb 2025
 02:24:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Feb 2025 02:24:08 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <1f9a86a5-97d6-41d5-9a30-0422fc9ec137@collabora.com>
References: <20250214-virtio-shm-page-size-v2-0-aa1619e6908b@redhat.com>
 <20250214-virtio-shm-page-size-v2-4-aa1619e6908b@redhat.com> <1f9a86a5-97d6-41d5-9a30-0422fc9ec137@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 20 Feb 2025 02:24:08 -0800
X-Gm-Features: AWEUYZlfgST3-O9VCrzw5HD0jnPovA3jL5BWDBB878el2RF0dCmg4Z8bMopNsuE
Message-ID: <CAAiTLFXihV_DUpd25Mc-OcgsNJ5tVJx7XYsETgxh+7cFuicuHA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/5] virtio-mmio: read shm region page size
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Daniel Verkamp <dverkamp@chromium.org>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	fnkl.kernel@gmail.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e8H7O2XTVG4MFgZW-QIOkFkAUlRoNUPrE1wlNYLxIso_1740047051
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 2/14/25 18:16, Sergio Lopez wrote:
>> Use the newly introduced SHM_PAGE_SHIFT register to read the page shift
>> for the shared memory region, derive the page size from it and store the
>> resulting value into virtio_shm_region.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  drivers/virtio/virtio_mmio.c     | 11 ++++++++++-
>>  include/uapi/linux/virtio_mmio.h |  3 +++
>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
>> index 1f594b626d7a7734e8ec58766737a118c26bad94..0f892770739ea84b3e7be5615332773049b10ab1 100644
>> --- a/drivers/virtio/virtio_mmio.c
>> +++ b/drivers/virtio/virtio_mmio.c
>> @@ -537,6 +537,7 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
>>  			      struct virtio_shm_region *region, u8 id)
>>  {
>>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>> +	u8 page_shift = 0;
>>  	u64 len, addr;
>>
>>  	/* Select the region we're interested in */
>> @@ -560,7 +561,15 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
>>
>>  	region->addr = addr;
>>
>> -	region->page_size = 4096;
>> +	/* If supported by the device transport, read the region page size.
>> +	 * The page_shift variable is initialized to zero above, so if this
>> +	 * feature isn't supported it will result in a page_size of 4096, a
>> +	 * default safe value.
>> +	 */
>> +	if (__virtio_test_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE))
>> +		page_shift = (u8) readl(vm_dev->base + VIRTIO_MMIO_SHM_PAGE_SHIFT);
>> +
>> +	region->page_size = 1 << (page_shift + 12);
>>
>>  	return true;
>>  }
>> diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio_mmio.h
>> index 0650f91bea6c70f935764070d825d181a2379afb..43348be30eff90ee228b6490b9d3c35ba4c50aa5 100644
>> --- a/include/uapi/linux/virtio_mmio.h
>> +++ b/include/uapi/linux/virtio_mmio.h
>> @@ -133,6 +133,9 @@
>>  #define VIRTIO_MMIO_SHM_BASE_LOW        0x0b8
>>  #define VIRTIO_MMIO_SHM_BASE_HIGH       0x0bc
>>
>> +/* Shared memory region page shift */
>> +#define VIRTIO_MMIO_SHM_PAGE_SHIFT      0x0c4
>
> What's the logic behind choosing 0x0c4, why not 0x0c0?

It seems like Linux doesn't support it yet, but in the specs 0x0c0 is
already reserved for QueueReset.

Sergio.

