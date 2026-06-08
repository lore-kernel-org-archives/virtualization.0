Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB90C366816;
	Mon,  8 Jun 2026 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912622; cv=none; b=ImnuJ4LJQeJLSQE5Gs7Ns2py6cRZ1J0DB/cDr41mKUGOjDHow/kx8JVcCTbPV6D0UXQ+hFCaHuNYJelVaqETChNPLzeMtHMOm39st89oLs3SNeOJPql07vhHCOM76NXYJ7S9YKy9UgYBY/KLpgWhIO4plNDAZeE3sqhns0LMi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912622; c=relaxed/simple;
	bh=wr7Dk+ou0ZV3BSYFv5uMYxFoA+OegcSjLKOYXbJfg4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecPdRGjEtos14fKGFDevL8VY6iJXoMvpYDW+kbvJrSTJMF6RzX8hKd+3UoBMdcFnUqf0P12TMkVlCpMIAFPll/MNqajUgzN4xdYLQAJ/HG85g7OYUzdmK3IAnxJEU2Z3kXpE0tBFDApioYdLfcbL6dlEPhUoXNsW5oE5PNZ6HcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkTtnLeN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkTtnLeN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18B71F00893;
	Mon,  8 Jun 2026 09:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780912621;
	bh=P1+02I8/mz51EwWNuh6VrtfUH5JJ8Oucs5gbUQNRuzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UkTtnLeNlq2eQb6waQhRAxcdvreXzCydPiLS98J0WqRAb5SmaejJ9aM7CLiNGo2Bi
	 kEln4O1pbX0mexH/ttKADhNMlt4M8FhyEXL3oefVBhb0euY+qYUIhUgni4T/ljYKWx
	 PjbGwZm7xjAomfdSaT/NIuNHt9aC4+E3eEPjshL3qx7ao3xrHiv9qBAaQ2OOKMdaNu
	 Ce1aI0qTrEts39TQm/72ZBoPZ3CY4YGaC96EhVfzHnzwe4OvAG8TM1L1qvmWOQ57yH
	 glYdspkvbrY1ZTAskwYXyDhMeKa7jXyjldLReW+zfzAXgiETtSM0wX7zTkbdtqJ7Vh
	 BZqfqHR1dmhvA==
Date: Mon, 8 Jun 2026 10:56:48 +0100
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
Subject: Re: [PATCH v10 05/37] mm: hugetlb: remove dead alloc_hugetlb_folio
 stub
Message-ID: <aiaQ_I2kxfC2hVsD@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <a9b5764c69269e5c0518e496b057a75354373b43.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9b5764c69269e5c0518e496b057a75354373b43.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:34:57AM -0400, Michael S. Tsirkin wrote:
> Remove the !CONFIG_HUGETLB_PAGE stub for alloc_hugetlb_folio().
>
> The stub is dead code: all callers are in mm/hugetlb.c
> (CONFIG_HUGETLB_PAGE) or fs/hugetlbfs/inode.c (CONFIG_HUGETLBFS),

obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o hugetlb_sysfs.o hugetlb_sysctl.o

mm/hugetlb.c seems dependent on CONFIG_HUGETLBFS not CONFIG_HUGETLB_PAGE?

> and CONFIG_HUGETLB_PAGE is def_bool HUGETLBFS with nothing
> selecting it independently.
>
> The stub is also broken: it returns NULL, but all callers check
> IS_ERR(folio), so a NULL return would not be caught and would
> crash on the subsequent folio dereference.
>
> Remove it now since follow-up patches change the signature of
> alloc_hugetlb_folio and would otherwise need to update the
> broken stub too.
>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Assisted-by: Claude:claude-opus-4-6
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

The logic seems good but you should fix up the commit message. With that
fixed:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

Thanks, Lorenzo

> ---
>  include/linux/hugetlb.h | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 5957bc25efa8..1f7ae6609e51 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1123,13 +1123,6 @@ static inline void wait_for_freed_hugetlb_folios(void)
>  {
>  }
>
> -static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
> -					   unsigned long addr,
> -					   bool cow_from_owner)
> -{
> -	return NULL;
> -}
> -
>  static inline struct folio *
>  alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
>  			    nodemask_t *nmask, gfp_t gfp_mask)
> --
> MST
>
