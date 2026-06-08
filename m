Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD535B634;
	Mon,  8 Jun 2026 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921853; cv=none; b=XIalq4uAEcfvFJo2N8tt7gU/qnzGim/PCiAMGGpb4SOMaZGF1/xJtiXgKiFfF1RXVoiKuvkonhfz4srgj4RLoPGXQ/gl1aTrhixb7v4XCxqeGYx7plBYCuEXC9b2j/340RjPEciicwFV+UYeUQQwKf+ttMkXncOFUqQYSEE5T8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921853; c=relaxed/simple;
	bh=pAvpzJzbB1KGc+CY9fpN8vJvpA9xFQNBdhRSVvoDZ88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=It/kmKfRxBh63jyidHwPjzeVAlvjk6BgCIABhtlL1e/G/RYy0eeLMC+BtQd8CWyYmEMFUY8tpYwBmqX/47ouetHckCKzNRw3RH1wqwlZDTNK/UI/doADPuTznfHFn4lFGhLwcGOmQ31jpi1OYo3ef5cJOP7TdVKQd9EKmnNGLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MptGS28x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MptGS28x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DCE1F00893;
	Mon,  8 Jun 2026 12:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780921851;
	bh=7K9xf/Abv65PD5WJKWreEjZFt+w5IAtgpsFxo2CIhfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MptGS28xZRXTQDjUm3m8/WhCwkOlQzTNjeYnfC4uD+6XNOlWaTscB40cuNOohwjGF
	 vPtucP/L1ctoze31pqe0An4IeAVPiBA6AwZMqbWYJeQVPRlRzJkTjEh9Fmf343veDD
	 p9fPTpFXNKwtGcHjpdPy8HPkI08CKKgyXXwR3QYnYnc/s4h+fG5N5jYIUIbIEPwnnn
	 OeQeaOkAxRcS/HOD/t5/zqoOfTsZBKN8rm0aFqNgFnXbZOb9AhW8hjwdTQyGTrVdEL
	 GpsnGHWRwFYt0fKJhplVf0VTVLcoVCxif/Ms6rv05VPSdd5k1Dp6vuOnBd4oBSbvMD
	 F1tLurbUDYapw==
Date: Mon, 8 Jun 2026 13:30:39 +0100
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
Subject: Re: [PATCH v10 26/37] mm: vma_alloc_anon_folio_pmd: pass raw fault
 address to vma_alloc_folio
Message-ID: <aia1xjOPMip_dM7Z@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <94f64aeca62d8419d76f2cf82b36f1da6017a312.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94f64aeca62d8419d76f2cf82b36f1da6017a312.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:39:10AM -0400, Michael S. Tsirkin wrote:
> Drop the redundant HPAGE_PMD_MASK alignment at the callsite.
> NUMA interleave is not affected by the raw address; the ilx
> calculation shifts addr >> PAGE_SHIFT >> order, dropping
> sub-page bits regardless of alignment. post_alloc_hook will
> use the raw address for cache-friendly zeroing.

But then what's the point in this change?

And why are we changing what we pass in this parameter but not the
vma_alloc_folio() kdoc?

>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 970e077019b7..d689e6491ddb 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1337,7 +1337,7 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
>  	const int order = HPAGE_PMD_ORDER;
>  	struct folio *folio;
>
> -	folio = vma_alloc_folio(gfp, order, vma, addr & HPAGE_PMD_MASK);
> +	folio = vma_alloc_folio(gfp, order, vma, addr);
>
>  	if (unlikely(!folio)) {
>  		count_vm_event(THP_FAULT_FALLBACK);
> --
> MST
>

Thanks, Lorenzo
