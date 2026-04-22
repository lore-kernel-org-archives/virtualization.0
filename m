Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983EF2D73BC
	for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776889976; cv=none; b=naXgW0SxArnN288X+btR0zfU2UQxn0oWhCCqdhTLv5ZKiaFVdznSeRIhFZ6zJDMDrruoR+N0XPF4/zyO9vhowGxl5f0fzMUJtEp9QA1FscgxHwPsD3c/xA9sWR4oet/tlNOk5OW37EQdMpXtINOAj38Q7vsz4v6YE2Hrejjt6K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776889976; c=relaxed/simple;
	bh=txBDlyu1ezieQzyXS9C8BF2vzT0DIUhYErYLWe5Ihlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=g4LH0hV9LjM9qE8N4kKvep7M21sF+x3BPNi4+17AvflpdwlGhOO41Pbff24l9BHf7zaSMIA8Gj80dtrbbq5eu9CnVaNo9DyLWgYownxYZ5SXoNVeZn2uMyEhfXkCkvpmJbkcMW2WYiWE2PDIGOqTBX/lw+QrNvs+jDOyYa4KmHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Plv3JKxb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Plv3JKxb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776889973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j2mexCWnAXHTuyUVY4iwTSyRl6JB6J5POTCYS/bdHQE=;
	b=Plv3JKxbNUmu1D4FYf8cdnWpZ1gG4PeRzQftv9HjFj65ZOLdjPyhg8PZjTvskgiN2bhwQW
	EujrNcsZy0N6mlN5QRf3Lw2OKpJZ2ILRu0oYPl2mL3RdWyVTZ47QKDWdfaWikO1si4oBGC
	uhTy0QIiadR2St0hhMD5YMbcePNZ/dg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-D9oHgY_8P0G6sTaw-vrOvg-1; Wed, 22 Apr 2026 16:32:52 -0400
X-MC-Unique: D9oHgY_8P0G6sTaw-vrOvg-1
X-Mimecast-MFC-AGG-ID: D9oHgY_8P0G6sTaw-vrOvg_1776889971
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48906aa28cbso31759775e9.0
        for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 13:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776889971; x=1777494771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2mexCWnAXHTuyUVY4iwTSyRl6JB6J5POTCYS/bdHQE=;
        b=kzGB45KFGhA8xKVzBOzsSV28ssKSrww4b4ZAumMCvLiKoUJCmDM3tOXE4fubb6w/dv
         2aUberAV9PQlQ63dHVjTWSipFN4JERFz9Vt4wryH9dEUdRIuydHKVFOdq2bv++JWuaF/
         d7HHu7jpfC5P3Xj1P800KXPVQAZ/RRwCifUiB2izvK5a5FQhuzVQJ0B+kNetgclNt+Bc
         pb4X+iDBAQo741ZIGhUSm3zuqsiIj8pHJL/f1AK5rEElSByjHvbDcKzxws0mbKbo5tSW
         HnyqaEzhIjgDlM8EAsktba/G2g2v2JbrOntOJeDqefgjK3VIg7gMjFDtJZHGZlWqsCxI
         StFg==
X-Forwarded-Encrypted: i=1; AFNElJ/r/DxBrznm5lMtT8SpW3ZJXVUOQP6AO0CpJlmRvQztenLGTWjI9E4m6Xdb8K96tOwgInN6xSntBVJ57g12jw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhAtM3/rh+KKwCUjPqgf1dOfPtFy2hsyGMuTdizN7BYxvQjrWZ
	6HyJGrGtN0ehy3I56p3NA1wEOkO2AbSSBaOLI5dwPa2MWqJ6LAt5PoQWvpxOAAwDWHPrlcagcV9
	R0t8Npii+yGOvxpduWMKd1RfCwm48/RyX44LtE7ZAna+BjTtb2q+K49k+Me3r9FC5+wxT
X-Gm-Gg: AeBDietKN7+a6fEykhEN6JgcUkmlps263Ymp2THB6WhZh95ebarWoyX4oRSj2DLIH7K
	RJH92yTnRYylmkJ33e/yDAGofdRZ7uVlZHWB4MC0gNd6dXT4zA5r353FygJxmc/045dgSW7tJbV
	aKFMnFIn1kT/1pghNrcX3Gg7xo7VvbZaBROX3CyrWbEogQ3/NKp+IyuX1JJY/yOkbQ5s3c7c8tL
	gm//M/AcBA/ivBMWUFIwvrnlpRZeHKHu4sneRcReEDuBY2mU0zVlwYcL1ZV0OiJSk3EHHhxn2Kn
	NSSWVVKj2p1zMCigwhh+YfsJYkcOGNHHHCwk0/v1I1cSvMja43uqWC4ssmA/vPKRCzbNLNzNaE+
	cSIjKLvxPQ/6QCj4m+ogdtLm3wbCIcpOZpCjQUdmL4TnZDC+dZQwXWg==
X-Received: by 2002:a05:600c:2288:b0:47d:52ef:c572 with SMTP id 5b1f17b1804b1-488fb881ee2mr228774795e9.1.1776889971060;
        Wed, 22 Apr 2026 13:32:51 -0700 (PDT)
X-Received: by 2002:a05:600c:2288:b0:47d:52ef:c572 with SMTP id 5b1f17b1804b1-488fb881ee2mr228774125e9.1.1776889970331;
        Wed, 22 Apr 2026 13:32:50 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4ffa8sm49363292f8f.35.2026.04.22.13.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 13:32:49 -0700 (PDT)
Date: Wed, 22 Apr 2026 16:32:44 -0400
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
Message-ID: <20260422162811-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: 5aTrMxro8HI-PpkhTvp_C94d2t7GfnktE7LzdM6n-yM_1776889971
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


I am sorry i do not understand. Users have no idea if they need
"user_addr step" - it is an arch thing.

the places that pass USER_ADDR_NONE can avoid being changed.

*However* without this change it is easy to miss someone who
has to pass the address and simply forgot to, and this
someone gets GFP_ZERO from the caller.

It took me forever to find all places as it is, at least
every change is explicit.

Because no testing on x86 will show the issue, and it is a subtle
corruption even on other arches.

I think churn is better than a risk of silent corruption...

-- 
MST

