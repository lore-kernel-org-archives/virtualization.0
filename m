Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575D137649A
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952626; cv=none; b=atsFy67+NV5PD7drul6S9ptVc8XRcF5SBChmb7BFgt0PE986+aow+GE26nd5ohAJLpCChTmrqjeJQVBogVMAAtuMcNBUOSC510CtmDf9lUPc5mHFxxHYZC45tZq+wZsBQQZNMxBUMNYys3X+TbN9a9P//tWwBeUPac9rvoG9t6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952626; c=relaxed/simple;
	bh=fL//XCAOIiyIn0ronmlF/wWx77EaGyvJmJxt2U5uk5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MHMNh+lufq/LNOCzZ/dKbayhd0HhWFApiu44iOdSI0yvLq3N3OhT/kKYQBU9hMhFa/yE0Zi74L/vkqKssS0/0WZ+PqOfrsYhemSfMlW877tLv2a8jP9cNZ9DVwqn1qhr9R1kVxiZ8kSWCDh+6DL1q1lN/J42GAimPqCkivlu3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5/g9VeF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5/g9VeF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780952624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yPKXt45eBuYwq4y81CcQcHJA9vR4mX15BetGx3tuktA=;
	b=i5/g9VeF+XvucJmZV37+NlMmZh5GS7ZOQKVaJCEuGDq5wZzPtukeYkBZrlHyv7ziERu+1V
	3tvL4tex5uE7qotzasqHbqEm5jUH7ducdvT/w/FNayuHDMpc9G5f6wCf1E7buEZT2V7Rn8
	D2wrTqqJlgBi4VJFPWhgYeq/qSzcqc8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-6PuT8G-WPFutxrqRJ9IMYw-1; Mon, 08 Jun 2026 17:03:36 -0400
X-MC-Unique: 6PuT8G-WPFutxrqRJ9IMYw-1
X-Mimecast-MFC-AGG-ID: 6PuT8G-WPFutxrqRJ9IMYw_1780952615
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef2bd566bso2602994f8f.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 14:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952615; x=1781557415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPKXt45eBuYwq4y81CcQcHJA9vR4mX15BetGx3tuktA=;
        b=SMTA0z/y3PkSkPIvTO//w/BcTz7Zhvc4mtTKhqbJihrS8SGfxr9/WO4pILdI/LU6on
         qojagdKv6mf2SB8390t8u2C93fEUqKPU/RVTuntMvpS1df6qicumAUQrvVXN3x+aQhST
         WspFXDyHW45GhstSmK5xAphgPpjEdQlZlviRVicHZxAU68mpE52U/CfFMUawj3FGEkfy
         uj2eUqL7Igp2ctfxnF1v/rQEykyholIuqZSwcawvOJgbhCHmfBf+GiGswZl5fOwseWCs
         UQ30fTdBbQ6wsCyDzIHTIRWxK0OIeFP6VMNI16syk9bT/BIYkqcmkSFC1wfHD0FLHvrX
         kClg==
X-Forwarded-Encrypted: i=1; AFNElJ8j2hKtNSSRwdonLvRAtWdVyKitfIhW99smwcgKW+4g8WuiAgGTHuzRQ/A+5Mhnxq3p1ck37/mJpg8sx2LUvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFAQ0ja7Z1S9EVc5qO0YGMKzAQtDjLyAQ239eTK9EoPH5qSUgn
	mg1G7+FHcIu7/h7vG1s7js3WaPt9G/WiM6y6qv7AVGZeZWr3niJ+2C/XT1DhFQ/T71g0rb1kM7g
	iXoZifjMorWV0cGUMrxtAJSRfuzdfaxURcRkYwn82rdCwY8JiS/X2oHzNDHKCTLCRl2dU
X-Gm-Gg: Acq92OF2zIGZQznpM9vROWLOcw3R8MrvrHwANkanQ9GeQ269TVvdIZqkhCbpV+UVWkQ
	WMw6x1WQLA3QFipYG0FcbDQfDVSa51J4S+yNIT9RWLLi1QkNsOeFPuBU+mEFKU31Vlp6UYeucHn
	op+ku841XxqrgkVOmCLs/8/Uk5/8U+lVeAxSw4zR902lq3n6wscS7Gp384Aw+6tRl4JzRYM5oaV
	DMP1oznYBTz8pZ+MywkYavGIiE13dnxkfU34tzwm16ubnkm9lQ2vPJhTO7+b/T8nrzTGHf2IVq5
	F+yo76K/7FykDZXfB11ZA1xQcQmQ0Yq975MBLV26FG6W5cOwJ0SLNIfXsSz73yIqJwdng75Mo/P
	2tq8XW6lTreQ5Uqiy4WPg6+FYQlfFp55TxhLnKP3vIZLOIjjV9h5reg==
X-Received: by 2002:a5d:5e08:0:b0:43d:77a8:3baf with SMTP id ffacd0b85a97d-4603062bc2amr28471158f8f.32.1780952615091;
        Mon, 08 Jun 2026 14:03:35 -0700 (PDT)
