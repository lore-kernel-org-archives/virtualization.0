Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E855039BFF5
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778627348; cv=none; b=AepEmSdM3FtJqPARV9pLDhcqy97Pepn+xI7ErwV6+cxqMaDrMlkNRcWucv740pTZJyDcv1yeVENx478SdGRnabiJ/ruTVEHFNEop076lC+1+fKzvZ+FRmsd9NSZp9MNU3nbgrergCYikPHozLB3laiHLT5x4s+6ziTCwHzWKnE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778627348; c=relaxed/simple;
	bh=n88vqj4nmtdMk1o5i2yjKCIfZ0Z9bnAOvjBFay7SjCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HDvYbH/nlYcs27BrG0a3566OJUMbT3OYNeIka48GxBrtSbRrMFAH2rw4M1bCx8BeKv/xSpQoCL6OpQEB9NdxTuZjzSnWwPVc4y5McGq/C9Maa/THoEixLi6JdcV+3JXbo5GDrxlVx0AtPgCQOvxirJwshJ59vYBWM4GAkt0bGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OClovmg+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OClovmg+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778627345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jfYztun+Ckl4TQFSOsYDj/dxDNvMV7VEGy8D7Y98Eog=;
	b=OClovmg+z//xavFVJGja0KRGZPzjw4TBiKZtyPWlDogZ3/3y0NKd+k8q8cBv3HFUPYukv7
	9FbRmWxcgRoKkCWvqLsRXCnHaAE1bHxwHaGfG8A0GvgbktsDVPw7i8pESe3JICy+IW0ArP
	E9zXSmIpYbutpyBPbPBdR0kdBzRsyBk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-jePPvJ5dMdWvfV-dZyyRMg-1; Tue, 12 May 2026 19:09:04 -0400
X-MC-Unique: jePPvJ5dMdWvfV-dZyyRMg-1
X-Mimecast-MFC-AGG-ID: jePPvJ5dMdWvfV-dZyyRMg_1778627343
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44d68ed8f95so4849836f8f.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 16:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778627343; x=1779232143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfYztun+Ckl4TQFSOsYDj/dxDNvMV7VEGy8D7Y98Eog=;
        b=iErG5bYtjnv9JeJtZlBbY+bjYcd0BL4+8+kk9/9oRu9hvLwX/P8901mkXooIZXkIe9
         eBxNrF91LVcXgD+CtxRaXkp/Vdp/xlGTF25VaCYI6Y4Z+6vTWbWlVtB+Hp63UjrE3co4
         YDxLPjYVv0YtV/tqIxgvwFULOVQJk3iqPUfPms92O71Si9KppX9DqEhEzkEHTnYPcR9o
         n1mtBSfvMS9OVvhHaxeaGE2+mEYIRfDafaJ3hAXY58xfzfEq/l+xnB1+BsyFuUGTRhxj
         dFA1cCQB70xHckMr7Ccs3OcN9p93I+639+G8iGLCQXsBqUPMc/gEPpb0OjyHdwnQzVQf
         oJEw==
X-Forwarded-Encrypted: i=1; AFNElJ/QqCD4HTNAV+TNFvaiGPgFlssiz6oOYcSQITiyXJfB17rYd7nlFVWGfry9qAAuEfgWpd0AnCx0qz7TGDvpMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywg7FRblIGBE4nRvvDxqqr/c7De7H6MNiIX8sx3ZAuV0G9d1aU8
	lAeemPd6YQYphMe2bt3mwlCqDqle98DHPwcAx7MfJMEo+xxnmDydBH5PkZ9n0fTMW38umAAxzua
	RvEUwdm+bfEUCjbQPQp+zDh6yIbXly9irynGwOQXpZ+wASfD60vD84HmMaQCpo35ahbVi
X-Gm-Gg: Acq92OHBgRl8jmhS0j1mW1nqUVh6WFqEqvdpNbqz/YMXwZWR2w4LZzFNwp0AVNJsSgG
	GzuwBbNT2i78kzwEkiSMWYqQNWs3MHCYTidA/BNvi+h1vqjz4ftBjFawCm2owNc5hLnz3J65/DV
	UxhRJDHWJi4SaSYIGatyg3uGUYE1uSt22J5DyIEZGDPGaKSuhsMuD9tLPOoeFb2/3WonFR4/skU
	oX2a5xA9y4b+dbNO13aMs9Demyu2P5Zpvyh3Pg+w7x8dh7MYX+TjYfLVFM4ppPvjFVMsgwqeWwe
	/3WZbOar3f4+3AC3giasNJCuVpUdrJLVq4Ueej+otnOwXCPjYkIa871/xS4v2DeBCackbkv7v/0
	J3eiAd23+dB+UAJZtKXltMsyCc3DaMBtB7ME07KNk
