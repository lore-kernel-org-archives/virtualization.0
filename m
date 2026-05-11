Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11E3402435
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514953; cv=none; b=N/YqiaLF8BVLAqEmgfrNQA/JVcHSF2ojnzn9M4TZKGvBdvO6F7AtRmn39P8TJJPUGeJvVlY1AhB9VIOU8RgJWRypWeryHDnvyh1fQoCFs0mPDWNWfp5Qu6YeIEykdVR9CjoabF0jUvbH8MtvvjSCvCTfCINSoYwPNmbnkdQt9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514953; c=relaxed/simple;
	bh=TsGQPJnPEkYvT01y/40nouZgrDE845oWx7rogITeQEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=biUSQPf5LCkT3pRjV6ynH2JPtbIwPtDu/l5QkhgPN+sJJ/zAHCPZ5xmkoVJvebeIzYvc/gmmsA0lJiSrJL71r7+ArA1IcDDGzwFtvqam3CLzcxlyAPpC8OmoZag+lf5upYhv7YuqV9do+YeWdCfl18naRDg/wg7Fm+BqU0zWmKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQavqM0K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQavqM0K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778514950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vh4TZQwOj1LDvIW+49RnIFBfwPgx5sko4Nvxu6iVtR8=;
	b=RQavqM0KnbA4RGAbhfMr90gmoCQqqZ88gE9FsdIJIKL5Ymc+0Nejaf1GzeKRpRs+nKwsz6
	NLTm6Ryea86mL2Z+2p9EYGc/ovgtFVMZnZEF4eleA+yitliP0K61KG2w/nHOOrylAEdqEm
	u/5p9lef1TQxWEF0RRhpGiGyjvj5igM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-3MoRDy0QPh6rvggSHJlyuQ-1; Mon, 11 May 2026 11:55:49 -0400
X-MC-Unique: 3MoRDy0QPh6rvggSHJlyuQ-1
X-Mimecast-MFC-AGG-ID: 3MoRDy0QPh6rvggSHJlyuQ_1778514948
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48906aa28cbso40843425e9.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514948; x=1779119748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vh4TZQwOj1LDvIW+49RnIFBfwPgx5sko4Nvxu6iVtR8=;
        b=V+EXy6Oasz4oBfCKcCONtS58Imo1HOCKsaYYN0YSbHytX6xIJ4qAlFZCkfXAFyV7ij
         mL4TXRRC+m38AslKugqeudTha7YEwXECmcFqilmSJ/wNEuzI59/9D7cPLwGw03sSLQif
         jy3hbkwep7qBlhiuC7dSeZD/wBC7jRgzKXF2HyvPPrFYY3W1XPI1sfpGXQAR2k8WTi5v
         HlWr0x39gjm+cMxpSFarssH64KfrkuIbh5Z7teo2p5uuT1Re2z6/o7nlNe+TtZWI/x55
         8y2MEzZgC8vVZ+jzQIHAOtJBTNZdgzxdTGUAL/4OXKdRTefwG9HnaYF4xO2XivcDLWZr
         9kbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8V1qiC9DEtMjZeUwCQFdf2+fY9n0RmvMhTjVhVPEQugPID5OZYpuEgthXDIqAzD/ibwjwrobXcd1NcxfBR/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxicZCBAP5WWgdIZj4g0WyjF3gMZoMH1ABoUqdTJ8VmOG4He6q
	vgxiBcN0mGqDvzw35kGWcjjdOvT0spoJ2maUk+Fzs1OfjVovwer+gdUgvz2mEzZPXc0nslPZdgJ
	hEkZ1kwZbVWsqp2x0cJjlzur0n2JNtP5ToduMWljkwZtg5Ko3cU106XiK5zu/ttlDk95a
X-Gm-Gg: Acq92OHb/UTl7JpO5cCbznZ7XIru2PXKrTZwqqh+piB4gwTe9I2H2XtVbr418X//SAb
	05DV5iILRuDD/PysRscEUdPiHStUKJ+YQWAwdKKR7b9DUYxnXVCCjZMzwZCDKsQaBSG2UivWklu
	a3KEmdGiv3er7a+BAok6tOcECSl5HO8V4wpraeTYHYzG9YgO1IHP/ayPEjOPCRl5dKDBuY93vLk
	Vq9L/ggCP9NVh66g0TovhVX/vCq++YVcJJr0HcpzKYlZdJA1PGJpA+kVVE3IQgVMAuMSJlhojMI
	fRDjaJU2bsEYZCJESR46jajkD/4N+UwMPehxbBIrsu6LzzxjBV5+5ZlyW8jFnDt9HddFxV1wn9H
	WF2VJi2Cnq+K8p+SWpFExUn5i4GqwSTUf7wOUm4m+
X-Received: by 2002:a05:600c:3547:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-48e8e1e6eb9mr1618905e9.2.1778514948215;
        Mon, 11 May 2026 08:55:48 -0700 (PDT)
