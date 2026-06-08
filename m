Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE29B3659F9;
	Mon,  8 Jun 2026 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918653; cv=none; b=IshEIDgBAbgvyYK8CBAEu6tXO5qa4evhMoeikkqojGlZDhfiZWWJq/q4VdIRxMTVD/0p+dqmdSAK8Qi/EsVwa/1HXzWzwWUkNSvIazRNdfAbPZ/IqMYQFEtDQbMUOZqtcKm6jXaoykpLgNUR+LFDDR050FQX6qlLRNM9uANxsZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918653; c=relaxed/simple;
	bh=VH4qnQUUyUH3P/evQNgTsIrIbgABdIYTpYY9higPfUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5/f82Whmbhj1M+ly69hsVPMGUTGV6d6epilXY+augqRYXo8X7d99pxyRVcNmdY6hi3QV6iqwFsiWPzHizGnhvi+aAyPAC+gzSjaJc9cEvh/Vu5Nncv37ZgduxesRvATuTcUKu3MgAepJiv0mHIPC2eP5MS3s2VI+/vtc9fd3PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+uCzJA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+uCzJA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204D61F00893;
	Mon,  8 Jun 2026 11:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780918652;
	bh=bbKY+/QgX1YlcLcIfrnvHn6Xg3zI9+wq5m+o05G1544=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W+uCzJA04h4lzxITom15y9mpKUyp140CgqBFDgSwg5WCzBbgjz/KQrJTlLC9P2y5B
	 GjViMKOTSs2jqW7wAmxaLRD5EEQGdDrbYaXJRCqraK10o1SZ54CalvhU6r55CtO/sO
	 jmJSb0GEQGsgpELKbh/8NPOTf8xqHRwlOaTS9hKais/K5iHw1Ke8HcmHKrGL6jjP1g
	 MymtfUnNk2bMmRaXi24NC4ciKkRiMulBpz1Np958dlIjoVj1iuni/TcDw2dxRgyh6m
	 5QGtocN/+xw66CFrL3NmgNqaFmiu5JRZZE9RIZJMWSTy2mo24LsUtUvNubxScWlBYZ
	 i6I9IJqXpFSHA==
Date: Mon, 8 Jun 2026 12:37:20 +0100
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
Subject: Re: [PATCH v10 16/37] mm: alloc_swap_folio: pass raw fault address
 to vma_alloc_folio
Message-ID: <aiapFvxPXuPd4-OP@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <d2be78654e9dcc7cf5b8a542c2c8f331187c80c9.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2be78654e9dcc7cf5b8a542c2c8f331187c80c9.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:37:41AM -0400, Michael S. Tsirkin wrote:
> Same change as the previous patch but for alloc_swap_folio:

Please don't say 'same change as the previous patch' :) explain what you're
doing here. It's a pain to have to go check otherwise.

> pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).
>
> Note: NUMA interleave is not affected by the raw address;
> the ilx calculation shifts addr >> PAGE_SHIFT >> order,
> dropping sub-page bits regardless of alignment.

You're expressing the same thing as the last patch differently, but then
eliding other explanations from that?

All the same questions as I asked for the last apply to this also.

And also - if you've now made this a _requirement_ that is broken
otherwise, then aren't these bisection hazards and should be squashed into
the change?...

No patch should break anything at any point.

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
> index 21f640674c4f..6c14b90f558e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4750,8 +4750,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  	/* Try allocating the highest of the remaining orders. */
>  	gfp = vma_thp_gfp_mask(vma);
>  	while (orders) {
> -		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> -		folio = vma_alloc_folio(gfp, order, vma, addr);
> +		folio = vma_alloc_folio(gfp, order, vma, vmf->address);
>  		if (folio) {
>  			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
>  							    gfp, entry))
> --
> MST
>

Thanks, Lorenzo
