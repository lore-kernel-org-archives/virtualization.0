Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E533F58B;
	Mon,  8 Jun 2026 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917233; cv=none; b=WtFwqVzgabWA2cZjtHn4g6vOyVbu2BImpRXP9ks+/gEfRjvtIkp2SI7Nd4UIfgUENnIOszzHWEebsrRYNKrPOgWOs5sRfz+MhN2hUNNeOzJiJwMNs5v9shgXWjYls3OARdHAX9Gen9jGDll/iX2pzIDJyhp27zch7MvlgfDCQuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917233; c=relaxed/simple;
	bh=KC+uicU/B9ZZgU3DjZNygswy0QSjvcRUVDgEaOeI9gA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M4lz3WH/Q9Pbg3B2FZ9rGsng76D87BEhKfMicsU84IXdQeUfOaS6BeOFpuamyp9NhcX9KGXwuR84SnYu3vN2EAJbDo7WdgxE6B0T1YbEJnAR5J2Zew6uMTYZSyJo6oiLMFjfiPsu5aMBqehsHxWKE73j/tvOj4aH57CecZ++BVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVO2Xhpt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVO2Xhpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8544A1F00893;
	Mon,  8 Jun 2026 11:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917231;
	bh=XGLJigV2d51VfcYTfl2W0053EcxmumDAe7qlHgw2QFo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=dVO2Xhpt5B9et3HtGZ+E5d1dDwlrohdKp3ui6s8ZawWlFdNVIF820M+BYU1lU2ait
	 w0NEv49grfPSyTsnHbfNTxMPoe0jIAi8DcOTYsU7E1pz4q/MFzX7BDm64USjSZTrB/
	 f5sMNgZUD514qMoBCoyZ4GHXnNTKDoHU26W1GuAv3Q3TRjHqCGUdc1CadbTSYYHaEL
	 rCfZ76HtL+z/LqyCEwsRsYwHI2jhvjI/LHBh2UThS/oQM2jDp0lbqpVpgU38tkL2B9
	 6NTz8VUDL8inCaOfCwgC1iXHvtXQVuNQ0FIU8eJgspROwelNNwbqAJFWgcINsPcoVM
	 AAgE0rkSS6xxQ==
Message-ID: <e54f9b79-b6b4-4911-86ac-48b61889765a@kernel.org>
Date: Mon, 8 Jun 2026 13:13:42 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/37] mm/virtio: skip redundant zeroing of
 host-zeroed pages
Content-Language: en-US
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 virtualization@lists.linux.dev, linux-mm@kvack.org,
 Andrea Arcangeli <aarcange@redhat.com>
References: <cover.1780906288.git.mst@redhat.com>
 <8d5d2fa3-a60c-4d04-b3bf-7a8fe89cb1a0@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <8d5d2fa3-a60c-4d04-b3bf-7a8fe89cb1a0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/8/26 13:02, Vlastimil Babka (SUSE) wrote:
> On 6/8/26 10:33, Michael S. Tsirkin wrote:
>> Further, on architectures with aliasing caches, upstream with init_on_alloc
> 
> It seems those are niche architectures so we can ignore that part for perf
> purposes; the other reason why user_alloc_needs_zeroing() would be true is
> booting with init_on_alloc.

OK I misread how user_alloc_needs_zeroing() works wrt init_on_alloc, as it's
negated. But you're changing that anyway to skip that user zeroing, right?

"
This series eliminates that double-zeroing by moving the zeroing
into the post_alloc_hook + propagating the "host
already zeroed this page" information through the buddy allocator.
"

So relying on "everything in buddy is zeroed" would still work I'd think.

>> double-zeros user pages: once via kernel_init_pages() in
>> post_alloc_hook, and again via clear_user_highpage() at the
>> callsite (because user_alloc_needs_zeroing() returns true).
>> This series eliminates that double-zeroing by moving the zeroing
>> into the post_alloc_hook + propagating the "host
>> already zeroed this page" information through the buddy allocator.
> 
> I wonder if this whole thing would be much easier if those that would want
> performance would enable only init_on_free and not init_on_alloc at the same
> time. If you enable both you're paranoid and just eat the cost I guess. Then
> you're maybe also paranoid so much that you wouldn't want to trust the host
> zeroing anyway?
> 
> post_alloc_hook() already has logic that if init_on_free is enabled, there's
> no init during alloc. So then I think you would only need to communicate
> that host zeroed some pages when the guest adds them to the buddy allocator,
> and that's it?
> 
> I.e. if we can just assume that everything in the buddy is zeroed, we don't
> need all the PG_zero flag and whatnot complexity.

