Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274AD31327D;
	Mon,  8 Jun 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923880; cv=none; b=lSXzyu7ZsXfZtOCiiDGN21t+wQFmCyAu/aMgV3Y7Bj35BYaQKNS+yiV2Ubha9VT7+5/arNbKm/J5S8VQg99R9trTx5P8mLk1Aca5wxOphujXF0L+P41AafTDPhk/dSyAZkWxEudkmDQ+GWAYGnVzD5vr2/J2OmsBi42ZMfUyCuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923880; c=relaxed/simple;
	bh=6MKTXBJGrx2jSfLIad1ZMuJLl3MwVixtkI47w+MqGfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKrfxXCvhAJyTxKtnuKhrypwNqSuuUGP9OcZt73ld7hcHfdl65yqOHcVRatHeOO2ZxQ1ncfSVrHHXWmJaNGV3jWxDtjqYYNjlObWR/yCPXpW9wAnCeZYGxLhnGl/Qas6ksRu89yQfjBrQzaK7IfyjQKAMO4TmCu5n9XWZCU7vtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c4ZBBJoX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c4ZBBJoX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5UXKBSwaQ6wOhFTdLFwEFzOnJtE2mdR9K9zfG4lUm6E=; b=c4ZBBJoXs86PzCb6awPgQPSZFx
	du+H98mAuQFn1Yr8m3TURjgWKDh/ImzxoY5Zj9On05ZVYpUXYHn6cfeESDmMuUuZPCGlbjkaQyrvv
	Lt4GhZEUXwGQnT2dlOicXkqIVoKdj20NKsoDc5B3vum4jJr/6F6BX4W3dw/JZR2G8l0/xa3/Z0tdv
	e6SVjRM+lv7i1LQuZBt/a+kz2XNLvJNnS/aka+4XDv1EQN9WVbdaH7HSfUUB+LCqVAB8yr1oCWDbl
	CX8KT+fNycj8Yi8kE5u9ibWnQ3skqGPvRAIJ6qx09ZSMchlbpg9nizVP+TtN94JQX81fF93x7WGhl
	zjbkuLiA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWZeW-0000000Djex-3ITN;
	Mon, 08 Jun 2026 13:04:28 +0000
Date: Mon, 8 Jun 2026 14:04:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v10 07/37] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <aia93IzhTgi1vGi6@casper.infradead.org>
References: <cover.1780906288.git.mst@redhat.com>
 <50d410b47fe3f45327783e05bd306d5eaab75e65.1780906288.git.mst@redhat.com>
 <aiaUDTeHDA45ZXFS@lucifer>
 <aiagMc9Ng_AE_adh@lucifer>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiagMc9Ng_AE_adh@lucifer>

On Mon, Jun 08, 2026 at 12:06:35PM +0100, Lorenzo Stoakes wrote:
> But instead of overloading user_addr to indicate all kinds of things, instead
> make life easier by actually breaking things out.
> 
> Like:
> 
> enum alloc_context_type {
> 	KERNEL_ALLOCATION,
> 	USER_MAPPED_ALLOCATION,
> 	USER_UNMAPPED_ALLOCATION, // Maybe? Do we ever?
> 	/* Perhaps some other states we want to encode? */
> };
> 
> struct alloc_context {
> 	...
> 
> 	enum alloc_context_type type;
> 	unsigned long user_addr; // Only set if type == USER_ALLOCATION
> 
> 	// Maybe something suggesting context or whether we init before in some
> 	// cases?
> };

Ugh, please, no.  As I suggested last time I commented on this
trainwreck of a series, lift the zeroing functionality from
alloc_frozen_pages() into its callers.
