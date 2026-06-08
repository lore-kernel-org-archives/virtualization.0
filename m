Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758243E3D9A;
	Mon,  8 Jun 2026 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944043; cv=none; b=R0vT0r534dvyyZ+NxqTfOED4yg6smB1sSgHdVQIE17C0I75XSFpk3qcDriwAgKSbmSwQBStK+7Mm1X+VD/wreM5AeKdhXGpBFVakMiNALCbVhrzLXFm9gANL1eXiDK+/UmHiuGxEwBF3Hy5NFhSVyfQdSqdKQTKmZ7vNoqpo12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944043; c=relaxed/simple;
	bh=hcB1CT4YiBdZu/cwa8G+KyIb1D/tSaRxmKREKmbgNT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLbJZVQK6YSBgsT3z/6Z0HxJ78yJxCdePBoTb2zPhOfxHgdrR6ynFjPtFZq/ygrK1auuzjHepldePBYWen2A0LOIGMOGsuLsyTLS7PHD6IvHvYO2d3OCgwEry2TC9romDunfHoeENQLfM+YMqEU44HDvxU7cGQjwmgMe+6uVcwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rWW0Da2A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rWW0Da2A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rODWarQ33toh6GcLQ0egZ0dIkhPTmQcNE0V/AVwOXkk=; b=rWW0Da2AKVtPEHGBOef5L01skU
	N3t2UUEzlb7SayICRkQkZtyv0Eox7bGJhzCajVs5gnSV27boOClCc61KmNpFZRBACCFxkEFvmGkrv
	/zQTGIsktWdqxilC3t+6sFapdX3dJNBzIL1u0Uzmsm3x+AGd0NEPBJxsD2oyeb3ClNZj0qvAS640T
	w1zpRyyRV4yxNQvF5wi0wmhqHNnP5XDfQDOfmAdyxrneYMsKz4TtUX2VQDpjR3qD+2dVmHoUjwTap
	ixTgydaKkY5IrrN/U+mBDg4hNAJ8b/vIvQwr5GmlOQF9MB4UnN1j88fMYdsZq53WSyzUJkdhNjloI
	9tB51GZA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWetb-0000000EEOU-3b9P;
	Mon, 08 Jun 2026 18:40:23 +0000
Date: Mon, 8 Jun 2026 19:40:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
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
Message-ID: <aicMl3hPJMgOkfSv@casper.infradead.org>
References: <cover.1780906288.git.mst@redhat.com>
 <6a2f93e4447e55ada6ccf0f4d5c64e8d41a848d4.1780906288.git.mst@redhat.com>
 <aias_qh3wR-Xkf6T@lucifer>
 <aibpL3REDdQ8Vhys@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aibpL3REDdQ8Vhys@gourry-fedora-PF4VCD3F>

On Mon, Jun 08, 2026 at 12:09:19PM -0400, Gregory Price wrote:
> On Mon, Jun 08, 2026 at 01:00:17PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Jun 08, 2026 at 04:37:48AM -0400, Michael S. Tsirkin wrote:
> > >
> > >  void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags,
> > > -		     unsigned long user_addr);
> > > +		     bool zeroed, unsigned long user_addr);
> > 
> > host_zeroed or something would be more appropriate no?
> > 
> > But in general do we need to propagate this around, can't we derive it from
> > the page zeroed flag?
> > 
> > It's really confusing as to _which_ zeroing this refers to, it seems the
> > only one relevant here is the VM host zeroing but that's completely
> > non-obvious and now everybody using these functions with the extra param
> > will simply have to happen to know this.
> > 
> > If we could find a way to avoid this propagation that'd be ideal.
> > 
> > Failing that, making it clear this is _only_ for vm host zeroing would be
> > better, but then maybe we need to think about how we could encode this in
> > some other way, e.g. passing alloc_context perhaps?
> > 
> 
> This is unaddressed feedback from 3 version ago:
> 
> https://lore.kernel.org/linux-mm/agXYbcuQYooG74pb@gourry-fedora-PF4VCD3F/
> 
> We can infer all of this from snapshotted page flags and propogate those
> around.  This is infinitely more useful than just a single flag being
> pulled out into a boolean, and more extensible.
> 
> void
> post_alloc_hook(struct page *page, usigned int order, gfp_t gfp_flags,
>                 uint64_t pg_alloc_flags, unsigned long user_addr);
> 
> 		^^^ page_alloc.c internal falgs only
> 
> Once the allocator gets a page it wants to return, it can take a snapshot
> of the flags at that point, and then doodle all over the flags as it
> goes through the page setup prior to return (include the post hook).
> 
> Haven't seen a reason why this shouldn't be done this way.

I'd tuned out this awful series since it'd become apparent that my
feedback wasn't going to be taken seriously.  Good to know I shouldn't
take it personally because he does it to you too.

I think it's apparent that Michael has no understanding of the MM.
So we should start again with the architecture.  Let's look at the
problem that he's trying to solve:

 - The hypervisor has zeroed the memory that it passes to the MM
 - But the MM then zeroes it again before passing it to userspace.
 - We want to avoid this

Let's make sure that's the actual problem before going any further.
Because I do have a design that will satisfy that without doing this
insane level of invasive change, but if that's not the problem, there's
no point wasting my time writing it up.
