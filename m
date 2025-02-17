Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D855718DB33
	for <virtualization@lists.linux.dev>; Mon, 17 Feb 2025 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776784; cv=none; b=nI4nKY1kdSG8NxYRtOyr6zde2eFNUBnvDwNfwMkSOUfA9aJwkV8TzXqDoeTMazg89JOAMEOHvT0nudnAPw4vXJEkSNLbd9B8ZZCfcDva42snT2l7TB64h1A8XOzZ/r4SP0xG9cov9u3S1EVxW3bWcYGh7+4TeSwCKH6N4Pgdkgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776784; c=relaxed/simple;
	bh=vfGe1WhH3u9EJrPfu6F2TVFGpeySf1sa0OGAW7VgWZM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwnrqPO3b2NTUTK/T6YvKEVibQMU+vTN/ZydMXJea/AjRhPHSNFAjCm+ULMydsSZw4Mv5lbM1XtNGDfKR2SOIZ4li8xdttc6uxQMor18iVJ/uMUlMckqQkKENtpRyo7TwNiiMcwrfp1wHZbkL/sZSGdQvq0K/sd1cHIr5YMkJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBmE5F0B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBmE5F0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739776779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vlfl+lmHhnb3eDe+iFkolSYqaJktZfayJNrM+qurEz0=;
	b=EBmE5F0BS6y/QANt7Kw5K902fkWGjBGZiFPlfzssLeQ1CRvE46XApwkjv8ocLVKLlNyOmM
	QuGyPvL8kaSGb3k2G58wfg3EE12ZlXZXSpaEH2Ph3hknywIn0jEkSsVJtQiP3WYdcRY6nt
	IChs8dH7iSlfMaBB3cJFyhmYlDQbosM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-ZXdDmd8yM5CK3yAb8TuWcQ-1; Mon, 17 Feb 2025 02:19:38 -0500
X-MC-Unique: ZXdDmd8yM5CK3yAb8TuWcQ-1
X-Mimecast-MFC-AGG-ID: ZXdDmd8yM5CK3yAb8TuWcQ_1739776777
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc43be27f8so5463032a91.1
        for <virtualization@lists.linux.dev>; Sun, 16 Feb 2025 23:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739776777; x=1740381577;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlfl+lmHhnb3eDe+iFkolSYqaJktZfayJNrM+qurEz0=;
        b=hXou1vXfn4557dgxYeOO1i0qpxqin8e/E/8OmBEqoeMutsiNHS1NWt9lav5aUxXA6G
         CA5qiiq1x5vdh+VoOLFuZCbcD9EHrJDIHcCuaZpjym6v7KrFx52JoD8GjEUQmo+XUodB
         oPwUjcNhRt9ppL3Qtb6v5gp1qZqSlknhjRroj2nMbTBs0z74letGTe8NxpWotpfWuTH2
         l3sc0iMKoaO5gz0AvNYGFbfjDM0ErqPFRjUuWxVbPD8SrWffB+uq/cHJ3ORZQZiBIeLK
         /p93jzygBy/nyWIrpGD5MavwGaJ7GLCu/dAlaHQXJPEah4sduVnwI0Ut4sKa/VFpAIU+
         +KWA==
X-Gm-Message-State: AOJu0YwgLLXZ0BpR3PpzuSuwbM5YteYnBiOsNEufn5RhIAszbHcXy0x4
	HjDHNl0A+Av8FHJS5Ora6f7ZlkvheSULflgfT4ujf5Cab2CFyLey0/LfuAGGGydxzrcHC9oTAXj
	C0fmw9aZoSA+OMZ02QvJBfou78rk8HFSR7G8vLpvO8B9zXUt8Fu/scJYCifTlGz8WP3hvkwjjK5
	Qp5Ly0759kZgs9KDwGdcGzRfOC+LUfGOAf9MFd5Q8=
X-Gm-Gg: ASbGncsW7hmWTtpGOPGAPeLIpoTApFmCC6idQkKYM1xFPvZKkn09xB4Cxezvsiy3l3W
	FhdoIv+aqEKVF2y1gPu3b664JkivcRrKv7tJcQaGObs/U5Dmizl5pJ66+K5Cr2L4+I4S899FnCA
	JwZ62Eu7vEvmmzY0ObL58=
X-Received: by 2002:a17:90b:4ad0:b0:2ee:a4f2:b307 with SMTP id 98e67ed59e1d1-2fc40d14deamr14187536a91.4.1739776777317;
        Sun, 16 Feb 2025 23:19:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqqYNFvrv7otKwk8EcZ5/jMtgR2Ep8+aemJnqKzPb45Yu2FPbMWq7EQ9gKvlZNIOHRf6FoesIjHYgLlK7NWSg=
X-Received: by 2002:a17:90b:4ad0:b0:2ee:a4f2:b307 with SMTP id
 98e67ed59e1d1-2fc40d14deamr14187493a91.4.1739776776856; Sun, 16 Feb 2025
 23:19:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Feb 2025 02:19:35 -0500
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <f6d6de4d-1b87-4a53-a2eb-0d9ddfbc4311@collabora.com>
References: <20250214-virtio-shm-page-size-v2-0-aa1619e6908b@redhat.com>
 <20250214-virtio-shm-page-size-v2-5-aa1619e6908b@redhat.com> <f6d6de4d-1b87-4a53-a2eb-0d9ddfbc4311@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 17 Feb 2025 02:19:35 -0500
X-Gm-Features: AWEUYZkmTZoXk7_Rz3zTEPLKhoc079NRhM3R6YYEKHGPH952bEMjXNC96qKluPM
Message-ID: <CAAiTLFU3UhQyHzpPQKQpJcp_vpOrWdDU7Gv_ng6Vbm0B_+Lv9Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/5] drm/virtio: add VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE
 to params
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
X-Mimecast-MFC-PROC-ID: fO_OHMoTf9EOQibO7bIzOlYHyHxjBgBOM-HVjxp68Oc_1739776777
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 2/14/25 18:16, Sergio Lopez wrote:
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> index c33c057365f85a2ace536f91655c903036827312..4b49635b4fe1d4256f219823341cef8e5fa8f029 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> @@ -117,6 +117,11 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
>>  	case VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME:
>>  		value = vgdev->has_context_init ? 1 : 0;
>>  		break;
>> +	case VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE:
>> +		if (!vgdev->has_host_visible)
>> +			return -EINVAL;
>
> Nit: virtio_gpu_getparam_ioctl() returns EINVAL for unsupported params.
> While this is a supported param, but there is no hostmem available.
> Hence, should a different error code, maybe ENOENT or ENXIO.

Good point. I'll update it to return ENOENT in v3.

Thanks,
Sergio.

