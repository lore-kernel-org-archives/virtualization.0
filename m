Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC095392C5D
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068961; cv=none; b=JxyR0ZA1+heLug9G955BJlGdV1p1QBFZDKmZUlTphITEWd+BYWoL3O/fvycPx7CAzeJ5ybBfYNr+NoOBTQEN06zP+X0GRRKPs9M2u3gusXNSBMyy/VD2IM3d8vgw+8kfKHiOoHEALSnSSY2APHAvUBHzgHhqUt7DpWnGRY4rssM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068961; c=relaxed/simple;
	bh=IynBP1xNxhC0gDIWmoXTYME2eIumM1yWHA/A/mJzrOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=o5uOfR97U1Ggq1lu9OALYVU7MMM7BWLvtZgHyOT2Z682aSiTwKxBfZLtqwerzzcN1x3ptw/xjaMPvtazob7+0gCeJ55nUkFLIVo5cy0Jl6weobc+g3ZuSet80I3PBJ5f3gWuYFRIkH/Gpwif5SJso0++ZD8BePTUMWstZyWrS34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ze1lo/8K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ze1lo/8K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776068959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d7T2EfZlOhL6EGzqfce/4yeDNVNuR7hO+mhzu7kbbMs=;
	b=Ze1lo/8KqCLfhfZITwUMOvoFlRUJE0znSIKpAEuCAP4KK3a4AmJIOFIPdWqYbMSq+b2cod
	CcPtMd6xOuKRzbm6TuSI/00215kMg9+/sEUaL4j4nCeCzA2NFuTsCvCMWHYYzPFMlToMne
	14qgkcUyxcuRiv7/4xH6eYoKiFurMpQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-n7hbUhz5MlyjkmujeMkyeQ-1; Mon, 13 Apr 2026 04:29:17 -0400
X-MC-Unique: n7hbUhz5MlyjkmujeMkyeQ-1
X-Mimecast-MFC-AGG-ID: n7hbUhz5MlyjkmujeMkyeQ_1776068956
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d1ceb2ddfso3776626f8f.2
        for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 01:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776068956; x=1776673756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7T2EfZlOhL6EGzqfce/4yeDNVNuR7hO+mhzu7kbbMs=;
        b=QWzTdo89mikSGuFP4MHFx8OkTLmyM6src4GSPpb4hHH2+J0TDHhWGD2k6Z/9qaQNS0
         3ZZq8eYcmnW46qMOOo5orSdc37e2kuBArxB08uZyCMTWdbntVqcXTQ2NiO7COCAZ4+Ji
         OPFSj1H1FQodBybTyP11t+ZV4VkNcIfOjVrqHNlB48Kz7xUSwOdWjmuKH9gm4Ip/g+BW
         6vQXFSHy5GuibLRJuv/dbqGOjNg8YWGZ0gEnsSOhykuBNquZr2zyqhOcJTFnOmslw4zk
         /cJv2HYnEasiTMHAyPHaxr5JyNIF8N2RgidH02sSZFIyCb+FBfYRyD5M2ck82F1mlg5t
         ZRyg==
X-Forwarded-Encrypted: i=1; AFNElJ/nJCKvrUsBPUul85jVh6cZjouNdhd8OBCFXTZMMB4veoLhMXUxKw19m34C0nDUCzcDYo8s/yCS4UruTmvIrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJW7z9maPQqNihUHRuedlvuLKRvRfONHIay9PfWDvBwblMFlfJ
	JRtv1ZNh2wDIIItXgmMMsFTMC7YER8tGofL8uIjEJv+PuX0c+J61fKV1kO3w0wwLIwN4Eaxxk3K
	gs3fisysjwdfsKHE5DsTaCXGzlYwgicWw1rSgbIRvZ4scg9soXfVAQyIPbhvji+oRTzkW
X-Gm-Gg: AeBDies/nn9mnw2h30ffsck465rfIcmWQgEtYFgNXJF+IyA0uUoeN+KYI60Ww24+ZTH
	BMU0cJTSF7QKpK//hKFiitqjKKJEjZLck4u7gMlDHIwsFSPKoo7wsPYt9mreVmkyzynJBkjPsUd
	z3jKZGYHZuA4o11GvvRcey7WXyAFzoa7SLzzJyzehwdV1jwfh7zpNiikKjFFKIwSn02hr1a45RW
	mq087/sMSprObP0nj/znDWKBSOj5mPWIbdW8bVZpbwcAx/s4LlGceOJFGwNkt+sAmFqxIT/ADGw
	4isw7I9ZiR3/pQlZmQy4y14PLi5eCuB8XX2VyqXxSwFd1m3P2dD1yoxjf0Wu9CdczmyQ+eRLCJA
	D49d2BcIa6mu6ylxfgLhBxrs9do5kUE5gsSZAOPgrvsM=
X-Received: by 2002:a5d:5f86:0:b0:43d:2be:e54 with SMTP id ffacd0b85a97d-43d642b5035mr18655081f8f.39.1776068955983;
        Mon, 13 Apr 2026 01:29:15 -0700 (PDT)
X-Received: by 2002:a5d:5f86:0:b0:43d:2be:e54 with SMTP id ffacd0b85a97d-43d642b5035mr18654999f8f.39.1776068955408;
        Mon, 13 Apr 2026 01:29:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7bd2f237sm3321886f8f.23.2026.04.13.01.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:29:14 -0700 (PDT)
