Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5F337E30D
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536364; cv=none; b=Z914kyvJ6TuwK4Ga1Lz0Jfv5+KSR/aLj3nUSsfEozk6zVPV9jSndwS/J3C/8XhkKjh8nAwY+rrv+YyQo8lfVJT1xctCkXdyrcehm0oynaT3HkmnAIw/cXYGSI+lxhsmF1x+akJzDqeuypvhr1NEvrGDouKImzrXU/7F+/ayU17E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536364; c=relaxed/simple;
	bh=Kdicn9IKL6UNg+h69nOhQoEg/Jknb996+Pv+LBMMEAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buFfB4ipSFwlmvBragRqXloljr07RILVs69RXVYTBxC1YG/K9gqU+sVElHegqVKQtsFAqAviYjD1iWXkJX78u9CgZ8+N09u0dnuLTNVBRzXkfoVRwKNZRKMlBW+VQ45ujQUoj/8eyC34XXnYtDFMlrUaWPbFEqzGCfs7GqUAELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ys97uiKJ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ys97uiKJ"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8e8c0c2d2bcso632510685a.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 14:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778536362; x=1779141162; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zawmE/mtpN2n4/3m+Q4HP4926MV70apZ3swxtsElHX8=;
        b=Ys97uiKJ6T/lPbn5T1o5ptubv/YscbFhCFIdE/5ZRGLK95lIL/Z4k7PWjDPMk1pTNu
         pGJ8GVH9CIrWeNT269NLSGX7UZny8vfJQsXRqbxIO09h2p9eFIu5sA1Bbv1B+9QcZZ/t
         e8FyZWP5E5ptu06KlLm13kNcEPOiDkIx6y+heXV6MkEot4qIXOo7n/xE6IPcqJf2pU9Y
         6AwJnkOEvC5DX91+EFp49pg1sSyfbQpy5wCSCtsy4Qvqd3t/bVbHKlUKmGQJU0uuFBQf
         bRCOC+wPA9J5cPeLO+NZWSPVY3laXygtKmW/u+OB1pxj4Ko19TnDMizz3lPgmDrJ4uD7
         w/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778536362; x=1779141162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zawmE/mtpN2n4/3m+Q4HP4926MV70apZ3swxtsElHX8=;
        b=DH1e7uMxJdASfmSntgHtLBMfyWzkGrs7EP3J86fLpXt7uwoZqSY9W6OwH2FMeeM6u+
         pOw0Yw08JTRFSRILA/IvEfy7LN0Vtq163ib+v91cCOuP4qJ8ru2+0rH2mxxNC0QwNoHd
         YEj1baqCdGQ+pMF0pcyIYyd59a3WHa4AjxZkB0mNBVs9DmbTjnXN616FGtdH8ult3tCo
         05Mj0xTTCzJjBvQelCt3bzhViv7gTPiUodOSFw99Jq/FNfYc3SZbSFNj4ecRTsAyuR1U
         m+UqRAAhetpTyDn6A4qL8FriELd9aFbb7dB2lttMBCLNAuzE8gQdrnWlhFUhr7jbk6Pq
         AMgw==
X-Forwarded-Encrypted: i=1; AFNElJ9bN1MTOQgKsmTgcMVc6VwNnuAYFDZKAEGNSXZoq08NqmvDHN9tQSic2Q/wSEI3Ap80eeo773vuYCqfn2huiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwG7dyixPdwwf0xWr/5v1cOYRsEl9/S6ZSFqF1O42D6EIWp32so
	wnGc2rXZvzxI+PwIkaih4NehNZQdb8wOdTsSLmSkDxjB9rIt2VcwqwKDpnLNtOTyC0Y=
X-Gm-Gg: Acq92OEX2mR+ynjwHDV3O6AIKihak2TNLWxNKID9p/L2A/UiwA4sj3omErfKBgMU+Km
	c4M08+Gvri/58Nj/9e1sZOFYP8pIR6KVwKCUA7rEpDegu0EpIKYCNwBaOihyQoi1lc4+hLdiRLZ
	ccdtzMe2WtwBd4l9Ie5uhjwPGhEyfWt+6/+3j4wDIcNb8EgCvyi5Xo/ydxDM6dCxmLf/zrd3N0N
	QcboRS1ihn3bG/Ai3OlZHcgN6VTJUc/QQF2orCjGOL6PGdk6mMlMbM8XuoK32PBC7wlXGYWR1MH
	6psVSSByO3KDgS/IIpBEXfPkwZaM1sXqSzzFptlYAItkhyNknJ2KHmQOrX3gccVnz7DLSu7DYxs
	JNYdYkU6cikdcRPjyk8BGrstP3kyK5EeVVdpHjyWTLXBvJO8LYsViakOzVOx+4VYrK0AlJ+MkuZ
	M+LxEjQAFgJYqXBX4momMGpqcRDoMW7hepH3erftygT8n8/0RG7+FiPFkbmdhWeHvEk//dkQQAT
	jtvQFpVTkzv
X-Received: by 2002:a05:620a:4003:b0:8ef:3953:7d0 with SMTP id af79cd13be357-90cfd3568e1mr38106785a.51.1778536362049;
        Mon, 11 May 2026 14:52:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-90cc338d234sm74534785a.43.2026.05.11.14.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:52:41 -0700 (PDT)
Date: Mon, 11 May 2026 17:52:39 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>
Subject: Re: [PATCH resend v6 10/30] mm: alloc_swap_folio: pass raw fault
 address to vma_alloc_folio
Message-ID: <agJPpxyu4gKqq8rj@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <369a08b86f51572b2715a9ec577de27ea98000d3.1778489843.git.mst@redhat.com>
 <agH-PrpY269pyuJQ@gourry-fedora-PF4VCD3F>
 <20260511174032-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511174032-mutt-send-email-mst@kernel.org>

On Mon, May 11, 2026 at 05:41:16PM -0400, Michael S. Tsirkin wrote:
> On Mon, May 11, 2026 at 12:05:18PM -0400, Gregory Price wrote:
> > On Mon, May 11, 2026 at 05:02:39AM -0400, Michael S. Tsirkin wrote:
> > > Same change as the previous patch but for alloc_swap_folio:
> > > pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).
> > > 
> > 
> > Starting to seem like this should all just get squashed into once patch.
> > 
> > ~Gregory
> 
> I mean I was told the patches are too big and too hard to review.
> It's just same, independent changes made in several places.
> Does it matter if they are squashed or not?
>

Mostly i think the ordering of the patches thrashes from one set
(alignment) to another set (USER_ADDR_NONE).  If all of one set was
pulled ahead of the other then it would be easier to follow.

This particular set seemed trivial enough to just be one patch, but i
don't think it matters all that much.

~Gregory
