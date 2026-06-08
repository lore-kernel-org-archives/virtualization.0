Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51423E6DD4
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947758; cv=none; b=KJjC4UkIoYmLI/rCwneCZ4dKAvGXiIv2NwpFOvgCiHs7aTCuwVUIoDn200VIsWWb37x2Gj+PlH3rEpiCFhf81WBC9YqwtTsw3o5sulnjq+NIXvCaztxLm1H31MNg6K//fcosXVbX9vtHzC7PAqzbYcoSvcaOFtLtIvUiB7atHUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947758; c=relaxed/simple;
	bh=50W4UDlXpfoF6kiopXqMLDOA3XXRFOPMfAQy3ckHZh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Qz9byXmKCcAl5rkmJl3QT2FIjoaI98yJzzV758BHaIwO/QgLQlUx5f6BqXvMVBY3sPlbBX91KNkPfCtNASY7ZLXSh1yVVBnn3XGcVZdRpFudFFw4lsWd/sOEbmg7QZcKJScK8yi2wgds9w8+fzzJ7UCQs6OFu8WK9wDKCHJsqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1zK7g2h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1zK7g2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780947755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UyaugOeWdyxnQAKpdKSlyb4RePHF9b2tnJFLR/rHRb8=;
	b=J1zK7g2hp0+zetkBb07dXSoxQ8l7/qC8/h0cBUReu3cW8x6Yz6Vncvi/1MzIYFvturHxOl
	mNGIF0fiwi8htOjT7bDLr8b277gd+BggbMZuvBYSIlQfX+AvlD+U4D1vy8lEMzdPpxFp/O
	l7GVFkkb6Yn/JVQ3u422V6NYpRDX4c4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-Q0_qncfyPhmPqQ0jzy7Geg-1; Mon, 08 Jun 2026 15:42:32 -0400
X-MC-Unique: Q0_qncfyPhmPqQ0jzy7Geg-1
X-Mimecast-MFC-AGG-ID: Q0_qncfyPhmPqQ0jzy7Geg_1780947751
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-68d2340cb67so4252106a12.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 12:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780947751; x=1781552551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyaugOeWdyxnQAKpdKSlyb4RePHF9b2tnJFLR/rHRb8=;
        b=m4EDzTKdp9UMXaqgj22pSDgXvpt4Lb2Az74Jf8+5BGH4OQ7RPlCIJG91tasYM4yYHi
         aBdUzbYY44R7CIzZ5rfRo9oPspWwNhsDOgqXPazsu+chx4vgfmKreBwQZ/pJ6rWH+elo
         K/7NxEz62qVEEvi69Cjc2gO3AR+uHADXqA/PUQQEkNjNlMVJw58n5tqY9qR2GTXyfABy
         6DzXS5+jXOpbmBhlr+8oxNRw84ucwr0hsct1CnQnFFr3dUIU0aRRSfzVqLASaolyZOm1
         ADi4L6G9LUTkkgJN6GAuDW/Zl2TjfXy59nzKpbhrIej1eK7zTkNxeCDZwQJwzkFZdwF0
         Q73w==
X-Forwarded-Encrypted: i=1; AFNElJ9UuWNHRfqurUlT/Whx5ys7S2W8SS69g7CiyXKMaCWQqQWQPnut3qEg3fi+eUb/VFcZ5DSp/Iqmu3a7uXadhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YywLgeAke8lgPic6FAJrOCfib7yCj5OweicelUOrEN1nEtWF1OJ
	OcotSKwrFv8QYIcSM+rPPxVAfjiUNAINU8RI3klb7HTEuLUFb4eZR74pQO38lFId6SQuSqb3Uvy
	Rg62fDyApEt1jW3hF2hXgXZzgEJ9VKZa50JxE7rbgwG1GVBt9FBWtnX+YFKTbUkgxcObA
X-Gm-Gg: Acq92OFsWdb+u4mXfg8hma0FGF71M3+YcB3XhSHinRxw6GoUCqWryzPN3wpRDFGo6H/
	WwmCjiQZp7Dfz5ZztRksKOtE1VnHMzbYeeTht+T5ifFJnNGvTer323BMUIX9rRz9+kgEyU9vEXw
	rS4ns7QsnHZnlyZcAIy7h0xXKtf3JcOn7144C0QXjazWqkOvBRQy31c39/NZm43C0AFrf8M/y0V
	YvRxB6uew3WP87N6As22EbxtIpbPOZy2amAWWZp/4bCWpLZEjVgktASkQwH2fAKBFMVcD0g9EGR
	FNoHp/TDIV3bMl/00FUQFNfxZzZoJD8W3UJV9WXLjujF2+Y5V6bxbNNjBWk2V4WNSF4Q7E19yPz
	HVK0l7/UrqV9di67dwTFrCspeStOBwz9Cd9NqwsUUk17DtsoRP9devA==
X-Received: by 2002:a17:906:4fca:b0:beb:9dc2:6f3f with SMTP id a640c23a62f3a-bf372c2cca4mr809351066b.36.1780947750642;
        Mon, 08 Jun 2026 12:42:30 -0700 (PDT)