Date: Mon, 13 Apr 2026 04:29:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH RFC 2/9] mm: page_reporting: skip redundant zeroing of
 host-zeroed reported pages
Message-ID: <20260413042505-mutt-send-email-mst@kernel.org>
References: <cover.1776033471.git.mst@redhat.com>
 <ea67e39bc3aea1b0b491908f851ffce25154cd26.1776033771.git.mst@redhat.com>
 <2155527a-e077-4b71-80ee-d735f9984f60@kernel.org>
 <20260413040143-mutt-send-email-mst@kernel.org>
 <4e1b349b-d0df-4ad5-8050-9a2b3b3831ac@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4e1b349b-d0df-4ad5-8050-9a2b3b3831ac@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vMkxX012wucL1xTuTpeukSV7qJONVBm6cCkDlTSpHuE_1776068956
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2026 at 10:15:08AM +0200, David Hildenbrand (Arm) wrote:
> On 4/13/26 10:10, Michael S. Tsirkin wrote:
> > On Mon, Apr 13, 2026 at 10:00:58AM +0200, David Hildenbrand (Arm) wrote:
> >> On 4/13/26 00:50, Michael S. Tsirkin wrote:
> >>> When a guest reports free pages to the hypervisor via the page reporting
> >>> framework (used by virtio-balloon and hv_balloon), the host typically
> >>> zeros those pages when reclaiming their backing memory.  However, when
> >>> those pages are later allocated in the guest, post_alloc_hook()
> >>> unconditionally zeros them again if __GFP_ZERO is set.  This
> >>> double-zeroing is wasteful, especially for large pages.
> >>>
> >>> Avoid redundant zeroing by propagating the "host already zeroed this"
> >>> information through the allocation path:
> >>>
> >>> 1. Add a host_zeroes_pages flag to page_reporting_dev_info, allowing
> >>>    drivers to declare that their host zeros reported pages on reclaim.
> >>>    A static key (page_reporting_host_zeroes) gates the fast path.
> >>>
> >>> 2. In page_del_and_expand(), when the page was reported and the
> >>>    static key is enabled, stash a sentinel value (MAGIC_PAGE_ZEROED)
> >>>    in page->private.
> >>>
> >>> 3. In post_alloc_hook(), check page->private for the sentinel.  If
> >>>    present and zeroing was requested (but not tag zeroing), skip
> >>>    kernel_init_pages().
> >>>
> >>> In particular, __GFP_ZERO is used by the x86 arch override of
> >>> vma_alloc_zeroed_movable_folio.
> >>>
> >>> No driver sets host_zeroes_pages yet; a follow-up patch to
> >>> virtio_balloon is needed to opt in.
> >>>
> >>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>> Assisted-by: Claude:claude-opus-4-6
> >>> ---
> >>>  include/linux/mm.h             |  6 ++++++
> >>>  include/linux/page_reporting.h |  3 +++
> >>>  mm/page_alloc.c                | 21 +++++++++++++++++++++
> >>>  mm/page_reporting.c            |  9 +++++++++
> >>>  mm/page_reporting.h            |  2 ++
> >>>  5 files changed, 41 insertions(+)
> >>>
> >>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>> index 5be3d8a8f806..59fc77c4c90e 100644
> >>> --- a/include/linux/mm.h
> >>> +++ b/include/linux/mm.h
> >>> @@ -4814,6 +4814,12 @@ static inline bool user_alloc_needs_zeroing(void)
> >>>  				   &init_on_alloc);
> >>>  }
> >>>  
> >>> +/*
> >>> + * Sentinel stored in page->private to indicate the page was pre-zeroed
> >>> + * by the hypervisor (via free page reporting).
> >>> + */
> >>> +#define MAGIC_PAGE_ZEROED	0x5A45524FU	/* ZERO */
> >>
> >> Why are we not using another page flag that is yet unused for buddy pages?
> > 
> > Because we need to report the status *after* it left buddy.
> > And all flags are in use at that point.
> 
> I'll comment on that on the other patch, where __GFP_PREZEROED, which I
> really hate, is added.
> 
> > 
> > 
> >> Using page->private for that, and exposing it to buddy users with the
> >> __GFP_PREZEROED flag (I hope we can avoid that) does not sound
> >> particularly elegant.
> > 
> > But propagating this all over mm does not sound too palatable, right?
> > There's precedent with MAGIC_HWPOISON already.
> > Better ideas? Thanks!
> 
> I'll comment on the __GFP_PREZEROED patch.
> 
> > 
> >> Also, if we're going to remember that some pages in the buddy are
> >> pre-zeroed, it should better not be free-page-reporting specific.
> >> I'd assume ordinary inflating+deflating of the balloon would also end up
> >> with pre-zeroed pages. We'd just need a (mm/balloon.c -specific)
> >> interface to tell the buddy that the pages are zeroed.
> >>
> > 
> > Indeed, it's also easily possible - it's a separate optimization, though.
> > Another simple enhancement is including hugetlbfs freelists in page
> > reporting.
> > Doesn't need to block this patchset though, right?
> 
> Not blocking, but I don't want something that is too coupled to
> free-page reporting optimizations in the buddy.


I can add that in the next version if you like, sure.  The main issue is
that it means we need a flag that survives free.  And the benefit is
much smaller - unlike page reports, deflates are rare.

> The comment above
> MAGIC_PAGE_ZEROED triggered my reaction.

yea, that's more confusing than helpful.

> -- 
> Cheers,
> 
> David

