Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5503806CE
	for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162608; cv=none; b=L5BhjuL1lnd0+VsdJtlnbOIe7fl3Ao3xEYewJSGR6MoxoBwLiCyE0UHt6bPszrd+GgF8tF7fJ2JMm2STbXSbySWa2G9XBe0DEUs4sNXIxXCnR59DMr6pxsMVINQkBevC9NUmt4jGeHt3W5fvom6MlU1XUlNrK4RPVbtz9YhcqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162608; c=relaxed/simple;
	bh=Ci19rfdXCISbNs/xcEwIdN4jo28HEF3TdAXdbY3iDoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rdb4dS5yUM1SECXk3ac1W0Pl8LF1w2KWyASuhyQGFtIlibjqlYHF/4Lr2aiwf//BivrpBEO7MTQpgU8CYaUYu1SrzOKrf9xcnstu7KLMr33upF/U3x6alFoNf3LsMD18DWWVAPreJu0Rjz2VHO6uvCmuFtH2fTlVk2qHPIfGjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHS0O4GE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHS0O4GE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776162599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zCYL+ZoJzKHMQDin2IVxvP3VkJWBlHF10mQGVNRGJ/I=;
	b=KHS0O4GENBFEl+SPOxgvL5nz5tPmIujy+gWVKE00SOrLAQX6qNWKvYhx7LGDNDlxo19Nld
	adZ+GyqGaBIWA16buPk/gqZgETe7fu3VFS6Vt6vr87YOTB6u9gWxaTgfUIJjEKDAqBGIo5
	C5Wn7IhXAWixl/1zEylCOAeNsRTHwvE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-8EfjvtgqOwaJtmT7zQifXQ-1; Tue, 14 Apr 2026 06:29:58 -0400
X-MC-Unique: 8EfjvtgqOwaJtmT7zQifXQ-1
X-Mimecast-MFC-AGG-ID: 8EfjvtgqOwaJtmT7zQifXQ_1776162597
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c0fcc6deso33877215e9.2
        for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 03:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162597; x=1776767397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCYL+ZoJzKHMQDin2IVxvP3VkJWBlHF10mQGVNRGJ/I=;
        b=rlB5hO/PLgY7W8/C3WIFto47Ql+EprcaS3BcUyHWJznH1atDGoIT5KlYf6ymXQR7f/
         fe8jE5NHJzpCc96TwcgahltntpqX3EdsgxYouc9lH0/Fr4EzHs18P0nvhgue1g5xbBmF
         TVWZsm9fuSWWFBJ2bk1z17BLIgJANcn0VSlQeq/XDJZjg/6mbLQvxkCiMkG/qNa1SA7L
         g5DiFOrlS4gzeHbO2vzrsdYfBus9IfQZ3no3AY6deghoJcsP9ZtBZojkLEH7u1xa5dup
         hf8JTuTfGOJrlKru/3OXFXgJ3aX30ZAwffzDPvDL1yseNLRwT/FaMcSzr/0OcaMdvj23
         x57g==
X-Forwarded-Encrypted: i=1; AFNElJ9VLjckWUks06Sks5Mi8OQnop7VSL1UTEX6vu36cgHOTKgVC30xjQQmmq5SziHQoV0WdV1qqEQEPnyuxb9MOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWqn1vPSFNYtp2IXp6pvbIPqSttY23G+VhdaAcSuLevO5vG8Fe
	Aoo2TUTq2lQA5M4mxb2Gb/jVfsuCPN7BWhvRQ1l2fEvmACuQRaqak3ET/hNCixfbhmiEOODwdlx
	G9FGxMOSSD93zfQNPqglMoszHYTjvuVU1expbuA3+piJ7kGdOJ0UmT99Esj/MlWGsJzUDt215IK
	pn
X-Gm-Gg: AeBDiesQYBzKQ9sUhBFw9cR0vTWRWHwN4Tpyuk0J/aYIDnhcxW8Hc8iuHyGKIC7dOjr
	Q0CV5XH3dtky+ca8/k8uympkmjkL7OFT4or2nSox5pJ/VFW63c8zEohRDlQQBc/LHeILPckmtzz
	+uKl//pxmtWlhjYQGqLVER2HlrlUll8I3DqSGQB4RPgECfHW3avBRGNxaRQrjLRFszDi9qnxqyb
	+oqjtc2UPmj9uvfgi0hkg8iQQ/SpMj5vTyudFD2IPUnCnFz/jjQBL4AOiUuvBoEL/CL5TILtSsd
	wtxUTkfGYZbf+IKNuimo5zDcQhiouH4PFUUZkJsJLPhV3ogEspjGPDjel546udHOSM92ayT3q/e
	kEwqrbY7WbETFsoEc4Xmhbr8UHHzpyZT+UvWda9ucW9I=
