Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE04305668
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859566; cv=none; b=MxV86ufLuEToHcNDY1gAOp2B9zUC5SfMzxEof2GC3fm9Q93y8EtPMlGo0PYJ03co3AZIuttSsmKmqEUGxHWX9I2NcwAgwCgcpxC7UMOnsJxsRk1fZiq6Y7xjYnevuYDWzKkAQxCKE0pRmrFwBVG31e2qyoatfRpe0DgzK3odcuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859566; c=relaxed/simple;
	bh=TZ6FN0evsU83Qkybe8h8Hy8iiimz3lCzOXtq52eCjv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqLSq/KHa4vFMCRx/PejIOCPLehvwdcBO1v2V4CAt3w1EeOa6hAKxSVJOlJOLfWlh9pPAdvGlLo8OS4gJv4KMBmQz18Do+WrWVoIh5pdzmYs/fTr9pbR1DsNn6NJbSJYqd8uBGZhSdEs+1QkWK63FAJBOwU4+SpoyJVfuHncTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DehHxkTB; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DehHxkTB"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-911449d9d03so200524585a.1
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778859564; x=1779464364; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vcnoZCj9StmYM28UVGL5OD3x4745ox3PgFdBX56PHJ8=;
        b=DehHxkTBNl8aJPsjiGT7FJNhA97McE5LsZLUWNBYQe5uJAzhIPtgd+jyzd2x3RLw9C
         huOZVFh3EvbEfSJ76Gikhj6NHGOiKKxs1UdpEqHVzwkYim+dCu/LYxbdAb0BkEUSWHqx
         BVM8JXey4r2ncJSPNEovq4fDSq60hFW7OggAklin4XOG8Y68Rf7OYhJYHc/yHiVV7EQZ
         q9JvB4cd5xWq9nl3BbUeeREc8kRuAnhdZMDG/s/BXMflQ30SN2+cIAVJpveXpPdsYfpa
         RDAJoM8HYgaAwu0ssInT0mU2IVnfe4wIYGN2rMco2/UfHCI14UVG8Lz0NiJKO4zXVROw
         /3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859564; x=1779464364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcnoZCj9StmYM28UVGL5OD3x4745ox3PgFdBX56PHJ8=;
        b=geWMCYUYXQaxI8SIuzSASCh11mb9kxkjQUJuSrkfMXD2Q9jukSz3FGlBmkHR8bQEg8
         Rxx4cpcHGTw3gJNYrqgTW0wYv1EyPIjoH13U9Xr8mH+36yDNf5oBwPo3ZWY+ULsHiHfX
         PNvLd5+yvjJCFOVaobwSODqtaqJxups18ECVJQ8BFKCnJlgHoZTEcszMs/OpQukWHSd4
         qAw+Lj3mQKLg3fdyKOtxv35s7BWFVbD3yD3xkjqtlcjQylj2uola//kEy0wm4BzVQ7hW
         MPhTJU3N2xsaILRemk13F7A7k0kuRjwPXhfmRvXkSUJHUujkvIjS+8UcfCe/ys5sHdzT
         SWzA==
X-Forwarded-Encrypted: i=1; AFNElJ9JkIMaS0mPlDfg4x4yJiJb0+oDaaaBj8byrwHWfkR93jmFP/CFW4l36Dj02j9zTiHPWfs22yyMSGqDFPRO3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHFBU+lQBVgnIdqbbckUlNDjN/9qDgPs+ccyO78uLpgZ5esHRM
	kknGn3+FrT9/2oZ+VpkYP06yilTxeN7nDz1E645D8saxmbG0gu9Hj1XvQTgncLhvpsQ=
