Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A040319ABD8
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992381; cv=none; b=DqJ4otZHFSZvT+8azjjK37C0Mc/5s2V1Gy7o9UjYo+lVtACiiqXjrfI0ReZMmkDhyuFiJMkT6FnmVhjJ/6iT0m5Oua7x+KQciiwOMoHCofcx1oTlT7Cn38J+VQCpMlUzH6MIXXNSymRYxslGm5nYrjRyJ1Y6+1MwNM4X02bvZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992381; c=relaxed/simple;
	bh=UzctvEXGPkxRJJFL6usyl9J2oOluX53QVY2A6gfvG1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hc7FqrSxE0XnEhx8S+n71r8snAejZJptpwCy2UseXptzAY0Fv/WqqkYVspwGm53trJu9zEycwKC+qXLPmgHAxK7LybWAqyBFsEzR8PcOrELW6weJAMPqL7JITUHsLDBnikCweOf60RhTkfSxhPXLWfcwGPaY7XQQUrGcjC1p620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlrGL5R3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlrGL5R3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780992378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mtkf4sgMqVoG+F92sfanLnqPLF7Ap+Es97Nko8xXfZE=;
	b=QlrGL5R3OV3xg2IG5zffSE0P9pcDMUgrcNwN8ImtjNT8mMzJE40lg+rhATWKS1NyIMaK43
	sHEgrkeAIvaP0kCwQK1aGV37HxdjFRa65vI7gIopQyLzJQWo0JCeHECSqVIc1UL4GZiHoq
	77nxDSAJdy6cmHu5ahwPvi976vOclvU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-bFBCUJLVNQam-wHLqiJrQQ-1; Tue, 09 Jun 2026 04:06:16 -0400
X-MC-Unique: bFBCUJLVNQam-wHLqiJrQQ-1
X-Mimecast-MFC-AGG-ID: bFBCUJLVNQam-wHLqiJrQQ_1780992375
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b8adf8b8so47882855e9.0
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 01:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992375; x=1781597175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mtkf4sgMqVoG+F92sfanLnqPLF7Ap+Es97Nko8xXfZE=;
        b=RJC7Lkq9SJ4u+3aMdUqJ5Rj/n6OAy1MhZlZ7Ub11kTwZ8o5pbWxsOtObO/wlMsJpTQ
         Yx7Tohdn61M0lOU0dFHMtGCa7U4MSzpaSdA0VpMFIoDgji9bS0X4dqRHzJYtDYEyzSrZ
         FzZYdpP/lq3fVJU7eW+ZbLGeubSEfkEzRxRoDMZgx84dQF1alhpJRt7ThlnjpYbmSv+0
         +hwYf4pxbj9NRn3bOVjlxDFlJke7oTyHKbL9ugF2gEQ19sSZWEcx7k0TTjKNAExrGoKd
         ZwKE87jzy5jUchJw8VVvb0m3CZZZoP7EZLU/rQupZ0ECKBBwBxYG85SjNA47K0UrnM6F
         Av5w==
X-Forwarded-Encrypted: i=1; AFNElJ8xFfSkNe/8hmCYCW0GFpbKQ2hkqSSDC514YsKAA4onXorIUrvACe/pOyIN20hLYERmpqWaYv19FrO0b+6GPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAOoy5Fg7HV0+QZi/SH8w9cA0a+PInEsLYDHP3Uemr56VU8HUU
	PWxt297mEKuth1k63jNKZFXI+KmToE9Ghp/sHLyh9Fg1oOq6clIWKb9l5VAXkuvggy7qKhIkUgW
	2qoLw8EWQv1VTV0QNfkOpi+x0sBcIeOC2pQhzokxgq+RG0dZY6uWcZWc20FuofexwRabS