X-Received: by 2002:a05:600c:34cc:b0:485:557d:9fe with SMTP id 5b1f17b1804b1-488d67e65e7mr221616795e9.12.1776162596761;
        Tue, 14 Apr 2026 03:29:56 -0700 (PDT)
X-Received: by 2002:a05:600c:34cc:b0:485:557d:9fe with SMTP id 5b1f17b1804b1-488d67e65e7mr221616355e9.12.1776162596244;
        Tue, 14 Apr 2026 03:29:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5dcf845sm118552305e9.11.2026.04.14.03.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:29:55 -0700 (PDT)
Date: Tue, 14 Apr 2026 06:29:52 -0400
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
Subject: Re: [PATCH RFC 3/9] mm: add __GFP_PREZEROED flag and
 folio_test_clear_prezeroed()
Message-ID: <20260414062524-mutt-send-email-mst@kernel.org>
References: <cover.1776033471.git.mst@redhat.com>
 <b21b0ba353330f24b9e10ee5bf01b60f32043327.1776033771.git.mst@redhat.com>
 <b258160c-5287-43dd-b56e-268c403b85ea@kernel.org>
 <20260413163644-mutt-send-email-mst@kernel.org>
 <da935245-9c75-4cf4-8a42-2c6328bd93f9@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <da935245-9c75-4cf4-8a42-2c6328bd93f9@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dtFt0ymg0kb6ACT1xCgqAx382Pg6Pykl3l1bAEMzH2Q_1776162597
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2026 at 11:04:04AM +0200, David Hildenbrand (Arm) wrote:
> On 4/13/26 22:37, Michael S. Tsirkin wrote:
> > On Mon, Apr 13, 2026 at 11:05:40AM +0200, David Hildenbrand (Arm) wrote:
> >> On 4/13/26 00:50, Michael S. Tsirkin wrote:
> >>> The previous patch skips zeroing in post_alloc_hook() when
> >>> __GFP_ZERO is used.  However, several page allocation paths
> >>> zero pages via folio_zero_user() or clear_user_highpage() after
> >>> allocation, not via __GFP_ZERO.
> >>>
> >>> Add __GFP_PREZEROED gfp flag that tells post_alloc_hook() to
> >>> preserve the MAGIC_PAGE_ZEROED sentinel in page->private so the
> >>> caller can detect pre-zeroed pages and skip its own zeroing.
> >>> Add folio_test_clear_prezeroed() helper to check and clear
> >>> the sentinel.
> >>
> >> I really don't like __GFP_PREZEROED, and wonder how we can avoid it.
> >>
> >>
> >> What you want is, allocate a folio (well, actually a page that becomes
> >> a folio) and know whether zeroing for that folio (once we establish it
> >> from a page) is still required.
> >>
> >> Or you just allocate a folio, specify GFP_ZERO, and let the folio
> >> allocation code deal with that.
> >>
> >>
> >> I think we have two options:
> >>
> >> (1) Use an indication that can be sticky for callers that do not care.
> >>
> >> Assuming we would use a page flag that is only ever used on folios, all
> >> we'd have to do is make sure that we clear the flag once we convert
> >> the to a folio.
> >>
> >> For example, PG_dropbehind is only ever set on folios in the pagecache. 
> >>
> >> Paths that allocate folios would have to clear the flag. For non-hugetlb
> >> folios that happens through page_rmappable_folio().
> >>
> >> I'm not super-happy about that, but it would be doable.
> >>
> >>
> >> (2) Use a dedicated allocation interface for user pages in the buddy.
> >>
> >> I hate the whole user_alloc_needs_zeroing()+folio_zero_user() handling.
> >>
> >> It shouldn't exist. We should just be passing GFP_ZERO and let the buddy handle
> >> all that.
> >>
> >>
> >> For example, vma_alloc_folio() already gets passed the address in.
> >>
> >> Pass the address from vma_alloc_folio_noprof()->folio_alloc_noprof(), and let
> >> folio_alloc_noprof() use a buddy interface that can handle it.
> >>
> >> Imagine if we had a alloc_user_pages_noprof() that consumes an address. It could just
> >> do what folio_zero_user() does, and only if really required.
> >>
> >> The whole user_alloc_needs_zeroing() could go away and you could just handle the
> >> pre-zeroed optimization internally.
> >>
> >> -- 
> >> Cheers,
> >>
> >> David
> > 
> > I admit I only vaguely understand the core mm refactoring you are suggesting.
> > 
> 
> Oh, I was hoping claude would figure that out for you.

