Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81153A6EE9;
	Mon,  8 Jun 2026 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911815; cv=none; b=bNmStVb5domvjhkXzVAU+R0iswj9p1tS3xgNN+/nXqoScLOSj9apWZsKS/KX1bXACIbR7mJFnixuBGY9ae9/9QkpkqJK2aF2lh5TdTsSGvEXhEZ2S1938JYWmQuhJvSca82fH+FLw3P/gLPTsryXWJEkpjlh31Y1QhSVqPLvLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911815; c=relaxed/simple;
	bh=54XPwmWyT2h3tWHnPBh3+68MKYmRfBde9mll16nzWUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rk9Ej6pr1YDLsYD26BvRea6K3EBz2fU8FWrDdjg4i296seTomcMN/EYJl/kDJQ3oYh7wqzCj6sIZ59Wg3d60VmCXj5/a0M21s5bJ6i3fWHn01Sxh+FUJc6GUHAcwvtPhFfGfqutPMgdRaZ31qnVg2cDS8o2TX9QrggvigN/JuZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG6271fy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG6271fy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FB91F00893;
	Mon,  8 Jun 2026 09:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780911814;
	bh=NWzNwd41K014rRzleNCcA3bHTWanKla6egxzBAWBDSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FG6271fyWdED+PCEocy1/8B9zEZikn30HwkNdCmZM2JH0pcqFK5H6+CtzcXXt0EDY
	 fRTPOyA7R6sPYsZcfZ8+Hey3Z0ZXYGI4wQqrXgKpC1xFjJjQQyeEA1dLg/ACBKk2PK
	 6JiKAnszdqKmvXR1Lyq75wgNuznoXK+fYknlLtMVmctJJTzh5YaUGFc005dDMb85WI
	 Eu2ML59W2SP4WEUSYk/pvv3Xvk4+bLgT0/oyStQBYuDynQQBBEvcA8WNbrwF3zCmst
	 e937L5T05nDdGOQ7RdulyfDazoZqNmRtiN4VnLvJ2G5NIeKwB/UXzIZ3KnpA5jOamn
	 ozOEQnZPyPmZQ==
Date: Mon, 8 Jun 2026 10:43:21 +0100
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
	Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v10 02/37] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
Message-ID: <aiaOZoa2vSCz_0wY@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <df06b66fe4ff8e925ee0714955abc2183a727b90.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:34:23AM -0400, Michael S. Tsirkin wrote:
> TestSetPageHWPoison() is called without zone->lock, so its atomic
> update to page->flags can race with non-atomic flag operations
> that run under zone->lock in the buddy allocator.
>
> In particular, __free_pages_prepare() does:
>
>     page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
>
> This non-atomic read-modify-write, while correctly excluding
> __PG_HWPOISON from the mask, can still lose a concurrent
> TestSetPageHWPoison if the read happens before the poison bit
> is set and the write happens after.  Follow-up patches in this
> series add similar non-atomic flag operations as well.
>
> Fix by acquiring zone->lock around TestSetPageHWPoison and
> around ClearPageHWPoison in the retry path.  This
> serializes with all buddy flag manipulation.  The cost is
> negligible: one lock/unlock in an extremely rare path
> (hardware memory errors).
>
> Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
> in this file operate on pages already removed from the buddy
> allocator or on non-buddy pages (DAX, hugetlb), so they do not
> need zone->lock protection.
>
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Can we have Fixes: and Cc: stable and also send this separately please?

These patches seem like unrelated fixups that you've discovered along the way,
and don't belong as part of the already rather large series, unless I'm missing
something here.

Thanks, Lorenzo

> Assisted-by: Claude:claude-opus-4-6
> ---
>  mm/memory-failure.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index ee42d4361309..3880486028a1 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2348,6 +2348,8 @@ int memory_failure(unsigned long pfn, int flags)
>  	unsigned long page_flags;
>  	bool retry = true;
>  	int hugetlb = 0;
> +	struct zone *zone;
> +	unsigned long mf_flags;
>
>  	if (!sysctl_memory_failure_recovery)
>  		panic("Memory failure on page %lx", pfn);
> @@ -2390,7 +2392,11 @@ int memory_failure(unsigned long pfn, int flags)
>  	if (hugetlb)
>  		goto unlock_mutex;
>
> +	/* Serialize with non-atomic buddy flag operations */
> +	zone = page_zone(p);
> +	spin_lock_irqsave(&zone->lock, mf_flags);
>  	if (TestSetPageHWPoison(p)) {
> +		spin_unlock_irqrestore(&zone->lock, mf_flags);
>  		res = -EHWPOISON;
>  		if (flags & MF_ACTION_REQUIRED)
>  			res = kill_accessing_process(current, pfn, flags);
> @@ -2399,6 +2405,7 @@ int memory_failure(unsigned long pfn, int flags)
>  		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>  		goto unlock_mutex;
>  	}
> +	spin_unlock_irqrestore(&zone->lock, mf_flags);
>
>  	/*
>  	 * We need/can do nothing about count=0 pages.
> @@ -2420,7 +2427,10 @@ int memory_failure(unsigned long pfn, int flags)
>  			} else {
>  				/* We lost the race, try again */
>  				if (retry) {
> +					/* Serialize with non-atomic buddy flag operations */
> +					spin_lock_irqsave(&zone->lock, mf_flags);
>  					ClearPageHWPoison(p);
> +					spin_unlock_irqrestore(&zone->lock, mf_flags);
>  					retry = false;
>  					goto try_again;
>  				}
> --
> MST
>
