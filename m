Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A945130ACEE
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512547; cv=none; b=MiJ53/wc7S/GmynRzXvlccBOPQ6SKdvI2Rg62LWOJingR4gKkJmN7dH3CC9DOaXyL6zRZtVPbCc7wQQlBNUfDLB03nBK7mTc/XwBDR/5Raagx3KMhCkZEQVVBkbaeGvpsPW8ndyDvyRtqWrpGNOxWmR1Jgu9y/Wh82yMv86Vhq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512547; c=relaxed/simple;
	bh=nk8hE5v8+3CIaIuDoXep25HN/SD7sZy8FNF33B159Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tG/Cv3+VUcr70mkTDm1Hkpj1dpo0AtNxHJ6b5CI5RZCnhazqjoiQ5/EqRp7BXYGoNUUgYo6ixr4XmOgvOui1UxtgC1vxbFlCNhUnwICvfszc094/XyVbi8HZNRgpjyZeI98RABCJChsytiJlLyFFd7asB2h/ogGOMUBkPOrCxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xr8WldP7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xr8WldP7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pw7Ok457RiSERsUb2kiTq/Cv9uGPdowjG2q0yMpggx4=;
	b=Xr8WldP7NCNhmbpquVaqDL6tngQF6V+DddOo1KvqSVMRjmdX70ou09yjAss5fUDRRAmjNX
	3xCx/8qzXgiRq/Ckolweq8pup2qVpvSo9+5THhjLAYAgU1UjNw9VVjkaR1mk30+lHIxrUB
	GIoDEN7Dz1fSVToICbyip5B9TUv573Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-tv31S5JaNnqwT7dyxmdGIg-1; Mon, 11 May 2026 11:15:35 -0400
X-MC-Unique: tv31S5JaNnqwT7dyxmdGIg-1
X-Mimecast-MFC-AGG-ID: tv31S5JaNnqwT7dyxmdGIg_1778512534
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6749e8562a7so3678759a12.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778512534; x=1779117334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pw7Ok457RiSERsUb2kiTq/Cv9uGPdowjG2q0yMpggx4=;
        b=Xaf789157Fgt1ifBM4nmKLlwKNVd6Gb1w8jXmE/WYrzNVfYacRs7QJnkwf+hLCqrlJ
         xMuW3fH6vpAKZYSAVMuwYg+c4sCMFioJki23ncVy0Bl7vzq7NkQixTeZHc8036TzNPE6
         fqIiR+lZqfSUSfQsXrBZZRR/Hm97NdQXy3obgR2Y/5qGHGPIs540tDztmxDJqoUR0MCq
         Gstg6p4Hwk8LTL0PGFgwz4VX2UUUJPMhRxhihbic63njOGLscO8ATFZbkalLqdxbXhdV
         j89E+lwaCpmGmkUc4BiZzjhYGD48TNvq9qKseTtomzPPkihYBEofNuEtK3g2+7GZoQrF
         GNSA==
X-Forwarded-Encrypted: i=1; AFNElJ9FdSA8kqxVUVzPOj3+7IUhc/s00ZQjyvNcw+uEckkMxHUpanSqw7jiv0sR2OyjbLg1HDU93URzkhaXR8/fFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIfEKOG9xuhznItntNILbiD75VbojOQKDv7dBqxvJOTLBihYZk
	KOdaAUGkPuvTp+wNnu4vYsw/cvRN3lenyn9FLemnZoNDtf0lPYT5UbrEw/zthyDBA6Fo06VB8a0
	vAlZtoXmzucbZawPNIm/DXdeVip4sI2EXsZmY9qhJvfITTy3PWvp9ZNIy36Uv4aInls4y
