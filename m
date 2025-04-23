Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7291B0F17
	for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390717; cv=none; b=K/6SHd8dsDzxnkrnsaT2WHxem/DC7pBJ8aaysRt9xZ5hH2y4kDImNA+XPSpCqZHEGlfbVYfs2HlWF8DrGxVZcI9hOVrT+mJ7XF4y5e4bcK7XnMQrlBG6JjWRjQpHIB4/XTzxpsRdxuDQi4CAhE8cLCicvVUrLDm+GtBAmry9m2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390717; c=relaxed/simple;
	bh=h3D+v7S/DE8v4VXSLO4J78ijDrD37ur1IijJWbA1kPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Gswrm081PubVzIibbKtkYG+BVqCj4M7tPcdaKz17z5YsGxQOvjjIdj/ZizGWYnSQorQyFMbsKPLo2HtaOQLGqbn3yK1aLXyaohjNyGCgXmcj3epzGvbQUiXQwxX6WdQ+xw6nqK/2xr+YCtzFv0bY2UHnqe4fh01xpBBIkqDJqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtvnDUah; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtvnDUah"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745390714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJQr5daKI6/1i+nwgHlDoYSZzm+JP1wEk08aCiKUf8w=;
	b=YtvnDUahU/NIwm+jAMKeVlRp1kxa+PIRtpYrXvqAt+sXFgHRJgMmO44CU6A8T/ptHFlOMs
	+iyk/aCXGJ3RXN6WO21sq8lGnxkcSwOnlofl56c7bhQyRkFlERhazW1klDifFJMeuECXzq
	kynOOvA+s9zsG/6Dk6dIX9YfQcC5WiQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-77VmSeFTO4-cHiyjin-gFg-1; Wed, 23 Apr 2025 02:45:13 -0400
X-MC-Unique: 77VmSeFTO4-cHiyjin-gFg-1
X-Mimecast-MFC-AGG-ID: 77VmSeFTO4-cHiyjin-gFg_1745390712
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43efa869b0aso38182975e9.3
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 23:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745390712; x=1745995512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJQr5daKI6/1i+nwgHlDoYSZzm+JP1wEk08aCiKUf8w=;
        b=PAFckPGLHWMjbc+uDealPh8SbZ/Yc1+kFQtUwBETla9oRMnwjKYVk05xnyBpLZr+oK
         1v2GqkYTWYCjCOA0JhuZoVu3VhzJjDDVvq9dqpkJV1O4hYfhYm3F0TjSPrEyA+VK8hMN
         im2LgMOkT2GEnF9/4uWgOHXKhILcD+Sf9NVFu7IyOAL9niNm6UvN8H6vQrkPQ46vRYFr
         Mn3w/4Po2g4EiR4k1SYZ9j60SxT9VevaetsRvYs9y3Sv+KZb/D4J+ljigfNen0gnrTFA
         +yqw4CgrkvbqgFbqwbeHkTYjUWc/BpfT6HfXz9bbjjtWxteM+keXqMMzOyiblVjDN636
         V42A==
X-Forwarded-Encrypted: i=1; AJvYcCU9vvBJwUgPTdpwloc/N7w0VUJembU3CTKox+tOcCcV/Zig7ZC8NCQ5X+wq4bOgMBZgLd/HL3biE0yzPoNHIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCx9sp2hoURimwJH/3aPwuoz8ZjYPwM/mqOVHgmHSbPmuRd1Y/
	0IOuC9t00y9TWMN9gysQy6JDA836RbT00U1cHry8H+68Z1QODvBAAX+2x+2NSUfofuiTL4sxNm/
	Mb9p+AWsZAfd5SR9tGNudBK3tptI47NLZFUxy50qcxr5OczNbChiJwpuAnejyxSvj
X-Gm-Gg: ASbGnctfhtKLsABY40JAJMmzzKn9BvxtUOerYT/5E9KQTlGf4AXzPDOSIqQUUwSYxQg
	9AssiQDhXWvG12MTqdbNOAo/FdD89kfuktNlNkUr2smvZe8pAzBgR0AScZsnKOiOpGECtYMA3mL
	Y6TO+eYlEfeboGLvMu4QlCKjdf8Vg24kbSKv/KWJQC2+Dpa4cG8Tr6LDEcDDKBKoschic/jLUOg
	CYZLOdVGAPkvYRgt/h515jp5gFzyGV8vKbTZKuXOCtYHwOZ80v0nZ5tlDmfMjfRfwqUOVhivUii
	0W6IYQ==