X-Gm-Gg: Acq92OFWI5p89KS7aJAD77LYf7RDdtJM0DsaWPZoTgKw1AIlI1EJiQMV/Pj3OemzcPD
	JPQmuwmuHrY8D6MQQZwuSzSD5wpP1sQyVPhUFJ7wULY5jXtjYwRWkswKmdlyF5ZXZfmAP2VyaiP
	AXTC+7HaQ5l8VcaDCfMMLSK6h7ig21vDSe/FQvlVRf+GlXhKn6l5zx2Pa9ZaREO0vtDd10gXGoG
	13cYM4cxXzYpKFgUsY2PCa8SNMey37UIPJnayJuA/KaW0JB3GiAqNja+F61+9KC8D6X1Y3qWZHA
	LlytuBvOURgRiz62vb1iOicdoXEcd6eRrot2M0fkq1vAbB1/enJU4lvQR749F4mbe3qAbOkWgC5
	I2dDlmfE2T6Ey6LHG3CNVedEh83630c0uONi7DDXPAd2Sy+kRNhWO1Oia6nwybQVjeUfccvLFCt
	NQDUBcbyIDK96o3bqNQDETNWLD/M52Q0BykcvD8oTVQZtYhm6B+JNy9UzWY1m5tN6HGzCI1PAX4
	lPWZoDUT6N6oIjxgQy3gW0ELd9aPrHpww==
X-Received: by 2002:a05:620a:12da:b0:912:67ca:bab7 with SMTP id af79cd13be357-91267cac05amr271493385a.2.1778859563525;
        Fri, 15 May 2026 08:39:23 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36d137sm564275585a.1.2026.05.15.08.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:39:22 -0700 (PDT)
Date: Fri, 15 May 2026 11:39:20 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
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
Subject: Re: [PATCH v7 09/31] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <agc-KFwvSDxEImVt@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <45d1ea85b574399459a64fdba28fcf04abfa3e7e.1778616612.git.mst@redhat.com>
 <agXS7dMmtJrPhu9W@gourry-fedora-PF4VCD3F>
 <20260514135214-mutt-send-email-mst@kernel.org>
 <agYa9s5B7OWG-kjR@gourry-fedora-PF4VCD3F>
 <20260514150750-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514150750-mutt-send-email-mst@kernel.org>

On Thu, May 14, 2026 at 03:08:13PM -0400, Michael S. Tsirkin wrote:
> On Thu, May 14, 2026 at 02:56:54PM -0400, Gregory Price wrote:
> > On Thu, May 14, 2026 at 02:00:31PM -0400, Michael S. Tsirkin wrote:
> > > On Thu, May 14, 2026 at 09:49:33AM -0400, Gregory Price wrote:
> > > 
> > > There are calls with no __GFP_ZERO but they do not allocate userspace pages.
> > > 
> > >   - drm_pagemap.c: GFP_HIGHUSER -- no zero. But this is a DRM device
> > >     page migration, the page content is preserved from the source.
> > > 
> > >   - test_hmm.c: GFP_HIGHUSER_MOVABLE -- no zero. Test driver, pages get
> > >     content from device.
> > > 
> > >   - mm/ksm.c: GFP_HIGHUSER_MOVABLE -- no zero. KSM merges identical
> > >     pages, content comes from the source page (copy).
> > > 
> > >   - mm/memory.c new_folio = GFP_HIGHUSER_MOVABLE
> > >     - no zero. This is CoW, content is copied from old page.
> > > 
> > >   - mm/userfaultfd.c: GFP_HIGHUSER_MOVABLE - no zero. Content comes from userspace via userfaultfd.
> > > 
> > >   - arm64/fault.c: __GFP_ZEROTAGS not __GFP_ZERO. MTE tag zeroing, not page zeroing. Page is zeroed separately.
> > > 
> > 
> > Right, so in all of these cases, it would be just as correct to pass
> > USER_ADDR_NONE I imagine :]
> 
> Hmm. Are you sure? Isn't the address used for numa policy?
> 

You said "They do not allocate userspace pages" - so wouldn't uaddr be
USER_ADDR_NONE anyway?

Even if they do allocate userspace pages, they weren't passing
__GFP_ZERO before, so either:

  1) They did not depend on the buddy to do zeroing before, and
     user_addr is just a dead variable in those cases anyway.

     or

  2) There is a bug, and they should be zeroing the page.

I just see an interesting hardening opportunity.

Not suggesting you actually implement this, to be clear, maybe just
documenting the idea on the thread as a potential follow up.

~Gregory
