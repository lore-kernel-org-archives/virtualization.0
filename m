Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB301CB329
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337973; cv=none; b=QhZt0EGb5q+WCYDIWSw90TOBjtvgLCW7WfmTTr4QIO0bsKcMwqIcQ09l49zMT4/Bfxr1j+w7OMKU5PXX7vXcGQ77ZNBKPb4Jm61TTCK/h+3384a5+AoRoDWm0mzIvkeugvosl7YTA2xHuFAVl3gk5ea8ewbQzwIgNQsbXL2Lbds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337973; c=relaxed/simple;
	bh=jz+4fFpyrnTKr/MkttvmGxu9rYqzL3UUL7h2NuXcZtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Isa8BZDzBed2MLxCHG8E/ibXs/+R8QpH4ERR+q3c5m9ODZ+VwUM3YwG7DfrAL0NRQq2uGL/g4/50NSccszBrwZH1VIcbHLPl3Kj0cjgRBmH5AEJz91fE7/YjMQzrD58HVrdJnHQvCVpMilrCzpK7SfLOFS1hFuWty42BWTErBlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wd/oaWsN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wd/oaWsN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724337971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1PgDdjBoF4JblXtgGjeuWjO8887IujC2mbPadvbkarU=;
	b=Wd/oaWsNIFSF3jwj4UtTDgH3K53zs0/qxIuZ+qInVZVEGDI6J6IUWHYunEnfKpNe0ZR09r
	lGUnzX9C13IsKeea0ZH+Jc/Ai50EW9MiBi2AE4nZ4fNAtZ38oGrUuov+WvkH3jXtavK9yn
	NfVG2q4fsBiOxtyIxy/RkFr12faWXq8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-WeQyYXEGOT-J_KqSCF4KnQ-1; Thu, 22 Aug 2024 10:46:08 -0400
X-MC-Unique: WeQyYXEGOT-J_KqSCF4KnQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-427ffa0c9c7so9481395e9.1
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 07:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724337967; x=1724942767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PgDdjBoF4JblXtgGjeuWjO8887IujC2mbPadvbkarU=;
        b=SpmSL3vnk2U0hmHB6h/2rPMJTWr43Rp1JOlhmBoJf6ltth0IQRZt2pztKtEBQPKGUg
         6pH1aVLSStYSA0rhD7zeI6nmnuE7DABf0jL4JmOThsE5lBLmn9AfKGTWewwFESdjKB24
         Zk9EHnEINqJkvZv10KCiJBjFdxbfbt/K5Tllx6vCUtJkxIzS9IbVRe3Hjtqd6H9KePyg
         FRZHt/Gy1qjISrz9necyZpqWlo7AvldgoBcHcKe23h2Tw6s4BCQDB6FV5JBuTntIPU8C
         ZP93oIfPWs7/4SckkZU1xaRgg2YNZTDn4Saq17UwoRMjI9jO+4Zszl8rrladvNHkapkf
         JnWg==
X-Forwarded-Encrypted: i=1; AJvYcCU9t90oTHmp6cN9gvI6lek14vAmgAcnHF1JtTuhhoKk2pKFUhJDFk46od8A5Z507/OWnKIb2mh/w4soatnmqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YytGHVwrz2VMhWJ400KCMlZbn+IqqauVqHOqRXFKb66iKQjwWCb
	dIj1lYDrPPcP1R258hohW5A669i5kzkZ+7jeV3gfOn8CnjxQAwqTpMvkMFw7Mxn9uIyPE4p+Yfx
	C2rXgd7bEyx30QLr3v65MT2ui85foeV7Ffbep0PwrJrqaAFW0BT1S4zVevwzpQXIt
X-Received: by 2002:a05:600c:3c97:b0:428:29e:8c42 with SMTP id 5b1f17b1804b1-42ac55cababmr22017825e9.9.1724337967184;
        Thu, 22 Aug 2024 07:46:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuLJzrR9+0Fk/xHqiEDPcjVZlaqCd+ihtEn7Tv4wCKVbCZaYnuqG4WIXNLVH5okrCjSI5r3g==
X-Received: by 2002:a05:600c:3c97:b0:428:29e:8c42 with SMTP id 5b1f17b1804b1-42ac55cababmr22017335e9.9.1724337966687;
        Thu, 22 Aug 2024 07:46:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514e088sm27643235e9.8.2024.08.22.07.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 07:46:06 -0700 (PDT)
Message-ID: <85f934ea-9c5a-4adb-8c6d-6c82beab41b1@redhat.com>
Date: Thu, 22 Aug 2024 16:46:04 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/virtio: Use XRGB8888 also for big endian
 systems
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, Javier Martinez Canillas <javierm@redhat.com>
References: <20240820090908.151042-1-jfalempe@redhat.com>
 <2734s7h2c4tbtwzdlijbf7u3fvdcqtlcdipamsf4pf6jgx2slt@aq5bm3fuqgkz>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <2734s7h2c4tbtwzdlijbf7u3fvdcqtlcdipamsf4pf6jgx2slt@aq5bm3fuqgkz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/08/2024 13:12, Gerd Hoffmann wrote:
> On Tue, Aug 20, 2024 at 11:07:40AM GMT, Jocelyn Falempe wrote:
>> Mesa doesn't support BGRX8888, that means most wayland compositors
>> don't work on big endian guests.
> 
> So you are doing a hard switch from native endian to little endian.
> 
> While this should be fine for modern userspace API (aka ADDFB2 ioctl) it
> is not for older APIs (ADDFB ioctl, also fbdev emulation) where only
> depth=32 is specified and userspace typically expects a framebuffer in
> native byte order.
> 
> Ideally virtio-gpu would support both big endian and little endian
> framebuffer formats (simliar to bochs drm driver).  That probably is a
> somewhat more invasive change because the DRM_IOCTL_MODE_CREATE_DUMB
> doesn't tell use the format which will be used.  Possible options I see:
> 
>    (1) Be lazy on creating host resources, i.e. call
>        virtio_gpu_cmd_create_resource() not at DRM_IOCTL_MODE_CREATE_DUMB
>        time but later when the resource will be actually be used (and
>        specifically after DRM_IOCTL_MODE_ADDFB(2) ioctl so we know the
>        format).  Needs additional state tracking (whenever the resource
>        has been created or not) in possibly lots of places.
> 
>    (2) Support changing the resource format, i.e. in case
>        DRM_IOCTL_MODE_ADDFB(2) is called with a format different from the
>        current one go through a destroy-and-recreate cycle for the host
>        resource.  Might have tricky corner cases (resource being in use
>        when DRM_IOCTL_MODE_ADDFB(2) is called).

I've implemented (1), I will send a new series soon.

Thanks for your advice.

-- 

Jocelyn

> 
> HTH & take care,
>    Gerd
> 