X-Received: by 2002:a05:600c:3487:b0:43e:a7c9:8d2b with SMTP id 5b1f17b1804b1-4406abfab7dmr152587625e9.24.1745390712285;
        Tue, 22 Apr 2025 23:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESPeBSydPIH0zVAjW7EqTg1hmkncqgVOAhXdcSWQ91oQ3uYj81WGlTIQYk3qbwlXLCw+komw==
X-Received: by 2002:a05:600c:3487:b0:43e:a7c9:8d2b with SMTP id 5b1f17b1804b1-4406abfab7dmr152587385e9.24.1745390711947;
        Tue, 22 Apr 2025 23:45:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d4707csm14014875e9.40.2025.04.22.23.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 23:45:11 -0700 (PDT)
Date: Wed, 23 Apr 2025 02:45:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
	Eric Auger <eauger@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2] virtgpu: don't reset on shutdown
Message-ID: <20250423023922-mutt-send-email-mst@kernel.org>
References: <8490dbeb6f79ed039e6c11d121002618972538a3.1744293540.git.mst@redhat.com>
 <ge6675q3ahypfncrwbiodtcjnoftuza6ele5fhre3jmdeifsez@yy53fbwoulgo>
 <20250415095922-mutt-send-email-mst@kernel.org>
 <lgizdflxcku5ew2en55ux3r72u37d6aycuoosn5i5a5wagz6sc@d2kha7ycmmpy>
 <5aede4c4-5dfd-4ec1-9fd8-a5d6700678bd@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5aede4c4-5dfd-4ec1-9fd8-a5d6700678bd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AROPRgVr_JNUlPS2NOP5m3P5ptoh7YvEyQNjjsY0Ho8_1745390712
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2025 at 06:49:04PM +0200, Eric Auger wrote:
> Hi Gerd, Michael,
> 
> On 4/16/25 3:57 PM, Gerd Hoffmann wrote:
> > On Tue, Apr 15, 2025 at 10:00:48AM -0400, Michael S. Tsirkin wrote:
> >> On Tue, Apr 15, 2025 at 01:16:32PM +0200, Gerd Hoffmann wrote:
> >>>   Hi,
> >>>
> >>>> +static void virtio_gpu_shutdown(struct virtio_device *vdev)
> >>>> +{
> >>>> +	/*
> >>>> +	 * drm does its own synchronization on shutdown.
> >>>> +	 * Do nothing here, opt out of device reset.
> >>>> +	 */
> >>> I think a call to 'drm_dev_unplug()' is what you need here.
> >>>
> >>> take care,
> >>>   Gerd
> >> My patch reverts the behaviour back to what it was, so pls go
> >> ahead and send a patch on top? I won't be able to explain
> >> what it does and why it's needed.
> > See below.  Untested.
> >
> > Eric, can you give this a spin?
> >
> > thanks,
> >   Gerd
> >
> > ----------------------- cut here -------------------------------
> > From f3051dd52cb2004232941e6d2cbc0c694e290534 Mon Sep 17 00:00:00 2001
> > From: Gerd Hoffmann <kraxel@redhat.com>
> > Date: Wed, 16 Apr 2025 15:53:04 +0200
> > Subject: [PATCH] drm/virtio: implement virtio_gpu_shutdown
> >
> > Calling drm_dev_unplug() is the drm way to say the device
> > is gone and can not be accessed any more.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_drv.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > index e32e680c7197..71c6ccad4b99 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > @@ -130,10 +130,10 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
> >  
> >  static void virtio_gpu_shutdown(struct virtio_device *vdev)
> >  {
> > -	/*
> > -	 * drm does its own synchronization on shutdown.
> > -	 * Do nothing here, opt out of device reset.
> > -	 */
> > +	struct drm_device *dev = vdev->priv;
> > +
> > +	/* stop talking to the device */
> > +	drm_dev_unplug(dev);
> I have tested this patch on top of Michael's v2 and I don't see any
> splat on guest.
> 
> Feel free to add my
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric

Thanks, Eric!
Gerd, do you want to post a patch officially?
I just sent the dependency to Linus, maybe mention this for the
maintainers.


> >  }
> >  
> >  static void virtio_gpu_config_changed(struct virtio_device *vdev)

