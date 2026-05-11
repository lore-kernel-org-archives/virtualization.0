Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3AD332634
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512184; cv=none; b=XYdB2BKlRVNBGohGZ3BjjoX4cxpNK4ChrezCt/8K52GU1IibgHFp+8m5RGplyXdcVtHMNwSoJ3B/1MxRRB2zzWqU0ejHGEPOHj/QlH6+ira+knRdSMz/uPpI9URm8JDaSUvqJo91wniekRn1sJtTiRD+Z5UlKRX18iVCTMl94xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512184; c=relaxed/simple;
	bh=Dnf4+DfJsVd4W+XYmvPc8kClnijoEAXClbX5eCs6Bdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iuKUTOGOWMM16scNppzERoYkTtsd9iI7egKm06pBWW9s/ncj1+PGJvjKg9afhoiQeMsXLvwc6zUWOPeZHj3AZ966ZwJEBoyQa3NNeG5c7gDM9zHP+h+etdtFBBd+TcNhZEhajL/2SSBVTINx2SeBZ4ihLUrTEOhZOfQfRCJvveE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVs/ohIz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVs/ohIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AizvbhkaHZmbiszzPT3Ur4sT9Sy5a6af0Jfvs/KZVvM=;
	b=UVs/ohIzwCjCd4bswKveO1Xnxnx8+pHzVR/1UhIQj/0gv7GMHesQV528oYlmCGZR6kCKfi
	sRJMOrJl3msI5pPMLc1MnNMBEJQryE3Kq4ZdRyive3bj0WW9aTDLCWs3Y5oW5T3HmqHcVl
	Iy3ATPjvFUEP8ZC38MaNvACHSS/2mS4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-aMHpWluUP4an2zy21ttq1g-1; Mon, 11 May 2026 11:09:39 -0400
X-MC-Unique: aMHpWluUP4an2zy21ttq1g-1
X-Mimecast-MFC-AGG-ID: aMHpWluUP4an2zy21ttq1g_1778512178
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48e5eecd0aaso25304345e9.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778512178; x=1779116978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AizvbhkaHZmbiszzPT3Ur4sT9Sy5a6af0Jfvs/KZVvM=;
        b=fn4hY9Z+rjh+jQJ0WQ1+Bkeb6g0P9odfV5+bH2p+1kqu0hkmy9/AOAh3rLPCe/gjSz
         FqIk0Hm+O7DMgii7sDxoyK81z93wSmFCfkl/D1j7rGS8ntnHjdck2issjBHJnW4FX2YU
         sfwzQBdMoDEc8RLr0RmCe/CmS4EPGn9s520gecrvjJFbd019w4HvOTjm5gUpvs729CkT
         vI43K+a8+dPdy6pPgYuYAoR7cFHraKvECQamCb4/v/lKOccUhgc16TgV5gVFi9DnFVMd
         m942DG5Y7uDFHMJqIw68ByVx4MXRQeDtEi7YPxRUkH2pxaJJeD7lB7rmnbRslX7VUBzF
         QCrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kQbqfe04tJ7bSNiipiUgyCv+ncTcnUJzFWT2Jw7HiCAuJGa08M8/BlLvr3tp+COBTWZQ4Ag/utUndDI4NXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNzwyLDrL1B9zoqQE1A5mtPghQo9apIdw0HEUMX+GoUrVLaA8F
	WXv3fhbZ7kKq99rf5a6u8RWj+cuNMlsDtzfp5cqmU/pBAH0yijeHIgVHSwkzz42mkVA9hV5TKUG
	zQMZW2u3cWUkxEsnrEghEZgM9PmNBQ3n4wxbDVG3j5NngN0DODCrZlO+Q/b/Q6E01siDh