X-Gm-Gg: Acq92OELYPyvsdPJzrA2Rcc3zhNByxJUnqw4k4gQY7TgztAaqVCjWA4tWjffEKC+M+7
	6QeQPsi61tQxs/EWpWhaeE6wIX6y+b+9HCivr+7Yyt1xTg6wm+4DqE+1zi1uQ+ktX1XnHCAoLAx
	HMqF230x30qgbXY17JTIcTC4Q/P+9BhDrXbu57w3ZY9ZUX7XyrbCvtfmtpRbPoeO4TDoGN264rI
	ELNlbQi3fMrERefZlVXQsd5F9h8nC409zpZrBJBQloboNG6s3kYurT9q4OLaI3aJcZRn8nFeaAw
	gKtfSeA3/7xipK3viXMmKaNXQu4tNcc7nu1HlhmSkpEmyufcgL80yq2Cm4xefP0EuGy1E6dcSQW
	ARRd+sdVXQN9+sIYPOQjHxF41EpGBmU34e2e3x1VtKnHMU6vFF4P+dA==
X-Received: by 2002:a05:600c:3515:b0:490:b409:94f4 with SMTP id 5b1f17b1804b1-490c2602a24mr294886885e9.28.1780992375125;
        Tue, 09 Jun 2026 01:06:15 -0700 (PDT)
X-Received: by 2002:a05:600c:3515:b0:490:b409:94f4 with SMTP id 5b1f17b1804b1-490c2602a24mr294885445e9.28.1780992374486;
        Tue, 09 Jun 2026 01:06:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d66c8sm440082815e9.10.2026.06.09.01.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:06:13 -0700 (PDT)
Date: Tue, 9 Jun 2026 04:06:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: New design
Message-ID: <20260609033042-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <aiePVsiV-w-IZ8A4@casper.infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aiePVsiV-w-IZ8A4@casper.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4jzgfEXRUBzMATxM4tAQQeuaXf1kWD3PrT9XNoQ9nH4_1780992375
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2026 at 04:58:14AM +0100, Matthew Wilcox wrote:
> OK, here's how I'd structure this:

Thanks a lot for looking into this and writing this Matthew! Looks
workable, let's see if there's rough consensus around this.
Two questions to make sure I understand.

> 
> 1. Introduce PG_zeroed for buddy pages
> 2. Set it if init_on_free is set

Not 100% sure why we want this bit. And I am not sure this works
actually because init_on_free does kernel_init_pages
and does not flush cache on arm32.
You will notice that user_alloc_needs_zeroing ignores init_on_free.
Right?
How about we skip step 2, make the patchset a bit smaller?


> 3. Set it from balloon driver
> 
> https://lore.kernel.org/lkml/c7094de807c0e963526686e1d245bc76193b1a92.1776689093.git.mst@redhat.com/ 
> 
> but add FPI_ZEROED instead of an extra bool parameter.
> 
> 4. Introduce page_is_zeroed like this:
> 
> static inline bool page_is_zeroed(const struct page *page)
> {
>         /*
>          * lru.next has bit 2 set if the page is already zeroed.
>          * Callers may simply overwrite it once they no longer
> 	 * need to preserve that information.
>          */
>         return (unsigned long)page->lru.next & BIT(2);
> }
> 
> (you'll notice this is similar to page_is_pfmemalloc() but it doesn't
> need to be in mm.h)
> 
> This step is going to be a bit fiddly.  We weren't expecting to return
> multiple flags in page->lru.next, so clear_page_pfmemalloc() just sets
> page->lru.next to NULL.  So somewhere we need to make sure that
> page->lru.next is definitely NULL, and then allow both the zeroed and
> pfmemalloc flags to be set in it.
> 
> The important part of this is that it allows the zeroed flag to be
> returned from the page allocator without introducing pghint_t like you
> did in v2.
> 
> 5. Now you can start skipping various zeroing steps higher in the call
> chain.
> I understand David's disgust with vma_alloc_zeroed_movable_folio()
> but that is surely a separate cleanup and nothing to do with this
> patchset.



One other question: would people like to see it as a single patchset
or multiple ones 1-4? Multiple ones would be easier to review but
of course this means no actual perf gain until part 5 is merged. Is that
acceptable?

-- 
MST

