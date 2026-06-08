Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4EC3CC9E9;
	Mon,  8 Jun 2026 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929885; cv=none; b=g/LHkkprdsvCXuL6OV31nC65dTwqkbEPgILrb/60hNRpO94UC9f5bvzVH9JT6cZhrtdSd9o5wX8NE6E6Q4JyM4UloCt7zrExp3xg1GaLbs+AgFngZ0lamnEnpLdLBHsEWptF0Ww2t1jrHVFnkwNOPncdEeWkw1vuKsPoKMOSCXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929885; c=relaxed/simple;
	bh=r7Qx6V2OmVSJnjOKQQclFyZUCX+/RA69HQR4lMWBmsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5ShQKSvnkvzAGBbPhfHW4A+Jrii9eFfRycKWtKwQiMhVBQhwrLLvailbzMQDYJvEJwkByg0D400rZRpRlECELQLOtItJJ7bFHATyhRW6KKZpuc3uiMNUohRvaPfqbfl5Ah3uf3rienosorD+pwn2ZSkDCdscAZGPSwG0E/WAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qEZ2rfLs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qEZ2rfLs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FxrPivMbcmKajNADeOIQJSutYQmqflAH9yFR+Tkhzog=; b=qEZ2rfLsXeQPXstEumnD0TPoke
	G3uVOFYfYZm9ffHHSXqTJJFo3GaYIIFTgRdhkRuOwIeiYC1T6U/AqkBUHC2jIGEDZ4cJD/LgSbRhx
	GyTXxhueVwjCkYX4pqcgJKlIHfL/fJsoGNG0rQ9u/jwReAjU4zSbIlnj6HrMfHOHQCmorcJxp8U/i
	SEq0fsV+6QhKJq6Xh6i1p9lLQMqQ2JpHJSbl+F37JsvEIxNAqpH5o9X5SiQGfs8fgCHU0i7fRQY5M
	dQpF6noruDu/qYzNBCXL7UUhB3ZFhFvkScQZzTjp7OK+NXHG8cEVCHNdUawfFX3wxDgMR6BeRmpac
	Y0WOUMZg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbDJ-0000000Dstq-2Gul;
	Mon, 08 Jun 2026 14:44:29 +0000
Date: Mon, 8 Jun 2026 15:44:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
	linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v10 07/37] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <aibVTe5HTk-fF_kj@casper.infradead.org>
References: <cover.1780906288.git.mst@redhat.com>
 <50d410b47fe3f45327783e05bd306d5eaab75e65.1780906288.git.mst@redhat.com>
 <aiaUDTeHDA45ZXFS@lucifer>
 <aiagMc9Ng_AE_adh@lucifer>
 <aia93IzhTgi1vGi6@casper.infradead.org>
 <aia-q026facbptoT@lucifer>
 <d0ff6269-8b8a-4983-8569-d9a8495829f3@kernel.org>
 <aibSPsc33YQiYSMI@casper.infradead.org>
 <ef14cfdf-5f1f-4e3b-846d-fe1462042883@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef14cfdf-5f1f-4e3b-846d-fe1462042883@kernel.org>

On Mon, Jun 08, 2026 at 04:37:03PM +0200, David Hildenbrand (Arm) wrote:
> On 6/8/26 16:31, Matthew Wilcox wrote:
> > On Mon, Jun 08, 2026 at 04:26:18PM +0200, David Hildenbrand (Arm) wrote:
> >> If that means that we would handle __GFP_ZERO consistently in the callers of
> >> alloc_frozen_pages(), that would also do I guess. We'd still have to pass the
> >> user address down to some degree, through folio interfaces only at least.
> > 
> > What I don't understand is how the kernel page allocator needs to know
> > the user address in order to effectively zero it, but the hypervisor is
> > able to zero the page without knowing the user address.  It feels like
> > somebody has x86-centric thinking where cache colouring doesn't matter.
> 
> (not commenting on the icache dache mess we have to drag along)

Well, that was kind of the point of this email ... I did ask the
question you're answering in a different email so let me respond
to that too.

> The thing is that with free-page-reporting the memory is already zeroed by the
> hypervisor as part of discarding that memory previously (e.g., MADV_DONTNEED)
> and allocating fresh pages on re-access.
> 
> So it's not a question of "why is the hypervisor zeroing less efficiently", as
> zeroing is just a side-product of reclaiming that memory in the first place.

We definitely have users who don't want the guest to trust the
hypervisor.  So how do they disable this optimisation?
