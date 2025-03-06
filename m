Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111681865E2
	for <virtualization@lists.linux.dev>; Thu,  6 Mar 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276335; cv=none; b=kw8U9cFSBePoPOP3y/vCD8g/ad7mwzIqVzuLh0l30jCUXZgJeu4gRe+j1BtmAJ4vM2ofq+qpIX7Ri5TWmcd9tDJibu1dZ4rjw9kPA/KouKNfsISeh5uWZ3LxDngJ77OYq/3WabngK46Hl8Ld1JvAzfoMUdnzeVsGlzsfPfqQSJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276335; c=relaxed/simple;
	bh=1mrQA3uTO5h6ZiINd3iS+tcdz2BagICZLJWut1QbQmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIGg9ibAInMNitcyd2c5ZcveOIDqz/qD91ke7WTK8r+mfwid4yRCG2Qrqu7vDca29w7NSDiA11/HQWq7su2ShuoHsI+ADjfBpTrYBIkk8YC2bGS20lMWPyGwHrETDYpNzwyibLT42knTW3Llr+BdvUsxdlcDACMLf9/6aMBZDMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=IE48niZy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IE48niZy"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bc638686eso14002985e9.1
        for <virtualization@lists.linux.dev>; Thu, 06 Mar 2025 07:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741276332; x=1741881132; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65Y7a4qK+Y/6ES6G6BlQKGj/GPIU9m2PJUgZAs9+KOM=;
        b=IE48niZyRyPna27uxX0mh4Tn3nnTeXCTeHsik6LwARRF+OAPkKx92qLU+oaVIPWuQ6
         8php37/DlHoZs48c/ek4uep7ahee9MvHZNI882zselUzYNZoP577wO80OODVG53+OFsa
         AV6Rnw0SScBIMW/ewXiac131sPQ0FE2eQRKsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276332; x=1741881132;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65Y7a4qK+Y/6ES6G6BlQKGj/GPIU9m2PJUgZAs9+KOM=;
        b=TK8VT772HGDUWSTTPc7QrNm735jqnzWKPSEkNICl9/Kx+k2SZk2CKA6lTi4iuWwQ7R
         KrA1/kVPGHZg/+tM7R/eR81QOaqXE1hAcnQM7esKBILNQu+CVgCVhLRIfDCs32FHX9PX
         DS4t6JV2RvcPS0JIfwYud3nUQwMHSJeWqJYvg3HVjtU8fyMr1hAB7QYNbKaxH9G4MTAm
         Cgdk+fw/uiAcW9aoc1D6Mt60p/cRCFiHyZE9+2Z5CjO0GkosiqldqIYlUHxSoC5TDCL4
         drYv1W1590YvQ7fFYY6AhZbwygU5BxtkMlPjnZaDlwUxyFzzUZcBKh+0D1wEELI3ZYSd
         abmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVvZsVr1NTCGtnp43BvHFCQo4mdHBa2DaNYaEDbPVVpMGrMPYeM8DZ/r7lu7bSwFeLVMvCOp3lsoNBxIJtfg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8LUXjnBHOoVaUeZW6Xx+skOvDp7EJCxoi6EIjbdykfn0mjB3n
	m8AEe5ZGPzFdaNErMDS59r3ut9JJazuISGRq18HtPGCi20O91RfbLVc8ewWnpEk=
X-Gm-Gg: ASbGncufN0FA/QFsNzg6JOIKuG3e0Ol24Nx7oP552PZhG6+6AzNG9EXHuyr5l/zmMFi
	hNdgeS/bYIOFbvdlWw0lVTVNErlNbXJvGWXDNqv0hVNjxNjKGZJPkQZcLpaLOsCd9mb5GZXLmcF
	a8L6kpFP03lAY/rVeRs+Lq8LbtygmcSrW3/E1ExWJxxOF0p/TA91ATGKZT7VRxJU91x8H7Q3WLr
	+x0he1RQD/XcZq2+VyXWQm0CksbA6xu8eaQ3DDneerV/faVoWghyxDxmMxZ0A2qrJ+rIgRDGtHH
	4nrJMcnT2hinWCXTN0p8jzF8lazjP38HSOwQF/crXCAw//r+o2vYouoT
X-Google-Smtp-Source: AGHT+IHeuGIWVWKb5j99SUKnlkK36tGpar1+KKK0aAa1IuGT6GpOgqR53OExqVvUKbkpEbvf2dKyFQ==
X-Received: by 2002:a05:600c:3b17:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-43c5a6014b5mr36395e9.5.1741276332172;
        Thu, 06 Mar 2025 07:52:12 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcc135676sm65178565e9.1.2025.03.06.07.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:52:10 -0800 (PST)
Date: Thu, 6 Mar 2025 16:52:08 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
	akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	dmitry.osipenko@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH drm-next 1/2] vmalloc: Add atomic_vmap
Message-ID: <Z8nEqDQhjU-Ly8Js@phenom.ffwll.local>
Mail-Followup-To: Jocelyn Falempe <jfalempe@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
	akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	dmitry.osipenko@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-mm@kvack.org
References: <20250305152555.318159-1-ryasuoka@redhat.com>
 <20250305152555.318159-2-ryasuoka@redhat.com>
 <Z8kp9Z9VgTpQmV9d@casper.infradead.org>
 <3bfd4238-6954-41a3-a5a3-8515a3ac9dce@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bfd4238-6954-41a3-a5a3-8515a3ac9dce@redhat.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Thu, Mar 06, 2025 at 02:24:51PM +0100, Jocelyn Falempe wrote:
> On 06/03/2025 05:52, Matthew Wilcox wrote:
> > On Thu, Mar 06, 2025 at 12:25:53AM +0900, Ryosuke Yasuoka wrote:
> > > Some drivers can use vmap in drm_panic, however, vmap is sleepable and
> > > takes locks. Since drm_panic will vmap in panic handler, atomic_vmap
> > > requests pages with GFP_ATOMIC and maps KVA without locks and sleep.
> > 
> > In addition to the implicit GFP_KERNEL allocations Vlad mentioned, how
> > is this supposed to work?
> > 
> > > +	vn = addr_to_node(va->va_start);
> > > +
> > > +	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
> > 
> > If someone else is holding the vn->busy.lock because they're modifying the
> > busy tree, you'll corrupt the tree.  You can't just say "I can't take a
> > lock here, so I won't bother".  You need to figure out how to do something
> > safe without taking the lock.  For example, you could preallocate the
> > page tables and reserve a vmap area when the driver loads that would
> > then be usable for the panic situation.  I don't know that we have APIs
> > to let you do that today, but it's something that could be added.
> > 
> Regarding the lock, it should be possible to use the trylock() variant, and
> fail if the lock is already taken. (In the panic handler, only 1 CPU remain
> active, so it's unlikely the lock would be released anyway).
> 
> If we need to pre-allocate the page table and reserve the vmap area, maybe
> it would be easier to just always vmap() the primary framebuffer, so it can
> be used in the panic handler?

Yeah I really don't like the idea of creating some really brittle one-off
core mm code just so we don't have to vmap a buffer unconditionally. I
think even better would be if drm_panic can cope with non-linear buffers,
it's entirely fine if the drawing function absolutely crawls and sets each
individual byte ...

The only thing you're allowed to do in panic is try_lock on a raw spinlock
(plus some really scare lockless tricks), imposing that on core mm sounds
like a non-starter to me.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