X-Received: by 2002:a17:906:4fca:b0:beb:9dc2:6f3f with SMTP id a640c23a62f3a-bf372c2cca4mr809347366b.36.1780947750169;
        Mon, 08 Jun 2026 12:42:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e05199sm897247566b.29.2026.06.08.12.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:42:29 -0700 (PDT)
Date: Mon, 8 Jun 2026 15:42:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-kernel@vger.kernel.org,
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
	Gregory Price <gourry@gourry.net>,
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
Subject: Re: [PATCH v10 12/37] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <20260608153957-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <f92f6f06e5804b4ea7f68b8664b7e69953b50f4e.1780906288.git.mst@redhat.com>
 <aiacZ6_7SG3nvVjM@lucifer>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aiacZ6_7SG3nvVjM@lucifer>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mCbTFP6hJJvPUT1GGkUcQ1TE9ZjF_AlcvoqEnrhzhDA_1780947751
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 12:23:07PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jun 08, 2026 at 04:36:38AM -0400, Michael S. Tsirkin wrote:
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
> >  mm/page_alloc.c | 35 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 4676fd49819e..d4fbf1861a8a 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1861,9 +1861,38 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
> >  		for (i = 0; i != 1 << order; ++i)
> >  			page_kasan_tag_reset(page + i);
> >  	}
> > -	/* If memory is still not initialized, initialize it now. */
> > -	if (init)
> > -		kernel_init_pages(page, 1 << order);
> > +	/*
> > +	 * On architectures with cache aliasing, pages zeroed via the
> > +	 * kernel direct map (e.g. init_on_free) must be re-zeroed
> > +	 * through a user-congruent mapping.  Host-zeroed pages
> > +	 * (zeroed flag) don't need this: physical RAM is clean.
> > +	 */
> > +	if (!init && (gfp_flags & __GFP_ZERO) &&
> > +	    user_addr != USER_ADDR_NONE &&
> > +	    user_alloc_needs_zeroing())
> 
> We check this (gfp_flags & __GFP_ZERO) && user_addr != USER_ADDR_NONE thing
> twice, can we just put in a 'init_should_folio_zero' const bool or something?
> 
> > +		init = true;
> 
> As Vlasta says not sure if we want to add complexity just for these arches.
> 
> > +	/*
> > +	 * If memory is still not initialized, initialize it now.
> 
> I kinda hate that 'init' is unclear as to 'do init' or 'was init somewhere
> else'... Anwyay.
> 
> > +	 * When __GFP_ZERO was explicitly requested and user_addr is set,
> > +	 * use folio_zero_user() which zeros near the faulting address
> > +	 * last, keeping those cachelines hot.  For init_on_alloc, use
> > +	 * kernel_init_pages() to avoid unnecessary cache flush overhead
> > +	 * on architectures with virtually-indexed caches.
> 
> This whole paragraph seems pretty useless and just describing the code?
> 
> > +	 */
> > +	if (init) {
> > +		if ((gfp_flags & __GFP_ZERO) && user_addr != USER_ADDR_NONE) {
> > +			/*
> > +			 * folio_zero_user relies on folio_nr_pages which
> > +			 * requires __GFP_COMP for order > 0.  All user folio
> > +			 * allocations set __GFP_COMP via __folio_alloc.
> 
> This whole paragraph is useless and very like the kind of stuff AI generates for
> comments, i.e. overly long + entirely unnecessary stuff.


It was an attempt to make sashiko shut up, it doesn't understand the
context and kept complaining. Didn't really help so yea I should drop this.

> 
> > +			 * user_addr != USER_ADDR_NONE implies sleepable
> > +			 * context (user page fault).
> 
> Can you safely assume that? Also inferring which context we are in from this
> parameter seems risky.
> 
> It seems to me that you're now making it such that kernel developers:
> 
> - Have to know when and when not to specify a user address, and under what
>   circumstances we might consider that to be mapped.
> 
> - Need to know to do this correctly for aliasing architectures or have silent
>   correctness issues.
> 
> - Need to take context into account when specifying this.
> 
> We definitely need to find a simpler way to do this!
> 
> > +			 */
> > +			VM_WARN_ON_ONCE(order && !(gfp_flags & __GFP_COMP));
> 
> Surely by now we can assume this?

Another attempt to make it obvious.


> > +			folio_zero_user(page_folio(page), user_addr);
> > +		} else
> > +			kernel_init_pages(page, 1 << order);
> 
> I hate this hanging else branch... definitely prefer {} on both branches.
> 
> But in any case it seems like we could avoid some indentation with something
> like:
> 
> 	if (init && init_should_folio_zero) {
> 		...
> 	} else if (init) {
> 		...
> 	}
> 
> Or even a:
> 
> 	if (!init)
> 		goto out;
> 
> And stick an out label below?
> 
> > +	}
> 
> >
> >  	set_page_owner(page, order, gfp_flags);
> >  	page_table_check_alloc(page, order);
> > --
> > MST
> >
> 
> Oh and in general it seems that this conflicts with [0] which removes
> kernel_init_pages().
> 
> [0];https://lore.kernel.org/all/20260422102729.166599-1-hsalunke@amd.com/
> 
> Thanks, Lorenzo

