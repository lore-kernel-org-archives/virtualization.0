Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2C34CFC2
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926529; cv=none; b=U8utgb2COptU9gyoszRh/YoeP8WEKBGeMdarUnUKX0mkdxgDYVxtYs0vRhFwpq30bME1Q8o3GiMJJUvH8Sb+lIjCIrtnnwSv5z8duXtl8FxkZMTRESc6V/vAUhi3s97sgLtiAdczRCLWCHwqPepgsqMrBQeUw0MOTLTT1bp+qFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926529; c=relaxed/simple;
	bh=V/3C3iHgYOS9sDi2nK/Ncy4FwliOr4kXu6TWRUNB6JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Jxx7U3mVjAU+1bAYAIAgPvIJ/fpBtNUvOAifT0uaEq/xS6kyZ9I+AOm6xe3pswmEDhkIuu+8YQDI4UO1NqjQQ1XSf3mOiw6oGalx3lmjLWqgbI66EhtWW9mbyRQ3X4KRH0XBJLZ+QrWMoInOLA8Xa13Rh+eDy0qrm3CDD96TO3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZYbfXAa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZYbfXAa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780926526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xoJIhnuvHMP+I5R4ZGbFyAQYvKF+rv0fOA2ZXMSfz9U=;
	b=hZYbfXAajQ2c3BQO9X0iqeNBZ8npG0KTyCiLZyDAvFGjp+sKHU4a5NRMGdgxOTp7k3O02Q
	wlHGnH8GuAPd/1sgy+ZBd9wuplwJemiRLB4roUZ9lxQLVp7bYQiCcvY3s+DP8dm61Iu+H5
	P0icFfe4hqFS/44g7a8lN3d/973Fqn0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-1zI_cW0_MGy1_sdz_p68AQ-1; Mon, 08 Jun 2026 09:48:42 -0400
X-MC-Unique: 1zI_cW0_MGy1_sdz_p68AQ-1
X-Mimecast-MFC-AGG-ID: 1zI_cW0_MGy1_sdz_p68AQ_1780926521
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b7959b9fso45135015e9.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 06:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926521; x=1781531321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoJIhnuvHMP+I5R4ZGbFyAQYvKF+rv0fOA2ZXMSfz9U=;
        b=Ete1I7DGvTlu78vvzoulB3egmZcrUSAuf7ov0/YYWA7CizoHsdgpaHDcueLyhCB0DB
         5PZ85DBwpF3eUdgBXYnPS9byZiS1E+lrgn7pQpUHLwNLpzA3MYHxuacDdNnXS4ya/JJu
         viQPDZHpO0M+OGraP444+e5SpiCex9iXs7u4TyfF13DUh95FaUwuiqFyka9NtZuhsJuP
         na8+EcgSrqBNQ0CNjpF29x9AKXDidTrKW6de6QAHbCvlQeUzVghkF9qfxzQiT+zcr9nR
         Zjr91hNssJFmx6YNGYotoPXwwuHTMulE23YHTQSk7GBo4K/BRqADegtM10G9UAcO5KvK
         ldGA==
X-Forwarded-Encrypted: i=1; AFNElJ/J4sfMGKzKkW7bWUVXPlYP0QcFi6Se9TBvSv/q9I9c4kdOmhFTqwmX0BH2PkP20B8DO73lG7N/S/CXQjqQIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxENnQ8ONj66t9AiLe1K8MzyyLp336mhfc1ZN85V2xcmX/gIsbi
	ueZH1aE6CllnObHApQHJXI2ymYyCNtq14xA8tO/xB+vb3x3clvVfWDZFP3ecxj3V75ooAOC7+YV
	H/FnOjlkE2/YxRzx/rukmGXTvBNtKzv+8s/GwO2AEMgoGVxz+et5xnSADciWqIMTiP4q0
X-Gm-Gg: Acq92OEGCf2uRMaTPqK57kxx9aQY/PPeX8+kdhzJtuSdvQ6hPhz3RAZEeEvK34A1aQj
	5ekVvjcx5zh7COCIG/CHU8HllbFe/K/aiiAUn6PLGU5K0pCmlcNYtaCJcnHK8Fq/Gs5Eh4BtE3N
	UQ8YYv1iI9bCKTH2H+S2nPzHPW4ZABzw1oyI6mgy+9yIkc+H3BD2301hnnUeen9mDl5lh6WZlzU
	CRx0L70MmymsODogOfGAf9n2l4yLUn0SLzEGeEyUojGllSsZ+s6UzlOtdd0CRETLJRLPLZboUPp
	f38xWJpitpq0vqu0eVmL3p6DFc8fliTAvEGlDSFhUP4rLsfMB3IYAo43F0EWOsiCE7t+c3HQ4Fa
	XFCzPZyIasW2TMCZuaUFOWjM=