X-Received: by 2002:a05:600c:3547:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-48e8e1e6eb9mr1618285e9.2.1778514947593;
        Mon, 11 May 2026 08:55:47 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fff9ab8sm203070735e9.2.2026.05.11.08.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:55:46 -0700 (PDT)
Date: Mon, 11 May 2026 11:55:40 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>
Subject: Re: [PATCH resend v6 03/30] mm: thread user_addr through page
 allocator for cache-friendly zeroing
Message-ID: <20260511114853-mutt-send-email-mst@kernel.org>
References: <cover.1778489843.git.mst@redhat.com>
 <9b53972f4854c1064b92cefc464f51949afeb83f.1778489843.git.mst@redhat.com>
 <agH3wceKcPNmixCj@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agH3wceKcPNmixCj@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hFhbeSD5qh_p90bWLH3QBcqH9rPKCw9CHL3RFM65vBQ_1778514948
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2026 at 11:37:37AM -0400, Gregory Price wrote:
> On Mon, May 11, 2026 at 05:01:55AM -0400, Michael S. Tsirkin wrote:
> > Thread a user virtual address from vma_alloc_folio() down through
> > the page allocator to post_alloc_hook(). This is plumbing
> > preparation for a subsequent patch that will use user_addr to
> > call folio_zero_user() for cache-friendly zeroing of user pages.
> > 
> > The user_addr is stored in struct alloc_context and flows through:
> >   vma_alloc_folio -> folio_alloc_mpol -> __alloc_pages_mpol ->
> >   __alloc_frozen_pages -> get_page_from_freelist -> prep_new_page ->
> >   post_alloc_hook
> 
> This is the nitty-est of all nits, but when doing this can we please
> prefer stack style?
> 
>   vma_alloc_folio 
>     folio_alloc_mpol 
>       __alloc_pages_mpol 
>         __alloc_frozen_pages 
>           get_page_from_freelist 
>             prep_new_page 
>               post_alloc_hook
> 
> Claude has a bad habit of writing changelog changes this way, and it's
> painful for a human to try to read.

Sure.

> > 
> > USER_ADDR_NONE ((unsigned long)-1) is used for non-user
> > allocations, since address 0 is a valid userspace mapping.
> > 
> 
> > +/*
> > + * Sentinel for user_addr: indicates a non-user allocation.
> > + * Cannot use 0 because address 0 is a valid userspace mapping.
> > + */
> > +#define USER_ADDR_NONE	((unsigned long)-1)
> 
> Ehm, hm.  Does -1 hold as a non-user address across all architectures?
> 
> What about in linear addressing / no VM mode?


this is used on a fault. I don't think there are any faults then?
But maybe FAULT_ADDR_NONE would be clearer.

> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index 7ccbda35b9ad..ee35c5367abc 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -337,7 +337,7 @@ static inline struct folio *folio_alloc_noprof(gfp_t gfp, unsigned int order)
> >  static inline struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
> >  		struct mempolicy *mpol, pgoff_t ilx, int nid)
> >  {
> > -	return folio_alloc_noprof(gfp, order);
> > +	return __folio_alloc_noprof(gfp, order, numa_node_id(), NULL);
> >  }
> >  #endif
> >  
> 
> This change seems out of place unless i'm missing something.
> 

Don't remember. Could be from a change I reverted. I'll look.

> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index f24bf49be047..a999f3ead852 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1806,7 +1806,8 @@ struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio)
> >  }
> >  
> >  static struct folio *alloc_buddy_frozen_folio(int order, gfp_t gfp_mask,
> > -		int nid, nodemask_t *nmask, nodemask_t *node_alloc_noretry)
> > +		int nid, nodemask_t *nmask, nodemask_t *node_alloc_noretry,
> > +		unsigned long addr)
> 
>                        user_addr?  uaddr?

ok


> > @@ -1823,7 +1824,7 @@ static struct folio *alloc_buddy_frozen_folio(int order, gfp_t gfp_mask,
> >  	if (alloc_try_hard)
> >  		gfp_mask |= __GFP_RETRY_MAYFAIL;
> >  
> > -	folio = (struct folio *)__alloc_frozen_pages(gfp_mask, order, nid, nmask);
> > +	folio = (struct folio *)__alloc_frozen_pages(gfp_mask, order, nid, nmask, addr);
> 
> Not on you, but the changes in hugetlb.c as a whole are :[
> 
> We do all of this to pass USER_ADDR_NONE all over the place, but the
> alternative is having a separate function specifically for user-land
> bound allocations.
> 
> So the trade off is:
>    a) churn the current interface for everyone
>    b) add a user_ variant and know people will just get it wrong

I was also explicitly asked not to proliferate too many new APIs.


> IIRC you said the consequence of getting wrong here is subtle corruption
> if a caller got it wrong, and this was related to cache flushing for the
> provided user address?

Yes.

> Stupid question: Does this not apply to kernel allocations as well? Or
> is it simply a matter of the cache having stale data that could leak,
> and therefore it's not a concern in-kernel?
> 
> ~Gregory


Not a concern since we zero through the kernel address.

-- 
MST

