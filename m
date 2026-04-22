Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE59346AE5
	for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887233; cv=none; b=Z9HhdcDqZ9M0+GtjMB/ZNP2skxoskHkZ6fQBcYd1faJUfAJfd6GnhOUcSujZeA0i3C8Svr3OwzfsVx+97I8OyjKs568thCEWRMEVP1GnvUHSoeZLC0mqjnTUVY33ic0JzBAqq2R3voiFItnr0ueG/WmI8nZex2gPBep3OlHRyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887233; c=relaxed/simple;
	bh=0nf05vma3xhqsy8YbrfdkENQdMmOEcvjpQx6mh+lTeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOPN2XFbQxw2TfmYLfDGYFRr1J728BTFTQOohDwjGYsv5wsu2K70fiGMPd3v1wE+mDpFj0l9tDM6xk9q5Rh/z+TNa+AROYTRY8tLMCZS92TuGCDf+tk1GLaxy94uOfn5vR8vhzpu0weCNYsPnthHqt8AMmmJ72yrrfXLtrEfClM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WO62TxtU; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WO62TxtU"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89fc4147f2eso65048386d6.3
        for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776887230; x=1777492030; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGdOZjYFd//HiRQ+b4VwV4BRdopXfvmgy3UzEHyg/Zc=;
        b=WO62TxtUYyMG2LujNfBLV49rpgelDcAvxYxm0VdIb9WxLtlxNrgztYQ3M+vqa8CUPg
         X53sg9GS2B07p5S63j0hw9Ggy4kY9yjYeN9ULKgeuswuF1uhVM/3QqMwbg3LO2YP0w4c
         UmsdQlfk3d2ooeUlti8OKLi74qAZZi5oNtG7MbEPTD3NlPHrznwsRXBt1FqRi9LaKPwD
         TYmmpB8TpmJR6m9VQ025bmzOP2p1Ej0pUt5TRSlV26UKspPviEaY3UyA+9krIym1/fUX
         1k6eZX1xwztWjkbS47zbcmMVmCBjYWkf+32nu+1W4BWvfX6fNxVtvkolj7UvMnm/2dBH
         uKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776887230; x=1777492030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGdOZjYFd//HiRQ+b4VwV4BRdopXfvmgy3UzEHyg/Zc=;
        b=SbwvowfQsUhZ2Rd8RVIoXiEP9EpylQWhrtA1kXQkZBr9+MJrtsNGd4O653YRvJT+W4
         +mqDFzjig1T34WA5GEiIORwHJJb7DLyIdn1jcorT6hP9givcghWalAh/LkjIGUpfdp7C
         6AdaNtQSKw/K4u2Y6/CxEkhAa3mSsywwx8BzbfM89U/NQRUALiII+k5iyJEFk2heiE0J
         WRzxSChb02Iz1WnWFWASmlE0HR1Xj7ivBHkclI4+0Ztn3mtSoKfcDeb6bVwT7eDNtaca
         sCTpg0CaGPqrXukljJFSK72OvPcGOoJQTXJTKkE09wsMZiGs7IWZGjd3Z+bjVxoaA6w7
         Hb8g==
X-Forwarded-Encrypted: i=1; AFNElJ/+Cg/nXtuXRLXJ8F6neXlbAL7aj7sbpZ35Tzs7RrrAHfeBBUpD7fE1RLHNeJ6qzvkinOk9qkHG1mFuWmZq9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbXgcYLICeoaT8QMUhd4l/xl4jFW8HlSIXQN7Kr5hxrCVYXvOh
	l37z/+I4rqwk1U2uJOt0WY7c6RNLJ4/oaXp3b5Q8RnOpscbqnGsUpQxQWI8K3+mIyfw=
X-Gm-Gg: AeBDiesCTG+jH22EaBPIYC3OI79nFbQRfVf1QpWOLLKZdm/e14f8Nw5mCId75PGOjiB
	JlY351RLo7xuomaxTX5abjKbudm02B1OLshxwlQ5zPiY8DtD1fbWpwofm5B5nrOofsZCIj18fNJ
	AaVTMf0+aW+OtWfP27x9akXKZ2lTepl/1tuFKq2JXa07dAygiEUwc2AQltV3ozojVqDnJ3cXeGc
	Tgl5eTGq52x/Q/MAno0ZTB0HC8IcxuikcCZliMmKtd1qP2MD3k4fMm7zHTna9dBa+/RuSkT+p6K
	XcVtkcV218DwUx9UVzSiQRpodIDr956RKM57uPLkQqWnMDHqFzGUAS1zN98CxrCyWlAOomMJeSF
	HAyz62Y+NyM2pxfnyntflYP1AyOab1Isavq61hxthLfY3Gi3Qq7mjedJVsAtRjjQcSeHAfFiaVr
	LjUV5shMTJZKJZ5QwAQuxX+27brIrR+ZMriy4FFd7DycJNtqjPs0vbaQdVhs+yEnuTMpO75MVNq
	/K/kQw6EdI0GShOLee1
X-Received: by 2002:a05:6214:5e08:b0:89c:6a86:e632 with SMTP id 6a1803df08f44-8b028061bf0mr329097316d6.18.1776887230490;
        Wed, 22 Apr 2026 12:47:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-246-228-50.washdc.fios.verizon.net. [71.246.228.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aec3a3bsm138295346d6.49.2026.04.22.12.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:47:09 -0700 (PDT)
Date: Wed, 22 Apr 2026 15:47:07 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 01/19] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
References: <cover.1776808209.git.mst@redhat.com>
 <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>

On Tue, Apr 21, 2026 at 06:01:10PM -0400, Michael S. Tsirkin wrote:
> Thread a user virtual address from vma_alloc_folio() down through
> the page allocator to post_alloc_hook().  This is plumbing preparation
> for a subsequent patch that will use user_addr to call folio_zero_user()
> for cache-friendly zeroing of user pages.
> 
> The user_addr is stored in struct alloc_context and flows through:
>   vma_alloc_folio -> folio_alloc_mpol -> __alloc_pages_mpol ->
>   __alloc_frozen_pages -> get_page_from_freelist -> prep_new_page ->
>   post_alloc_hook
> 
> Public APIs (__alloc_pages, __folio_alloc, folio_alloc_mpol) gain a
> user_addr parameter directly.  Callers that do not need user_addr
> pass USER_ADDR_NONE ((unsigned long)-1), since
> address 0 is a valid user mapping.
> 

Question: rather than churning the entirety of the existing interfaces,
is there a possibility of adding an explicit interface for this
interaction that amounts to:

__alloc_user_pages(..., gfp_t gfp, user_addr)
{
    BUG_ON(!(gfp & __GFP_ZERO));

    /* post_alloc_hook implements the already-zeroed skip */
    page = alloc_page(..., gfp, ...); /* existing interface */

    /* Do the cacheline stuff here instead of in the core */
    cacheline_nonsense(page, user_addr);

    return page; /* user doesn't need to do explicit zeroing */
}

Then rather than leaking information out of the buddy, we just need to
get the zeroed information *into* the buddy.

the users that want zeroing but need the explicit user_addr step just
defer the zeroing to outside post_alloc_hook().

That's just my immediate gut reaction to all this churn on the existing
interfaces.

Existing users can continue using the buddy as-is, and enlightened users
can optimize for this specific kind of __GFP_ZERO interaction.

~Gregory
