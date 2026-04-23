Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5653BD64A
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776945434; cv=none; b=Vg6Y9s74eU7lwx1X9DitNINSTDtQ+w0z+VnfQofvUJ/jtaHSbuKBuqZttsMGLv/Kp+FO3cW1/xDzNB2mfd0jPNPljh01DLjkM+0tPVSWDByYCCVIsqWygJYUGp7r4ulKMTMm7tArQVcJJLDUl8K3yA19d4PC2JHcw5mDS2MtGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776945434; c=relaxed/simple;
	bh=cerLyyGsxZbpGHR7Ohl2x/Kc4s1l02lVCZCqTvZs2Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RbtWtp8mQZnCl8j5B5ofZLLuNMT6rX+RIHVMTWyVYSYA7RMZqXa1bHQ+U46sM0c724bTs2UA1DGz0J+5iw/dWqBr16VojZzsTQxGQ+F75iJyf+zQxbaNxjAOCYNZa+nEHaP3MkLVyRp1SxuPmRY1i1XEvTdhz3buPLqlCWwXQf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lopnv4Fy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lopnv4Fy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776945432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jMZWtfjIWNO/JysIhn7eMR9XhBiqbQQjvoPhb55A6AY=;
	b=Lopnv4Fy4FBYYtT5uZcHZJM/JxJrRn4AuTZ0uigqu6Jn0U6LC0euWRpWChXirJB8pyVuaZ
	FXa8Lml7XIeb8YGFITDPincfWWgjtQeNEWtbkL5nhoUUR18R2r9/qf/Q9IKSH8yrnoiF15
	DuzCuqOwB92Gbdpz7iYS+LhFx+H+xQE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-B04SuH01PTW81O2jERvFNg-1; Thu, 23 Apr 2026 07:57:11 -0400
X-MC-Unique: B04SuH01PTW81O2jERvFNg-1
X-Mimecast-MFC-AGG-ID: B04SuH01PTW81O2jERvFNg_1776945430
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so73268525e9.3
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 04:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776945430; x=1777550230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMZWtfjIWNO/JysIhn7eMR9XhBiqbQQjvoPhb55A6AY=;
        b=iqhcetv02RfDkz9tfZg6t1YvGgmlyBWXfn+RDPxBj17PCijHY8SVHKS0iOpuXW7TaL
         Ojz/RzyC5hDe9s0UXt7w83TxFOzEjmgq2VgITmUZlrlAFPWRgeLYq8M5UK9igX3CJt4J
         RkPclBw1kGvNLNsu8kf9y7vZ8z1gP3PYLqqHHfuCIWpgQwKyfPMMPtrjSatKHQ4VTX2v
         sDyPCnaXILuBvBr0hTafVmpm0Wtl8w7DSxL/wxxndqM5zDHGLipTNuW3zX1O1WS4ozgS
         tDwkFUaZRYSV0a1MO3Sh8rjSyzO49CLd93GSUSilj9saBRfBOl4Kh+N4GPPF9kBFgSgR
         JQNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JGxuklgd5LWqwasgweCaORIT0PKvnZAh7TeS8/NYfAd1c/+uxZActru74KJhtPJDI5aJ2h+8YZjdHHsXieg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7Ry0thU/wfP3Hrnrdoy/u3B4/6cfRLa8dFO0dosKSL06SVwXL
	dWlG+cTptY6EAHckY+5TXhKEKWjelAXUJLwXltAz4BbkDPZCI629AQD27AD/CyESTbgnNbKllkN
	e241b9BlCC6HmAC4leE/d6t+M4eqlOFFQw934MZRfqJ/McvOg8be71+RpYEvxDiE+idZJ
X-Gm-Gg: AeBDietbYosgSpwPSt0ltTSoYMC0vk19BKIb8KSr4SCcqOK7Iw1Jb8Ip49MMMvfAPQH
	Bc4BL8kxEbeUbw6hh3ykE7b4ozFYEatgts+xkwqbHOuPt1TnHzKnbHPM9PgKUnuIUDmDlDIzhjE
	Nok6aWAFfRBLdAERMVhhCjcKcg8kdtWmabkehLBm4j7Mfp1GgS+x41LJ/Qf5jh26gaICCHRivGN
	M5PqXmOIulgAG3odIXvajz4H8ZDg7/bN3ZRpqebJFBvEii9Pky6KVMZ7H2wZ3/eQW5inR+zUZCC
	twH8kafDBWCe98cbKSVSFhd2fuJ48WEGRSWaDYyFGOBMo2wGj/oRhW2IN7wfn+o9qZmhimzA65A
	fchZdtFHtN1xa2Be7BxNnhkQR3ob+63Q8/evf+evvqFgYKoYJ3yppYg==