X-Received: by 2002:a5d:5e08:0:b0:43d:77a8:3baf with SMTP id ffacd0b85a97d-4603062bc2amr28471102f8f.32.1780952614599;
        Mon, 08 Jun 2026 14:03:34 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm58735162f8f.6.2026.06.08.14.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:03:33 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:03:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Gregory Price <gourry@gourry.net>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <20260608165819-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <50d410b47fe3f45327783e05bd306d5eaab75e65.1780906288.git.mst@redhat.com>
 <aiaUDTeHDA45ZXFS@lucifer>
 <64f2e580-aa82-4849-9236-b8ec4208ca24@kernel.org>
 <AEB19464-20A9-4C5B-97B8-681CCDD81031@nvidia.com>
 <2475e4c4-9ba3-4091-9bfd-1c1c15163da7@kernel.org>
 <aicbZ9lewv1wJqqS@gourry-fedora-PF4VCD3F>
 <8BB8D6E5-8644-4CBC-BAF1-0AA19702E042@nvidia.com>
 <aiclJGgB07L3rV-P@gourry-fedora-PF4VCD3F>
 <D754DEDB-3A3A-4F6E-BF64-79086F0A6467@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <D754DEDB-3A3A-4F6E-BF64-79086F0A6467@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0K6VhkQcIwZ1JW4Ngl9flOVH0adSLP9193xFQFq1t_4_1780952615
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 04:37:59PM -0400, Zi Yan wrote:
> On 8 Jun 2026, at 16:25, Gregory Price wrote:
> 
> > On Mon, Jun 08, 2026 at 03:52:20PM -0400, Zi Yan wrote:
> >> On 8 Jun 2026, at 15:43, Gregory Price wrote:
> >>
> >>> On Mon, Jun 08, 2026 at 08:39:10PM +0200, David Hildenbrand (Arm) wrote:
> >>>> On 6/8/26 17:27, Zi Yan wrote:
> >>>>> On 8 Jun 2026, at 7:08, David Hildenbrand (Arm) wrote:
> >>>>>
> >>>>> Or should we defer zeroing after a page is returned from allocator? So that
> >>>>> user_addr does not need to be passed through irrelevant allocation APIs.
> >>>>> Something like:
> >>>>>
> >>>>> alloc_page_wrapper(gfp, order, user_addr)
> >>>>> {
> >>>>> 	page = alloc_pages();
> >>>>> 	if (gfp & __GFP_ZERO)
> >>>>> 		clear_page(page);
> >>>>> }
> >>>>>
> >>>>
> >>>> Not really sure what's best here. I think we'd want to limit the lifting to some
> >>>> internal API, so it cannot easily be messed up by random kernel code calling
> >>>> into the wrong API and not getting pages cleared.
> >>>>
> >>>
> >>> We're a bit in circles on this.  We discussed explicit interfaces a few
> >>> months back and the trade off was:
> >>>
> >>> a) add user_addr to the existing API and cause churn
> >>>
> >>> or
> >>>
> >>> b) add special interface like above
> >>>    increase the buddy surface
> >>>    leaves open the ability for users to get it wrong easily
> >>>
> >>> If we forget VMs for a moment and break this step out separately, the
> >>> core question is whether page_alloc.c is the right place to be calling
> >>> the folio_user_zero() or whatever it is.
> >>
> >> page_alloc.c calling folio_user_zero() is fine, but my question is
> >> whether we should do the zeroing inside post_alloc_hook(), part of
> >> allocation.
> >>
> >> What I propose is to lift __GFP_ZERO up as much as possible,
> >> so that most of allocation code does not need to care about it.
> >> We do the zeroing right before the page is returned to callers.
> >>
> >
> > essentially we end up with something like
> >
> > alloc_frozen_...(..., gfp)
> > {
> >   folio = whatever(..., gfp);
> >   if (gfp & __GFP_ZERO)
> >     folio_zero(folio, -1); /* don't do cache flush part */
> > }
> >
> > alloc_frozen_user_...(..., gfp, user_addr)
> > {
> >   folio = whatever(..., gfp);
> >   if (gfp & __GFP_ZERO)
> >     folio_zero(folio, user_addr); /* do cache flush part */
> > }
> >
> > The downside of this is obvious: it's easy for developers to get this
> > wrong and call the non-user interface for user-bound allocations and
> > miss the cache flush (that is only needed on some archs).
> >
> > Not saying that's a deal breaker, but it's something to chew on.
> 
> I agree that misuse can cause trouble. But if we do the churn approach,
> what prevents developer from doing alloc_frozen(..., user_addr = -1)
> and using the returned page for userspace? It is possible the allocated
> page can be exported to userspace later.
> 
> BTW, that cache flush thing is fragile even today,

Probably arch dependent. On arm32, I think if you miss the flush, then
PG_dcache_clean will be clear and then you get a perf hit but
it's still correct. Didn't check others.

> you probably can
> do alloc_page() + vm_insert() to get a page without doing proper flush
> and export it to userspace. There seems to be no mechanism to
> prevent that.
> 
> Best Regards,
> Yan, Zi

Because maybe you want to expose data to userspace?


-- 
MST

