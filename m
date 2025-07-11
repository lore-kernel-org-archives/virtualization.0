Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C92428725E
	for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233202; cv=none; b=LZNu4nXs3PN2RBmvvgZUCKaFeHqKAfJArTT0FrWJnieo6mioHtmUAvyGQZzbZWFeQRpE7s6FHulSQNcUGqD3SkPV2m0qptJzcd5cm5xXpA5w5CN9zeWkppFD6TuR2FG/aQTmLL6Bk7XwMgBC1laMiD8UEl6K6+DvOYi1WkKsL6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233202; c=relaxed/simple;
	bh=FD8akNhVCFE9rvl/IJgfqw/cZ2FtCXuUIv3/TN6KnGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cu7YJ9cVm4bnTIfdwCh274vcPkAfX1F720sOT1Zco/2c4ys/ANtBaXxGglIRahJYjfmzvvm0APGfUlDX2hhHSaBCbGS8cI7tCOlto5YQm6h6OM6FLOlv0l7dTud5KVGbizB/Gv9WKqVGhtmuZdnBcc96YOp6uO3NfpPjpKZ5UCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=edWqK9fX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="edWqK9fX"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4537fdec39fso6245375e9.0
        for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 04:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752233199; x=1752837999; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N2PVAjumjM6QBebDLC5QW4Rc7DpYox7DcXnPsrpWBK0=;
        b=edWqK9fX356rqn8qm/WSsjgal56PcRNCOahwB4upBDOOGyewSEau92lKjOugAghno6
         e8v/gqDL0foW0lnnyLFF1Or3RVnPzjMNlerNsbwbo/hNWUmlW+Yz3s/l8AZ9cnDzPsg8
         rpSrzhLhC3xd59VzPDMSHOwU+AQBOqsHAtHkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752233199; x=1752837999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2PVAjumjM6QBebDLC5QW4Rc7DpYox7DcXnPsrpWBK0=;
        b=CNLYLKjWipSpXnHySKvAggXd31V++2uRZ9TacNEWp1WSIhHsSOZSw5ALQPVFNTi0Cg
         E8HEtcuDwh7LOBjlqbSujg60bF+eY0bYvD7VmjAT+j1mFdC1mfs16OVf1LqD/1CHC7D/
         52Xmh9qnNKbmjELBe/SJc8ydbh80F4iGi5IKOmj1WtEqCpmJBWl60AwKcioK8lM6jGfV
         vdMRnigMXN+pdYcIByAfQQHMjwAMeY1Wp/IP6kAFFcr6l9lyQptt7S91dhzt+3hFaVbn
         unhuzWgxUtLIhILgStX/ygV66pxdZVW5kX3J4+nghMEwQbHTH+/wfOp82U5+WsG4ixaR
         a/iw==
X-Forwarded-Encrypted: i=1; AJvYcCUZLwvTv5HKG3uUjH/jFxJL5T8+oXlTlk+8QgfKBZ2ngkLYjEB6ronQpxqzLjWIYGikvHoZK8cPgeCuCR0k7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwewFTsNM4QOJK7uh+hizGNMSWDb0YurfG0uHHHquJiBY/VN5Ot
	pQ8N23MJ3shrN9fYZM+ir4K4NRKC83nDQEfoS+yhtXWEaFm8PURYfMex0QAKHq1Ay0s=
X-Gm-Gg: ASbGncu1wnyxLV2TY8J5PWBagFLcHiz7tVTKGk3BQe8tgFLUnZoZoqq2Pba4UtxXML3
	VA/wvf2fkHgMvdV1FOm3XHy/YUHoYBdsDOTE4UHm5WWKKro9o/Ur7WlrX4m0GArf24Hp1nf7pnl
	Ug/+bqT6gXDNEDUTP+EhXjc5kKPFKSfCPClM8xe4AshcarKBb7SPdEbrEQ51UfzPhS7zm+n/O5l
	PqDxrXlw9/RDHinwhknb6ag9lhHgE4eNx+9dFu3H+CfErbeFa+YHjtA7vmQoFdwrDQjJo+KGxML
	y/mPMv3K+tV04tuxVA4Qcb9NG9BVCIwGQNsoe71MYXG5WhskACkpSSQHVbuysPEpD8jGngXzBvC
	z5DXHWLnfmGt09auHc0Iow2st+HPXWDwGhkFzWyb0fcB/
X-Google-Smtp-Source: AGHT+IFVi7nm2kebBAJ8+93+5amqUpcfmZWMLm3ginfXIg49P5tt280hta+taQINrMUsHsBQFiNG1w==
X-Received: by 2002:a05:600c:6295:b0:43b:ca39:6c7d with SMTP id 5b1f17b1804b1-455ebce3f18mr16886065e9.3.1752233198798;
        Fri, 11 Jul 2025 04:26:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2464sm4296653f8f.38.2025.07.11.04.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 04:26:38 -0700 (PDT)
