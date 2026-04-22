Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3879328B7A
	for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892841; cv=none; b=H8o+ixHksvxP1P95Ijv+ye3pv8ZKNIqmPbn/OnaYiHlGtIJBkVf3WDN8Fy+1mzklmqskW4NNIRXvVt7YfQ6eJWDKNpLienaUbTukQC6Lsp8ZkFnAdhPtSYkM8GHCtvNYMZUb+lkck9TifS0Nl5eABj+89SM7ZuYEUrTaepobwY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892841; c=relaxed/simple;
	bh=6SyZvBrbf+USjtmnc7xlaVRQIMYtEt4QvTpWJfC1Iso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QSu9/+wpy2vKSN9evW3dqmV6+zbTML9RO3dIg8JJqr5bmLqdeZBONtF7Nrzzi3RwOAePQdPfkFb5OO1RWDCtkSTCTBxyDw4JFFQ9nE9dbdoTNh+U1tLAc+rHI6qP1uWNcpHYFy7+Zpeu9ijiQhWq+aqxFHqIQX+t2fDpxJ5s0kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnF32aIi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnF32aIi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776892839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AuBD0WIXDzq4C1LKbO1zkVvixca9JBQuddXhofRNlk=;
	b=bnF32aIiXQ9h0gDuqekKWX731rxMgupX05BDsx15SwCrqPMY5r0OIj64l5EwXNMFJBpGMd
	N8DaNc9V+GEJNe0ykrII9HC3cEZaMLipD0K/jsFsPyRRuXkxT/ftJ4M/9mwDtIQ9Qg6y3+
	U2mCMrgAwGzGtPRVslXd1p/iy2jTpaE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-suzxSix8P7Klsa6-nG8tKQ-1; Wed, 22 Apr 2026 17:20:35 -0400
X-MC-Unique: suzxSix8P7Klsa6-nG8tKQ-1
X-Mimecast-MFC-AGG-ID: suzxSix8P7Klsa6-nG8tKQ_1776892834
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a5523fd53so13467805e9.3
        for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 14:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776892834; x=1777497634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AuBD0WIXDzq4C1LKbO1zkVvixca9JBQuddXhofRNlk=;
        b=ExQwinA49VRk8+alDyIRWC2Vi36rO9BUgLrJkmpg7UR6Mkf8MSpQ7nc14+TQAoaMBv
         C+1UwxZ9d7DGz8f3CMNT7s2gSAO4HJkPWzY/uK6gA7sRNP9zXNUJQwdNgQ3v3pJ18kKd
         AXf5268ly/7oiHdiYuHFNYO9r1vLdwy4Rtz7Qh0RtOWX8t0W89Z4xIGYdVnBdgkkV/UK
         5cbCl9pr54aCYD93WSNhMh5Oypi1fza5vV5fG1Y39kxGQpRUqARAfG1x7wHD2mg6dooO
         rfGpk4mgaY9/gcSrWXPDPASFZRVq/q/04C6yHpSLos/7AmW0yZ5OZ4TY+DwgE6C3eFfv
         TdCw==
X-Forwarded-Encrypted: i=1; AFNElJ90Yw3O3X440wj9g+B0pcteaxWgY1HfLb0kOmI1zdxZXqh1G6bIQsunTT8SSShCX/U+UGNlY4miB3ntdf2RKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPspIio5nNh6R124A4MPc7HzIwFC9VnaJOvvI5kyvFYor+OjRe
	bFnAdB6Tf51Wm7xhzKpmHVJ7A0NWqXqb8emlIzCCFbovH6suESqmeYfbkGDnto8u5ZMAP6umU1h
	pW8A/SFEVi1iQb/5cfZsqohzNvAetVjGWIGj7b6n4sIpmZMJ1ArYmyegMAuhkkIhaLZgU
X-Gm-Gg: AeBDiesfHg8U+Tu2L7uQq+oFTRUsmOPkQ8kmgguOhpZZqHWqSUOuSs1yTyst240w6HY
	S4Vhj/1efuYFFq9qTejMg2TIYIMeGgIM/hTPrShw0RP+lID57eNrue8wDe8Sf1L1yLVBpINPoOb
	jSmYqQChbBR0K2s6IsKJKsx/XDM2J+slv7wgQD4++rebTrYv90QeTujdr6J67dvy9+3XMvci6sm
	gOi6wUMI0+jfJUyg6NGP32WuOwmRLrkw+oZTXU7/QcpUT53vIKRxPskbMrNJhXmmTzkkjDyQB+s
	0kRbPVFrsvlqAo25THRzOwYoLRiirPiJEQ1l/KDhybGCKhMLsL81HMGYTidnUraLDdQHF0ZT+qY
	0aGO0ZxBN7vbzkz9B9u+04Yj9f1XJ2+eiqIslWMpbq2JTSRCsdZowKA==