X-Received: by 2002:a05:6000:100e:b0:454:353e:3f4b with SMTP id ffacd0b85a97d-45ac0b2d931mr6693662f8f.3.1778627343073;
        Tue, 12 May 2026 16:09:03 -0700 (PDT)
X-Received: by 2002:a05:6000:100e:b0:454:353e:3f4b with SMTP id ffacd0b85a97d-45ac0b2d931mr6693637f8f.3.1778627342575;
        Tue, 12 May 2026 16:09:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45492271510sm42875375f8f.37.2026.05.12.16.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 16:09:01 -0700 (PDT)
Date: Tue, 12 May 2026 19:08:56 -0400
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
Subject: Re: [PATCH v7 17/31] mm: hugetlb: add gfp parameter and skip zeroing
 for zeroed pages
Message-ID: <20260512190250-mutt-send-email-mst@kernel.org>
References: <cover.1778616612.git.mst@redhat.com>
 <4039b0b96594b69b15ad4bcd64cbb33de3cec350.1778616612.git.mst@redhat.com>
 <agOju4MRXyS7Wp8E@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agOju4MRXyS7Wp8E@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2YHiG0Uvu_x4KklnWw2BD95VmobSXCnZ3wDKQmcjWmI_1778627343
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2026 at 06:03:39PM -0400, Gregory Price wrote:
> On Tue, May 12, 2026 at 05:06:37PM -0400, Michael S. Tsirkin wrote:
> > Add a gfp_t parameter to alloc_hugetlb_folio(). When __GFP_ZERO
> > is set, the function guarantees the returned folio is zeroed:
> > - Fresh allocations (buddy or gigantic): zeroed by
> >   post_alloc_hook via __GFP_ZERO.
> > - Pool pages with HPG_zeroed set: already zeroed, skip.
> > - Pool pages without HPG_zeroed: zeroed via folio_zero_user().
> > 
> > The address parameter is renamed to user_addr; the function
> > aligns it internally for reservation and NUMA policy lookups.
> > For pool pages that need zeroing, user_addr is passed to
> > folio_zero_user() for cache-friendly zeroing near the faulting
> > subpage.  All callers pass a page-aligned address; the
> > hugetlb_no_page caller passes vmf->real_address & PAGE_MASK
> > for consistency.
> > 
> > HPG_zeroed (stored in hugetlb folio->private bits) tracks
> > known-zero pool pages. It is set when alloc_surplus_hugetlb_folio
> > allocates with __GFP_ZERO, and cleared in free_huge_folio when
> > the page returns to the pool after userspace use.
> > 
> > Suggested-by: Gregory Price <gourry@gourry.net>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Assisted-by: Claude:claude-opus-4-6
> > Assisted-by: cursor-agent:GPT-5.4-xhigh
> > ---
> >  fs/hugetlbfs/inode.c    |  3 +--
> >  include/linux/hugetlb.h |  5 ++++-
> >  mm/hugetlb.c            | 47 ++++++++++++++++++++++++++++++-----------
> >  3 files changed, 40 insertions(+), 15 deletions(-)
> > 
> 
> This seems much much cleaner this way.  One nit, doesn't need a respin
> unless you feel like it.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> 
> 
> > @@ -2980,6 +2993,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
> >  
> >  	spin_unlock_irq(&hugetlb_lock);
> >  
> > +	if ((gfp & __GFP_ZERO) && from_pool &&
> > +	    !folio_test_hugetlb_zeroed(folio))
> 
> stupid question:
> 
>    if (!from_pool) - wouldn't folio_test_hugetlb_zeroed(folio) be true
>    because __GFP_ZERO is passed?
> 
>    If not, SHOULD it be true (i.e. should we be setting that in the
>    non-pool allocation path when __GFP_ZERO is passed and allocation
>    succeeds?)
> 
> If so, can this just be simplified to:
> 
> if ((gfp & __GFP_ZERO) && !folio_test_hugetlb_zeroed(folio))
> 
> Maybe that lets you eliminate the bool entirely?
> 
> ~Gregory

Agreed. I will include this if I need to respin.

-- 
MST

