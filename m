Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D551137C914
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 22:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778623426; cv=none; b=ZVx0XBZCP8MzDCWUMcsXKnvn1y5nsz8htxGKvWEykDe8LLGOqn2NLjIvSTRmUDPYRAA9uC3vOC8m2wdDW5fm96+w9/bknnDO8gH6r2AggpWFobWSF9NcmMSj1vSXPu3H7PPavoEepXNIWYflwsbqtiQ/2f+7xsLgTgiH+6fEoVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778623426; c=relaxed/simple;
	bh=P11G55OuJ+x8NFPakVaRen/yKl8LGk3f8r6ZSNSvUlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyNB7EAnAmoj5eJDq8DXkjSV1VxmxEqYHzLsOmR/K/Rm2e40J7GNSg6CPceoS9pHsZjt7FoS1gSPw57lrRspQheqTTTroeKn+CRj6opcTVsyN4DXDkwY7w3s0rKp+6bhkKebuhp4CqxKxoN9h2ehRKwLxGp1tz0wp4LN7v+QWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SrzNxfQM; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SrzNxfQM"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50faf8ed9c5so32096081cf.2
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 15:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778623423; x=1779228223; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpy4x7dEQdIOgJjvqOzPRDk/nU9rzNx4M+UIRXa20ZQ=;
        b=SrzNxfQMkZm7+qYUxy+rFU5JzO5WVb6niM2N1eyf6E/AQMZ2gslG9O97pm0o/lxgKN
         tCRLbtHHDZVQAoeTPIMP4nf+MZDq29wLb3PIsQRK2tHRSK1V1Hgot6Zd4ddX7pc6ujt1
         ejarQNzQNw77cJDRP8bzOyNpjuk6ZiUiUnqmiJ0KYjCDL4bQAFC3hzqhcN+BZ7xxXtWM
         /UF4WkyH2NwfpUgIBsH6lPSlIAIzPfr4bR9aJY6IFmMozR9UW0a3azRlrYmdAsl+JKLQ
         rx28TLxBIkqT9mbP4XE4Vsl/ZGk/RLztZlHOihcpHf68Ti6wqsNOBFlBaJX4qHrwdiZs
         HY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778623423; x=1779228223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fpy4x7dEQdIOgJjvqOzPRDk/nU9rzNx4M+UIRXa20ZQ=;
        b=Ebz9adOx6Hxs1LcK9aNMAfQMxyDsIDenNTFExTLLE6o3RcESEiZrJ75RoJPZRiirMf
         Rnc5Uq5g+Y7drKBa1IwttlPc0nnkxdDDCrENEaZhwyGEN63jqYSdo7/s7VAja90Y4idE
         R2fyl4BYsKup1VX4wuU9ZEjl4+ezf47BU8e/G6beoksIm0CMnSLRZNR9ezOX6mIMNmQp
         2UdQsuJD94F/IQ5dBFbbzAGlqacPkoCmRS3TN0rrZWW3uHhnsetwTcKisMqcmzCytzUF
         ny+LjH/+rorn9/faaTNAbdgmlp1uxOAibhQkIgNQkQLcg728VtPl4pXnLlRWu3OMCrGp
         5N8A==
X-Forwarded-Encrypted: i=1; AFNElJ/hJvscYSQTEIzB9Cd86Vv0B1/FS13sKDd39HhDjlobregz3aiF5lLGAzZdO/s0JIStfzQKTRlHc2aSer2Y2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhMBcKHKuA0JerBMJudG58wlVBOuz1EcGq+2yATWxUPUlmcfY0
	C7458F885xxzgmZ7NSDSmQS9OKWTE0pzsnGdYSer03Qhil65WedM20k03TVlx5qhYN0=
