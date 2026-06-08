Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E11367B6F;
	Mon,  8 Jun 2026 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918201; cv=none; b=BaJQopSRK1DCCp+VJgSx4Sx9tDPd3rUZxw6ub0RBN5qgqlqyEaG2XL7S+cZb7ZzSBykhoq4z8LtpFTKLVmKWH3kRuoakIJMH25zs2kFT7osctM9Eb1bzBaB08U8DLNbWscux7Fc7Vd6TtbOKLK0JhkbDngdbUwvs5tDnvQA0bKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918201; c=relaxed/simple;
	bh=Gl9FbyJ+M2GL+aZlQplx/dhqscyZ80f+TcGXgHZ2ZdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtgrGEC8MtppkTJDx74BFlYBx5A+4HppjuPJ0qX7l+E34enePUZW3wCgNe9qWNq07ZUBTGFx6fUUH0xCl7g5bt3CWR3uvKiAY+ZcFRY+U3TXPkl1DGo9okA7f2FReWsyXoXJ22hFoErwXM2Oai2WzPu9usWIkBauYMVjZlcaj6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASH3KSrE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASH3KSrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDB71F00893;
	Mon,  8 Jun 2026 11:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780918197;
	bh=/bLoWkKU6zRSNbiRPvCYb7WguBa+jCqnG9JHGzaDK+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ASH3KSrEWKEkMmPU3BX0LMCJuqKW/4pxjDUHNyuaL6SM94st1yY+UBI4goLs68V93
	 xnd7OdESoFQZOMFMdAjzPXWHkxJ8InnA7wG5c78nx6a3uy2I2SZH64W7OLKu1kPhJ3
	 1ghkiAapTMo1jBhiJ0AWK/++JoneEiCgcdMOxQhCr3u0pB4c6BroFlHuit7e75AntZ
	 W/smfPyMqLKIhjogXF4QMwI2r8oBBrTtbOy7b+Ewmtn2N4eq/9WGPSqVsb2d+5kov3
	 vfCEbdxDWwAstJlPPtcCTjrt5Qvli59q9GXn7RtGjvw6c32sHniQ2CeD+5je3KMGe0
	 jKEcDvloXPSUA==
Date: Mon, 8 Jun 2026 12:29:43 +0100
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
	Magnus Lindholm <linmag7@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v10 14/37] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
Message-ID: <aiam0zdR6BJ1HKwP@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <c374d7a35a35eb4bd5ed85f87ff6885fae605fa9.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c374d7a35a35eb4bd5ed85f87ff6885fae605fa9.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:37:08AM -0400, Michael S. Tsirkin wrote:
> Now that the generic vma_alloc_zeroed_movable_folio() uses
> __GFP_ZERO, the arch-specific macros on alpha, m68k, s390, and
> x86 that did the same thing are redundant.  Remove them.
>
> arm64 is not affected: it has a real function override that
> handles MTE tag zeroing, not just __GFP_ZERO.
>
> Suggested-by: David Hildenbrand <david@kernel.org>
> Acked-by: Magnus Lindholm <linmag7@gmail.com>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>  arch/alpha/include/asm/page.h   | 3 ---
>  arch/m68k/include/asm/page_no.h | 3 ---
>  arch/s390/include/asm/page.h    | 3 ---
>  arch/x86/include/asm/page.h     | 3 ---
>  include/linux/highmem.h         | 8 +++++---
>  5 files changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.h
> index 59d01f9b77f6..4327029cd660 100644
> --- a/arch/alpha/include/asm/page.h
> +++ b/arch/alpha/include/asm/page.h
> @@ -12,9 +12,6 @@
>
>  extern void clear_page(void *page);
>
> -#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
> -	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
> -
>  extern void copy_page(void * _to, void * _from);
>  #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
>
> diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
> index d2532bc407ef..f511b763a235 100644
> --- a/arch/m68k/include/asm/page_no.h
> +++ b/arch/m68k/include/asm/page_no.h
> @@ -12,9 +12,6 @@ extern unsigned long memory_end;
>
>  #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
>
> -#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
> -	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
> -
>  #define __pa(vaddr)		((unsigned long)(vaddr))
>  #define __va(paddr)		((void *)((unsigned long)(paddr)))
>
> diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
> index 56da819a79e6..e995d2a413f9 100644
> --- a/arch/s390/include/asm/page.h
> +++ b/arch/s390/include/asm/page.h
> @@ -67,9 +67,6 @@ static inline void copy_page(void *to, void *from)
>
>  #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
>
> -#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
> -	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
> -
>  #ifdef CONFIG_STRICT_MM_TYPECHECKS
>  #define STRICT_MM_TYPECHECKS
>  #endif
> diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
> index 416dc88e35c1..92fa975b46f3 100644
> --- a/arch/x86/include/asm/page.h
> +++ b/arch/x86/include/asm/page.h
> @@ -28,9 +28,6 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
>  	copy_page(to, from);
>  }
>
> -#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
> -	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
> -
>  #ifndef __pa
>  #define __pa(x)		__phys_addr((unsigned long)(x))
>  #endif
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 8b0afaabbc6e..642718a50c27 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -303,7 +303,6 @@ static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
>  #endif
>  }
>
> -#ifndef vma_alloc_zeroed_movable_folio

We're specifying this function unconditionally even though arm64 overrides?

>  /**
>   * vma_alloc_zeroed_movable_folio - Allocate a zeroed page for a VMA.
>   * @vma: The VMA the page is to be allocated for.
> @@ -317,12 +316,15 @@ static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
>   * we are out of memory.
>   */
>  static inline
> -struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
> +struct folio *vma_alloc_zeroed_movable_folio_noprof(struct vm_area_struct *vma,
>  				   unsigned long vaddr)
>  {
> -	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO,
> +	return vma_alloc_folio_noprof(GFP_HIGHUSER_MOVABLE | __GFP_ZERO,
>  			      0, vma, vaddr);

This whole change seems unnecessary?

>  }
> +#ifndef vma_alloc_zeroed_movable_folio
> +#define vma_alloc_zeroed_movable_folio(...) \
> +	alloc_hooks(vma_alloc_zeroed_movable_folio_noprof(__VA_ARGS__))
>  #endif

I don't know why we need to add more of this alloc_hooks() dance when we could
just do:

#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)

Like the existing arch stuff?

>
>  static inline void clear_highpage(struct page *page)
> --
> MST
>

Thanks, Lorenzo
