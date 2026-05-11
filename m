Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CA444102E
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517425; cv=none; b=kuQ9LCJrOF9F5mWzfdnR6xVlYqmf1PbwSqIijjx/EYXtMerwWc+nkz+Fa83pn3KX4rT6lK4fmKIEvEASDn/6E4nIhcHJoFQYo8Me+FJ1SufNFMpZ77q8HM6YudZxyXjV3mF23twLcwIlkYX6f8yJunRNDNlV6EVV3OkmVl7s7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517425; c=relaxed/simple;
	bh=32rtVjsBu7bs/E7DjCga1Xn78UtvzNsnqDjSRttbyRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ob5QZf+30S/j4omSzTGDmhNz7blzIlzr+ECfNcb0yht11QF3w0P7xooaMOosuEuR3wCnRQ4jVhA+h4RkC05oOmCfuWCo9KOaEyKNxW9qMR1E5fZDTu8HoKUuU+Qfhatno2DEDRwd8esNWgiLTGkdLHoyFD1VTbtVYBXoSkYvZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pEH8B1PT; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pEH8B1PT"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ef5776530bso436794085a.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778517423; x=1779122223; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPk5XHw7qn/fXCccKXVO5r2Z4HwdHblAfBNUt8aXN5s=;
        b=pEH8B1PTk6ISP5n4hTf9HUYfV9OyhIUg/JVomTzQoJenFy9n+6LGijoaQV+00EbDwC
         /KLauJkElEGrr3qNjxIg21z4gMB7tmHS7uc59WbwMsSjv3WtReG9JrWFm4VLbCnKogBi
         8rd0Pe6UYBPDe5Z991lqroilSGN6A5e7Rnk4B6okhj3gC1TIaLWGGqLZGHNSt3urqLW8
         snStdWcxNLTrthdzs1Bkwb9oi7L7yMDNwPRwT6RYrONY5M1Chu9cFUrokbeJdKQkB5iB
         iXJ6lxr4xV6tCNfC0tvzaHeBPNHkMgNvure3nRo1IoC3jHEjXvOt40FtvIPOHsz0eeUm
         SV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517423; x=1779122223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPk5XHw7qn/fXCccKXVO5r2Z4HwdHblAfBNUt8aXN5s=;
        b=m23kH8uqy2ppvBI4TaCzvwmh7q6FPgrwhFwyztgF6dwXRZgBBbgloxj6CYuvBX1M8h
         DZS0RpwUPuZHSs2Wfi2MBreDMx+Vev+sPX65OpB3L7WsFu8qimsjOEgcGegSeCBTTQmR
         wQ2WyUv3WKb4a4Vt7gPmgNzJFiOn8xRix4iPwH+Qw0FBNmb7+DlI7x5Brwdh/jwWeG9Q
         dbBoOQLXw6MMe7cksZBSb4ROZotyFLKreSsR3FLZeyCFUiXOWY7mlUC0o64YBSkH/aDz
         39hi8tEnseWTF2LXgol6uxhDnhuZ4WGY1T71j63SzNT9AbsqPpFaXRsLqAENIezdUyZX
         5FqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6JiPrbW37VTtgXuzLa0AC82VLIqhvuAXK5r+o2wAqTPOrDO2BgNeevQ5I/J9EXTu52VnsF5/dYgvgDagK5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzV3V6eR4H6joV7h31idWeAaGuabNGBMOB/JXKecBAW3OTLGKUY
	3uaVrZGTelqtBQjSaq09xdtVGyyncyvC+tG0EivGz4BnlSTrrpicOhr+S60rMkW+vkE=
