Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919B3CCFD8
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985942; cv=none; b=qC3uY9o3ukacUXZrUBN4sLADxtvualIZQTS1p5ABiB9ySb+CidPLzorTzbhj1TMd9072dXFYHu6mqY8A9lu1i8tVVIuMz0fc3d6/gUUJpaZd6w0b2oujqtdHtULtCRBQWMKStrRVylHGomT1KCDa4UVrhPR7hfsxJ4ty53/7uZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985942; c=relaxed/simple;
	bh=2V4VNjsLWZcueXCFHd09srlb7WUAcIZjCm5t+Nylnt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXzqbLsG2Ie9peSgbtedjfN8xaccJ6RbY60IXNHGZ3IBM07HekaI+ePBB6/8MKGQwKFNeWuCF5qDx4OuxK8R+8crq6iM9fzq69TdpU/Od6pfp5AUuri2A7wbNxgy3nz3aeBwF2zkQ1BhI1+4DN8C73Spr5CZeKYPLwsAMK+SCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uHX+C4YF; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uHX+C4YF"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9155183b42cso674344685a.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 23:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780985940; x=1781590740; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WyHS2mdLzaoQuFPek2z//fxHK8pVAjskPhevZrWWAyg=;
        b=uHX+C4YFtbBADBne6+kibYYUl2h36N5vyrQjPU50cTQgVHEeUaus7K+mInvGyxUDMO
         EvT333dmfkj0SgC7geZS4nHw0Qro00ZcAv7M58xkIPABC2xiSwTIDXXGPMJb6kC2fed+
         lH5Q6S5zlt1v+lgxFd0aN3f1+sO/BriMoa24KzUTfOgHB1APPvPcujPqVOKLjnBqwFiT
         jRLE5HHJBHdZ1TqLQ+0LjAxQg8B6pmgXhryKd5cVHrseB0iYLdF9MpyHYNkEP1ZhgxYg
         0I9wfQJkveB7RnwKYbgM2kk9z4Uu8gvAa/O7AJn8mLY6AhmhNnbDQGSGx3R+Rhk9fjRw
         QNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780985940; x=1781590740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyHS2mdLzaoQuFPek2z//fxHK8pVAjskPhevZrWWAyg=;
        b=dCMhV4vh+EW8CiYYlb8dJS2rOmVPVbXVlX9iBtcIVuHs7lmNB1RTY0GhMdJm69kbdb
         ZXEYGUnHWQLwFvSsSMiYXwR13gA65N3DTig8EdMhEUwTNAGiGcZxXz7QWhGP9SMtSqGy
         9VjlahPGel0jAScqfteBFSMSt6HTJHs7A8ASdE3vU1o43/Dsrh/lW+4nljaQdeDGazKU
         f/BRWOnkDU1s24Y90wdpVrPHziuod5prcmX9AW1IA1qsQlfyt8HpZuQlDemxKssrN1ki
         X6DN/RapjZWfs4cmcZSI/b5l3uNnMPY1RkCe5RKNnC4g40IArfclTrAs2ixaGgOJOjta
         1igA==
X-Forwarded-Encrypted: i=1; AFNElJ9TtiHmRPiPUP3xnFGI2VxFBZY68y2vm4jFTxPwr2E/sPZLTRJGN+8CSBA12WwP8rEXA+2LajkT9s3nvR+KHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzU91trWzYoN9AAnugFmuW9jcxFpvK1wG/FiJR16q4ttMzdAqZB
	8WNsF93QXSGim3lHWN7tU8FHYVMPVAhBD3S275JTcRaxS+TAS7sXSftDCS43O/NLHB8=
