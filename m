Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D54A3546FE;
	Mon,  8 Jun 2026 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918541; cv=none; b=FrwCYKzp7dNNAMIwV/4F6ogR09TTY0h5qfq+nch5A0Mcl/XsbVKe2Gm8tqz6i40y3nw0Was1c0p/rbIK5yhJq2n8PwK1uegAXqCcl443EVM/iuckkoy5IRS1DVqq2Vv+1PXZTqHRqF287ysC00vr4NQIlD2iadcZm3Pkaib9WYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918541; c=relaxed/simple;
	bh=ci6OQq+CFcUaBZEhdjWIhzQCTDYwrldsct7EdCH9VzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvmlHbDG4GQq1svNHBRzxJVTcyrABGUPKB9/B/rt92SCq+zkWxkkJbYlPdDHTfPcYJ0Ye0tOQeX8BWcWegyqRt4+dUYm+ProSKuLrTAcqfwI5BAyt2q5se6Ir6qXRaYLveGOQTdbUKEvCHJh9byWUAFqWZmmtmTaPIMyede9BYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEn4Cg4m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEn4Cg4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165351F00893;
	Mon,  8 Jun 2026 11:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780918540;
	bh=+mt/AQPoXVlo6YJRcaj8WIglPtUVRoT7Dfgki2X6jvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UEn4Cg4mDB4ZqeEENfhRLZ7CrCWKslv8smC/a7WmpX/Rw+bW6iFuBZ/DLi5ZVfAvF
	 wDI4SpiPlVUscTRteSxgpmAN61p5Hg3FU/KSPU61RVjIlHU7pDEK3IC7n29gYIrXRI
	 oo5+qthlnghCO4xmG5YrKq/cTvL8zsKwETxVQfDL0TQ/LXe4YEP1PsdT9C7oI0R9ud
	 +TNjaw89uQKCcIaRboc76St9sLzDrrrOuGJOkY1cir0WuZsTkTfjyJlrapaS8k5Lum
	 XMgtlY73eBx3lEOMCQAZRMf0Pyam0nD5yT3nkasxPGDBADEoxq+ggL4shNvrZGl2KP
	 u1tyU8EvsjL7A==
Date: Mon, 8 Jun 2026 12:35:27 +0100
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
Subject: Re: [PATCH v10 15/37] mm: alloc_anon_folio: pass raw fault address
 to vma_alloc_folio
Message-ID: <aian4VFP8s8aYJu2@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <2e931dc3daa76b57eaedd5b2d3d49f1075797252.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e931dc3daa76b57eaedd5b2d3d49f1075797252.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:37:25AM -0400, Michael S. Tsirkin wrote:
> Pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).
> NUMA interleave is not affected: the ilx calculation in
> get_vma_policy() shifts addr >> PAGE_SHIFT >> order, which
> drops sub-page bits regardless of alignment. post_alloc_hook
> will use the raw address for cache-friendly zeroing via
> folio_zero_user().

I'm confused as to the justification for this? You're saying 'make change X,
it's safe because Y'. So the justification is now this post_alloc_hook thing.

But are you now creating a new requirement of vma_alloc_folio() that you must
specify the actual address we are faulting on, not an address within the folio
or the folio's base address?

(If that's a requirement, why is it?)

If so you should update the vma_alloc_folio() description 'virtual address of
the allocation' is not at all clear.

And if that _is_ a requirement, then are you sure all allocation paths are
correct?

I already see addr & HPAGE_PMD_MASK in vma_alloc_anon_folio_pmd() for
instance?

If it's not a requirement, why are we doing this? it's surely useless in
that case?

>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh
> ---
>  mm/memory.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 86a973119bd4..21f640674c4f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5268,8 +5268,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  	/* Try allocating the highest of the remaining orders. */
>  	gfp = vma_thp_gfp_mask(vma);
>  	while (orders) {
> -		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);

If you're removing this usage, could you also remove the silly thing of us
declaring this at function scope then using it in branches when we should always
have declared these separately?

> -		folio = vma_alloc_folio(gfp, order, vma, addr);
> +		folio = vma_alloc_folio(gfp, order, vma, vmf->address);
>  		if (folio) {
>  			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
>  				count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> --
> MST
>

Thanks, Lorenzo
