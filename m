Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24D0288B1
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950314; cv=none; b=dP3EFnwbq3n2vRiwzqxsAjB5t3+F4lQuL/NEGWIX7jssT3LBE68HOd9vZeZ0KdqlcDZ3OLW1TjO7rPzYusUjvbn2rtMoNvISNbMcU6ZIzfoAi7sMVxA9juQAVmbQLeQuGO52e1p6ytu4ptCCMB+yeW3/KDW5MR4lqqbBgcOucVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950314; c=relaxed/simple;
	bh=ImfI2N5lsSbY8ZIrrjW/GdrRf15xOOnh5SqHf/0DTwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEkcQG3NDaos8LWz7S4Bfhngm1/RooGzCnUtrbKIZVs0UuNfmZMzerWwozEWbz+FJ8DIOnmLUkFEGFQzxO2Bh2DOMVjuuLT4Wb/OnCjYY+JUDkO9nUa91Ch/r2D7BN86d2YEIqv+74dapc/hvXHUJzt/wSTZUpNNBiBIBKIrI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=i/vXWeRA; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="i/vXWeRA"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ce9ddeddefso52971626d6.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 13:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780950312; x=1781555112; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CLdOd3zAkOhu7t1Gmww+B7T7VImh1oQ+8y8VHy5V/0=;
        b=i/vXWeRAyDQ6VLI004H3EnvObT5jdm375i2Hzdd6GcwlvHUtIU+611KL662kHX6Yt0
         8faKTZpuQuZ5QksIpCPpJ0fJMF7C+YL4SjWR2J2Pf6fx6xWec/gPvLdeuNJ9A2akGUHS
         1nSgdDRpNDwCkICiIVFQfg8NZ/dCJhve+dPm3QiIVwwjVfFjIEynIiHPFd+iZn8D6eHj
         B1u95QGIV72r4eEZ1pzQP+kxReBeFMG/polSrWHho976OpbM+jbyzwznLE77RJchSrS0
         f7O0p1JwY0JfxHG+H4sRlYb987Fz3kOdD9hJCb6NVtdeWObxNOcnXOCIogFSUTSaK6qb
         JXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780950312; x=1781555112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CLdOd3zAkOhu7t1Gmww+B7T7VImh1oQ+8y8VHy5V/0=;
        b=Ix19gIZiBs/bInaH888GbT6+Rv0fwQsi3pZHqfMrwXYfpE/iARC+iBQSb3mbqmYUyb
         FvMhCbn50CFUL1ykN6s+1gLmd84pQqi2sg6V9JCORrCoRig5UPJ2dgdupvRHKJIZShUQ
         1RzIzBF/9l6mriw9r9eyyoYs6HVMLN8Ehk/7O2cgmYr5GFCaTbrLjKIz/mRzEGUxOZPv
         KC9680RzluPpxytm9Q6/0gVn5z2GjYEM+yBtjs9W8dcJyV9F38Q6LKzCDZZO/pkVLToz
         x7qMwvWW0tvAVaDy/Qgwu2jdEjROXfYQyqXGOMhj6VANRMecr41H0TrOnQv2rDZHNVAw
         b00g==
X-Forwarded-Encrypted: i=1; AFNElJ/3FBggj/XyuGATnB13mW1F86bdbnV28OUUFT4FWQAaH245sWu5Z7uhVcN1f9myk5rgPGd5yioSv7SxdSwE2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzsn/OvmDbyZlKHzn4uZYHiVO0GiPXviRqsWk4U91RAdvUbyQnu
	k9/KbwCMYegKU4iscUVXCHKfqxNLN63ihJv96tozyeqLSM1QF800qF9gL/+9nU17E8U=
X-Gm-Gg: Acq92OELdR7Eqq8MYq0yjKF4gzyKkBTK241Jw5IaGi5YWg4DnNoQQY4p2xGYrFIbhtt
	ZUoRfghya8fuL9dQRDZnvvZHgzG8Ktt20fHFPoVXWUnR8wpLMk7oWIz3xy5ihnZv9zEZM3K3UmV
	Hfvm1OH13HvTHv9gFGms+mEHS9VLzE3kROI7gKktNdFqAsnpP3QtOxQxIIBS2RJrd0mbw5g+4WZ
	i/ff/p1/VLRJYs5yA55EqeZ+73Abez4s/4wbP0+K7tbUvqvnpWI7rEuJ16JZpDusrh/W3W8dNDG
	nhH0aLmXARW2FwHU+D/AXi2KVu57nftybMXHxL4QdwDW5Jk+RI+c06/fx8xKO1r7ROnaT8OewPQ
	vkO9h2YjShyOAex48G+j0yAPZcOEbHJJ9Q9nixxxnDCoU5hOuYBYr4GeGAEnI5WOlTu7P4M34sE
	GS4KuQtSOwY9KVwq63u8+Kj4f1UL/8OCWpIVZ7Za8z4cmlR+Ki+snXclwstjqUjJYvUI5AEFbdY
	k1WMJSEphamI6yVJw==
