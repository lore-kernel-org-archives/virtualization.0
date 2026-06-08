Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD131E831;
	Mon,  8 Jun 2026 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916810; cv=none; b=mR1V5lKcGl6Ae/I0qQbEosOsMdeR8HVXC6HVGjhZ7S6cx10cDtMzfzvRCHajyZSljCsMAPuqszZwW2EFX38MkBjuktnxk3t2o1KAK9BMiG7TP4Zo0usaulqMzvAkvT3rBFTlQF3pwaPaYlEHaRXKPlMemxdWMJhXZuP95FODlbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916810; c=relaxed/simple;
	bh=495K67maBlduWJujzDW0Tn6RpndsyPuxj6DbFX1trGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOqBxVLi8742im/T6hpyreLC5TzX81KUDNukih+b/8ZBWffxqZC2y1M/oVRUlYuHJGhK6bcvBcT7qNO5m+oxWiast8ho6+OpbZc7Jp/DhW6IHyHd9qCcy6qM/tihh4h5tf2qIpphfna2K/BIMSB++0my7fCyfbrUNzsEueGFQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEMzA+zx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEMzA+zx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977C71F00893;
	Mon,  8 Jun 2026 11:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780916808;
	bh=9Z6ITjW+9ib3T9oaP6VQ0ImjtuaXiSytRRMaM1yP95c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FEMzA+zxJl5fL2o40m9U4BwWUrHPiIcEF97nnqiTlztYyn1DoUl9ddn7aNoqLBAoy
	 H+OUCjkZRnolnNh5+UYHDPGU4dl2p9xvSbMmpQEg4lufiZ98AbWi7KWe7EX8WrtWO5
	 9PCRCGezNw3jaINWRud6uRSJD9w0NujKmqjjKaKtxajnC1HYmhhmB4SjnB8AfUKd2t
	 RsYua3+g5qUujXN5+b5SQ1Go52nDgoXOAWh8i+Jl1NG12Fugaz22qDQzclB2RfYtmw
	 5BafYyB5QWqqVP3BLH6y3WnL1UyZVMeYnEriW3ollVQi3MR8HC3BOYlOnkX+QG0yPP
	 Y9FbcY/maJHpA==
Date: Mon, 8 Jun 2026 12:06:35 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
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
Message-ID: <aiagMc9Ng_AE_adh@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <50d410b47fe3f45327783e05bd306d5eaab75e65.1780906288.git.mst@redhat.com>
 <aiaUDTeHDA45ZXFS@lucifer>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiaUDTeHDA45ZXFS@lucifer>

In terms of an alternative, I feel that we should:

1. Continue to not change external APIs (correct to not do so)

2. Avoid adding this to any code paths that don't strictly need it

3. Refactor the existing code to make it harder to get wrong. Don't have an
   easily confused sentinel, rather have some kind of context state that is
   passed through.

I mean we already have alloc_context and you're already updating it :)

But instead of overloading user_addr to indicate all kinds of things, instead
make life easier by actually breaking things out.

Like:

enum alloc_context_type {
	KERNEL_ALLOCATION,
	USER_MAPPED_ALLOCATION,
	USER_UNMAPPED_ALLOCATION, // Maybe? Do we ever?
	/* Perhaps some other states we want to encode? */
};

struct alloc_context {
	...

	enum alloc_context_type type;
	unsigned long user_addr; // Only set if type == USER_ALLOCATION

	// Maybe something suggesting context or whether we init before in some
	// cases?
};

And thread that through?

That way we can also add further context later if required rather than this
awkward easily misunderstood parameter.

It might means some further prepatory patches but it avoids the confusion of not
knowing what to set this to, and could perhaps be set further up the stack?

Then look to completely eliminate cases where we zero other than with
__GFP_ZERO.

Perhaps others have ideas too, but this kind of approach seems more appropriate?

It also seems right to send this work as a entirely separate series. 'Always
zero user memory using __GFP_ZERO' seems like a totally valid independent
series.

Thanks, Lorenzo