X-Gm-Gg: Acq92OG/WSHC3XPUD+xcuVzhOnobgsaRJ3sOlZ2Jb8BstGFhIR+iPfqCXvR6ka+O9n7
	+qsal72Eih/r74FlT/S6yAgB6hjD1DkWsvvMhLNt5YS2dd+ECtoXHNJ63aN8o/+6nwMMZ7INHr/
	Xe/r/9SPcxI9Jmd7CHVOR2NE1JCS2QZBd9T4aeY0tYUV97tu9j9XrbGMK9m6EcrdYOreEiBpcwI
	i+m2VqwFDdxVIgFhSErSsK2No8A4k88QEArVkQOy0EnHF2ov/nN+0TSa+Mgeq1LNAiSADj8YQ9Z
	Ul8EpLKnX38NldeQBbEP880Y61W0e43xKVSdPi51cc0P7Fxbe/Vc4Fu7O/gcfO3na/szt3ohBFI
	3mRoxpFj8Xs83cHgDgMfarABwqCJwEbVOiZxhr/ZU
X-Received: by 2002:a05:600c:34c8:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48e51f2f85emr427543935e9.13.1778512177753;
        Mon, 11 May 2026 08:09:37 -0700 (PDT)
X-Received: by 2002:a05:600c:34c8:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48e51f2f85emr427543085e9.13.1778512177160;
        Mon, 11 May 2026 08:09:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e0bf2sm334546605e9.4.2026.05.11.08.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:09:36 -0700 (PDT)
Date: Mon, 11 May 2026 11:09:31 -0400
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
	"Liam R. Howlett" <liam@infradead.org>
Subject: Re: [PATCH resend v6 01/30] mm: move vma_alloc_folio_noprof to
 page_alloc.c
Message-ID: <20260511110719-mutt-send-email-mst@kernel.org>
References: <cover.1778489843.git.mst@redhat.com>
 <a26c5850219e349f8a666282aa8003a82a4819b8.1778489843.git.mst@redhat.com>
 <agHsFsEIU8b9RiJr@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agHsFsEIU8b9RiJr@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lc_b-qmVWtGQoM1Xkl0LipVSZ3NE6ZPXQ_BuRUQ7bgk_1778512178
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2026 at 10:47:50AM -0400, Gregory Price wrote:
> On Mon, May 11, 2026 at 05:01:44AM -0400, Michael S. Tsirkin wrote:
> > +#ifdef CONFIG_NUMA
> > +/**
> > + * vma_alloc_folio - Allocate a folio for a VMA.
> > + * @gfp: GFP flags.
> > + * @order: Order of the folio.
> > + * @vma: Pointer to VMA.
> > + * @addr: Virtual address of the allocation.  Must be inside @vma.
> > + *
> > + * Allocate a folio for a specific address in @vma, using the appropriate
> > + * NUMA policy.  The caller must hold the mmap_lock of the mm_struct of the
> > + * VMA to prevent it from going away.  Should be used for all allocations
> > + * for folios that will be mapped into user space, excepting hugetlbfs, and
> > + * excepting where direct use of folio_alloc_mpol() is more appropriate.
> > + *
> > + * Return: The folio on success or NULL if allocation fails.
> > + */
> > +struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
> > +		struct vm_area_struct *vma, unsigned long addr)
> > +{
> > +	struct mempolicy *pol;
> > +	pgoff_t ilx;
> > +	struct folio *folio;
> > +
> > +	if (vma->vm_flags & VM_DROPPABLE)
> > +		gfp |= __GFP_NOWARN;
> > +
> > +	pol = get_vma_policy(vma, addr, order, &ilx);
> > +	folio = folio_alloc_mpol_noprof(gfp, order, pol, ilx, numa_node_id());
> > +	mpol_cond_put(pol);
> > +	return folio;
> > +}
> > +#else
> > +struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
> > +		struct vm_area_struct *vma, unsigned long addr)
> > +{
> > +	if (vma->vm_flags & VM_DROPPABLE)
> > +		gfp |= __GFP_NOWARN;
> > +
> > +	return folio_alloc_noprof(gfp, order);
> > +}
> > +#endif
> 
> Can this ifdef not reasonably be done in a header?

It can't :(
In patch 3 this will need to call __alloc_frozen_pages_noprof, and
that's in internal.h


> I know the old path relied on basically mempolicy.c being in/out of
> scope based on CONFIG_NUMA, but we should make an attempt at keeping
> page_alloc.c clean on this if possible.
> 
> ~Gregory

