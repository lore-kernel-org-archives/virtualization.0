Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEFC24293C;
	Mon,  8 Jun 2026 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909939; cv=none; b=RY85r4uKPp2CCRYBdpY+n3wa+FCFtheR9ipd5A0fWuHZvsOrW5p3k9x3448aIwukJiDoyIAFrS5nZ7zXKow1iv/f/Bs7e5nDa9pTTBS9PEg3B+9ikJi1/A/u5WHB38yxoSRZFfzvEnPNAnokMXN3r+c+HgXpUNCMujbHYVp8dkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909939; c=relaxed/simple;
	bh=ftXaZua83dJsx0OG5dqxJYf/GwMi3VCYayOBdI9497o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EraSQ7QpMGDxg7t8f+ConiXurZaQitKv4U3q8PekK8RfIRHXpxYlqkD5nFRmiTFKNMl4kMtnNL6JKHWUSWZB1sZ/1EYURxMlHgtmlNav88zye/Yq3Hfh49WjZXm9MC6CtKAUgxcqRqKRbRinwlUZEapRPuUBhJRxN6lRdQDQHbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eU9PyMYQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eU9PyMYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1891F00893;
	Mon,  8 Jun 2026 09:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780909938;
	bh=0iERoe27+MYrdO8H4QFZ3r3a7HKS5A6vCqgmgUIRzcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eU9PyMYQzKJA1f/XM2FG2/vwX3G4uJSPuHMlzSIliNNuxmbbaZwSjPPzEqTFxM+Sm
	 54Y7m4qdd1/jN7vvRCkSRUUwqgTJoPa3aS6od0Hb6imqUHhO09OuEd+s5XjOzqEYSo
	 cSBsLSe1CO+5F47uRRvmK6mASknS0kWeI37+QjBgB3pCbqFmO/xtO2BhvupYikyj3x
	 dqZ5mBvfbYMHajtagemxACsY1sVSuzZOBiN6QrGKrB2//bDxLDxOmCpv7491JGZWVQ
	 Ygk0oNSCrXvQZfMiH8aUea91VJN1vkVVrdZNDno1NwWOQqNTZDyYRyj1WGTun387UA
	 ZRVVZfNddtAdw==
Date: Mon, 8 Jun 2026 10:12:05 +0100
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
Subject: Re: [PATCH v10 10/37] mm: add folio_zero_user stub for configs
 without THP/HUGETLBFS
Message-ID: <aiaEOe0j0hIeNa31@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <60d48e3c6f03238f385cdb8e48f6d8ffd4cff387.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60d48e3c6f03238f385cdb8e48f6d8ffd4cff387.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:36:02AM -0400, Michael S. Tsirkin wrote:
> folio_zero_user() is defined in mm/memory.c under
> CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS.  A subsequent patch
> will call it from post_alloc_hook() for all user page zeroing, so
> configs without THP or HUGETLBFS will need a stub.
>
> Add a stub that uses clear_user_highpages() with aligned
> addr_hint.

It's not a stub? You're doing default behaviour for !THP || hugetlbfs?

>
> Without THP/HUGETLBFS, only order-0 user pages are allocated, so
> the locality optimization in the real folio_zero_user() (zero near
> the faulting address last) is not needed.

The 'real' folio_zero_user()?

But they're both real? In what sense is this unreal?

This commit message is pretty confusing.

> This also matches what vma_alloc_zeroed_movable_folio currently does.

You're also not explaining why we need a random new file just for a single
define, this is really weird?

And please don't add new files without adding an entry to MAINTAINERS.

While we're here, can we just move this function somewhere else? memory.c is
like the junkyard of mm. Maybe util.c.

Anyway this seems like it belongs in mm/internal.h.

>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh
> ---
>  mm/folio_zero.h | 18 ++++++++++++++++++
>  mm/page_alloc.c |  1 +
>  2 files changed, 19 insertions(+)
>  create mode 100644 mm/folio_zero.h
>
> diff --git a/mm/folio_zero.h b/mm/folio_zero.h
> new file mode 100644
> index 000000000000..c135b3a34da8
> --- /dev/null
> +++ b/mm/folio_zero.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef MM_FOLIO_ZERO_H
> +#define MM_FOLIO_ZERO_H
> +
> +#include <linux/highmem.h>
> +
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
> +void folio_zero_user(struct folio *folio, unsigned long addr_hint);
> +#else

No comment explaining what this does in comparison to the THP/hugetlbfs version?
Let's have a kdoc comment here.

> +static inline void folio_zero_user(struct folio *folio, unsigned long addr_hint)

So we have a folio (physical metadata) and an adress hint?

> +{
> +	unsigned long base = ALIGN_DOWN(addr_hint, folio_size(folio));

const please.

> +
> +	clear_user_highpages(&folio->page, base, folio_nr_pages(folio));
> +}
> +#endif
> +
> +#endif /* MM_FOLIO_ZERO_H */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6d3f284c607d..0943ab724032 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -17,6 +17,7 @@
>  #include <linux/stddef.h>
>  #include <linux/mm.h>
>  #include <linux/highmem.h>
> +#include "folio_zero.h"
>  #include <linux/interrupt.h>
>  #include <linux/jiffies.h>
>  #include <linux/compiler.h>
> --
> MST
>

Thanks, Lorenzo
