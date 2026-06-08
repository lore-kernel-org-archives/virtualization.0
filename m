Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BCF257854;
	Mon,  8 Jun 2026 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924156; cv=none; b=Bbi4chN4n8KWYXRNdigZeFa/779zneptOyGltKA2MV/49ITBxRNYM8oZFiDd8ClQ9x8DH4csnBKt4fBAHc7nFWaWiDAC1+D6b3E/3xpl9aZsJI+V2ZJ6OYquamTifyvG44Me3hnaI23aUpVDIeAxIa7bp9Eg7n6daYOF+TE552A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924156; c=relaxed/simple;
	bh=TKcxefLi6weEsC118ojxRQAagDnfRHplsd7yZkFfvg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ttqsg4san8Zb/0BYZfdwAOj6QsIPRquUwReRXACIesoAjiQ0EKzkhH4slxll2jhsZXwkyPnOSnCkbj/oE2+BgDBM+dpj03aFA+rqn0WHRkLl1Cr6+xeVtzt3F/maN9F+PaZeOmC4nvvsjo7p9kYW3stFZjIu/ZJTxDwJ4E32E7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU7YEBCQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU7YEBCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651D51F00898;
	Mon,  8 Jun 2026 13:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780924155;
	bh=X1iEpMFcGnAl+xKpt0NCSfDOMAqvdEhxAtn0P3aNA7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bU7YEBCQHlplquRshq6kKbwUGvzFVb7VR8mZ2dvgpkxbTNXhS0vZUvTtL24/ml3Zo
	 RoE2DymVzNMfcbkMQ+QqEHHLRgmMmohbeqjwk+U5kaA3etmTxN+6+juwemX1tbEKLm
	 DnJWCarLmiR2FMn0kjQoo4j5twD4IKPU0TeSG4kbT8GXjIcYpE+4fWzn2sJCXWCcTt
	 Nwz6FK/tlPdOO3f1SbdG9GrPlWxypSqGMMkj30lq+rriV8B6YuNVl84HrXCZbwlM9A
	 fRdLvPKw2z2T2K6jd4Bap7uquleu7spiRJjKN/ja1+d7AdzscS9YIgyBpKCQxChJEg
	 3j7sFvtkN0cWg==
Date: Mon, 8 Jun 2026 14:09:02 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, virtualization@lists.linux.dev, 
	linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v10 07/37] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <aia-q026facbptoT@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <50d410b47fe3f45327783e05bd306d5eaab75e65.1780906288.git.mst@redhat.com>
 <aiaUDTeHDA45ZXFS@lucifer>
 <aiagMc9Ng_AE_adh@lucifer>
 <aia93IzhTgi1vGi6@casper.infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aia93IzhTgi1vGi6@casper.infradead.org>

On Mon, Jun 08, 2026 at 02:04:28PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 08, 2026 at 12:06:35PM +0100, Lorenzo Stoakes wrote:
> > But instead of overloading user_addr to indicate all kinds of things, instead
> > make life easier by actually breaking things out.
> >
> > Like:
> >
> > enum alloc_context_type {
> > 	KERNEL_ALLOCATION,
> > 	USER_MAPPED_ALLOCATION,
> > 	USER_UNMAPPED_ALLOCATION, // Maybe? Do we ever?
> > 	/* Perhaps some other states we want to encode? */
> > };
> >
> > struct alloc_context {
> > 	...
> >
> > 	enum alloc_context_type type;
> > 	unsigned long user_addr; // Only set if type == USER_ALLOCATION
> >
> > 	// Maybe something suggesting context or whether we init before in some
> > 	// cases?
> > };
>
> Ugh, please, no.  As I suggested last time I commented on this
> trainwreck of a series, lift the zeroing functionality from
> alloc_frozen_pages() into its callers.

I've not looked at the callers closely enough to see the delta on that, but if
it avoids this mess then also worth looking at yes...

Cheers, Lorenzo
