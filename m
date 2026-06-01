Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AA0380FC2
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296961; cv=none; b=P0Zpc4rtS6MwmYuZkWTDijS1aN7VUsKMumHAW4h90eu9/skIy3W5GTh4uKOiwJL/Z7GSuN9wkwiOAsH+hEoevHgTGUTvGUkoubFAtnr03wMndBk+9VeGaSPOooNfVm0axFoMQ3DBKnPHt1GEUlOfCoObmr6nxRwcysgW0QtsyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296961; c=relaxed/simple;
	bh=P4ci7939oAoSFX3QZMcR+g9OzCdRhMWsgsON9iJyDxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccxtJ7IZ8sFyos7s4xeG0E22W2b8tFSHihGF2duAZYofSM2s7/fklDchwV7fNWGd7hj2PBd9CZ7bdBPImUvfh3LM84Lbg0d+jw08I5n/n8rbS5Q99bb855t5oY9zGbwPdiErbGcGPmySvL830TKSQQ4JcDhX+1aHInFvQ+57mhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l2XcYZnB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l2XcYZnB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 286A8267F;
	Sun, 31 May 2026 23:55:53 -0700 (PDT)
Received: from [10.164.148.35] (MacBook-Pro.blr.arm.com [10.164.148.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC3C33F905;
	Sun, 31 May 2026 23:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780296958; bh=P4ci7939oAoSFX3QZMcR+g9OzCdRhMWsgsON9iJyDxY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l2XcYZnBFq46QasN5IndOOMdI3pzz+fV5RWUDhOxVW+rQDMeCXIqTS+7r8segYuJW
	 Xghmnvke/cDzfY9U1/KdC1zwyc3pK96gURH8EJf03SAAs84PvL1aZlWNR8oq58Rhsz
	 VmZRPn1pITg0z0mXpWYMu0RlNiY8/t5hC/Nueiww=
Message-ID: <167e9c40-bae2-46a2-bef2-e0240fe0ef35@arm.com>
Date: Mon, 1 Jun 2026 12:25:31 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/37] mm: hugetlb: remove dead alloc_hugetlb_folio
 stub
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 virtualization@lists.linux.dev, linux-mm@kvack.org,
 Andrea Arcangeli <aarcange@redhat.com>
References: <cover.1780067977.git.mst@redhat.com>
 <8e2d9431b0e324100d550c765024c883560a4367.1780067977.git.mst@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <8e2d9431b0e324100d550c765024c883560a4367.1780067977.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/05/26 8:52 pm, Michael S. Tsirkin wrote:
> Remove the !CONFIG_HUGETLB_PAGE stub for alloc_hugetlb_folio().
> 
> The stub is dead code: all callers are in mm/hugetlb.c
> (CONFIG_HUGETLB_PAGE) or fs/hugetlbfs/inode.c (CONFIG_HUGETLBFS),
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
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Assisted-by: Claude:claude-opus-4-6
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  include/linux/hugetlb.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 93418625d3c5..f016bc2e8936 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1129,13 +1129,6 @@ static inline void wait_for_freed_hugetlb_folios(void)
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

