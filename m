Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB95139D1A
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318204; cv=none; b=NzYgLPLUWG33GRGIIdFMjikGa71az07slHh2LVMpUlxkAL8DT9HBjFngDr+y85v15drAQtVNWjOrMpZih1KaZpKJDAGPO+2KJV2jUG2KlD1bfFXxlwvQxB4YBGS1aRNFBw9vx/8CGQOLnN8RfvFBLqzjpaeVHcsIpZ6PhLXDBmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318204; c=relaxed/simple;
	bh=/3P3EtdCc7rr0sB+9rh5vRhTZhu1DdBeTkII5d8fyvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJkrIYxXJnPJXJkj1mluofUVne5SUMUG3N79MSVtQifdi2NgRYMOx4xDKsblXCocmRZsy7rO9b4wOL8KLV4wZ3d5SM5DpIdbehziz9Pfrf5NC2Bv85zVH5sULZn6RvDFDePWG7ke2zVF4cXgLNoh1aAfNmc0GXdo43dgeSouoo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AcRsYyu1; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AcRsYyu1"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f3cb747fafso6093111fa.3
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724318200; x=1724923000; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0Lq6Y4I+CSXI3kv77xC+HPYsP4G3D1iWJBZIcmDlUc=;
        b=AcRsYyu1NGey2IgQUEpn83dzXGMwmgatuWy18pB40FTUvI7hy2LKUELBQ6I6wLqfo5
         t9LHPBGJCZfM2IJyRbfyMsRiyKtaUMcob5yjSTvt3Tr+NOXn2a1fYRAiPs6mx8aZePzd
         CMm4GIer4j+2LcnrCTOJ9gYgN3pKKcnZmqlpuW5crTTvCldfXJ+sgXt0tgxgkehI0e80
         D6M9a9v/gIRxmdOGgRGW7RP+GUxgZ58au90MzWpKhk4QHd9Mv/qO8LDMZCCWSOJb2lSF
         p/IHkszAfNnFJjecYqFOYjVGQzc014J5fCRIef/QDNQrTF76uEKyWytCqBJWGo46IiQj
         rICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318200; x=1724923000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0Lq6Y4I+CSXI3kv77xC+HPYsP4G3D1iWJBZIcmDlUc=;
        b=O4xYeGLqwTW5iimnYxkbcPXSxcrOcnbZym2cNWhjYYT45naqEOfWIHOy+VBW8jHqhO
         iu0Lu1jpgXQOc4pAkhKmqQ01Natf6M+ezz7ijLZGSszgPtC50eGqYsqwSkwOgb+3m5Pl
         IhpLEzwh9/8cwatrbr4CsrGX6k/BcB8lSkeQwaB18iRo2DA5Eig13teBjhM4i2zcqHTJ
         DBRehHBQEVB/deHuq8Nq6wUOSt8BsqYj6OtxM5sn6WQ70A38cS6dreR77iXEMcjt39YV
         szNEuF2L7CNakzDwghY9tylGnq+3VoBXC9BNF31KsWf/NSzvQqaGfCwqY1oDnBvsvaOF
         vspw==
X-Forwarded-Encrypted: i=1; AJvYcCXFLiOLLVsCNFqG+oYnCLHqi0ql9Kdl6kZ1t2+tPbPHr9EcGjQHIgA6uyaofNRKOkJntbkqrocWcoEDFXNzCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+hLx5nK1zrFPgonGFi4k89UnkomFAjZzu7xqtvpobQRPeDY+7
	W64JXCDja1LhZBfOm1NjDzv9YgijPncCm6P/tRCr2+1FE/N3LJ6Ma9vjpja/5aY=
X-Google-Smtp-Source: AGHT+IHey5fz87xcf2+59YzIPtjPhSZkzqW33/JXCuGkDvdIypnimWzYcIFv58faa0n9Xne1GrXYQw==
X-Received: by 2002:a2e:711:0:b0:2ef:1db2:c02c with SMTP id 38308e7fff4ca-2f3f8862642mr29088661fa.10.1724318200030;
        Thu, 22 Aug 2024 02:16:40 -0700 (PDT)
Received: from localhost (109-81-92-13.rct.o2.cz. [109.81.92.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c4377sm694072a12.74.2024.08.22.02.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:16:39 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:16:39 +0200
From: Michal Hocko <mhocko@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
Message-ID: <ZscB9xynFs4imkl4@tiehlicka>
References: <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka>
 <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka>
 <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka>
 <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <CAHk-=wjTTAKRgVD=StNbV1FtPz+a1DHYBbrJuP=kmd_vm8ssFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjTTAKRgVD=StNbV1FtPz+a1DHYBbrJuP=kmd_vm8ssFg@mail.gmail.com>

On Thu 22-08-24 17:08:15, Linus Torvalds wrote:
> On Thu, 22 Aug 2024 at 16:39, David Hildenbrand <david@redhat.com> wrote:
> >
> > Linus has a point that "retry forever" can also be nasty. I think the
> > important part here is, though, that we report sufficient information
> > (stacktrace), such that the problem can be debugged reasonably well, and
> > not just having a locked-up system.
> 
> Unless I missed some case, I *think* most NOFAIL cases are actually
> fairly small.
> 
> In fact, I suspect many of them are so small that we already
> effectively give that guarantee:
> 
> > But then again, sizeof(struct resource) is probably so small that it
> > likely would never fail.
> 
> Iirc, we had the policy of never failing unrestricted kernel
> allocations that are smaller than a page (where "unrestricted" means
> that it's a regular GFP_KERNEL, not some NOFS or similar allocation).
> 
> In fact, I think we practically speaking still do. We really *really*
> tend to try very hard to retry small allocations.

yes we try very hard but allocation failure is still possible in some
corner cases so callers _must_ check for return value and deal with it.

> That was one of the things that GFP_USER does - it's identical to
> GFP_KERNEL, but it basically tells the MM that it should not try so
> hard because an allocation failure was fine.

GFP_USER allocation only impluy __GFP_HARDWALL and that only makes
difference for cpusets. It doesn't make difference in most cases though.
 
> In fact, kernel allocations try so hard that we have those "opposite
> flags" of ___GFP_NORETRY and ___GFP_RETRY_MAYFAIL because we often try
> *TOO* hard, and reasonably many code-paths have that whole "let's
> optimistically ask for a big allocation, but not try very hard and not
> warn if it fails, because we can fall back on a smaller one".
> 
> So it's _really_ hard to fail a small GFP_KERNEL allocation. It used
> to be practically impossible, and in fact I think GFP_NOFAIL was
> originally added long ago when the MM code was going through big
> upheavals and one of the things that was mucked around with was the
> whole "how hard to retry".

There is a fundamental difference here. GPF_NOFAIL _guarantees_ that the
allocation will not fail so callers do not check for the failure because
they have (presumably) no (practical) way to handle the failure.
-- 
Michal Hocko
SUSE Labs