X-Gm-Gg: Acq92OGZyFyS+5uYU/2Ls0NRhqlFZGA44Z5KUdZdVQYS2rOqnMsS4vo9QSa5mQGB84x
	fUoIyjwKIYACcuFIIjVLRFf36gZDd+YO9nq0VFKwvw/sLYj8l4mZW5xo98OK82jwyiaJuMD78Cv
	BoZrgEwInJjfmS9kYAE+985y41uxVx18tdRYcBtcKl6oF1paBXSIUg6Edi8niCOzfI1Ehay8QcV
	+EP82t+l1TgrlKh3iQI9RJ/wGDsSyxIEq72ig0gMB/kQ9ydCmMsG0Ij1LlZMbg3cRuOmcsLFhhJ
	toprB2h7lELVIvPAcgwZrgwOQX8abllr4botEMi4itsbsgk0y1+44NpHgCFeo9eS2cQPvOhD+he
	1GAhHOYbwNJPmvDIaqrbQqV+fbp4lNvhQPlaIpV370sZxOZT0u3sddlfLin5m7DRAFWOCBjcheD
	kRxHv2vySf/EblqKGgp+9azNjxHOmV3KPXtzMPgT1xwYKdTmTsglwM35dZbgjqtSBIxnMfnrKOB
	Zsx6jL0QS9m8V4wHhl6lTM=
X-Received: by 2002:a05:622a:11ce:b0:50f:f0be:dc7b with SMTP id d75a77b69052e-5162ff46f46mr3954791cf.39.1778623422619;
        Tue, 12 May 2026 15:03:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7c0fa5sm141204081cf.16.2026.05.12.15.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:03:42 -0700 (PDT)
Date: Tue, 12 May 2026 18:03:39 -0400
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
Subject: Re: [PATCH v7 17/31] mm: hugetlb: add gfp parameter and skip zeroing
 for zeroed pages
Message-ID: <agOju4MRXyS7Wp8E@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <4039b0b96594b69b15ad4bcd64cbb33de3cec350.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4039b0b96594b69b15ad4bcd64cbb33de3cec350.1778616612.git.mst@redhat.com>

On Tue, May 12, 2026 at 05:06:37PM -0400, Michael S. Tsirkin wrote:
> Add a gfp_t parameter to alloc_hugetlb_folio(). When __GFP_ZERO
> is set, the function guarantees the returned folio is zeroed:
> - Fresh allocations (buddy or gigantic): zeroed by
>   post_alloc_hook via __GFP_ZERO.
> - Pool pages with HPG_zeroed set: already zeroed, skip.
> - Pool pages without HPG_zeroed: zeroed via folio_zero_user().
> 
> The address parameter is renamed to user_addr; the function
> aligns it internally for reservation and NUMA policy lookups.
> For pool pages that need zeroing, user_addr is passed to
> folio_zero_user() for cache-friendly zeroing near the faulting
> subpage.  All callers pass a page-aligned address; the
> hugetlb_no_page caller passes vmf->real_address & PAGE_MASK
> for consistency.
> 
> HPG_zeroed (stored in hugetlb folio->private bits) tracks
> known-zero pool pages. It is set when alloc_surplus_hugetlb_folio
> allocates with __GFP_ZERO, and cleared in free_huge_folio when
> the page returns to the pool after userspace use.
> 
> Suggested-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh
> ---
>  fs/hugetlbfs/inode.c    |  3 +--
>  include/linux/hugetlb.h |  5 ++++-
>  mm/hugetlb.c            | 47 ++++++++++++++++++++++++++++++-----------
>  3 files changed, 40 insertions(+), 15 deletions(-)
> 

This seems much much cleaner this way.  One nit, doesn't need a respin
unless you feel like it.

Reviewed-by: Gregory Price <gourry@gourry.net>


> @@ -2980,6 +2993,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  
>  	spin_unlock_irq(&hugetlb_lock);
>  
> +	if ((gfp & __GFP_ZERO) && from_pool &&
> +	    !folio_test_hugetlb_zeroed(folio))

stupid question:

   if (!from_pool) - wouldn't folio_test_hugetlb_zeroed(folio) be true
   because __GFP_ZERO is passed?

   If not, SHOULD it be true (i.e. should we be setting that in the
   non-pool allocation path when __GFP_ZERO is passed and allocation
   succeeds?)

If so, can this just be simplified to:

if ((gfp & __GFP_ZERO) && !folio_test_hugetlb_zeroed(folio))

Maybe that lets you eliminate the bool entirely?

~Gregory