X-Gm-Gg: Acq92OGb0AlHlv6Yl9I9NlStlcOXhThLPbepMTWZ5PUR9raNKBVOxszTd64mHVTSEaU
	Q2aas8h5JRx0dOhlB6FbyDtoId4kPttyQwPhc0pY0ZKup/3gsouxZXwvwCedKhyYhh2YuLi0n24
	Zhzf5ANQJLlxoWs2RuyUuFMJmxrVbqLzRzZbUR26p5Zt2OD5bs9mckzA90vDItJMN8Rj4iivUE1
	vc6SlpTNO3lHKf3s1N25/ktZOS1y0VXhmjVCcEqQjYimccoewpT9JML8xTC12AXNMCrVoEabHqU
	AW+3/GpPgXyW+URSrqnmpN8IyuMmxjAik0c5A8ighIyRqox5ozfIAaO8BfNS0fsfiGEltTUFVtO
	Dx7sLKmMVJOxEQGqLy/+Ei65J0yRMn5egIiT4h6qn
X-Received: by 2002:a05:6402:3509:b0:674:37b7:227c with SMTP id 4fb4d7f45d1cf-67d63aa055amr12708519a12.2.1778512532300;
        Mon, 11 May 2026 08:15:32 -0700 (PDT)
X-Received: by 2002:a05:6402:3509:b0:674:37b7:227c with SMTP id 4fb4d7f45d1cf-67d63aa055amr12708486a12.2.1778512531582;
        Mon, 11 May 2026 08:15:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0b6baaesm3990113a12.12.2026.05.11.08.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:15:30 -0700 (PDT)
Date: Mon, 11 May 2026 11:15:24 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH resend v6 02/30] mm: mempolicy: fix interleave index for
 unaligned VMA start
Message-ID: <20260511111417-mutt-send-email-mst@kernel.org>
References: <cover.1778489843.git.mst@redhat.com>
 <41bd50fdaae943e1a79215ea4000322e74a823be.1778489843.git.mst@redhat.com>
 <agHu4iaL-3By0YuC@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agHu4iaL-3By0YuC@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pjKUyB4dg57-O8fHuNHt4PkLnfgR4EkLoAZSYr3yqsg_1778512534
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2026 at 10:59:46AM -0400, Gregory Price wrote:
> On Mon, May 11, 2026 at 05:01:49AM -0400, Michael S. Tsirkin wrote:
> > The NUMA interleave index formula (addr - vm_start) >> shift
> > gives wrong results when vm_start is not aligned to the folio
> > size: the subtraction before the shift allows low bits to
> > affect the result via borrows.
> > 
> > Use (addr >> shift) - (vm_start >> shift) instead, which
> > independently aligns both values before computing the
> > difference.
> > 
> > No functional change for current callers: the fix only affects
> > NUMA interleave and weighted-interleave policies. Current
> > large-order callers either pre-align the address
> > (vma_alloc_anon_folio_pmd) or do not use NUMA interleave
> > (drm_pagemap). All other callers use order 0 where the old
> > and new formulas are equivalent. However subsequent patches
> > in this series add large-order callers that pass unaligned
> > fault addresses, making this fix necessary.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> 
> Should this just be pulled out ahead as a fix (assuming this
> set takes more time to bake)?  I get it's not causing issues today,
> but the interface is otherwise technicaly broken either way.


Sure Andrew can pick it up if he wants. I found a bunch of unrelated other
"technically broken stuff" that I deferred fixing. Will get to it
once this is done.

> > ---
> >  mm/mempolicy.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 6832cc68120f..39e556e3d263 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2049,7 +2049,8 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
> >  	if (pol->mode == MPOL_INTERLEAVE ||
> >  	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
> >  		*ilx += vma->vm_pgoff >> order;
> > -		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
> > +		*ilx += (addr >> (PAGE_SHIFT + order)) -
> > +			(vma->vm_start >> (PAGE_SHIFT + order));
> 
> There's enough (PAGE_SHIFT + ...) spread around the kernel, i wonder if
> it's worth a define or a function (not in scope, just pondering).
> 
> ~Gregory