Date: Fri, 11 Jul 2025 13:26:36 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch,
	airlied@gmail.com, torvalds@linux-foundation.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
	kraxel@redhat.com, christian.gmeiner@gmail.com,
	dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
	olvaffe@gmail.com, zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 0/9] drm: Revert general use of struct
 drm_gem_object.dma_buf
Message-ID: <aHD07IF9Y7lntOLo@phenom.ffwll.local>
References: <20250711093744.120962-1-tzimmermann@suse.de>
 <bd14fdec-7e75-477c-a241-bac67f93d210@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd14fdec-7e75-477c-a241-bac67f93d210@amd.com>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Fri, Jul 11, 2025 at 12:32:02PM +0200, Christian König wrote:
> On 11.07.25 11:35, Thomas Zimmermann wrote:
> > Revert the use of drm_gem_object.dma_buf back to .import_attach->dmabuf
> > in the affected places. Also revert any fixes on top. Separates references
> > to imported and exported DMA bufs within a GEM object; as before.
> > 
> > Using the dma_buf as the one authoritative field for the DMA buf turns
> > out to be fragile. The GEM object's dma_buf pointer can be NULL if
> > userspace releases the GEM handle too early. Sima mentioned that the fix
> > in commit 5307dce878d4 ("drm/gem: Acquire references on GEM handles for
> > framebuffers") is conceptionally broken. Linus still notices boot-up
> > hangs that might be related.
> 
> Did I missed that response? What exactly is the issue?

Sorry, private thread from Linus that he's hit the regression, applied the
fix, which was apparently not enough. Then applied the revert of "drm/gem:
Acquire references on GEM handles for framebuffers", which worked better,
but still resulted in not-before-seen issues somehow. At that point I
figured it's best we backtrack because we seem to have a history of not
really understanding this anymore collectively. Thomas also found yet
another related regression around drm_prime in -next, so this looks way
too messy to me for late -rc.

The regressions left over after the bugfix from Thomas that's in
drm-misc-fixes is some silent hangs at login, without any traces anywhere
what got stuck.

We don't yet have feedback from Linus whether the revert more approach
here helps.

> > Reverting the whole thing is the only sensible action here.
> 
> Feel free to add Acked-by: Christian König <christian.koenig@amd.com> to the entire series.

Thanks, I'll apply it to drm-fixes directly assuming intel-gfx-ci
approves.

Note that I'm not fundamentally opposed to the concepts here, at least the
usage count extensions of handle_count seems not entirely off. But it does
look very questionable to fix the patches that switched from
->import_attach.dmabuf to ->dma_buf, and it's simply too late in the -rc
for more big games.

Cheers, Sima

> 
> Regards,
> Christian.
> 
> > 
> > Tested on virtio; and amdgpu, simpledrm plus udl for dma-buf sharing.
> > 
> > Thomas Zimmermann (9):
> >   Revert "drm/framebuffer: Acquire internal references on GEM handles"
> >   Revert "drm/gem: Acquire references on GEM handles for framebuffers"
> >   Revert "drm/virtio: Use dma_buf from GEM object instance"
> >   Revert "drm/vmwgfx: Use dma_buf from GEM object instance"
> >   Revert "drm/etnaviv: Use dma_buf from GEM object instance"
> >   Revert "drm/prime: Use dma_buf from GEM object instance"
> >   Revert "drm/gem-framebuffer: Use dma_buf from GEM object instance"
> >   Revert "drm/gem-shmem: Use dma_buf from GEM object instance"
> >   Revert "drm/gem-dma: Use dma_buf from GEM object instance"
> > 
> >  drivers/gpu/drm/drm_framebuffer.c            | 31 +---------
> >  drivers/gpu/drm/drm_gem.c                    | 64 +++-----------------
> >  drivers/gpu/drm/drm_gem_dma_helper.c         |  2 +-
> >  drivers/gpu/drm/drm_gem_framebuffer_helper.c |  8 ++-
> >  drivers/gpu/drm/drm_gem_shmem_helper.c       |  4 +-
> >  drivers/gpu/drm/drm_internal.h               |  2 -
> >  drivers/gpu/drm/drm_prime.c                  |  8 ++-
> >  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c  |  4 +-
> >  drivers/gpu/drm/virtio/virtgpu_prime.c       |  5 +-
> >  drivers/gpu/drm/vmwgfx/vmwgfx_gem.c          |  6 +-
> >  include/drm/drm_framebuffer.h                |  7 ---
> >  11 files changed, 35 insertions(+), 106 deletions(-)
> > 
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
