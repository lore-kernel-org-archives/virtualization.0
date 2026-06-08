Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A34BC15C
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948511; cv=none; b=VXmGI64uSt2XjyNzf80pxH83ybb95Zub8ZMekiDoaWgaJzgjzvGEDzmpeR9omo3LKjBY8ubv0+hZ5JlTTGvnQDRrPiKArllIyMw2W8ny3/0zIAcnmJUbFIP2yf7pHVwluOAqbok6+Wg4dGT5wKM71O3NmIelAquEcAUk8J0/BDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948511; c=relaxed/simple;
	bh=JXA3s4ch667vnuxWsX8i4Su/Y69iMX7B+S7Lg/Adh1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Gq/PQNjLYmAq+wJasKCd0bPFplSY81bLhZLKi0sMzXayBGZMgbsJ27dSfBGx7KaOBExOF7uZ+vKCpaZLTQwmxRFwQR5zQdXckVmNnvjtUQMbls8kkg9yq5OIxG57xEiZA1L745PCJhTD0qWKnzC5at/Z2i03bs+oO4zM6yVvTh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5ikco8V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5ikco8V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780948509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K1EvdDcjngGB9YGnsiekH6IRPqxO13+zTlrf/+W1zqA=;
	b=E5ikco8Vs5Ubfay2HR/emi18DTrGA1G530CrjJ3Zt4Sl0RM70wq7rcYELJUtvA7oUqNdPA
	HC2jkXCqEbnVhG0gO/Lr5Op1jzEhNoyrWhETve+h6m7ANacsXPydQS1EO9e3el5sQUapY+
	Lx5zxFa8agc4/xaYmR7uYjh1PUSR2KI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-1SEav8BEMLSr-fcxHCz4ug-1; Mon, 08 Jun 2026 15:55:08 -0400
X-MC-Unique: 1SEav8BEMLSr-fcxHCz4ug-1
X-Mimecast-MFC-AGG-ID: 1SEav8BEMLSr-fcxHCz4ug_1780948507
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a786f987so53685435e9.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 12:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780948507; x=1781553307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1EvdDcjngGB9YGnsiekH6IRPqxO13+zTlrf/+W1zqA=;
        b=s2q4Yjuq+5X8KD3JKGWrZZZW4j4v1RCd3uHsJ1838YL0FEIxY9IjefEiAUCrOEnme/
         Lv9jPgElBsV1H/J6x5p1pDvQ5An4hSHj+XWGCq2MAaSj3jBJJ6E4CU1MqoM8EtCxPKd5
         A8OceYP2bmMMAV+HBFfqQBg9xYv/4ZUzoK5TRs6bDpt/bmvVWrm2D6BlXfG+YccY38d0
         dieKxbusCAXBIHSnvTlUIH2fzPLVNHPyAbQDH9vMzdje4fPkmKqt0GQIooDS+CF5V63i
         3bVCcJhAvemuAuNqgiqiE8ErrZI9NOwVD1gWeQcS5lTqcBXSngJEaGlMcMc/BXDxaOeZ
         vmvQ==
X-Forwarded-Encrypted: i=1; AFNElJ94R0bKaHoKgx+e0BAxRT0tqQqpJ4T9wVLTygAfEf/F86lMsPbQKL4HBvQZb/z9aKN+AKS8/8Mt3m7oEVK0Cg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDd5cQ6Lsq6KVTIZTw7YzSPLo59J4exCoC+UQFpi2ARJX8k0CV
	VQ9E0oLOST1GiQGsFALBwA5+R1QcJN2gJRDW6nD9rpjfpSANyV3uMawU9IMs2L8xQQ3dzVAFX8o
	ZXXWupA5JN4DkZPktxOATZytTEhFVAW2PQZ5fXxTGw07WO0S2l50o3dpO4ZJnlduM+naU
X-Gm-Gg: Acq92OFNqXz4ZqXXjqJTgUaw8U8I8yoGqhUooQEwkDf9pA9zcw7/R63t0n5HVMDfMIz
	XM24MOWxcVfiAEozXA5UmxFTArVJlKNsoDIe9Zpl7nCQvhKovEBrUsJ8Ms4OdEZpc1GVP/WmUJN
	Xq4/xTUAJe6jVrQMGEIBkLRFnzT5P8y1RT3QmJYU03Yju2/FdI/XZVQFTkglsT6BRsoyBoKVjXD
	Sq8He12h6t0WKKhlqCJKrtRjF1dvBq/CHDElZSBEdfF7JoRatkOIcJPyKII08PcjxEdH1Md8ZQX
	vcxa0p2bYyOD/Gfx4Mkqtehut8FVCRpgkdelaNG73iOJDc44wZhkyDiFYW9dlFg9Ec3hU60wY7u
	g54KiUIda9dkpdkPMS3C+/VTEdK79HzuNxW0x60bv8MywlPL9k5NkSg==
