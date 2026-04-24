Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7B2DF6E9;
	Fri, 24 Apr 2026 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056082; cv=none; b=hoWyHJ5g7kjBMjtWrylPMY0BDJ2Fu4hvAiWMccjwR06+Ct8e9oUrJqvdpvKniuDzOvByAJBXnpbRmNbc37ycmHK8fvF/eF1R/8Dgtw7ZROSESjtrIpoC0ac9svcECXfTaIwukgTycbMvjjor+cLx0ymP1mRlstFvaqMJXQZF2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056082; c=relaxed/simple;
	bh=CBlRl+YpPrrcRVNfUoIocM7HYY5h0Ecdd85gOHI3Zxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1LmGdP2Fm05pkPiHOkoFQMXGLw4PThymMJAtlaXTCwYYOhwdVRcxkwz/Q/DqBo/A7cTuBdDDj1cyXMwtM5he3L8sLxhQWmK2Zo/Rjiwu2Rx/7R/sjgTrI7cpm5thebMq+QiqoU6fLhg+8jyXdE5yDYMDlp1DhUkeDSF4fJ0yy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FFGMzRxr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FFGMzRxr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0jMwEKotAvq2OL4OEp6t+lhTaMljgnAVvfhivquqvtU=; b=FFGMzRxrQI3FU/6XH/nP3cw2bz
	KTetZpzPQ/VUg6/QrjDvqOe4Kl13/C7miXnNFgHRjwkpTrCVViYOVdoKuZBRwmZ79YPuMUmz/XTU4
	hyPOfm9emkeL8t66v2Lm5nrkl1xcHWvytvpkul29rd6HDaMa2wfaumz4p2fAV6kl2shEqmx8lHiG7
	3yqDwh4QyR9k+SJ8mXKdWJ2/PYlkGtdcVclNsYhDUBPetd7muaRzLy2BtB0d9RhpKVsM5RTFS8e72
	AbvElS65WHKkUDrBlyuJAuRDP4OZ0C72Xpve6Q9/yKqPVeDZFjqQ/v4dJEcI/iADLkpRqbxDYMsPy
	nUzhEk/w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGLSZ-0000000FeLx-2qnt;
	Fri, 24 Apr 2026 18:41:03 +0000
Date: Fri, 24 Apr 2026 19:41:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 01/19] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <aeu5P1bZW3yEH54t@casper.infradead.org>
References: <cover.1776808209.git.mst@redhat.com>
 <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>

On Tue, Apr 21, 2026 at 06:01:10PM -0400, Michael S. Tsirkin wrote:
> Thread a user virtual address from vma_alloc_folio() down through
> the page allocator to post_alloc_hook().  This is plumbing preparation
> for a subsequent patch that will use user_addr to call folio_zero_user()
> for cache-friendly zeroing of user pages.
> 
> The user_addr is stored in struct alloc_context and flows through:
>   vma_alloc_folio -> folio_alloc_mpol -> __alloc_pages_mpol ->
>   __alloc_frozen_pages -> get_page_from_freelist -> prep_new_page ->
>   post_alloc_hook

I don't like this.  I think we should instead lift the zeroing from
post_alloc_hook() to the callers of __alloc_frozen_pages().

I don't understand why you want to remove the double-zeroing of memory
when the user has asked for zero_on_alloc.  They asked for stupid things,
let them bear the cost.
