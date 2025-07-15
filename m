Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8F1F0E26
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584879; cv=none; b=Ec8Azp0WlMiDSncgVhoDzyv6OFCHXij/f5/TTYAa/uA/BbxhUw1a2NzMazoccwnynLUXsqG5KIAnKSqYxAY3TTnV6JMF/FQAO9l5NuppxEz35M1lxm76c2vVFNPTaGS9eIlr4Bs6GjtuKHJc5P+fJ6fCYf303DgoAoCRqSn1rc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584879; c=relaxed/simple;
	bh=5DHTOEeibn3XpM7VD03XgDrl3GdLnZv4ysGISTOhvn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8kTM7hMRzpvootFfrq9WNvPC9HBGhjM7Xmtz2vjY0+npaJhzwfA3nmL17BcD5DXTsIqi3vJi/M7Kdzc0O6CmguqVy4mjwgRjoiyWZ5UIIgAQ7rc2QfU2K+leSwONQIFGp1Fzcou/APseOfM+oG+nYo8pOMdv6Nl56fslVCmpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=iYMwAoVq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iYMwAoVq"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso2521918f8f.0
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752584875; x=1753189675; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vhalk+tFLZLcoAcVW7SM+79/QnX7jEAgMagSpNChQks=;
        b=iYMwAoVq8OfoGxniiEYIKmise0ZfPwov7mWyMM+XKGChxCApY4YFdfRVrmUHWJCdX4
         OtMb6zitTrW7Z8OgDaudF5nKqv2jCy0UCnCwThVIYR9iYOVH75AhvAiQHReZy0WUsbJE
         Qq7ETSTqR/PCYzD/0N5+ClUl9/UqqBSQqHVqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752584875; x=1753189675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vhalk+tFLZLcoAcVW7SM+79/QnX7jEAgMagSpNChQks=;
        b=C3vdF3WsSFobGjfZ7IlSswte5gtpKBAQhfrMnmces0o0yBKJYY2/UXL7ZrSveNeeUC
         y971dECwY2+CCfv+i3v+5v/sPAOJn6+oUZMZqqG8yfh9i9Miu8VLOe+bswrFVutBrFhi
         dcIGUf71+TSoWooszBfWQcQqw3+jabKD1baouq1foGh+tf1pCVzzp4t9iwvDJJzfSKmG
         18z9CesMzabLAeCrWnloeJcMEiHE6jYcEFb704YlYVsmGxwfmvcUxiYe/rm6GpO0Dg/J
         WYUai0q+lPScPP5hy5JMKmqsDBiB8mj7l8Iq+3hlLYU8JZzEqnv854wYW8kKyGQe/qbI
         eVKA==
X-Forwarded-Encrypted: i=1; AJvYcCWiNL4Lq+JqRV7tUGf+8gH9qARMNo4t3rOwVtYbsrb5z93Lca2jIZBivy+fAFcVMthv3K/llg6Nq2uJ8kKRDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YycrGwtC+km6gRdG2LYttkxTukxsSf3gjplKJuMDqayNkEs67xx
	hx1EpYta8K8y7mJrTY05SAk11dXDnC/1G5cm+MhREpXbpLCYoVaJP/ET1IHoWdtn4jk=
X-Gm-Gg: ASbGncu9romCwj1eAaLz296TpFzc7ovjrDaM87N+4OJGujV9QNq5xG7pDoElU+6erlY
	lsWAoDn6B1O86gxzcNkX/le6FaCVtz3+zRHcyW73Yzmd5852Bzgg7jKPImBh3Qogq6PbWZGUEhh
	QDUnqE5c01dw369l3uQmm2fV8mNKYFlpR53falmudnWxPxtW1qvBPmRD+Nts+fUr0aBNHQ9KWgH
	66XJUEZ05IPup0kCOYOb6cQ9OoomwgE9EQjSe7841yiFs/PQQaLAtaTcIkCxRJl2do8g1roro/b
	aCOZC6i9OSp9xxiXHrIYqR7wlqyw0hTDmtupdsh+yUUDGCUe2WNtXNFmmoXF5/T6i3rjlBHtSRM
	OL0ZMUCy60u5Zxvj4DxEywp0aHA+UqOnR21tmLy3rQaNe
X-Google-Smtp-Source: AGHT+IFvjJv0iQ1esKVhC2U9EfqSY36m9csxovxVuTxGwCMaO1aKfhcXc28AxThBk/EuVM6f1XOsAA==
X-Received: by 2002:a05:6000:2c09:b0:3a3:63d3:369a with SMTP id ffacd0b85a97d-3b5f188e822mr16534712f8f.25.1752584874381;
        Tue, 15 Jul 2025 06:07:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d76fsm15422563f8f.64.2025.07.15.06.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:07:53 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:07:51 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, simona@ffwll.ch,
	airlied@gmail.com, christian.koenig@amd.com,
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
Message-ID: <aHZSp3BBBgS0p88B@phenom.ffwll.local>
References: <20250711093744.120962-1-tzimmermann@suse.de>
 <aHT6i723ffg2_m2v@phenom.ffwll.local>
 <7053d7c9-62c1-480c-bca6-ca8ad6ca49a0@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7053d7c9-62c1-480c-bca6-ca8ad6ca49a0@suse.de>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Tue, Jul 15, 2025 at 09:41:12AM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 14.07.25 um 14:39 schrieb Simona Vetter:
