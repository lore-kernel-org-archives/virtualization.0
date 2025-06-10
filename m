Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB8E22FE10
	for <virtualization@lists.linux.dev>; Tue, 10 Jun 2025 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562466; cv=none; b=UhoU2gkOv9tTmRsuyV3eVIXVnJDSmYOdq+4LI1taKjDifNWFA+RLXGnxcJxpXDO29KWIwRb5FShglW6onG6FQg0i5LIcQNmDd57w+PMDKXCJV3MFv/o7v90xqMPisQnSdxjcqALNF/1c9syorGjFStHPK3sLm1fPAranhwPL2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562466; c=relaxed/simple;
	bh=XvrsqEOdfXf0A5sl8PhNexgikLmqQdrUFQcyvSHgxyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IKr0IfNyEpqgNr0aXY1qH8jElHlhSagvoMfht+9YdR0C3pIb0TCauzojedILd5SnDR0w3z0vG/erVAktO8eWZCwdunOf0XiUPRXe1o7s3GAAhF1vxTGa7hDIvjjJJAgkmSePz2WPuuWj/5FMbpsbrRa5elORq0Y6ZcD6Q8zjvEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+Ujewyv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+Ujewyv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749562463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JaThg5+r5uhS87jz3/gzU48kE9fYSYuQjTKSX+XLaXk=;
	b=c+UjewyvG2W/yozdrHtmVYPsp50amu/VP9oR5wcSmttf8kJNRuYrcpJK/6zt2XoI04Gjy5
	SZ3bNFp0jgls609mH41X+apNxF5M3EzlG/b4Ncko7rF+sLJpplxdxb6QRofOjkVMy1V0ZN
	wrxZSRK/+TGEcZacrunzEszT5VFSziU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-NFBNkAtMNv-Za70HuXnC0Q-1; Tue, 10 Jun 2025 09:34:22 -0400
X-MC-Unique: NFBNkAtMNv-Za70HuXnC0Q-1
X-Mimecast-MFC-AGG-ID: NFBNkAtMNv-Za70HuXnC0Q_1749562461
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ade354a2f6aso266315466b.2
        for <virtualization@lists.linux.dev>; Tue, 10 Jun 2025 06:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749562461; x=1750167261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaThg5+r5uhS87jz3/gzU48kE9fYSYuQjTKSX+XLaXk=;
        b=NyokAiunj4t9AXuWuMYyEJOt716iRqAbNJvSEDbRSVEOQ58METwXQ04i5RIxcykJh+
         uTVOfzumQhu+fExg+q+j84OKmXiUIOCB2u75Bls8DV2Dumcvp1U8bp7Ogz4/Dp0ChbKQ
         S93B0lMfK0ENggjQUpeallz0XEwHB7OCHrQk87zZ+HeNEMbao9l1eQed/H9jbzC3Ox/+
         OKMK/RqPV293hdLvVOWkeMQtnqaowyyAAfa5Pxqcr3H1LDLWro3e/NglLWnlUns8Flwm
         q/Z8yR9Rj5kleR8AwKeMzE/XYfR+gp0n+mgPwIgUv/lF2mdLU/zIaEH1XlzpoRNcU4Lp
         2Vew==
X-Forwarded-Encrypted: i=1; AJvYcCWxi79SRHWZdgp1nlTenIKQl72Qxb7o+UZ9sCXSgfKMg4HCAuzMmgEOXXvOyKdfnt9oT2VXTxuXiKb5AqXbrw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3ZBEo7xMvquO9fGvs+5zCXU9gRDrtD851p8QN6kDNMlAGR1Q0
	nDmBLSliL81uAllukz8p0RsHkglaZ4lH1YNp4P4SOtg5DrvBX9yGz28gRQpyCU8YtLym+/AnNji
	E/Oc6OHQeJSRNietdm7okP0Tmp21z4RxqCgSm6OooRhvVAzmhbQzaIrz0ilbMKWkohIo+
X-Gm-Gg: ASbGncsyvqEe2ewXKLNnX2oU+/9jPxIm9Pi7E7GJNIuj+EiRWobXkD+yKAsWbqIzyoP
	wPFnvDOBwXTRUozbkL7RAHrKO3W9PZc4xM2JkGV59syYqdKX4Z0p7lEmuA6C43mYxpu66NXaUuC
	0bmQw40CDEJKYwIK48PUJGjPqiuUHgY4FlMpK5awUTGRI1t9ghvNiJqzYWa185Rn3eQ61Jqospr
	Kjze6Tm4ozr/bsbVlNxG8+mx+VgFahTfmOVbZn9Ny4csGYCYjC3bjpFTWl4X+a+FcZf8Db017gp
	4zkw2+KBFYKhqzmwQyDB7dJsDxKU
X-Received: by 2002:a17:907:9627:b0:ad2:4fa0:88cd with SMTP id a640c23a62f3a-ade1a9161d5mr1556452866b.9.1749562460786;
        Tue, 10 Jun 2025 06:34:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVQJ9XKVtgWAPBPx92DgJukt6mEoSr0j96sE8wez5IFUYtTCsIHQA0fNWr/TED56i/nhFt1g==
X-Received: by 2002:a17:907:9627:b0:ad2:4fa0:88cd with SMTP id a640c23a62f3a-ade1a9161d5mr1556448066b.9.1749562460153;
        Tue, 10 Jun 2025 06:34:20 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.220.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db57856sm727888966b.63.2025.06.10.06.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:34:19 -0700 (PDT)
Date: Tue, 10 Jun 2025 15:34:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] virtgpu: deallocate capsets on device deinit
Message-ID: <4si3wc7jhfcyukrepw3wi6zmylqf7b5ilnlxfpbbexcijcvlnz@3r2zcpxne275>
References: <20250505-virtgpu-queue-cleanup-v1-v1-0-810923da2b1e@linaro.org>
 <20250505-virtgpu-queue-cleanup-v1-v1-3-810923da2b1e@linaro.org>
 <5271820d-7afd-45e5-8103-b7d4fc818278@collabora.com>
 <c3ae2790-20d8-4220-848e-7b02b185e893@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c3ae2790-20d8-4220-848e-7b02b185e893@collabora.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qPrqY-HsEvN2Pq6n9WDsTsSi20ErNrQvS42n4PT2wiE_1749562461
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, May 05, 2025 at 07:22:35PM +0300, Dmitry Osipenko wrote:
>On 5/5/25 18:58, Dmitry Osipenko wrote:
>> On 5/5/25 11:59, Manos Pitsidianakis wrote:
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
>>> index 7b3c4d314f8eee692e2842a7056d6dc64936fc2f..a8b751179332b9ec2fbba1392a6ee0e638a5192e 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
>>> @@ -286,6 +286,10 @@ void virtio_gpu_deinit(struct drm_device *dev)
>>>  	flush_work(&vgdev->cursorq.dequeue_work);
>>>  	flush_work(&vgdev->config_changed_work);
>>>  	virtio_reset_device(vgdev->vdev);
>>> +	spin_lock(&vgdev->display_info_lock);
>>> +	drmm_kfree(dev, vgdev->capsets);
>>> +	vgdev->capsets = NULL;
>>> +	spin_unlock(&vgdev->display_info_lock);
>>
>> Isn't this lock superfluous?
>
>Wait a minute, vgdev->capsets is allocated using drmm, hence it's
>auto-freed when DRM device is freed. This patch shouldn't be needed.

Yep, good point. I mean the patch is not wrong, but I think we can avoid 
it.

Thanks,
Stefano

