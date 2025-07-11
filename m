Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BE11DED5B
	for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233524; cv=none; b=r0rD5I8DmmwEi/p40qkUnyMCTr9xxIzUFDf3uX7e/wnoykYZ87U/W+211H8dakrdxr7rQeylUW0gocQt13YKrA3b/6hf2PpvkXq5yF3lXpyHtNsRU4oOaAHVBzRu9mBK0gyFtFbuKVRhlDieVK6eXvzkwjVRWyybLbnRu0WZaOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233524; c=relaxed/simple;
	bh=xwh21tyb+bgWrhyLW4iEhOBSt0gHG1iw/xJCHoBGv7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEFJKc9+U9GnWbWEOl/qEzt2MK2l3tRPzA47rtRNo2RenLtd8/VZfqH4IUGK3kqQUsBUdhnsdP2+le/ar+BTlV5axorR6ZH3dWUQjgzs2eldBaEJe1OMkiSH7Pj/G75TypEYVvn578S8CApFmxkSI6ytedFyWywlmDvpWpFYwDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=OdhK0Mx6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OdhK0Mx6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-454b1d0a115so7183265e9.2
        for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752233520; x=1752838320; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/dNrxn0YIHnXxTbrqnAMkGtS4RTsd+jjEf/10Hz2GZA=;
        b=OdhK0Mx69MddHQh59aqyKKdTBoFFc1u7z/GtSYHlkntwKXV/KUAHV/w7Qpumwz7nQm
         TT8C9lC99MQi8Gy/6boXHuKY1Lswpe1/nWzSD9N9KZdCZzN9THxnDyTwf4N7WzxyPeHv
         3iP8cbzoEt+1QRY6M9fGE6BTvNLQ8IEXX8LM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752233520; x=1752838320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dNrxn0YIHnXxTbrqnAMkGtS4RTsd+jjEf/10Hz2GZA=;
        b=XG49DS30ihWkucEf9EPEWTTjOsFmcUj+I5TNdJ2/zGEdBk0g+PXjF6N2duyoFes7hs
         VapuRv8eG42X0MDTIrUKwdyiZrXcrHCaw8dF9zSPtbcYjhiqTaXYV1YLfM9JklkWMKIa
         MpVxJj/CA1tooQOSsAL0LwDoy7iAPRDBAeZyyifmUSOl1ujMs6zo0J9HlsEcgwBrZCan
         ufWIeFDK6OyDzuqrbIPclgtZLSsJ31eQt3HtTV0rWFV8+jSJnREB3IhVI6ErWyjn4ntb
         DZV4JJXBbAOVstLY2pGBL1b7Ixt7IYsiX7+mUKpOQiFa8F5HwMp+WC3IOEO3TbdQjsbc
         Mt0w==
X-Forwarded-Encrypted: i=1; AJvYcCU9SaiJ8fRQqv+AGty2AO5oXNg/PPGpt2LSaiyprh+2h+qSVDQOq1UZUb01rsjGoYRJiHwCmPuo2O5zrz9nGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBQGRHvyGIRGhal+t40m35FeZCNOILzrT5ybggE9AGq1i/XBx1
	RkXgVZT1d6FjJviWc8mciYLUL9n3I9mdD+wfZOwgEIOLHCGCL88rxZUeNdiWt0393qg=
X-Gm-Gg: ASbGncsEN1Vct//wRVqGI0EMAtmn8EAvFoOJ0mhOwRVz4JGoWg/yXPTfZTmQejMgNeN
	OyqaE3G0AgwIdaNwt7iH1YS54QAPopFxL2S5sQQrFIbLVzCVfvjTN2AirT24vt4ZZ1oXjWtJKZF
	Bb7PkGZe+PZFd5NmD+Q5wFnw297BNLMHPQVSn+JFWStL0kuXM5/mFCV3jp21w2ku3mAu3eH0QaN
	RFT9RGUzB8MClS0lLwT1Cjxyu22qxFa4jLEfj+vUhWncJ9FOXmwrFd2HY/rqUQxgsiA6oEHW2h+
	/lpFSbzRomHiErSOXYqxJ74cC73HxMI4iOjfmPPGBT3P8cU1/5NNsbG/kA58153bUFBPKbZWAoX
	q2+EpOxds3gZYgOmSM6/VQOIQuCpts2wjMA==
X-Google-Smtp-Source: AGHT+IExin2KICT09xxIWEiy7oXdoYxqzYy1rlv7xdICXXPI31huPS+YOlQR6sPcBxEiaeI5BkQrcw==
X-Received: by 2002:a05:600c:1551:b0:448:e8c0:c778 with SMTP id 5b1f17b1804b1-454ec27d5d5mr21986325e9.22.1752233520484;
        Fri, 11 Jul 2025 04:32:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5103c2asm81356815e9.33.2025.07.11.04.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 04:32:00 -0700 (PDT)
Date: Fri, 11 Jul 2025 13:31:58 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch,
	airlied@gmail.com, christian.koenig@amd.com,
	torvalds@linux-foundation.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, l.stach@pengutronix.de,
	linux+etnaviv@armlinux.org.uk, kraxel@redhat.com,
	christian.gmeiner@gmail.com, gurchetansingh@chromium.org,
	olvaffe@gmail.com, zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 3/9] Revert "drm/virtio: Use dma_buf from GEM object
 instance"
Message-ID: <aHD2LmTe238vh5BS@phenom.ffwll.local>
References: <20250711093744.120962-1-tzimmermann@suse.de>
 <20250711093744.120962-4-tzimmermann@suse.de>
 <9058368a-0e5b-4cb5-a04f-6feaa80329a0@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9058368a-0e5b-4cb5-a04f-6feaa80329a0@collabora.com>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Fri, Jul 11, 2025 at 02:29:04PM +0300, Dmitry Osipenko wrote:
> On 7/11/25 12:35, Thomas Zimmermann wrote:
> > This reverts commit 415cb45895f43015515473fbc40563ca5eec9a7c.
> > 
> > Reverting because the fix-up commits are suspected to cause regressions.
> > 
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Are the fixes and stable tags missing in the patches? AFAICT, the intent
> is to fix stable 6.15 kernel regression.

Yes, I'll add them when merging to drm-fixes.

> > ---
> >  drivers/gpu/drm/virtio/virtgpu_prime.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> > index 722cde5e2d86..97aaee26cb02 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> > @@ -204,15 +204,16 @@ static void virtgpu_dma_buf_free_obj(struct drm_gem_object *obj)
> >  {
> >  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> >  	struct virtio_gpu_device *vgdev = obj->dev->dev_private;
> > +	struct dma_buf_attachment *attach = obj->import_attach;
> >  
> >  	if (drm_gem_is_imported(obj)) {
> > -		struct dma_buf *dmabuf = bo->dma_buf;
> > +		struct dma_buf *dmabuf = attach->dmabuf;
> 
> Nit: I'd write this as `dmabuf = obj->import_attach->dmabuf` for more
> consistency with drm_gem_is_imported()

Reverts shouldn't have any additional changes, even style nits imo, so
I'll leave it as-is.

> 
> >  		dma_resv_lock(dmabuf->resv, NULL);
> >  		virtgpu_dma_buf_unmap(bo);
> >  		dma_resv_unlock(dmabuf->resv);
> >  
> > -		dma_buf_detach(dmabuf, obj->import_attach);
> > +		dma_buf_detach(dmabuf, attach);
> >  		dma_buf_put(dmabuf);
> >  	}
> >  
> 
> Acked-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Thanks, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