X-Received: by 2002:a05:600c:c0d3:b0:490:53b0:9e53 with SMTP id 5b1f17b1804b1-490c265c107mr216680385e9.1.1780926521307;
        Mon, 08 Jun 2026 06:48:41 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d3:b0:490:53b0:9e53 with SMTP id 5b1f17b1804b1-490c265c107mr216679675e9.1.1780926520756;
        Mon, 08 Jun 2026 06:48:40 -0700 (PDT)
Received: from redhat.com ([185.16.164.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918fcsm451375885e9.3.2026.06.08.06.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:48:40 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:48:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
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
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
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
	Andrea Arcangeli <aarcange@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v10 02/37] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
Message-ID: <20260608094153-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <df06b66fe4ff8e925ee0714955abc2183a727b90.1780906288.git.mst@redhat.com>
 <aiaOZoa2vSCz_0wY@lucifer>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aiaOZoa2vSCz_0wY@lucifer>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uC_EBKt9FdL_ryLVFe0DKWyovQuPxCyazYUPRv6Qq6I_1780926521
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 10:43:21AM +0100, Lorenzo Stoakes wrote:
> On Mon, Jun 08, 2026 at 04:34:23AM -0400, Michael S. Tsirkin wrote:
> > TestSetPageHWPoison() is called without zone->lock, so its atomic
> > update to page->flags can race with non-atomic flag operations
> > that run under zone->lock in the buddy allocator.
> >
> > In particular, __free_pages_prepare() does:
> >
> >     page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
> >
> > This non-atomic read-modify-write, while correctly excluding
> > __PG_HWPOISON from the mask, can still lose a concurrent
> > TestSetPageHWPoison if the read happens before the poison bit
> > is set and the write happens after.  Follow-up patches in this
> > series add similar non-atomic flag operations as well.
> >
> > Fix by acquiring zone->lock around TestSetPageHWPoison and
> > around ClearPageHWPoison in the retry path.  This
> > serializes with all buddy flag manipulation.  The cost is
> > negligible: one lock/unlock in an extremely rare path
> > (hardware memory errors).
> >
> > Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
> > in this file operate on pages already removed from the buddy
> > allocator or on non-buddy pages (DAX, hugetlb), so they do not
> > need zone->lock protection.
> >
> > Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Can we have Fixes: and Cc: stable and also send this separately please?
> 
> These patches seem like unrelated fixups that you've discovered along the way,
> and don't belong as part of the already rather large series, unless I'm missing
> something here.
> 
> Thanks, Lorenzo

I think you are mising that they are a dependency, not unrelated.
For example, this issue gets worse with the patchset as there are more
places that manipulate flags without atomics. No?


You are welcome to send this to stable, but I think stable rules
preclude theoretical bugfixes.

As for Fixes: the issue has been there for decades. I wouldn't know
what to attribute it for.


I guess I could send these separately, too, why not. Not sure
what this accomplishes, but hey.  But is that an ack? You want
this fix merged even before the feature?



> > Assisted-by: Claude:claude-opus-4-6
> > ---
> >  mm/memory-failure.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index ee42d4361309..3880486028a1 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -2348,6 +2348,8 @@ int memory_failure(unsigned long pfn, int flags)
> >  	unsigned long page_flags;
> >  	bool retry = true;
> >  	int hugetlb = 0;
> > +	struct zone *zone;
> > +	unsigned long mf_flags;
> >
> >  	if (!sysctl_memory_failure_recovery)
> >  		panic("Memory failure on page %lx", pfn);
> > @@ -2390,7 +2392,11 @@ int memory_failure(unsigned long pfn, int flags)
> >  	if (hugetlb)
> >  		goto unlock_mutex;
> >
> > +	/* Serialize with non-atomic buddy flag operations */
> > +	zone = page_zone(p);
> > +	spin_lock_irqsave(&zone->lock, mf_flags);
> >  	if (TestSetPageHWPoison(p)) {
> > +		spin_unlock_irqrestore(&zone->lock, mf_flags);
> >  		res = -EHWPOISON;
> >  		if (flags & MF_ACTION_REQUIRED)
> >  			res = kill_accessing_process(current, pfn, flags);
> > @@ -2399,6 +2405,7 @@ int memory_failure(unsigned long pfn, int flags)
> >  		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
> >  		goto unlock_mutex;
> >  	}
> > +	spin_unlock_irqrestore(&zone->lock, mf_flags);
> >
> >  	/*
> >  	 * We need/can do nothing about count=0 pages.
> > @@ -2420,7 +2427,10 @@ int memory_failure(unsigned long pfn, int flags)
> >  			} else {
> >  				/* We lost the race, try again */
> >  				if (retry) {
> > +					/* Serialize with non-atomic buddy flag operations */
> > +					spin_lock_irqsave(&zone->lock, mf_flags);
> >  					ClearPageHWPoison(p);
> > +					spin_unlock_irqrestore(&zone->lock, mf_flags);
> >  					retry = false;
> >  					goto try_again;
> >  				}
> > --
> > MST
> >

