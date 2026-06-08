Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9000E2D8DC2;
	Mon,  8 Jun 2026 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928105; cv=none; b=qMkbtfWEwH5Uhx0TnzyUBMdJlilIkiQMsVY1ZWEnoGcq3wbOkxY7jTzthWF1tF0oAQdZNWywxRNLLGX+9ZgPgLFEGDQER3EQdSh+qDtD+Wf9JTNwREUFYD8+eyztFxJotu8sm9xij5Wr5MQq7EwlNRAhlWkdN6Oiw3OzOl6nCKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928105; c=relaxed/simple;
	bh=IidshmeizibIq1+XUfmlh2sq6jNd8cPMU52ECg4UHJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qye6aZAVeG2pDZ//nRLX/jUz9Db1+9Y1hzQulrHIS8CqjPRWgW3OA/jWAazdySguONBgsz6hHeDtZHi24o/sebHcrIKArWXC4lEhT/yMtw46fudow8aZpa+lUeejVdT3gk0k+4YZW3IQAatWw4jWIJtvZS4nG4/YSnkX4gnD95w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrSQ6NGW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrSQ6NGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E7E1F00893;
	Mon,  8 Jun 2026 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780928104;
	bh=+JjRMFYZ9bfnyvS4nS4o2iK2w7M52sPr8xosvfHngF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lrSQ6NGWbgbwU+TrG/4asikVamSg3+rK6G39mFxSJGIY2txePMoj79z5wzKfUb98d
	 jWyaZ3wrYE7qZnx6lbMDlzmvoliM9J1192Th8k0MtLS9xbh73nM+0pEV7mcI5qNKDA
	 EUtZQkEIgtQcJUhqW5ZS0lkciWP6+l+H06X3NvRNS3W/sfSxoHWaaPNHNl5UBpZ7u0
	 5EF4iH6EsBBhZGCJ+U89dZiw639QkCq5Iv3mFjpiGYIxrK65bjTZ1T4kWZ5FZfhmhm
	 EEOwEbeU3LSRqRgQHrsv6UCcYlM4h2uZ1kFEDMvNrIuW4U8acH1N3rtFb1qdx9SoqK
	 gHO+8SMrX8MUg==
Date: Mon, 8 Jun 2026 15:14:51 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, virtualization@lists.linux.dev, 
	linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>, 
	Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v10 02/37] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
Message-ID: <aibMs9DXuhH_5F2Z@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <df06b66fe4ff8e925ee0714955abc2183a727b90.1780906288.git.mst@redhat.com>
 <aiaOZoa2vSCz_0wY@lucifer>
 <20260608094153-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608094153-mutt-send-email-mst@kernel.org>

On Mon, Jun 08, 2026 at 09:48:34AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 08, 2026 at 10:43:21AM +0100, Lorenzo Stoakes wrote:
> > On Mon, Jun 08, 2026 at 04:34:23AM -0400, Michael S. Tsirkin wrote:
> > > TestSetPageHWPoison() is called without zone->lock, so its atomic
> > > update to page->flags can race with non-atomic flag operations
> > > that run under zone->lock in the buddy allocator.
> > >
> > > In particular, __free_pages_prepare() does:
> > >
> > >     page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
> > >
> > > This non-atomic read-modify-write, while correctly excluding
> > > __PG_HWPOISON from the mask, can still lose a concurrent
> > > TestSetPageHWPoison if the read happens before the poison bit
> > > is set and the write happens after.  Follow-up patches in this
> > > series add similar non-atomic flag operations as well.
> > >
> > > Fix by acquiring zone->lock around TestSetPageHWPoison and
> > > around ClearPageHWPoison in the retry path.  This
> > > serializes with all buddy flag manipulation.  The cost is
> > > negligible: one lock/unlock in an extremely rare path
> > > (hardware memory errors).
> > >
> > > Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
> > > in this file operate on pages already removed from the buddy
> > > allocator or on non-buddy pages (DAX, hugetlb), so they do not
> > > need zone->lock protection.
> > >
> > > Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > Can we have Fixes: and Cc: stable and also send this separately please?
> >
> > These patches seem like unrelated fixups that you've discovered along the way,
> > and don't belong as part of the already rather large series, unless I'm missing
> > something here.
> >
> > Thanks, Lorenzo
>
> I think you are mising that they are a dependency, not unrelated.

Then say so.

> For example, this issue gets worse with the patchset as there are more
> places that manipulate flags without atomics. No?

It's your job to make that case, not mine.

>
>
> You are welcome to send this to stable, but I think stable rules
> preclude theoretical bugfixes.

It's a dependency but also theoretical?

>
> As for Fixes: the issue has been there for decades. I wouldn't know
> what to attribute it for.

Again, your job.

>
>
> I guess I could send these separately, too, why not. Not sure
> what this accomplishes, but hey.  But is that an ack? You want
> this fix merged even before the feature?

I already made the case as to why, as have other maintainers.

If you need to review what an ack looks like please consult
https://docs.kernel.org/process/5.Posting.html

Thanks, Lorenzo
