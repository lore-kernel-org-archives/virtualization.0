Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DEC195811
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 02:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776739104; cv=none; b=gU4+ELacdftUfP1RujDU+Bh0rUGinz8W9h0xZ7BGwCsLyoS3qDB2AXP4mmUWQ3n/0CFB/jI7uiGLc2iPKdgmelUoMktk11umdjbwV3Wr4gPMSY0ymJaxEosPmIubROIwIV5fYkIQPJV/TUehkmgj5AVVLSAsOP8i84UWJRBFlCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776739104; c=relaxed/simple;
	bh=34cMY+cN1mpIU3dBjwx4ZxTWTie7LIYAGZMXqTKBXmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UebTzWA0cw4wfnGY0ZPnc42sWvf1KIc1i71c08ccA0NlcyudTqvCHdnwUE4jy/VD2le8PeMhUXCCRC6LjECBqovdtHUS4+NrFCSFZESzzyfxsrf5nIRD6Ml8q4eLVjhDXkElRbsC05sia4NVimMRQDgabaHbNi/s5ZIydIVZTHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Rj23IRfR; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Rj23IRfR"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c70b5594f4so414633085a.1
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 19:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776739102; x=1777343902; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DFzhmNd1adFIkSfM46o3U59L62f2VQ0RrNdAOEaBXO0=;
        b=Rj23IRfRPMmjTqov94G7XW4jDssQoddLEm/U04o2hzRdAezIXob0KUSfFVRwnZJQky
         wxiQMv9npumSStyrg3PudB1EPt2B0cpL1Amdfz/jCIbDsuUa+bCrMroAo/49WB16exuz
         1yDtXTj0BIuoQi2uIgg/TfbQ4dj+4joTB2wPUt2D7rWnpkyZwaikeM5FKi7kjOsZmcnw
         XDyGAMFdTl99Su9x8WVd8aau8xAThgaw7PWJoeS0ACumpLc7wlA6xgchr3UnHzmoFLvu
         f6/5WgNnvSpn/BzdwmylKFfeCcf8ofw/dTapLCcqJsSWrTN0W2ROPeugZoq78ImDGYW0
         CVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776739102; x=1777343902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFzhmNd1adFIkSfM46o3U59L62f2VQ0RrNdAOEaBXO0=;
        b=CybSThXR8aF6u0Kfb+3VZEuT0UOXea7RRLu6H55czqkahLNZgmbe5a/xrmZMB7jRUB
         JkFtiYp8kQFtcxybyXlFb9gKyNTjiP8WRuJ2tDb8cL0euEpf4WbZ/pfq2Y7oN0pQYQtN
         C787caEJFoPWeGzJARH+NmA5OxR5Rl50oOyIjFrJXXko4vrsZrAoWT5LHYI0eiDvsuHZ
         I1VKN5fQrdTXIemjPEXPBwD7iCm7SAETzfblxANwnEcoIMsIQPWq9Os9z4TsM39E47Jr
         AfvCHieWV4GVcQy1xZdtaoEEhMIH7BFMvt/u61Gw1eb1tRSyUs4vN0B3U8FXwKcxVucJ
         PuaA==
X-Forwarded-Encrypted: i=1; AFNElJ+T2os4WPqez3v1K6kgaO41Fbu5ReWlQAjC35AlI5WMoHxvgr9x4KACl9hNP3g6sFunZFbxOZgwxJszUpDUHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxdKqwU/5FYxCSRhd57eurNYdyBSyfGv0ARQOsWoC48nxCV4g/
	XLBax0lgNdr7GDNmy9y/Aw+y3aI+/GeodO8EeolPbtxnHVXftLEoRKmvmqXCqxs+22g=
