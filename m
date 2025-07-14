Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D8E225771
	for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496785; cv=none; b=dJ4tDaDcouNRVMcyLrJGRXAspOc+I1SZj9BPxsUUdTALqFVdL3yn6WNuFN0Ur7EslTak7p/t7DVH9G5cYqQsVew7vMPfxsmP0/DOmih1NW2H1B2qn5xqre5N8sp2Wu0VYfjaK2MU0ljgNBC4tKS34HIYNeLkBgizELIyTwDR1PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496785; c=relaxed/simple;
	bh=Rv8v8bZp5vd+y6BD4PenY5xcThbuV69ONSekjNmZAEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJX3YCeiZ0ck7c7ogWc9H2PA4KGGKJJX7vyDodbG8Bd7VueK8ejQxuzOXY9kEARsIi9b6nRS9rMoQ7W5gmnzj6961mabW2S4Oi20IKVzzUQfWppoyJmWpsD1ReFewRb8Nobf7i/Z8QVuIkkIbBv4agStwI5zfjcGTIPL09oi9hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=GLeRCNpJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GLeRCNpJ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so3813180f8f.3
        for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 05:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752496782; x=1753101582; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XErAJu/6i7g4EFf9vKNbP+OcUQZQKENL92ttAjzjYEU=;
        b=GLeRCNpJnXHtRm/1+ZqUx7OD3ophChIoo8BU+QoR4Mea28ptzwOLr2ucbggCxaAfeO
         iYPPWRjPKgRZKZIKmqciNo4eVjQ3SmrPTYyP2VBicrSWUXLX9yTyftqklvnsPvJeZI10
         +97VXNSitv1d+aRr3vIA3omFNvbHW7ll3K5Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496782; x=1753101582;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XErAJu/6i7g4EFf9vKNbP+OcUQZQKENL92ttAjzjYEU=;
        b=RGeBFOZfGyRo49OYldTlixE3HUg+VwyS1Av8yzMyJvrlqvheHESDXfAvhVPthtI9Uz
         GnfRourFsv6x6fYhz1meJw8lrXaSwT8k3G6RNwGpPG4u3/gClhNts88x38q19c8qY5C/
         +u+dvfx9exDho+R/wUC2YAgwXCNSGjyNSQ8v4oCKvLB/UVO4yy0JqSYA00EFEOKtPP/q
         c4lfRtCYXYyaHIYstWonOC7z4tGP9HW02LQWlJNbzy1MIKLiTQvVfdos8aH2IJUR2BmS
         0vsJJXRdKvL6gNW/uNeIkQq+A3GfH75XrjWRryhy9Xio2LiaLubhtPLQd955dXbkqcfH
         xZlA==
X-Forwarded-Encrypted: i=1; AJvYcCUGLPpafN6HkZ12nDHu45SYnM2Z8QwOO4eRPbAWvrOm1wRKPJOM05ke3xrqF83JCOsRlWLAAZ0hUcpMwY03hw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGZPnMSGSqc0wP707McFor9ga6dOHBSjp9f7K2daMTXqO4qFEe
	RA01I6p648FFQFhxFu78mzmA9a2e2i3vbuUTwDBt3vg2+L8eRdt+6k44hAfsDYnIBMw=
X-Gm-Gg: ASbGncvXnEAcGd6KPBYb0MX3g4Q9uRGNrtxDORvf6ZtFKWrRiyE/6E6/UoQSg5OQwiK
	2DdWuZOPoVW7vqma4p38TZZ2E5PHu0OVanrZeebzXWDKnSqq9+GUbmQjaMdy6W1JEvFBM04nbnf
	zVvHSKHqkA9afS4kHWKLYGR2bHKK4qRBLd+9tgOGumqvGHQuI2tHq4DyWI9p/UQCxrQLktvPAxv
	DvdXg5ma4tEd09xKe5Gt2vKdM41XDeoQ7wJJhorDq197vlJRA3MHxLPr0eipnH80+ox5kvoAhjb
	yTVXk2ZA40g3EsHr/HH0hYP6arMuNted9awjjXyh1sNBTLmhCNydDs7lDN7TiW3VXBOgncJyUwD
	lZGjqn3EGjA8sXAd6Po7L33insgnENBz86nSwT8aQnez3
X-Google-Smtp-Source: AGHT+IG6tSn1rFwzUvQrU3dFhdLGnz5/j4mh9qiCr0au1QUPGoiO9awMtbUHlEtASqVdx2HXNSxeBQ==
X-Received: by 2002:a05:6000:25f6:b0:3a5:2875:f985 with SMTP id ffacd0b85a97d-3b5f18ffd7bmr10766504f8f.59.1752496781706;
        Mon, 14 Jul 2025 05:39:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26938sm12188789f8f.89.2025.07.14.05.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:39:41 -0700 (PDT)