X-Gm-Gg: Acq92OEAkqfh/FGcMOluEeGgldzmnao2I8B9/G7+C5gJfLv+V5HnfNcNHCwexrmF/nF
	CSE9uzAgnB8ixGISl51A1LcVCeu964Abq9nDcAtvtq5HMWXCd3PbeAJevDiZ3efTnAsyFStv/5i
	KD5/FP7h2IevCE5COHxtPFgQHLS7DziYehx0stAU1PKztaY8cXZOAl+3TSWZTdQAVd/vVJtg57m
	5Nm+Q0Fr8sSBBg3dpMvjNCa11wI3b7KOum8ml985cC1RRScwAdg1KmS3AoIUQwW9MyeI51CptlP
	kpIrPRNYNhDf5GM6zFXKiOG81S8HthooN2wkGtJswMGl177tdBRzIDtHgepzqGwQ73nZ2pP1CKF
	lZdi4qKMFKchS3Resnpuo3sUpw2+OzK7VyqH2kqG0X01IYkwfzyBOhAiziCGDprOpBkVw/Y8vSK
	Zj4H36FnI1LXnPhswJlen4eY671zJYVW3/FgEHZT2yYoCZjzH5mlq5uBFQSHji9RyAvEognzqB1
	skoQOnS6RqV
X-Received: by 2002:a05:620a:17aa:b0:8cf:f2ec:c52c with SMTP id af79cd13be357-9090dfffe49mr1442495885a.7.1778517422959;
        Mon, 11 May 2026 09:37:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b87bd588sm1178556285a.29.2026.05.11.09.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:37:01 -0700 (PDT)
Date: Mon, 11 May 2026 12:36:59 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: Re: [PATCH resend v6 14/30] mm: hugetlb: use __GFP_ZERO and skip
 zeroing for zeroed pages
Message-ID: <agIFq63QZugkWcXJ@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <fe1d24d4deafe0f5d1a9c51fcc040d9561c8592a.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe1d24d4deafe0f5d1a9c51fcc040d9561c8592a.1778489843.git.mst@redhat.com>

On Mon, May 11, 2026 at 05:03:02AM -0400, Michael S. Tsirkin wrote:
> Convert the hugetlb fault and fallocate paths to use __GFP_ZERO.
> For pages allocated from the buddy allocator, post_alloc_hook()
> handles zeroing.
> 
> Hugetlb surplus pages need special handling because they can be
> pre-allocated into the pool during mmap (by hugetlb_acct_memory)
> before any page fault.  Pool pages are kept around and may need
> zeroing long after buddy allocation, so a buddy-level zeroed
> hint (consumed at allocation time) cannot track their state.
> 
> Add a bool *zeroed output parameter to alloc_hugetlb_folio()
> so callers know whether the page needs zeroing.  Buddy-allocated
> pages are always zeroed (zeroed by post_alloc_hook).  Pool
> pages use a new HPG_zeroed flag to track whether the page is
> known-zero (freshly buddy-allocated, never mapped to userspace).
> The flag is set in alloc_surplus_hugetlb_folio() after buddy
> allocation and cleared in free_huge_folio() when a user-mapped
> page returns to the pool.
> 
> Callers that do not need zeroing (CoW, migration) pass NULL for
> zeroed and 0 for gfp.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh
> ---
>  fs/hugetlbfs/inode.c    | 10 ++++++--
>  include/linux/hugetlb.h |  8 +++++--
>  mm/hugetlb.c            | 52 ++++++++++++++++++++++++++++++-----------
>  3 files changed, 53 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 8b05bec08e04..24e42cb10ade 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -810,14 +810,20 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  		 * folios in these areas, we need to consume the reserves
>  		 * to keep reservation accounting consistent.
>  		 */
> -		folio = alloc_hugetlb_folio(&pseudo_vma, addr, false);
> +		{
> +		bool zeroed;
> +
> +		folio = alloc_hugetlb_folio(&pseudo_vma, addr, false,
> +					   __GFP_ZERO, &zeroed);

This feels like a very odd pattern:

  1) ask for __GFP_ZERO
  2) Have to check whether it was actually zeroed

Seems like the zeroing piece should just be sunk in if you're going to
ask for __GFP_ZERO anyway.  And in that case, maybe just `bool zero` as
an argument, rather than GFP (to avoid future overloading of flags).

~Gregory
