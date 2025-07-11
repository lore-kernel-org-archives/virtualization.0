Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C25155389
	for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752270771; cv=none; b=AmeJnSEb2m6pnyeJD4HgpTtpKd7HORQBiQiuLJsogYTK4mjKABoZKHputZ1aesR7GhqNpcaeaeVVDeDZ5f5v9RGcr75BSusAJnqPe219+zB/e/ZlEdarxLBtf826wuIlbWjLgGhSD2pggfJ98d277wMAWaPzhWG2+12JIHmQQQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752270771; c=relaxed/simple;
	bh=7qhUP6loyfP+1nHm+xiF8DaW7uZXe/BKUfvm8FPn3HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI+MCevLluOi+AhpyIBgHE+O6J6sDwKNiA2nP11t1vBHX8pbjgX0btFfbNj6vXpFhYiPExC0Qg2bSGgU8T7g6JVZJNYfrBGQzPLF/9MZSvgWG8711n5NyxlLzbTrIHaRot6K19JekXnY+ir2CbCsqcoKUwR4UGrtE2OqcLXHNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=KGp0U3gp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KGp0U3gp"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso18154765e9.2
        for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 14:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752270768; x=1752875568; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8RRcJnGL7VYeTaYAkj6SgjU8fJ+4S8aRG1AWN+AY7A=;
        b=KGp0U3gp2Uv6/BteTm1yE6q7GYAtevbg3PpB6oqqJhqT7obi+OgaywiNgmHo8gdO1c
         n+tf+65vnBakBSiEik8Elv/9gjWklk+AUKPTyfahB/Cik7vK9eWKwybl72ygrGC64t32
         smj2as4589Pw7eqZfjWjWvf5Ab+elkrsFBFhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752270768; x=1752875568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8RRcJnGL7VYeTaYAkj6SgjU8fJ+4S8aRG1AWN+AY7A=;
        b=I0meXwP7ro0un0IpSeZ9g2HMVB2oXYMMvRFAyLzyh+o6FJwL0V4E3pOeGWdbd1g6iv
         6m2xxWyE6WYo6K8MW/QeeGeYyqzsERQajcvh9npLgIrh0BkUCtxh7eV8tUDibnCN9uvX
         GtIv4mwtz8uw1y/mSfezSn5Tmq58zz2tNZgIlATntLMuP6LnzvFFqOnVxIgHo9KkzYcz
         pJwaw/RKsWodSf2/e+XjK9kXrmxneY5aNKu/DpoBbwkckZyFdG7YuJCLinfMXnwgsXkk
         ks+BSPM4lgmC04ZbvQoyTSgbSG/lQMo6bFn4b6qDz5dturwx3UjjB3bUHQyMjGp+lEHb
         FJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCVcGhNEUeIV+hkzbVm69hj7inUUk4gxqQM7kSRDqhs+PVOF+DW4m/RZq4rs0B5FKa0MbEAoYI6l+WCC3w7dVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLG3Qb+i0BYbQP3DdP2q9WNKSxYm0IN6ey/TDGTL8xCPuusda0
	ko2x1IUyf18CD2aYeCY7ZCN0ak+MPLIKG+51A8NuwGOJ255DCOSORaYDI0Dd9wNC/8s=
X-Gm-Gg: ASbGncuaHOW4TU2AYF6f0jsSyU005eaeOSo1enePfrYzQmteHgVuoJxwyG7VdY3Ghe4
	6NZ036GQwRe3DU8P0pfqITIxMVpacYz+A1mwrqZDPnK096dHtPrI3I5PCAuUI54xQ5V5g82mhqN
	0AxBU6Ph5g79KRzd2RMBJxIlzmHVZ5OH/d9I8zPYO3qLGCFeOctR3vLcMHc1B8TkCDkW3L4Smaj
	JkZ8i8VK6N5mkvyk2YSNRvt1+15hbpOxuwSES2wZAMp/j9tVVgt/QApY0/zruRNygmkFIAY+N05
	fR21eiTzLJFnLMmBLBxWjbx4vnFUjS5iK3+B7Lnes5G/FEPqdInRBvSjekVTWRQ564QaLrT/7Ek
	2I8HZLd8IWbDbVUuszMRZNyQGt+n0OSH/cg==
X-Google-Smtp-Source: AGHT+IFN19WMRiUUdCkB96tSscJeaW1XzTJqoWGFT70YkkmatxtYFIYZq8faZzHYKBK1l+DS/8d3rw==
X-Received: by 2002:a05:600c:c0c1:b0:455:ed0f:e8ec with SMTP id 5b1f17b1804b1-455ed0fec5dmr32188645e9.9.1752270767429;
        Fri, 11 Jul 2025 14:52:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e8cfsm5387021f8f.80.2025.07.11.14.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 14:52:46 -0700 (PDT)
Date: Fri, 11 Jul 2025 23:52:44 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch,
	airlied@gmail.com, christian.koenig@amd.com,
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
Message-ID: <aHGHrNVtupuOHODi@phenom.ffwll.local>
References: <20250711093744.120962-1-tzimmermann@suse.de>
 <CAHk-=whnUp7M-RZ6yzOyF6bzA4cmbckaH4ii_+6nBm0PqKOaQg@mail.gmail.com>
 <CAHk-=wif6u3C4gk7BtR1M+0SvHruXZ7xycP5oDdg-SF1D=ELqQ@mail.gmail.com>
 <CAHk-=wi3Fbiii2K9fgmoAgoJYoLuRyWfOZhh57FmREE15RbiUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi3Fbiii2K9fgmoAgoJYoLuRyWfOZhh57FmREE15RbiUg@mail.gmail.com>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Fri, Jul 11, 2025 at 11:37:30AM -0700, Linus Torvalds wrote:
> On Fri, 11 Jul 2025 at 10:35, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I'm hoping the login time timeout / hang ends up being due to a known
> > netlink regression, and it just happened to look like a drm issue
> > because it exposes itself as a hang at the first graphical login
> >
> > A netlink regression *might* fit the pattern, in that it might just
> > cause first login dependency issues and resulting timeouts.
> 
> Well, considering the random timing behavior of this bug, it's hard to
> be really sure, but two boots with the alleged "fix" for the netlink
> issue made the behavior worse, so it does look like my problems on
> this machine were a combination of the drm refcounting issue and the
> netlink thing.
> 
> I guess I'll have to do a lot more rebooting to be sure, since the
> hangs and timeouts have been so random. But the netlink "fixes" did
> give me a hang that was very different from the previous ones I've
> seen, so I think the drm code is off the hook on this one.

Ok sounds good, I won't include the drm reverts then. I do think the
change from ->import_attach.dmabuf to ->dma_buf is still suspect, and the
handle_count reference change for fb won't cover all the other places this
might blow up (just less likely since the most common multi-gpu use-cases
are sharing render buffers to a display driver). But better we take
another week to really think this through before rushing things.

The handle_count changes do look reasonable to me too, but for an entirely
different bug around bo import/export. And I think we'll want a testcase
for that to make sure, and evaluate options properly.

But now I'll just type the pr summary and then w/e for me.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
