Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793211180;
	b=5XB3oPByzwi7Rem9FxuGmgsyX6a8E6LdJyLsaARII/iyCkPTOmk1Jh+zfWwMA7l3F/y9
	 Enca/w2n1Q9nyIIlMD+imAUTQbSPXxW0zwdzV9OeoU7UClHlvF1lSuigtG6XnK+Zyu+41
	 TrtTL3sPCmSEw6puB8gl4B/weTo/BZ7Tn9bOsReWIEy+DyUuXO7fVhzYf+Fe1F5cAqzRp
	 VOvCxZitBBbBX94W3zuEMmXZZhbQICWYUAGN3L1JWWK0Zd76yJojdanXTEgggbFbA2bGw
	 gjQGpZQkrABVxGNAuqsnH6xWBZOUxjnY77mG5HEKsXHVVifD6gP4hCD+kEDtbKDuscA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ARyFxRSvqAD+wB2pvv1XS401e8GE7i3ocZP4rplHOIw=;
	b=OXVlEaSl+woEVHF1uWnlFX3y34AbMcDOOKdHiBVHUJ9hCxrVZCRyevpG3jh3gSCZJWg8
	 s0u+xugu7tO49b2JGfUzbliSupBj4z3xdwE0N1rOPPNLclkIvD+hXpokKa4z2Gh5N8dNQ
	 VUxzZH0v3WN+x9aPI5jCM0YNXgONYi5/g24GmXS6qCDBNybyBAmR486Yq8yk0hwVQ8Go0
	 kLvLfNpCPrgxJjv+7jW5JR7f0sY5jhLcTNCOnOi9P6CZBoLPob3jFmwJA003lWcPRZZh6
	 bgM2+EF0UlDV/i/wgSUOCwL3KNZjJL/JhMRHbTZIOAaM6MXz4YskhGrI6UAN+TK7XOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b7YvA559;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20CA60A2614
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 18:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C20CA60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b7YvA559
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ae8607e8afso10498997b3.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 11:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793211179; cv=none;
        d=google.com; s=arc-20260327;
        b=EoU5P66mvX+Y55amV6yLyWqPBAKPzU+hdG+e9dLdiawMTzmkyadkTR0Pr6o2DVKKAo
         fZzUiqQSjQq+NJeTlDI5PtTMVxw94YXJ75OENhfJigmwkiDM8oa5iYNQ6Oy96oXQ6unC
         6vUca0XsazCoHT87zCUHTHhcrPnJtTgBaKEe4JzXH46e2u/fLVyAnRx7ukJK5Yi8E0Ct
         rIxg7+0iRe5Gj8VsxiLVCMgo5ltOEaK0iUvKMJ/u26uKLdnUHRmE9rzkqLH0QLmfdqf7
         tcGHu2+5L4lB/I97vQNJ8xg/+mKnxTh8v4O11GR2Phla9Ub43EXNwxOtEx+MS20H50OA
         Qsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ARyFxRSvqAD+wB2pvv1XS401e8GE7i3ocZP4rplHOIw=;
        fh=jWzu2KoOfgNC98k3HV8PvGvXA63Bzg/Y/ousstzzUv0=;
        b=YT419sFWllFa3BKpWIVWZInfE2ygQTTgpr06yUG+mKsvtE2D30m76fLboOPFsxwp62
         Z8sk9c9Bzc7BzLj0cq+YhoB9OFM8gexCoakBHVZPHBsR8TzHUmDnuX1SkofBNnDuO434
         PW79U/Zj0Fr1ekeYD4YXoSzs/caXiXSnleHcEL6nZpCMEfZ8TicHMbk/Z6tyEWS7N264
         ZYc3HPcErBatohMJpw/qZl0LJqj0cTu+yqhcuASOt9DoUKjTgl20CVmwabQaCwgvRP6a
         4IfcwCYVdpB2DTrgcNsOYiNcztCFF0AKPcbshbziHlUEqYTLvfvh66GhbpYf+yh14mii
         i16w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793211179; x=1793815979; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ARyFxRSvqAD+wB2pvv1XS401e8GE7i3ocZP4rplHOIw=;
        b=b7YvA559LCEN/KAKghHyULmskdP43aPP/d1fdng57tH2S1w7rRWoFa/zEvHOODIDy8
         dRnxWji5L5uZqBUXc8hPhOX0H+2skvDsr3OTjc5KuHwRyRfezURhgVQzz3cywFWWG9tP
         ueCsF1LALVt1AywNpNGdWSovqn3LPX4NaJrz0x0ujwCIdUdKtcN7ygm7mhSxA2+K52Ke
         0Gz4EvndwJA1gWyGtMTdHrXGiO5dJwG8efAZ+15RK8Duz+41o5rTXaBvVp0cH9PYZZDx
         LHlLu/8S+M00AU+5EZsT63SuI0tt0TulKPnLbFRm00lFKJf06r/+0dfhGQTsz54N1TS1
         XqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211179; x=1793815979;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ARyFxRSvqAD+wB2pvv1XS401e8GE7i3ocZP4rplHOIw=;
        b=K1vxtfDCGboOF4KDxYC1Xmz91WKgo/nWYu0YJwoiIv9OBIZ7YMOlzPeuEYhNMTmDMb
         TaZpyRU+5Tszg0aXY6hAmCA2vwyFUAWeMgx55uYTqeJxklhk7LOriLCXSvolhSq6ahKM
         rAw9bNd3krGDk0xggBbY+yp484rhDqpMg/WwCxGFa5SehltJcNobvA6j1I7LxqFw2T9y
         DNoR1C7UvBxDCtLufgWUChD4qLdBvHUASJSnVhzFrja3+cSw9y1FetDpHx/OGY3arZZ2
         XzJtJMSNtTSXLrNp11RAZa9SqGpIMHFSFqu+TeKqk2AxrYFO07sDJivegnwBLJkGVYNt
         kpcg==