X-Received: by 2002:a05:6214:2aa4:b0:8c4:edb4:a44a with SMTP id 6a1803df08f44-8cee62657aamr283094386d6.23.1780950311379;
        Mon, 08 Jun 2026 13:25:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd0520d3sm177019896d6.27.2026.06.08.13.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:25:10 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:25:08 -0400
From: Gregory Price <gourry@gourry.net>
To: Zi Yan <ziy@nvidia.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
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
Subject: Re: [PATCH v10 07/37] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <aiclJGgB07L3rV-P@gourry-fedora-PF4VCD3F>
References: <cover.1780906288.git.mst@redhat.com>
 <50d410b47fe3f45327783e05bd306d5eaab75e65.1780906288.git.mst@redhat.com>
 <aiaUDTeHDA45ZXFS@lucifer>
 <64f2e580-aa82-4849-9236-b8ec4208ca24@kernel.org>
 <AEB19464-20A9-4C5B-97B8-681CCDD81031@nvidia.com>
 <2475e4c4-9ba3-4091-9bfd-1c1c15163da7@kernel.org>
 <aicbZ9lewv1wJqqS@gourry-fedora-PF4VCD3F>
 <8BB8D6E5-8644-4CBC-BAF1-0AA19702E042@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8BB8D6E5-8644-4CBC-BAF1-0AA19702E042@nvidia.com>

On Mon, Jun 08, 2026 at 03:52:20PM -0400, Zi Yan wrote:
> On 8 Jun 2026, at 15:43, Gregory Price wrote:
> 
> > On Mon, Jun 08, 2026 at 08:39:10PM +0200, David Hildenbrand (Arm) wrote:
> >> On 6/8/26 17:27, Zi Yan wrote:
> >>> On 8 Jun 2026, at 7:08, David Hildenbrand (Arm) wrote:
> >>>
> >>> Or should we defer zeroing after a page is returned from allocator? So that
> >>> user_addr does not need to be passed through irrelevant allocation APIs.
> >>> Something like:
> >>>
> >>> alloc_page_wrapper(gfp, order, user_addr)
> >>> {
> >>> 	page = alloc_pages();
> >>> 	if (gfp & __GFP_ZERO)
> >>> 		clear_page(page);
> >>> }
> >>>
> >>
> >> Not really sure what's best here. I think we'd want to limit the lifting to some
> >> internal API, so it cannot easily be messed up by random kernel code calling
> >> into the wrong API and not getting pages cleared.
> >>
> >
> > We're a bit in circles on this.  We discussed explicit interfaces a few
> > months back and the trade off was:
> >
> > a) add user_addr to the existing API and cause churn
> >
> > or
> >
> > b) add special interface like above
> >    increase the buddy surface
> >    leaves open the ability for users to get it wrong easily
> >
> > If we forget VMs for a moment and break this step out separately, the
> > core question is whether page_alloc.c is the right place to be calling
> > the folio_user_zero() or whatever it is.
> 
> page_alloc.c calling folio_user_zero() is fine, but my question is
> whether we should do the zeroing inside post_alloc_hook(), part of
> allocation.
> 
> What I propose is to lift __GFP_ZERO up as much as possible,
> so that most of allocation code does not need to care about it.
> We do the zeroing right before the page is returned to callers.
>

essentially we end up with something like

alloc_frozen_...(..., gfp)
{
  folio = whatever(..., gfp);
  if (gfp & __GFP_ZERO)
    folio_zero(folio, -1); /* don't do cache flush part */
}

alloc_frozen_user_...(..., gfp, user_addr)
{
  folio = whatever(..., gfp);
  if (gfp & __GFP_ZERO)
    folio_zero(folio, user_addr); /* do cache flush part */
}

The downside of this is obvious: it's easy for developers to get this
wrong and call the non-user interface for user-bound allocations and
miss the cache flush (that is only needed on some archs).

Not saying that's a deal breaker, but it's something to chew on.

~Gregory
