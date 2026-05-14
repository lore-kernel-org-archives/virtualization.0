Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246D23EFD37
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766580; cv=none; b=Wp0fqRzGX/dfrnl12h8wrs75F8PiCCw7erNHQgp57m/UQbQzb07m0jFb3M2ZhVj34Mny8bjpi3MEo6OLs7/4Hi1Qxk+GH71hp+qGLxfbfQ9OpGGf6NqgrXnfKSntIFDSPfNwb4EPMUkJxLXtznLRbgUFJ+EyXYiYCIJDWfrCOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766580; c=relaxed/simple;
	bh=OZUU6wejiT7mjDvuWG9JChopoDXLhXCYiwgilmov9b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGs7kXRHSjcGfycRA/xBUdd2UA+QLaxE6YcsiXGfWSuKiFXoVhcyF8DB9c/dIF0sLH6WHWqBKIxYMB6sT/0wzszNcr1DVJS4cZZFQwptV+pyOaiDcAUJRvvE3TQ1ij0xBWZw5TvHHXcJcloYzZnPsac00RNR9rChvB8Xh/bKQ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FBivzP08; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FBivzP08"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-90d1f03238bso248347585a.1
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 06:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778766576; x=1779371376; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPX+//kFk8/jIPUJw7pgOciEeGW6jgVvj62i43St87w=;
        b=FBivzP08hoc6ifNkTnt/oqqNdFM+38B5U+DP4d77PEY5MBhsezOky/eUntTbbWY9W8
         DmKhyJfMwuO3+t2i8ytUl0/KBAvpZwAOb+3HYbIpqD7JX4fQmSqblGfv+D3SeBf8G+Xv
         VgOYXJfqbuR409dTn4x17jZ/2wluGzbR+Hk5znISB1GpLsVA4zCYygQOb2qnmgkTe9ux
         UTuIPyfhk/OxqtF8zjO1+duact/YV2YEc6a3bpkZoFR48wRmY1SnZFnE3GQythFLlY6V
         4cx214MXgnxh9BrsKNb23OmOipG3imC4YsNFOwOdJM0aRKlvmbC5hUanFYEdWfB02V5e
         8CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778766576; x=1779371376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPX+//kFk8/jIPUJw7pgOciEeGW6jgVvj62i43St87w=;
        b=Kvxz6SJQ2U2K31cg7CTrJbbIN5L3o9SHnjydxtBRaTcOQfs5ChHIHJsbj7gZWFvEd+
         tJQ3E2nBO0nPbh9k2VleiHbEu9kMR0SxjTPxO7QQH1cO79CVSZmwZtQNe7O6of/5xXXp
         o5A6qED0vvn+s1uPotaEH8fAAfNq4TDncV9J5QjmpgtuWuq+RficWaPuFnyV/u/STQMl
         It4/ItKxs7iHoBMlqkZgQFcycKg6ianFnPH/24zanBx7voLYcCdb9341z83Uoh22xjum
         WUNx6/M2J5U2T3IVu1kL5HbNu2rJu6dVti3MWDXnShLB+DyTBeMNHDUDdY6iA7QFHY7B
         6DaA==
X-Forwarded-Encrypted: i=1; AFNElJ9MOMQZnrCPY4PpoEctumxZasPVCygd7kp9Se9DKfGqPDFD1Inw0I00fgDv7yURRfpVfO0GzlQBpheai/OhwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXJYCH4LCR9r9prr+61whjORbiwxZWaWEggS2+lSQyVrNhJW7K
	7vhcLSbYA8gg4MOw/bLagFgWWNt7ArkjBPqDgWqVLOROKSbgmdGNvVc48Gv34ZJelbE=