X-Forwarded-Encrypted: i=1; AKwUvBy9Aab4vDuIyhZIzwLgDKDMMkUFWELvNFab6Aa7EmjqTHJz5BLU2hooZRDW0kqhLvB49V8ydeXQJRHCGHwH4A==@lists.linux.dev
X-Gm-Message-State: AFq9FYLPh/928Plj+hwM0vPauttXn6nM/J2wALDbWp37FfXeEE/AUUdC
	ffeHWlxzT/IfuEfi1HxY45tynFTH0o66Ly4/aNq/qRTslUtFbIAGQgQVOr57LgyWTTk+5lkE4MI
	/+Va/hEOxjR+e1R/pxYjqoXWb9x1KRw1xcTx9TfRL
X-Gm-Gg: AYBFou3IVGQh87doF0sszTAqHUxtIUq/sECrnuCw2asx/2LZNX+xFjbF/dg2r1js5IN
	r4I4HftppB+qkpCCrTQerKInp4oG6rkQC6fZEY8eC3UhJfQmz3Gtnix8yZvZVp7dcP5FnOY13QQ
	krFsVsttypv4LhOTRvJtfjMoHtCe/OHErmqKu9ypgTfJlh47cvPyJeY22YcKDOtkA275TfQOpsO
	p2c1asVwYl1kx6jpAVQiz1fHB8c/lFcJijUt/HmzMZf3k2FQEOPkcWBzGYsQUpYfvYBJMMKM0Iu
	rqUSzCZ/MKeJPCmTR/cojVPjvdLoYqR/jxukYG7q7bFMO7vyFLPSgOQap8ETlWip8bAbmqRYKob
	L6JmCwBj5Rs5yU/cxyLZYOlRgLKVRcOp+KFs+V6WCDi+E2hoGB6WfMx1P35fUnSL9y7Q=
X-Received: by 2002:a05:690c:f86:b0:8ab:436f:6e7b with SMTP id
 00721157ae682-8b1b5e93e9amr21228787b3.63.1793211178194; Wed, 28 Oct 2026
 11:12:58 -0700 (PDT)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261027025616.1632690-1-kevinloughlin@google.com> <279a92da-772c-422b-8047-ad37dbae211f@kernel.org>
In-Reply-To: <279a92da-772c-422b-8047-ad37dbae211f@kernel.org>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Wed, 28 Oct 2026 11:12:47 -0700
X-Gm-Features: AclHuK87kmeri51i0i8SscXVJiPFVq3oTJZMZ4FP6A_jqbPgcyRklPs7gnicX7s
Message-ID: <CAGdbjmJ8qk7FCbGU85u9+db5_RtcrK2y_7TfNH+iuz+OJxebow@mail.gmail.com>
Subject: Re: [PATCH 00/13] virtio_balloon, efi/unaccepted: support memory
 ballooning and free page reporting in CoCo guests
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Kiryl Shutsemau <kas@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, virtualization@lists.linux.dev, 
	linux-coco@lists.linux.dev, linux-efi@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sidharth Telang <sidtelang@google.com>, 
	Punit Salian <psalian@google.com>, Peter Gonda <pgonda@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Jacky Li <jackyli@google.com>, 
	Steve Rutherford <srutherford@google.com>, David Skidmore <davidskidmore@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 2:01=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/27/26 03:56, Kevin Loughlin wrote:
> >
> [...]
>
> >  mm/page_alloc.c                               | 248 ++++++++++++-----
>
> This diff stat should give you a good indication why this series is not a=
cceptable.

Got it. I will keep that in mind going forward, especially if I end up
attempting a v2 that simplifies things.

On that note, I believe the majority of the bloat in mm/page_alloc.c
comes from...
1. supporting the legacy inflate/deflate option
2. introducing support for various page sizes to be unaccepted

(1) I can get rid of by dropping the inflate/deflate option, which I
think makes sense given free page reporting should be sufficient to
enable dynamic guest downsizing in cooperative scenarios.

(2) becomes simpler in part just by doing (1). For further
simplification, we could potentially restrict free page reporting for
CoCo guests to the current 4 MB MAX_PAGE_ORDER instead of supporting
any order 2 MB and up. There's a trade-off here for reporting
effectiveness under fragmentation, but perhaps support for 4 MB only
(and its relative simplicity) could be acceptable? Especially since we
would then maintain the invariant that all pages on the unaccepted
list are MAX_PAGE_ORDER?

If I can sufficiently simplify the changes (especially in mm/), do you
potentially see a path forward purely for the free page reporting
aspect of this (dropping inflate/deflate)?

Thank you for taking the time to review, David!
