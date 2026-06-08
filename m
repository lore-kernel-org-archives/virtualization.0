Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B03A9DA1;
	Mon,  8 Jun 2026 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911852; cv=none; b=o9WUKDUQaje08tYQMagU/mXKw7LLJRcdDnzNYNwZaXPG6WTn9+mOio5qR/elQNauSYCSyFLpHEGg11FFV3U1qtkj4pu7WWthBYj9XXV7irvGpPJTHASt2//eUJngn0PvilTBWFtG/uYRTa28UZvr3e28fuS30A1+HEyd0AnUrW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911852; c=relaxed/simple;
	bh=h+vinqqEi4Xg+UEnDlO7d+4hiLqGjdUbdU4uHPbXLnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3nze+BALTLUf8rol7x8IOUlEf7NUTOk1gSpcqNLHxZy8U6enXNZ2irfZESAlIGiHzmVzFW1yMjVEPZsM39cki1EODW5dtMRHme/nOV1i0TAg6LVqnxm/LixXHeppadrpCMFDezuMxgN9USTbYSdGLJxdEduQNblkVYqwvCdChQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMvyeZW5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMvyeZW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535101F00893;
	Mon,  8 Jun 2026 09:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780911851;
	bh=17m8mwsfA3GCBclFS0NKJ16jnmOTO1fnZAeW+abmcCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AMvyeZW5thkSCuPZGUdZYSNC2hm5d3bonc7xsD0+/P9v89ByLDRGzdevN0P96qemF
	 kyMJVco52PvR1bRNqX+K9x6Ue3uLGss+4arXKeJHILVAe+oOy9JlGNRuM1P4/iyb6V
	 /fv5pm1zatWy/yY/Rxkt8lElYDg/AfnH23/XgvexjWWOns52opKebab4yacK5qudy8
	 JUnir+CNDx5FbkciMHezSim9iwtJDb/S5XZGMXHMe5+hXzcSBAI8wdUJ8zbZGa9uV3
	 uh0siT5xbopvDcEFFeSNTAQ5fceK54Szx5OJQSqfdckrVt5Cf3aSA7Z/eZ9Ybv0lYs
	 vQjDiJZr6npbA==
Date: Mon, 8 Jun 2026 10:43:58 +0100
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
Subject: Re: [PATCH v10 01/37] mm: mempolicy: fix interleave index calculation
Message-ID: <aiaI4Of97oH5YTbi@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <f5b1dcc97baae7183e96743873b943315d93cdb6.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b1dcc97baae7183e96743873b943315d93cdb6.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:34:06AM -0400, Michael S. Tsirkin wrote:
> The NUMA interleave index was computed as two separate terms:
>
>     *ilx += vma->vm_pgoff >> order;
>     *ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
>
> This has two problems:
>
> 1. When vm_start is not aligned to the folio size, the
>    subtraction before the shift lets low bits affect the
>    result via borrows.

This feels really vague. Do you have examples of where the calculation has
been impacted like this?

How is this a problem that affects things in practice?

>
> 2. For file-backed VMAs, shifting vm_pgoff and the VMA
>    offset independently loses carries between them, giving
>    wrong chunk indices when vm_pgoff is not aligned to order.

Similar comments to the above. An example would be helpful here.

>
> Combine into a single expression that adds vm_pgoff and

Combining this kind of thing into a single expression is the complete
opposite of what we want to do when refactoring code. No thanks.

> the page-granularity VMA offset first, then shifts once:
>
>     *ilx += (vma->vm_pgoff +
>             (addr >> PAGE_SHIFT) -
>             (vma->vm_start >> PAGE_SHIFT)) >> order;
>
> For anonymous VMAs, vm_pgoff equals vm_start >> PAGE_SHIFT,

This is completely incorrect.

For anonymous VMAs:

vm_pgoff = vm_start_at_first_fault >> PAGE_SHIFT.

So if you remap a _faulted_ VMA, the vm_start changes, vm_pgoff does
not. The two terms can be COMPLETELY independent.

> so the vm_pgoff and vm_start terms cancel and the result

No, they do not.

> reduces to addr >> (PAGE_SHIFT + order), same as before.

No, it doesn't.

>
> For file-backed VMAs, the sum vm_pgoff + (addr >> PAGE_SHIFT)
> - (vm_start >> PAGE_SHIFT) gives the file page offset of addr.

That's the page offset in a VMA for both anon and file-backed?

(addr - vm_start) >> PAGE_SHIFT is the page offset into a VMA (canonically
determined by linear_page_index())

> Shifting by order gives the correct file chunk index.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

You're claiming we have an incorrect calculation here, but are not
providing a Fixes patch or Cc: stable or sending this separately as a fix?

> Assisted-by: Claude:claude-opus-4-6
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>  mm/mempolicy.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 4e4421b22b59..d139b074a599 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2048,8 +2048,9 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
>  		pol = get_task_policy(current);
>  	if (pol->mode == MPOL_INTERLEAVE ||
>  	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
> -		*ilx += vma->vm_pgoff >> order;
> -		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
> +		*ilx += (vma->vm_pgoff +
> +			(addr >> PAGE_SHIFT) -
> +			(vma->vm_start >> PAGE_SHIFT)) >> order;

This is horrible code. Not only are you doing everything in a single
expression for some reason, you're also making the parens confusing and not
explaining what you're doing here at all.

The code before was at least tractable, this is objectively making it
worse.

And anyway, the canonical way to find the page offset into a VMA is
linear_page_index():

static inline pgoff_t linear_page_index(const struct vm_area_struct *vma,
					const unsigned long address)
{
	pgoff_t pgoff;
	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
	pgoff += vma->vm_pgoff;
	return pgoff;
}

So isn't a far better solution therefore:

	const pgoff_t index = linear_page_index(vma, addr);

	*ilx += index >> order;

Which has the benefit of being readable, uses the canonical method for
determining page offset in the VMA + eliminates the open-coded stuff?

>  	}
>  	return pol;
>  }
> --
> MST
>

Thanks, Lorenzo