X-Received: by 2002:a05:600c:8115:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488fb77d7d3mr296536155e9.21.1776892834252;
        Wed, 22 Apr 2026 14:20:34 -0700 (PDT)
X-Received: by 2002:a05:600c:8115:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488fb77d7d3mr296535725e9.21.1776892833712;
        Wed, 22 Apr 2026 14:20:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10777csm537060875e9.8.2026.04.22.14.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:20:33 -0700 (PDT)
Date: Wed, 22 Apr 2026 17:20:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
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
Message-ID: <20260422171315-mutt-send-email-mst@kernel.org>
References: <cover.1776808209.git.mst@redhat.com>
 <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
 <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Fj9Yjg3VF285DcvSyof5npOthJ1Kia5lxoI90ebnBM_1776892834
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2026 at 03:47:07PM -0400, Gregory Price wrote:
> On Tue, Apr 21, 2026 at 06:01:10PM -0400, Michael S. Tsirkin wrote:
> > Thread a user virtual address from vma_alloc_folio() down through
> > the page allocator to post_alloc_hook().  This is plumbing preparation
> > for a subsequent patch that will use user_addr to call folio_zero_user()
> > for cache-friendly zeroing of user pages.
> > 
> > The user_addr is stored in struct alloc_context and flows through:
> >   vma_alloc_folio -> folio_alloc_mpol -> __alloc_pages_mpol ->
> >   __alloc_frozen_pages -> get_page_from_freelist -> prep_new_page ->
> >   post_alloc_hook
> > 
> > Public APIs (__alloc_pages, __folio_alloc, folio_alloc_mpol) gain a
> > user_addr parameter directly.  Callers that do not need user_addr
> > pass USER_ADDR_NONE ((unsigned long)-1), since
> > address 0 is a valid user mapping.
> > 
> 
> Question: rather than churning the entirety of the existing interfaces,
> is there a possibility of adding an explicit interface for this
> interaction that amounts to:
> 
> __alloc_user_pages(..., gfp_t gfp, user_addr)
> {
>     BUG_ON(!(gfp & __GFP_ZERO));
> 
>     /* post_alloc_hook implements the already-zeroed skip */
>     page = alloc_page(..., gfp, ...); /* existing interface */
> 
>     /* Do the cacheline stuff here instead of in the core */
>     cacheline_nonsense(page, user_addr);
> 
>     return page; /* user doesn't need to do explicit zeroing */
> }
> 
> Then rather than leaking information out of the buddy, we just need to
> get the zeroed information *into* the buddy.
> 
> the users that want zeroing but need the explicit user_addr step just
> defer the zeroing to outside post_alloc_hook().
> 
> That's just my immediate gut reaction to all this churn on the existing
> interfaces.
> 
> Existing users can continue using the buddy as-is, and enlightened users
> can optimize for this specific kind of __GFP_ZERO interaction.
> 
> ~Gregory


Hmm. Maybe I misunderstand what you propose, but this seems pretty close
to what v2 did - each callsite checked whether the page was pre-zeroed
and called folio_zero_user() itself.  The feedback (both you and David)
was that threading it through the allocator is better.

With a wrapper approach, looks like we'd need something like
__GFP_SKIP_ZERO so post_alloc_hook doesn't zero sequentially, then the
wrapper re-zeros with folio_zero_user().  But then the wrapper needs to
know whether the page was pre-zeroed (PG_zeroed), which is cleared by
post_alloc_hook before return.  So the information doesn't survive to
the wrapper.

We could return the zeroed hint via an output parameter, but that's
what v2's pghint_t was, and it was disliked.

The user_addr threading through the allocator does add API churn,
but it's all mechanical (adding one parameter, callers pass
USER_ADDR_NONE), any mistaked are just build errors.

And it makes the zeroing path closer to being correct by
construction: every allocation either explicitly
says no address or has a user_addr - and then gets
cache-friendly zeroing or skip-if-prezeroed, with no possibility
of a callsite forgetting to handle it.

Fundamentally, David told me I need to move folio_zero_user into
post_alloc_hook as a prerequisite to the optimization, so I did that -
let's stick to it then, shall we?


This approach also fixes a pre-existing double-zeroing on architectures with
aliasing data caches + init_on_alloc, where current code zeros once
via kernel_init_pages() then again via clear_user_highpage() at
the callsite. I don't see how that would be possible with the wrapper.

-- 
MST

