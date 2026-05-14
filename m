Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA0230FF2A
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778781645; cv=none; b=p2Uw45lOE5CnmRRrhX1U/mcmXBUTd3MmwdphT5G+8Dy/IzFr0p98v3oVQ2HLwbi9Mr3SaVn7O7R918aZ5XgIyRLrW+tdaWkTYpSv4hbWbsFmKTlYsM3Vc6RUN9XMAnLGUgwdzA1R2n8zKDjLofUcLEH6vJ2yzRbctER7STspRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778781645; c=relaxed/simple;
	bh=7M12n/sZI6wavmCkLjTlnZPULJZ5NWT41etWMhiFTNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=i+NcQ8pA+70ALSededWtZw9gE0o8mYbrmE9VO3TBSCbs19aQ/QzAKNI0ivugOEH3q8auA1+Ja3CNiVMmYTt1/NsxeuD8FdrfIJl9POWVaoQx/wzSbcgQtXj7b1AqWVbyutR+GOrmzsUDLog+4yiVuNKRc4dRwAHyHuZMi7e2YH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAQzr2lg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAQzr2lg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778781643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oQlL+kOZwMBzhWKBZwEOSjeyjgShl8X0ifAvXv35rZA=;
	b=NAQzr2lgxQY8PvcoTk+LlvB4ClRm//w/WcVtJNa511SmsRi2fb+vseBZl28o3DRbBaXQdv
	mkl1aYGUMTb04ePMCXpR3y/Gd9NAfsmtCu0W7RZJUcdacHbJrcHOKPthnrkRqG2JJ5NfIz
	C12EmJwa8+jzsuY+W6PoOzU+JLWQ/oY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-4u5yKCBzO5Want-W8D9hKw-1; Thu, 14 May 2026 14:00:39 -0400
X-MC-Unique: 4u5yKCBzO5Want-W8D9hKw-1
X-Mimecast-MFC-AGG-ID: 4u5yKCBzO5Want-W8D9hKw_1778781638
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44d9ace59efso5518761f8f.1
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 11:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778781638; x=1779386438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQlL+kOZwMBzhWKBZwEOSjeyjgShl8X0ifAvXv35rZA=;
        b=mAmwRLtPht97JN3nz6lcQ+TQaie+rQpRObT5tU4xV9QRHCzPS2ws2KMF0hwonb1tyh
         wSCZfPSIoiwDVeruNJkSXbPMx8ndj7//kKxdUmeQ/qX0bFTpriSOA1+n0pssTQtPdYc/
         AY9Bn7wo63etmxSSr/dBQaD1Ve2KpgM8lvPyGTACB6MG+SeiG4kQ36PrGVOkGx9GIdx9
         pObtNZOfhzd9w/GPg8Ejln9FzenqCskKaLRF775jBTFn0tW9sckXyhCWEe5fOZ7cH8j3
         6ypi856Y2jow7mxT/2Sq242nrhIMAjfWLjf2wxZ7MAS5Db7qhIimxY1qdAgUd0NUarFU
         2FhA==
X-Forwarded-Encrypted: i=1; AFNElJ/Yv/6HCheBkF+/7JXCXdbH5iw++id+c+xVNJqWRj4TSbfGMOE8TD/fO2gohxEIZUG7b+JwjgR8znonwIPRfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy84/8j165RP9kvsMluRBtEZOql0ewYfism55u7DXJu/kdbGMdb
	W0H3AHdvLWEYc/AtIbJpW7ZisWsPejM+CeWfZnWfgM/sFq0xf8JbkGJRAVjqyruG7tiT8nWkIu9
	S6N26/O8ZC6ckyu33kYazp1QhLIwdXg+ZM81O4MLMWLiKZ7CIPcWoAqXpZa55MRyNMghO
X-Gm-Gg: Acq92OGrHEyqvA+R2/RtB6YQLJIEOIwJuNsG4x35dRNGxZrhhUGpSmaTsUFEBtCmPlz
	YKNnVbvKwM4OluA6m7RkDKtHVW6euaMuT+sjssxTQWIfqDuHJpwe0EC/v+HK5p3oqECeWRVtNcc
	c+lG/yGsRlbRiAe8fBEyYGqX2wKJGIZ3qwweL0YpwMQ5QBrac9eDkI/8csJR03OBUZCJrVLNHa2
	E7tfIqAJbE4KAj900eyiGGZtLf+ZrgBW/CK7osfyTF8gCfbsbAIiHjiYVoCQYAdJUE8Z9My5AqN
	slUDK1kpmlKeOmTWr2SIQsZlYH5tveaxPrimqu1QKvaX4PBDbk2yF4gy5P1Vj5OCY8KHuO3PX2Y
	2RRUggkAy7LvyiLMIVMlV+mZz4GxhrbtwdEkBBc+i