We figured it out together)


> 
> Essentially, we move the zeroing of folios back into the buddy, by using
> GFP_ZERO.
> 
> user_alloc_needs_zeroing() logic would reside in the buddy and is no longer
> required in callers.
> 
> E.g.,
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 631205a384e1..44576ba3def5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5259,7 +5259,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>         gfp = vma_thp_gfp_mask(vma);
>         while (orders) {
>                 addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> -               folio = vma_alloc_folio(gfp, order, vma, addr);
> +               folio = vma_alloc_folio(gfp | GFP_ZERO, order, vma, addr);
>                 if (!folio)
>                         goto next;
>                 if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
> @@ -5272,15 +5272,6 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>                         goto fallback;
>                 }
>                 folio_throttle_swaprate(folio, gfp);
> -               /*
> -                * When a folio is not zeroed during allocation
> -                * (__GFP_ZERO not used) or user folios require special
> -                * handling, folio_zero_user() is used to make sure
> -                * that the page corresponding to the faulting address
> -                * will be hot in the cache after zeroing.
> -                */
> -               if (user_alloc_needs_zeroing())
> -                       folio_zero_user(folio, vmf->address);
>                 return folio;
>  next:
>                 count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
> 
> 
> folio_zero_user(), from where we would extract a function that operates on a
> page+order chunk, requires the address hint.
> 
> So we would have to pass that address. For example for the !CONFIG_NUMA case,
> something like the following could be done.
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 51ef13ed756e..29771c3240be 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -234,6 +234,10 @@ struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_
>                 nodemask_t *nodemask);
>  #define __folio_alloc(...)                     alloc_hooks(__folio_alloc_noprof(__VA_ARGS__))
>  
> +struct folio *__folio_alloc_user_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
> +               nodemask_t *nodemask, unsigned long addr);
> +#define __folio_alloc_user(...)                        alloc_hooks(__folio_alloc_user_noprof(__VA_ARGS__))
> +
>  unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>                                 nodemask_t *nodemask, int nr_pages,
>                                 struct page **page_array);
> @@ -291,6 +295,18 @@ __alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order)
>  
>  #define  __alloc_pages_node(...)               alloc_hooks(__alloc_pages_node_noprof(__VA_ARGS__))
>  
> +static inline
> +struct folio *__folio_alloc_user_node_noprof(gfp_t gfp, unsigned int order,
> +               int nid, unsigned long addr)
> +{
> +       VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> +       warn_if_node_offline(nid, gfp);
> +
> +       return __folio_alloc_user_noprof(gfp, order, nid, NULL, addr);
> +}
> +
> +#define  __folio_alloc_user_node(...)          alloc_hooks(__folio_alloc_user_node_noprof(__VA_ARGS__))
> +
>  static inline
>  struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
>  {
> @@ -342,7 +358,7 @@ static inline struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int orde
>  static inline struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
>                 struct vm_area_struct *vma, unsigned long addr)
>  {
> -       return folio_alloc_noprof(gfp, order);
> +       return __folio_alloc_user_node_noprof(gfp, order, numa_node_id(), addr);
>  }
>  #endif

> index ee81f5c67c18..28f448f40b75 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5260,6 +5260,13 @@ struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_
>  }
>  EXPORT_SYMBOL(__folio_alloc_noprof);
>  
> +struct folio *__folio_alloc_user_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
> +               nodemask_t *nodemask, unsigned long addr)
> +{
> +       /* TODO */
> +}
> +EXPORT_SYMBOL(__folio_alloc_noprof);
> +
>  /*
>   * Common helper functions. Never use with __GFP_HIGHMEM because the returned
>   * address cannot represent highmem pages. Use alloc_pages and then kmap if
> 
> 
> As alloc_user_pages() resides in the buddy, it can just honor any
> buddy-internal "pre-zeroed" flag.
> 
> 
> Once you are in page_alloc.c you can access internal allocation functions and
> take care of that without GFP flags.
> 
> -- 
> Cheers,
> 
> David


Pretty much what I did, except I felt it is better to change the
existing APIs. A bit more churn, but in return there's less of a chance
we forget to pass the user address.

Because, if we do, the result works fine on x86 but corrupts memory
on other arches.


-- 
MST

