Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8552F1FDF;
	Mon,  8 Jun 2026 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915203; cv=none; b=W+MD9ycdZmJxBUlJ54d0fxEcYpIYQ7Nq1zYJakZzQPOyZtL7RChz0eY9f0LUkl7XTedS/i1bv3CyJklWro1Ekh931Vt82G1G6CYywxTjVpBknNxZ/GIsaVC/f/3tsI3zysSHY+rRK/EXPiEKhqgut9YD3AgLbB7tH8uFIwIL0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915203; c=relaxed/simple;
	bh=btZJwMHUgnk5PYk4ULAWb22ShZE2YWRtVyctYPeQcdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw4FVaXlmQnoTiGW9NRcY1CPUXl/LIdrDa7bGYYQ6hPxRHWGOxaH6BySptAJG6plwbfF9trkCUsgCDJKpphI3afRe6pWDeoKSAtALn4uVXnry7srMuvenZCTJaPUz8g0ZCQsKqjxQZhYOWeSv8GbN4ze3kvJX3asZyr+LWzC08s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRZ35HRM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRZ35HRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8131F00893;
	Mon,  8 Jun 2026 10:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780915202;
	bh=UAI22XDH8Rk02hdvoTH5Zr8kOOXybFt3zj/PmpT+vR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dRZ35HRMCB5YSX2evh0CzhDac0sfa/9kUKcQbFlfBcNsqTjaHSKDIzFE6dOYCqSOR
	 BUqJZ+XA9CN8FBP52TGvSNdRnFmOPGzJnBdBc7oufRxFlAre4qCxSYKXJMB48tPDCg
	 +ocEPqSN9xwVrfWctPMv3Rr7rUsD06LgHJGhlhL6pRHwiNyrhwZIn/W8UTd2dW3rX1
	 XqHgCqrrgeiEu2HyAZG17AKzc4n0mZN/ICwW0yAnunJFvWxXe4EprolwzVzG5V2uol
	 /K4Qfq2c8SFn65Y15w92rlVyjpdUDrBvbDnlmzxRCpeVADi7bn0EXdCDRIj3W771IA
	 ZsoN//T+zOjXA==
Date: Mon, 8 Jun 2026 11:39:49 +0100
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
Subject: Re: [PATCH v10 13/37] mm: use __GFP_ZERO in
 vma_alloc_zeroed_movable_folio
Message-ID: <aiaau7RIhkJMS_oe@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <862a59e98104db76ee3998460bfc55e937c218c4.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <862a59e98104db76ee3998460bfc55e937c218c4.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:36:51AM -0400, Michael S. Tsirkin wrote:
> Now that post_alloc_hook() handles cache-friendly user page
> zeroing via folio_zero_user(), convert vma_alloc_zeroed_movable_folio()
> to pass __GFP_ZERO instead of zeroing at the callsite.
>
> Note: before this series, replacing clear_user_highpage() with
> __GFP_ZERO was unsafe on cache-aliasing architectures because
> __GFP_ZERO uses clear_page() without a dcache flush. With this
> series, it is safe if the caller passes a valid user address
> (not USER_ADDR_NONE) to vma_alloc_folio() etc., which delivers

Wait, so now you're making actual correctness predicated on correctly
passing the right user address??

> it to post_alloc_hook() for the dcache flush via
> folio_zero_user(). It is only unsafe if USER_ADDR_NONE is passed.

Yeah, ok I'm beating a dead horse a bit here, but no to this approach.

>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  include/linux/highmem.h | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index d7aac9de1c8a..8b0afaabbc6e 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -320,13 +320,8 @@ static inline
>  struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>  				   unsigned long vaddr)
>  {
> -	struct folio *folio;
> -
> -	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
> -	if (folio && user_alloc_needs_zeroing())

So now we are unconditionally zeroing the pages even if
!user_alloc_needs_zeroing()? You don't mention this in the commit message
and it seems like it'll regress performance?

> -		clear_user_highpage(&folio->page, vaddr);
> -
> -	return folio;
> +	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO,
> +			      0, vma, vaddr);
>  }
>  #endif
>
> --
> MST
>

Thanks, Lorenzo