X-Received: by 2002:a05:600c:8b4b:b0:489:1ff1:74f4 with SMTP id 5b1f17b1804b1-4891ff17707mr203280375e9.4.1776945429785;
        Thu, 23 Apr 2026 04:57:09 -0700 (PDT)
X-Received: by 2002:a05:600c:8b4b:b0:489:1ff1:74f4 with SMTP id 5b1f17b1804b1-4891ff17707mr203279475e9.4.1776945429042;
        Thu, 23 Apr 2026 04:57:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7bf7besm184344495e9.34.2026.04.23.04.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 04:57:08 -0700 (PDT)
Date: Thu, 23 Apr 2026 07:57:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20260423074433-mutt-send-email-mst@kernel.org>
References: <cover.1776808209.git.mst@redhat.com>
 <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
 <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
 <20260422171315-mutt-send-email-mst@kernel.org>
 <aemglPlcwFFHNj1A@gourry-fedora-PF4VCD3F>
 <c165d6af-4a35-4a41-9086-ee307640c044@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c165d6af-4a35-4a41-9086-ee307640c044@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zAh-7pqO0FUpxutiU5x0xHJkgsFGIR5KyAJF6U6S9MQ_1776945430
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2026 at 11:46:56AM +0200, David Hildenbrand (Arm) wrote:
> On 4/23/26 06:31, Gregory Price wrote:
> > On Wed, Apr 22, 2026 at 05:20:27PM -0400, Michael S. Tsirkin wrote:
> >> On Wed, Apr 22, 2026 at 03:47:07PM -0400, Gregory Price wrote:
> >>>
> >>> __alloc_user_pages(..., gfp_t gfp, user_addr)
> >>
> >> With a wrapper approach, looks like we'd need something like
> >> __GFP_SKIP_ZERO so post_alloc_hook doesn't zero sequentially, then the
> >> wrapper re-zeros with folio_zero_user().  But then the wrapper needs to
> >> know whether the page was pre-zeroed (PG_zeroed), which is cleared by
> >> post_alloc_hook before return.  So the information doesn't survive to
> >> the wrapper.
> >>
> > 
> > I was thinking more that internally you already have that information
> > you need to know to skip the zeroing - and so the wrapper can just pass
> > __GFP_ZERO and post_alloc_hook() would do the right thing regardless
> > 
> > Then on the way out, the new wrapper would take care of cacheline piece.
> > 
> > However, i explored this a bit - and while it saves some churn on the
> > interface, it adds two paths into the buddy - and that increase in
> > surface might not be worth it.
> > 
> > So I see the tradeoff here.  The churn is probably worth it.
> 
> In v2 I commented [1]
> 
> "
> For example, instead of changing all callers of post_alloc_hook() to
> pass USER_ADDR_NONE, can we make post_alloc_hook() a simple wrapper
> around a variant that consumes an address.
> 
> So isn't there a way we can just keep the changes mostly to mm/page_alloc.c?
> "
> 
> That should avoid most of the churn outside of page_alloc, no?
> 
> [1] https://lore.kernel.org/r/4bdc66f2-1469-4b91-9935-74c3d3ca0ed9@kernel.org
> 
> -- 
> Cheers,
> 
> David

Yes I'm sorry I missed that one and didn't answer it. My bad.

To answer the question, no, definitely not *most*. Here are some numbers:

What we save: 11 one-line changes adding , USER_ADDR_NONE in callers
that don't care about user_addr (compaction, filemap, khugepaged,
migrate, page_frag_cache, shmem, slub, swap_state).

Changes we have to add: 8 changes
Rename 4 existing APIs adding _user: __alloc_pages,
__folio_alloc, folio_alloc_mpol, __alloc_frozen_pages + add
4 wrapper macros/inlines in gfp.h that forward to the _user variants with
USER_ADDR_NONE. Roughly 6-8 lines of boilerplate per API.

 
What stays the same, but now has to call the new APIs:

all internal plumbing (page_alloc.c, mempolicy.c, internal.h, hugetlb.c,
the actual user-page callers in memory.c/huge_memory.c/highmem.h):
38 calls, of these 21 in page_alloc.c, 17 outside it.


The changes would be less trivial to review, too. And I would not call
the resulting very long names "elegant".

More importantly, it makes it harder to review: instead of
compiler checking we did not forget a parameter, it compiles fine,
but we get a subtle slowdown or corruption on non x86.

And I thought you agreed with this sentiment when you said
"yea something that is harder to mess up would be nice":
https://lore.kernel.org/all/20260414062524-mutt-send-email-mst@kernel.org/




From where I stand, we would adding technical debt by piling up new
wrapper APIs, for no benefit.

But then, I'm not the maintainer here. And adding extra wrappers
is easy for me. So, let me know. Thanks!


-- 
MST

