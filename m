Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD6B230BE9;
	Mon,  8 Jun 2026 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921106; cv=none; b=T1iembBwc2MFjOWKGjBqMrG3BWy5AcYE+FD2x59UuZlPnhbu2lEzqMLllxQ6nuAewSpHELiErcq+BwmBRrzl8XCP52gS1hL3p0a6opB5fnpo35se5M0h9LL5YKqKs5QsKb0Ltxb0qi++Shoxs87d3RBzMNWYRq1t66Zgf+t3K0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921106; c=relaxed/simple;
	bh=0vSZ+f3pLX/uoF2BPwHj+tqybjKHdJ4TTwpVpQAK4KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN0BubEQXAPwEWE96YsL50rY2pX8kAWkvGW+NMAGoOMvyRSg2ki2DqKk5M08BXoZves3vTY2EpGOd3vQ/rwlK+YV+F4oGRP3rrslF9ZH53PAImUDntmg61Afd3qBrvOxBazlLCoDvsVB2TtthceoO/y33kafUSTg0aDt6qkSQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhx34/wY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhx34/wY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544311F00893;
	Mon,  8 Jun 2026 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780921105;
	bh=4bq7322kWx6CdkqZCl5t40hKw6vHtvbzE6Il0jH62XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fhx34/wYyi4qTtqk4QuiP7p33JtlGJpEvv3WVDq4OHpVAN/F67imxKA0NQ0PqHEOO
	 ShQSTE81rARoCwQ9cNRunKxJJ84J+2QO2PhgO/o+PyUyavv7Yst3B14CC7xOqqUZGZ
	 M63vkmttzEJG3+GVuoNTTyrYgclFhpFN3cFQhCxmosN3QKE78i6tIT++nSeHN5PKO/
	 1qzSKEBjkThQMvqNYdB7dYV/Ar8pPs/LlN7E3nYNn96yANKRBbtcyed3o2rbmtMT3v
	 NVdQXSbpCvQ5WhFx0fz4IKTeueDE8+W+Bi+L0den+inJc3U9pCC/5TBx2D0YYS/yFA
	 CMUS8qxjqs+aQ==
Date: Mon, 8 Jun 2026 13:18:12 +0100
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
	linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v10 23/37] mm: page_alloc: skip kernel_init_pages for
 FPI_ZEROED when safe
Message-ID: <aiawax1SS7x4_DEi@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <7de6959a0fb1b255dc9bee2de494f51a6c21e468.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de6959a0fb1b255dc9bee2de494f51a6c21e468.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:38:46AM -0400, Michael S. Tsirkin wrote:
> In __free_pages_prepare(), when FPI_ZEROED is set the page is already
> known to be zero. We can skip kernel_init_pages() if page poisoning is
> not enabled (because poison would overwrite the zeroes).
>
> This avoids redundant zeroing work when freeing pages that are already
> known to contain all zeros.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  mm/page_alloc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 008f1a311c40..e3a7c40c769c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1443,7 +1443,14 @@ __always_inline bool __free_pages_prepare(struct page *page,
>  		if (kasan_has_integrated_init())
>  			init = false;
>  	}
> -	if (init)
> +	/*
> +	 * Skip redundant zeroing when the page is already known-zero
> +	 * (FPI_ZEROED) and page poisoning did not overwrite it.
> +	 * When page_poisoning is enabled, kernel_poison_pages above
> +	 * wrote PAGE_POISON (0xAA), so we must re-zero.
> +	 */

Again, please stop specifying arbitrary hex values in comments, this seems
mostly 'describing what we do here'.

Maybe drop to just e.g.:

/* if poisoned or not zeroed by a virtualised host, zero now. */

or suchlike?

> +	if (init && !((fpi_flags & FPI_ZEROED) &&
> +		      !page_poisoning_enabled_static()))

This condition is absolutely horrible, !(X && !Y), you're making life difficult
for the readers.

'if not both zeroed and not poisoned' is how that reads logically. Which is hard
to understand.

De Morgan's law gives us -> !zeroed || posioned

How about:

	if (init && (!(fpi_flags & FPI_ZEROED) || page_poisoning_enabled_static())

Or preferably something like:

	const bool poisoned = page_poisoning_enabled_static();
	const bool vm_host_zeroed = fpi_flags & FPI_ZEROED;

	...

	if (init && (poisoned || !vm_host_zeroed))
		...

?


>  		kernel_init_pages(page, 1 << order);
>
>  	/*
> --
> MST
>

Thanks, Lorenzo
