Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED132FA14
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934966; cv=none; b=nA3cyF5dUPZwrdJJzUb2u0/UQG5Y466klc1/cB5pVIko5Z77RTudlXP53DzdH10+Rg5x/qciEcjlh7rPly9FJfaKvaeeKgNQmhzYAiBAtTHbb+AX9L17he2qxJQQ89lR6mVHwGtWY7lc/jQacDSCvlcC+RriDbtGo+v6++0YaAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934966; c=relaxed/simple;
	bh=m5k9zKS5+KCFPJznp4odxkhVbFd0WBMso32hHlPgqKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d589SYRK55J94wlyy/szoaBThqpndhkiBQU3o0LFFRtAVoY3vspNxJNzMku6Q3ne3rZuDkFma6fW6GuaFr6wiT6UOkgfAKT57BANDbxHJ4A4lknURqVB1LeIxLXsIPILNoN5JWsKj5bnOcM/BO4bCZBUHasmTd3ZrTg9tmI+f9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NHu7qxDG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NHu7qxDG"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9156b74006aso324065485a.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780934962; x=1781539762; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vod/HHC1D5DZqL91Z7CA35Tz9UyVxNBY16ghjiAxtAU=;
        b=NHu7qxDGK1z+pnW6NAFSlcmwbz4XY5lB4/bY8SMBQQvfSljZ5QlRE8ZCllaanFJFHH
         hDemKKFIJ3laqI2X8ATxoA3g03HZiBmz67ikkEYBTYG5GqrOa08GMa/5l8nJTLlaYww8
         iGn+8jnIPOurci+heeMnHb9x7cUEoWFLFAbun631Ug2yiBL4Cu2ZNdSdIs0it0J3zhwa
         MNOhpTSCsTh6LrMiqeFpRXyWqB2kY9311ixTwy0EUVf05i+tSUBHBNXqbJi7O0vR2RwK
         AF28vju/xCqwn0QS3GHByxD7qfjseIRWHZRsQ7hBrpUFy1YvjKoLpHzrbokXruZ5xxqr
         PkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934962; x=1781539762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vod/HHC1D5DZqL91Z7CA35Tz9UyVxNBY16ghjiAxtAU=;
        b=bulxQhHYlqDzF/JV3EmCGBcK0M5goJyqaU3v/1duOVxinjhznp8XQsEfZ1jb5VPizf
         Lox7N9zIc9HQXGMTv8AnZ263KuP6Xm5r5wCNiv9WHixVg6ZxH8wBtfPicKFUG9c2KSWs
         0GpWUmLZ6YVoT4aNc+ooJLQSZzFtd7HOqo6TTS6zehsX80V21OsJvTNOrfJxQ+MkA3Lm
         Oh/YZsv9SX5Yn3GXbS+WTnAltqclI+YNLjzt/GBVcc4dV8+v29318IMRBmDhANgoLCkQ
         ZQjqohyRnZZaNdZJO0FjXv9Av3kJw0r8tEFQGC4wFU89GlIFUx8RQicoaoSfwnnzPy9v
         hKnw==
X-Forwarded-Encrypted: i=1; AFNElJ+UIl/XTSgjaTuthHZGg3WZUM6ilAisLeOOYGlDaUh4JKqJRLcbj0Vt/kNodv5G/3iby44kp1um7XLjfKLUzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKdrGKcktknVzcrjasCykk4bM8DclV5PDcnUvVZICqXrovWmSB
	FIEdf/KNTnSdqLarrib0l4TooIJxTBVBfdgHcian+xbv5VOAVvjubc51ydbvNJBGNHk=
X-Gm-Gg: Acq92OH3rvEDAOE6k0YYqNa2LyEKlCWCoZEd89b3Njzru9p/E5k4fedfQ3wNCXPXdxy
	Mv9EZoU1s5RmmjhxisL3yPnr2BPr3dB/ZwQe8N9js4rcKzCkeg6bFoCrX2G+8aL1udI4t3LwtLv
	orkM4RnPolvtKGBTZ6ZSnLyyvwv9P1EQIuh7MsKbJGeWRtYtUdhNe0qAP3US6LEgjdhsvfuH+14
	OMAJOjR1eBdqbe0nvTtGztge6har3YVrlTgI9Wq5hOmO5lwXfmDWoEpzTM/td0Ii2nvuttVdHOI
	S18lHzfAa07yk/CgdPe5RHqmK0TEcJiuJ7uYP21Gf0xVe58i8aCUoafhPMhN1qKvnhlaEzCjNja
	Q82vieacrfJiE4mancKF4WVL2nwhTi6eJHATiJusti8lYhJjAMmi8ROEfsuAvKOWYdYijC12J9t
	J9ZLxZF/AqCCr49eXeVpx5Jv87wBcb/oE9r0CnLXiJV6rdGGGrNotH3fJ6M3ThdU+XGNTJ9/C2f
	UbCHHNtL6ZUBXOODQ==
X-Received: by 2002:a05:620a:2a05:b0:915:8f08:5fa7 with SMTP id af79cd13be357-915a9db4f9amr2567293085a.52.1780934962358;
        Mon, 08 Jun 2026 09:09:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a22dbbesm1751766885a.13.2026.06.08.09.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:09:21 -0700 (PDT)
Date: Mon, 8 Jun 2026 12:09:19 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v10 17/37] mm: page_reporting: skip redundant zeroing of
 host-zeroed reported pages
Message-ID: <aibpL3REDdQ8Vhys@gourry-fedora-PF4VCD3F>
References: <cover.1780906288.git.mst@redhat.com>
 <6a2f93e4447e55ada6ccf0f4d5c64e8d41a848d4.1780906288.git.mst@redhat.com>
 <aias_qh3wR-Xkf6T@lucifer>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aias_qh3wR-Xkf6T@lucifer>

On Mon, Jun 08, 2026 at 01:00:17PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jun 08, 2026 at 04:37:48AM -0400, Michael S. Tsirkin wrote:
> >
> >  void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags,
> > -		     unsigned long user_addr);
> > +		     bool zeroed, unsigned long user_addr);
> 
> host_zeroed or something would be more appropriate no?
> 
> But in general do we need to propagate this around, can't we derive it from
> the page zeroed flag?
> 
> It's really confusing as to _which_ zeroing this refers to, it seems the
> only one relevant here is the VM host zeroing but that's completely
> non-obvious and now everybody using these functions with the extra param
> will simply have to happen to know this.
> 
> If we could find a way to avoid this propagation that'd be ideal.
> 
> Failing that, making it clear this is _only_ for vm host zeroing would be
> better, but then maybe we need to think about how we could encode this in
> some other way, e.g. passing alloc_context perhaps?
> 

This is unaddressed feedback from 3 version ago:

https://lore.kernel.org/linux-mm/agXYbcuQYooG74pb@gourry-fedora-PF4VCD3F/

We can infer all of this from snapshotted page flags and propogate those
around.  This is infinitely more useful than just a single flag being
pulled out into a boolean, and more extensible.

void
post_alloc_hook(struct page *page, usigned int order, gfp_t gfp_flags,
                uint64_t pg_alloc_flags, unsigned long user_addr);

		^^^ page_alloc.c internal falgs only

Once the allocator gets a page it wants to return, it can take a snapshot
of the flags at that point, and then doodle all over the flags as it
goes through the page setup prior to return (include the post hook).

Haven't seen a reason why this shouldn't be done this way.

~Gregory