> > On Fri, Jul 11, 2025 at 11:35:15AM +0200, Thomas Zimmermann wrote:
> > > Revert the use of drm_gem_object.dma_buf back to .import_attach->dmabuf
> > > in the affected places. Also revert any fixes on top. Separates references
> > > to imported and exported DMA bufs within a GEM object; as before.
> > > 
> > > Using the dma_buf as the one authoritative field for the DMA buf turns
> > > out to be fragile. The GEM object's dma_buf pointer can be NULL if
> > > userspace releases the GEM handle too early. Sima mentioned that the fix
> > > in commit 5307dce878d4 ("drm/gem: Acquire references on GEM handles for
> > > framebuffers") is conceptionally broken. Linus still notices boot-up
> > > hangs that might be related.
> > > 
> > > Reverting the whole thing is the only sensible action here.
> > > 
> > > Tested on virtio; and amdgpu, simpledrm plus udl for dma-buf sharing.
> > > 
> > > Thomas Zimmermann (9):
> > >    Revert "drm/framebuffer: Acquire internal references on GEM handles"
> > >    Revert "drm/gem: Acquire references on GEM handles for framebuffers"
> > Ok, I think all the below we should still apply for -fixes, because
> > fundamentally gem_bo->dma_buf is not invariant over the lifetime of the
> > buffer, while gem_bo->import_attach.dmabuf is. And so we blow up.
> > 
> > For display drivers the handle_count reference mostly papers over the
> > issues, but even display drivers are allowed to keep internal references
> > to the underlying gem bo for longer. So there could be a bunch of really
> > tricky bugs lurking.
> > 
> > For render drivers it's even clearer, they don't have framebuffers as
> > objects, so there the fb handle_count references does not help.
> > 
> > I'm not opposed to trying to unify these fields for imported dma_buf, but
> > currently they're just not. Hence all the reverts.
> 
> Thanks for the write up.
> 
> > 
> > The patches also need Fixes: and as needed, cc: stable added for merging.
> > With that and the above text as additional justification added:
> > 
> > Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
> > 
> > Also we'd need to chase down any addiotional conversions that have only
> > landed in -next meanwhile of course.
> > 
> > ₣or the handle_count patches I'm less sure. I don't think they're
> > justified for fixing the gem_bo->dma_buf NULL pointer issues, but they do
> > probably help with the GETFB/2 confusion Christian has pointed out.
> > Personally my preference is:
> > 1. Apply the two reverts.
> > 2. Create an igt testcase for the GETFB confusion
> > 3. Figure out what the right fix for that is, which might or might not be
> > the handle_count reference of drm_fb.
> > 
> > But with my maintainer hat on I don't mind about the exact path, as long
> > as we get there somehow. If you decide to do land the reverts, they also
> > have my:
> > 
> > Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
> 
> Let's first revert all the dma_buf switching in drm-misc and other trees.
> They should
> be easy. If we revert the framebuffer-related A changes first, we might end
> up with
> these intermediate errors again.
> 
> There's no hurry with the framebuffer changes. We can address them after
> upstream
> picked up the dma-buf reverts.

Yeah I think that's the most prudent path forward, otherwise we might
accidentally regress linux-next in an avoidable way.
-Sima

> 
> Best regards
> Thomas
> 
> > 
> > Cheers, Sima
> > 
> > >    Revert "drm/virtio: Use dma_buf from GEM object instance"
> > >    Revert "drm/vmwgfx: Use dma_buf from GEM object instance"
> > >    Revert "drm/etnaviv: Use dma_buf from GEM object instance"
> > >    Revert "drm/prime: Use dma_buf from GEM object instance"
> > >    Revert "drm/gem-framebuffer: Use dma_buf from GEM object instance"
> > >    Revert "drm/gem-shmem: Use dma_buf from GEM object instance"
> > >    Revert "drm/gem-dma: Use dma_buf from GEM object instance"
> > > 
> > >   drivers/gpu/drm/drm_framebuffer.c            | 31 +---------
> > >   drivers/gpu/drm/drm_gem.c                    | 64 +++-----------------
> > >   drivers/gpu/drm/drm_gem_dma_helper.c         |  2 +-
> > >   drivers/gpu/drm/drm_gem_framebuffer_helper.c |  8 ++-
> > >   drivers/gpu/drm/drm_gem_shmem_helper.c       |  4 +-
> > >   drivers/gpu/drm/drm_internal.h               |  2 -
> > >   drivers/gpu/drm/drm_prime.c                  |  8 ++-
> > >   drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c  |  4 +-
> > >   drivers/gpu/drm/virtio/virtgpu_prime.c       |  5 +-
> > >   drivers/gpu/drm/vmwgfx/vmwgfx_gem.c          |  6 +-
> > >   include/drm/drm_framebuffer.h                |  7 ---
> > >   11 files changed, 35 insertions(+), 106 deletions(-)
> > > 
> > > -- 
> > > 2.50.0
> > > 
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