X-Gm-Gg: AeBDievZfSaWx7c8CoWdMOF5B3IuVbZ01e2zoB7YiqSEKJvyN3PIYIcEyPETQGts+vC
	8suYlPLVvP4u/lSdJ0GjRuGWXFA8OiTjZJnKmQ50qTPRKgd61m3toSGkQr0xUCC1ASQy/4OIEfc
	6Wa4jSVrbQ2Ms6uQvFdIPRl+VSzSNATcW9ahUHbnw1vt0g92LOismDldTeOSJ+I6UBsVWVzLIip
	oRydn9ldeC3R16P8q4TIjU71yZLYGkhb5qTRWPUhqhCl+xNgk2S6Z8yo+e3OlC5cL1X3MrfBUpp
	kVy3p/2fkNQM1Tq8/ZgLFh2aAUfpBoa97J68t7wKbrvojzimXtKwnq5E/PlJXdleGRBMA9/ly+n
	trfkXeUdJVjW61KscJhFubVwswBJ3s6MTJO2R/3i3z61mp1DHVAtV9MHj1EJVu1r7q2r6XGDZK6
	uazBbce+2D6l+bJ7RN/NX64qowhncMxJSHIauQtf69BdNLOKYbbTRHMcIWxjjwrHNqR4fbKPyco
	6TjuEpJXvakUJIOlCJ0ieBnpRm9j5aPnw==
X-Received: by 2002:a05:620a:19a6:b0:8cd:88ea:fd21 with SMTP id af79cd13be357-8e78c5c1fe0mr2065685285a.21.1776739101852;
        Mon, 20 Apr 2026 19:38:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-108-51-163-112.washdc.fios.verizon.net. [108.51.163.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe90afsm1079220085a.3.2026.04.20.19.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:38:21 -0700 (PDT)
Date: Mon, 20 Apr 2026 22:38:19 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH RFC v2 00/18] mm/virtio: skip redundant zeroing of
 host-zeroed reported pages
Message-ID: <aebjG-qMLr0joG61@gourry-fedora-PF4VCD3F>
References: <cover.1776689093.git.mst@redhat.com>
 <c199e47d-b2fd-42f3-9e50-c47c848dc72f@kernel.org>
 <20260420192037-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420192037-mutt-send-email-mst@kernel.org>

On Mon, Apr 20, 2026 at 07:33:38PM -0400, Michael S. Tsirkin wrote:
> On Mon, Apr 20, 2026 at 08:20:57PM +0200, David Hildenbrand (Arm) wrote:
> > On 4/20/26 14:51, Michael S. Tsirkin wrote:
> 
> > > A lot of churn, and my concern is, if we miss even one
> > > place, silent, subtle data corruption will result and only
> > > on some arches (x86 will be fine).
> > 
> > Which would *already* be the case of you use folio_alloc(GFP_ZERO)
> > instead of magical vma_alloc_folio() + folio_zero_user().
> > 
> > I don't really see how vma_alloc_folio_hints() -- that also consumes the
> > address -- is any better in that regard?
> 
> By itself, it is not. But the issue is propagating the address from
> there all over mm. If we miss even one place - we get a subtle cache
> corruption on non x86.
> 

Why does it need to propogate?

Can we leave folio_zero_user() callers the same, but add a PG_zeroed
check in folio_zero_user() that skips the zeroing (but not the cache
flush) and clear the PG_zeroed bit?

Is this feasible?

You don't eliminate the folio_zero_user(), but maybe we shouldn't?

(a bit naive here - i haven't checked the PG_zeroed lifetime, i did
 see it overloads PG_private - so this might not be feasible)

> 
> I also note that we need a flag for free in order to implement
> balloon deflate as you asked. Here, I reused the hints.
> 

I'd sooner just implement this as

   ___put_folio(folio, gfp_t)

   __put_folio(folio) { ___put_folio(folio, NULL); }

And change the free path to take overloaded gfp flags.

Some of the existing ones might even be useful as-is.

It's essentially the same thing, but prevents a bunch of churn and
saves us a new concept.

optional gfp flags on free seem like genuinely useful interface for
certain callers (definitely not all).

~Gregory