X-Gm-Gg: Acq92OEZg5cgOYiCcv3LQzCNf+J1GvdtxcbGILR8kSuRqA0ehBXlnrre2lgTb59DapT
	24UiIXvY7X6Jni89wiXLuxqH7TRgC3MtgGIqE5/nminh9e/EGmAf4wLfMAXoeGWAMzATNGMsoqE
	BtVunmbu4vxEwLgQ0DC9pEJ1tr2Kl4uLSDSeMb2pzuZV95+ZgRDsngwhAQAHW6B7ag7LaG7E0Jh
	n3X4OhD2hmLpi2u18R68lLVd00EUs+dYBKwz2rcQGmnKmQz2aM6HSPivUI8ohzleUerQOyRq1tI
	+YNL9eNyyx9qm2qdafFrPxe5ivkAz0Qc5kWIF3VUinkiGbHyjHy/lC0iyxuTIKLMvfZedg3iLgZ
	3RoUTsKXSkxp1XHBfgGyjpIpLruHZNHDNU271Y2e54MKPOYrUDFWXBdDildSC8DcBtU9wgyJCOQ
	t29NWmEFAUrVU1RgC8mhcyJdmwqttVGYPk5mSvQ3NrhRwcYdqaabuCU9Ni81Eoq7/KS3BzCdNy5
	ekM19QGdjop
X-Received: by 2002:a05:620a:45a5:b0:8cd:c152:ee6b with SMTP id af79cd13be357-910af5599d3mr518683585a.8.1778766576120;
        Thu, 14 May 2026 06:49:36 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bd62e233sm248608685a.45.2026.05.14.06.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 06:49:35 -0700 (PDT)
Date: Thu, 14 May 2026 09:49:33 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v7 09/31] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <agXS7dMmtJrPhu9W@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <45d1ea85b574399459a64fdba28fcf04abfa3e7e.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d1ea85b574399459a64fdba28fcf04abfa3e7e.1778616612.git.mst@redhat.com>

On Tue, May 12, 2026 at 05:05:54PM -0400, Michael S. Tsirkin wrote:
> When post_alloc_hook() needs to zero a page for an explicit
> __GFP_ZERO allocation for a user page (user_addr is set), use folio_zero_user()
> instead of kernel_init_pages().  This zeros near the faulting
> address last, keeping those cachelines hot for the impending
> user access.
> 
> folio_zero_user() is only used for explicit __GFP_ZERO, not for
> init_on_alloc.  On architectures with virtually-indexed caches
> (e.g., ARM), clear_user_highpage() performs per-line cache
> operations; using it for init_on_alloc would add overhead that
> kernel_init_pages() avoids (the page fault path flushes the
> cache at PTE installation time regardless).
> 
> No functional change yet: current callers do not pass __GFP_ZERO
> for user pages (they zero at the callsite instead).  Subsequent
> patches will convert them.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  mm/page_alloc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index db387dd6b813..76f39dd026ff 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1861,9 +1861,20 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  		for (i = 0; i != 1 << order; ++i)
>  			page_kasan_tag_reset(page + i);
>  	}
> -	/* If memory is still not initialized, initialize it now. */
> -	if (init)
> -		kernel_init_pages(page, 1 << order);
> +	/*
> +	 * If memory is still not initialized, initialize it now.
> +	 * When __GFP_ZERO was explicitly requested and user_addr is set,
> +	 * use folio_zero_user() which zeros near the faulting address
> +	 * last, keeping those cachelines hot.  For init_on_alloc, use
> +	 * kernel_init_pages() to avoid unnecessary cache flush overhead
> +	 * on architectures with virtually-indexed caches.
> +	 */
> +	if (init) {
> +		if ((gfp_flags & __GFP_ZERO) && user_addr != USER_ADDR_NONE)
> +			folio_zero_user(page_folio(page), user_addr);
> +		else
> +			kernel_init_pages(page, 1 << order);
> +	}

Open question but not necessarily in-scope:

Should __GFP_ZERO just be implied if (user_addr != USER_ADDR_NONE)?

Putting aside how that's done without introducing another gfp flag
(maybe something explicit like `alloc_pages_nozero(...)` ), it seems
like a very short jump to just adding __GFP_ZERO to any user-alloc by
default.

I'd be curious to know how many callers across the system omit
__GFP_ZERO when allocating a user-page, and whether there might be
scenarios where we subtly miss it (seems unlikely and narrow, but very
possibly something a driver could do unintentionally).

~Gregory