X-Received: by 2002:a5d:5885:0:b0:43c:f7e5:817b with SMTP id ffacd0b85a97d-45e5c5cc2b5mr128617f8f.19.1778781638161;
        Thu, 14 May 2026 11:00:38 -0700 (PDT)
X-Received: by 2002:a5d:5885:0:b0:43c:f7e5:817b with SMTP id ffacd0b85a97d-45e5c5cc2b5mr128505f8f.19.1778781637466;
        Thu, 14 May 2026 11:00:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6449sm7948329f8f.37.2026.05.14.11.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:00:36 -0700 (PDT)
Date: Thu, 14 May 2026 14:00:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v7 09/31] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <20260514135214-mutt-send-email-mst@kernel.org>
References: <cover.1778616612.git.mst@redhat.com>
 <45d1ea85b574399459a64fdba28fcf04abfa3e7e.1778616612.git.mst@redhat.com>
 <agXS7dMmtJrPhu9W@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agXS7dMmtJrPhu9W@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TtesYm4ynM9Jwbgypa8LHaqnhAleWzylUSPzyPzCD40_1778781638
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2026 at 09:49:33AM -0400, Gregory Price wrote:
> On Tue, May 12, 2026 at 05:05:54PM -0400, Michael S. Tsirkin wrote:
> > When post_alloc_hook() needs to zero a page for an explicit
> > __GFP_ZERO allocation for a user page (user_addr is set), use folio_zero_user()
> > instead of kernel_init_pages().  This zeros near the faulting
> > address last, keeping those cachelines hot for the impending
> > user access.
> > 
> > folio_zero_user() is only used for explicit __GFP_ZERO, not for
> > init_on_alloc.  On architectures with virtually-indexed caches
> > (e.g., ARM), clear_user_highpage() performs per-line cache
> > operations; using it for init_on_alloc would add overhead that
> > kernel_init_pages() avoids (the page fault path flushes the
> > cache at PTE installation time regardless).
> > 
> > No functional change yet: current callers do not pass __GFP_ZERO
> > for user pages (they zero at the callsite instead).  Subsequent
> > patches will convert them.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Assisted-by: Claude:claude-opus-4-6
> > ---
> >  mm/page_alloc.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index db387dd6b813..76f39dd026ff 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1861,9 +1861,20 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
> >  		for (i = 0; i != 1 << order; ++i)
> >  			page_kasan_tag_reset(page + i);
> >  	}
> > -	/* If memory is still not initialized, initialize it now. */
> > -	if (init)
> > -		kernel_init_pages(page, 1 << order);
> > +	/*
> > +	 * If memory is still not initialized, initialize it now.
> > +	 * When __GFP_ZERO was explicitly requested and user_addr is set,
> > +	 * use folio_zero_user() which zeros near the faulting address
> > +	 * last, keeping those cachelines hot.  For init_on_alloc, use
> > +	 * kernel_init_pages() to avoid unnecessary cache flush overhead
> > +	 * on architectures with virtually-indexed caches.
> > +	 */
> > +	if (init) {
> > +		if ((gfp_flags & __GFP_ZERO) && user_addr != USER_ADDR_NONE)
> > +			folio_zero_user(page_folio(page), user_addr);
> > +		else
> > +			kernel_init_pages(page, 1 << order);
> > +	}
> 
> Open question but not necessarily in-scope:
> 
> Should __GFP_ZERO just be implied if (user_addr != USER_ADDR_NONE)?


There are calls with no __GFP_ZERO but they do not allocate userspace pages.

  - drm_pagemap.c: GFP_HIGHUSER -- no zero. But this is a DRM device
    page migration, the page content is preserved from the source.

  - test_hmm.c: GFP_HIGHUSER_MOVABLE -- no zero. Test driver, pages get
    content from device.

  - mm/ksm.c: GFP_HIGHUSER_MOVABLE -- no zero. KSM merges identical
    pages, content comes from the source page (copy).

  - mm/memory.c new_folio = GFP_HIGHUSER_MOVABLE
    - no zero. This is CoW, content is copied from old page.

  - mm/userfaultfd.c: GFP_HIGHUSER_MOVABLE - no zero. Content comes from userspace via userfaultfd.

  - arm64/fault.c: __GFP_ZEROTAGS not __GFP_ZERO. MTE tag zeroing, not page zeroing. Page is zeroed separately.


> Putting aside how that's done without introducing another gfp flag
> (maybe something explicit like `alloc_pages_nozero(...)` ), it seems
> like a very short jump to just adding __GFP_ZERO to any user-alloc by
> default.
> 
> I'd be curious to know how many callers across the system omit
> __GFP_ZERO when allocating a user-page, and whether there might be
> scenarios where we subtly miss it (seems unlikely and narrow, but very
> possibly something a driver could do unintentionally).
> 
> ~Gregory


I'd do this on top if possible.

-- 
MST

