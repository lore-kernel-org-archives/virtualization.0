Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313C3399365;
	Tue,  9 Jun 2026 03:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780977511; cv=none; b=aS6hPJPyLsSN1bEgiWNp7TUqW9+uFksJ3Vqzq9ShsJGrw9PPHJIjL/a39IWTOxqpTS2tfhTKBNZVyBY+11DPOVNa3Qr8hYBWNSyS3kYFBfqgHZTmKPptiKlws7co9iTeYz0ZJZr/XxmoM+gRHpPdqZTLBpePE7WKVFfziSIegjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780977511; c=relaxed/simple;
	bh=mwY2NjYXCxYXzZEWyv7wKd5PciLtK4+ro8oCl5A2e4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vme127NQJy31e/lGnB9PsG74cRg6L+qbec3h2ORFsoCkBNHl2I9aonzQZ2pnx1iPBUKHNedday8S40Z/dVhxgm3M4U2eEoZhfhu8YUXc+aTfj/DJZGjflQUqANPCjLqOZ+ctu6CtrQw1lJHnFMce931ZFGaL2uuHNkeS54g7o8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KVlTeVzl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KVlTeVzl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xDehR9KUPqQoyrvx8dJ31pkODcCvkj2FH2Lxm05cnXs=; b=KVlTeVzl9gptlTf4cf7ti0YqgJ
	7kk+WIHxe9bLMr9/Hp/bFKPomJ47VM1tIeLfJ7rJQUI08BwrhmkvK6qFmt6IMUzZYsoYkIxw3B7zi
	JWPXVCZ7AISi190rWHuQ09w56bLkkAbrvCWACJPXO/yATVyEjvqpfYE2Yp0GFLtYEOfte24XHgzJE
	+0tiFEB2S+OtQv+0nDJeD+Qz/XFxNL2jSOmqPh7RGxbo2rHbqO350yEC2x/aITEp3N8tYGySUI4zH
	YH4iSQtf+HUkHagh3FteqaTUXJVBL8b9ARb1RHHDhWxulKlgxlRbKKv8+cPZuIYWZcFexiH9GmPHc
	W8Iz1jWg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWnbS-0000000Ewtw-1GGB;
	Tue, 09 Jun 2026 03:58:14 +0000
Date: Tue, 9 Jun 2026 04:58:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
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
Subject: New design
Message-ID: <aiePVsiV-w-IZ8A4@casper.infradead.org>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780906288.git.mst@redhat.com>

OK, here's how I'd structure this:

1. Introduce PG_zeroed for buddy pages
2. Set it if init_on_free is set
3. Set it from balloon driver

https://lore.kernel.org/lkml/c7094de807c0e963526686e1d245bc76193b1a92.1776689093.git.mst@redhat.com/ 

but add FPI_ZEROED instead of an extra bool parameter.

4. Introduce page_is_zeroed like this:

static inline bool page_is_zeroed(const struct page *page)
{
        /*
         * lru.next has bit 2 set if the page is already zeroed.
         * Callers may simply overwrite it once they no longer
	 * need to preserve that information.
         */
        return (unsigned long)page->lru.next & BIT(2);
}

(you'll notice this is similar to page_is_pfmemalloc() but it doesn't
need to be in mm.h)

This step is going to be a bit fiddly.  We weren't expecting to return
multiple flags in page->lru.next, so clear_page_pfmemalloc() just sets
page->lru.next to NULL.  So somewhere we need to make sure that
page->lru.next is definitely NULL, and then allow both the zeroed and
pfmemalloc flags to be set in it.

The important part of this is that it allows the zeroed flag to be
returned from the page allocator without introducing pghint_t like you
did in v2.

5. Now you can start skipping various zeroing steps higher in the call
chain.

I understand David's disgust with vma_alloc_zeroed_movable_folio()
but that is surely a separate cleanup and nothing to do with this
patchset.