X-Received: by 2002:a05:600c:a117:b0:490:c2a3:23d0 with SMTP id 5b1f17b1804b1-490c2a32441mr202152515e9.35.1780948506587;
        Mon, 08 Jun 2026 12:55:06 -0700 (PDT)
X-Received: by 2002:a05:600c:a117:b0:490:c2a3:23d0 with SMTP id 5b1f17b1804b1-490c2a32441mr202152225e9.35.1780948506137;
        Mon, 08 Jun 2026 12:55:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd663sm484058135e9.10.2026.06.08.12.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:55:05 -0700 (PDT)
Date: Mon, 8 Jun 2026 15:55:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Gregory Price <gourry@gourry.net>, Lorenzo Stoakes <ljs@kernel.org>,
	linux-kernel@vger.kernel.org,
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
Message-ID: <20260608154658-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <6a2f93e4447e55ada6ccf0f4d5c64e8d41a848d4.1780906288.git.mst@redhat.com>
 <aias_qh3wR-Xkf6T@lucifer>
 <aibpL3REDdQ8Vhys@gourry-fedora-PF4VCD3F>
 <aicMl3hPJMgOkfSv@casper.infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aicMl3hPJMgOkfSv@casper.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LUTdwATD4EjvYn4MDdNENNmJNGo7apCr_oDQ7tF8NWU_1780948507
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 07:40:23PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 08, 2026 at 12:09:19PM -0400, Gregory Price wrote:
> > On Mon, Jun 08, 2026 at 01:00:17PM +0100, Lorenzo Stoakes wrote:
> > > On Mon, Jun 08, 2026 at 04:37:48AM -0400, Michael S. Tsirkin wrote:
> > > >
> > > >  void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags,
> > > > -		     unsigned long user_addr);
> > > > +		     bool zeroed, unsigned long user_addr);
> > > 
> > > host_zeroed or something would be more appropriate no?
> > > 
> > > But in general do we need to propagate this around, can't we derive it from
> > > the page zeroed flag?
> > > 
> > > It's really confusing as to _which_ zeroing this refers to, it seems the
> > > only one relevant here is the VM host zeroing but that's completely
> > > non-obvious and now everybody using these functions with the extra param
> > > will simply have to happen to know this.
> > > 
> > > If we could find a way to avoid this propagation that'd be ideal.
> > > 
> > > Failing that, making it clear this is _only_ for vm host zeroing would be
> > > better, but then maybe we need to think about how we could encode this in
> > > some other way, e.g. passing alloc_context perhaps?
> > > 
> > 
> > This is unaddressed feedback from 3 version ago:
> > 
> > https://lore.kernel.org/linux-mm/agXYbcuQYooG74pb@gourry-fedora-PF4VCD3F/
> > 
> > We can infer all of this from snapshotted page flags and propogate those
> > around.  This is infinitely more useful than just a single flag being
> > pulled out into a boolean, and more extensible.
> > 
> > void
> > post_alloc_hook(struct page *page, usigned int order, gfp_t gfp_flags,
> >                 uint64_t pg_alloc_flags, unsigned long user_addr);
> > 
> > 		^^^ page_alloc.c internal falgs only
> > 
> > Once the allocator gets a page it wants to return, it can take a snapshot
> > of the flags at that point, and then doodle all over the flags as it
> > goes through the page setup prior to return (include the post hook).
> > 
> > Haven't seen a reason why this shouldn't be done this way.
> 
> I'd tuned out this awful series since it'd become apparent that my
> feedback wasn't going to be taken seriously.

Sorry about that.

> Good to know I shouldn't
> take it personally because he does it to you too.
> 
> I think it's apparent that Michael has no understanding of the MM.

It's a bit of an overstatement but I'm more of a networking guy, yes.
What I freely admit I don't understand is why I have to refactor all of mm
first.

> So we should start again with the architecture.  Let's look at the
> problem that he's trying to solve:
> 
>  - The hypervisor has zeroed the memory that it passes to the MM
>  - But the MM then zeroes it again before passing it to userspace.
>  - We want to avoid this
> 
> Let's make sure that's the actual problem before going any further.
> Because I do have a design that will satisfy that without doing this
> insane level of invasive change, but if that's not the problem, there's
> no point wasting my time writing it up.

Yes that's exactly the problem I was trying to solve. Early RFC versions
didn't do this invasive change:

https://lore.kernel.org/lkml/cover.1776689093.git.mst@redhat.com/


But I was asked to refactor mm first and implement the optimization
second.

Sure, glad to hear what the design is.



-- 
MST