Date: Mon, 14 Jul 2025 14:39:39 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, airlied@gmail.com, christian.koenig@amd.com,
	torvalds@linux-foundation.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, l.stach@pengutronix.de,
	linux+etnaviv@armlinux.org.uk, kraxel@redhat.com,
	christian.gmeiner@gmail.com, dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org, olvaffe@gmail.com,
	zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 0/9] drm: Revert general use of struct
 drm_gem_object.dma_buf
Message-ID: <aHT6i723ffg2_m2v@phenom.ffwll.local>
References: <20250711093744.120962-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711093744.120962-1-tzimmermann@suse.de>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Fri, Jul 11, 2025 at 11:35:15AM +0200, Thomas Zimmermann wrote:
> Revert the use of drm_gem_object.dma_buf back to .import_attach->dmabuf
> in the affected places. Also revert any fixes on top. Separates references
> to imported and exported DMA bufs within a GEM object; as before.
> 
> Using the dma_buf as the one authoritative field for the DMA buf turns
> out to be fragile. The GEM object's dma_buf pointer can be NULL if
> userspace releases the GEM handle too early. Sima mentioned that the fix
> in commit 5307dce878d4 ("drm/gem: Acquire references on GEM handles for
> framebuffers") is conceptionally broken. Linus still notices boot-up
> hangs that might be related.
> 
> Reverting the whole thing is the only sensible action here.
> 
> Tested on virtio; and amdgpu, simpledrm plus udl for dma-buf sharing.
> 
> Thomas Zimmermann (9):
>   Revert "drm/framebuffer: Acquire internal references on GEM handles"
>   Revert "drm/gem: Acquire references on GEM handles for framebuffers"

Ok, I think all the below we should still apply for -fixes, because
fundamentally gem_bo->dma_buf is not invariant over the lifetime of the
buffer, while gem_bo->import_attach.dmabuf is. And so we blow up.

For display drivers the handle_count reference mostly papers over the
issues, but even display drivers are allowed to keep internal references
to the underlying gem bo for longer. So there could be a bunch of really
tricky bugs lurking.

For render drivers it's even clearer, they don't have framebuffers as
objects, so there the fb handle_count references does not help.

I'm not opposed to trying to unify these fields for imported dma_buf, but
currently they're just not. Hence all the reverts.

The patches also need Fixes: and as needed, cc: stable added for merging.
With that and the above text as additional justification added:

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

Also we'd need to chase down any addiotional conversions that have only
landed in -next meanwhile of course.

₣or the handle_count patches I'm less sure. I don't think they're
justified for fixing the gem_bo->dma_buf NULL pointer issues, but they do
probably help with the GETFB/2 confusion Christian has pointed out.
Personally my preference is:
1. Apply the two reverts.
2. Create an igt testcase for the GETFB confusion
3. Figure out what the right fix for that is, which might or might not be
the handle_count reference of drm_fb.

But with my maintainer hat on I don't mind about the exact path, as long
as we get there somehow. If you decide to do land the reverts, they also
have my:

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

Cheers, Sima

>   Revert "drm/virtio: Use dma_buf from GEM object instance"
>   Revert "drm/vmwgfx: Use dma_buf from GEM object instance"
>   Revert "drm/etnaviv: Use dma_buf from GEM object instance"
>   Revert "drm/prime: Use dma_buf from GEM object instance"
>   Revert "drm/gem-framebuffer: Use dma_buf from GEM object instance"
>   Revert "drm/gem-shmem: Use dma_buf from GEM object instance"
>   Revert "drm/gem-dma: Use dma_buf from GEM object instance"
> 
>  drivers/gpu/drm/drm_framebuffer.c            | 31 +---------
>  drivers/gpu/drm/drm_gem.c                    | 64 +++-----------------
>  drivers/gpu/drm/drm_gem_dma_helper.c         |  2 +-
>  drivers/gpu/drm/drm_gem_framebuffer_helper.c |  8 ++-
>  drivers/gpu/drm/drm_gem_shmem_helper.c       |  4 +-
>  drivers/gpu/drm/drm_internal.h               |  2 -
>  drivers/gpu/drm/drm_prime.c                  |  8 ++-
>  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c  |  4 +-
>  drivers/gpu/drm/virtio/virtgpu_prime.c       |  5 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_gem.c          |  6 +-
>  include/drm/drm_framebuffer.h                |  7 ---
>  11 files changed, 35 insertions(+), 106 deletions(-)
> 
> -- 
> 2.50.0
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