X-Gm-Gg: Acq92OG9BKSJD6f5q9MsscN5rx5qjK+XLu7K/wGmS0E5kZxqkPDrnb/bAIU3PHMph4o
	03xYLoLJqqOZAWohNqmDmA5F008N+vmLFHhSuTj55gL7CCXG7ukDnao8x2USsdgJzT8ZqOY/iEU
	FFpYDaANjOp4Ml+sPS+YgxSBIfMnSuoopqLwPR6RvdGe7OXZ78enhcBEgcfepcF1gcrX8XyLksv
	zO6O4W/a+eWfZi7Ww38QtAjh+Ws5TH0N1sARhE32dlRkfG7K4OGPTa/FIQXnl2bjb0U6FQEDTH0
	2cFFZQxnb+o3YHow9rKLsjR/8VoSwMG4FTfEE67Y0qDe0WJxDTDDjnKwVc2flM8pK4WaayLpG6G
	UMr+iuMnl5nku4PxnKBpGnFzSWLG2xsphKRUGOiFERrveymepCIc411nXK8269ZsSss+N8XwlTn
	62F26tZvj0cUEmaZtP+rEIaVsKqQPWRS9yC844XCY7LWj1U+HYmMsG+vZC481SVxu19AcJrq1fi
	KsF+hkUCD8JRy4FOQ==
X-Received: by 2002:a05:620a:4511:b0:915:9931:3a3e with SMTP id af79cd13be357-915ad1c091bmr2206391685a.27.1780985940133;
        Mon, 08 Jun 2026 23:19:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a2465e7sm2045397885a.19.2026.06.08.23.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 23:18:59 -0700 (PDT)
Date: Tue, 9 Jun 2026 02:18:56 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
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
Subject: Re: New design
Message-ID: <aiewUFBRyDNoAMGd@gourry-fedora-PF4VCD3F>
References: <cover.1780906288.git.mst@redhat.com>
 <aiePVsiV-w-IZ8A4@casper.infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiePVsiV-w-IZ8A4@casper.infradead.org>

On Tue, Jun 09, 2026 at 04:58:14AM +0100, Matthew Wilcox wrote:
> OK, here's how I'd structure this:
> 
> 1. Introduce PG_zeroed for buddy pages
> 2. Set it if init_on_free is set
> 3. Set it from balloon driver
> 
> https://lore.kernel.org/lkml/c7094de807c0e963526686e1d245bc76193b1a92.1776689093.git.mst@redhat.com/ 
> 
> but add FPI_ZEROED instead of an extra bool parameter.
> 
> 4. Introduce page_is_zeroed like this:
> 
> static inline bool page_is_zeroed(const struct page *page)
> {
>         /*
>          * lru.next has bit 2 set if the page is already zeroed.
>          * Callers may simply overwrite it once they no longer
> 	 * need to preserve that information.
>          */
>         return (unsigned long)page->lru.next & BIT(2);
> }
> 
> (you'll notice this is similar to page_is_pfmemalloc() but it doesn't
> need to be in mm.h)
> 
> This step is going to be a bit fiddly.  We weren't expecting to return
> multiple flags in page->lru.next, so clear_page_pfmemalloc() just sets
> page->lru.next to NULL.  So somewhere we need to make sure that
> page->lru.next is definitely NULL, and then allow both the zeroed and
> pfmemalloc flags to be set in it.
> 
> The important part of this is that it allows the zeroed flag to be
> returned from the page allocator without introducing pghint_t like you
> did in v2.
>

Are you suggesting leaking the flags out entirely, or just to the
boundaries of page_alloc.c (__alloc_frozen_pages_noproft and etc).

I assume the latter, but worth clarifying.

Otherwise this seems reasonable.

If we're just going to pile more stuff in lru.next you might as well
either add the alias to mm.h but keep the bits defined in page_alloc.c
to prevent them from escaping (even if they end up set, nothing outside
page_alloc.c knows what any of them mean).

Unless my read on this is mistaken, let me know if i've misunderstood
anything.

> 5. Now you can start skipping various zeroing steps higher in the call
> chain.
> 
> I understand David's disgust with vma_alloc_zeroed_movable_folio()
> but that is surely a separate cleanup and nothing to do with this
> patchset.
