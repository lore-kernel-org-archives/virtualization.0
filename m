Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F3E331EB8;
	Tue,  9 Jun 2026 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028623; cv=none; b=uecXb5Li8FteXdrP/Fl7QQUUTSLq29GnDF/FFMGP7444EnZj+BwKiBgj/0CMPB6xKNik5yeuyCHU026uwEP0rPDd7fkh9iGAFzalyopy44JZWovN4BebgavaRIKprQSsmdg3YT1RrfZFzDHm34OVUMD2LixPHDY9kBdIyAv2A6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028623; c=relaxed/simple;
	bh=3BN3fj6CPTGF+94UkYQWiLBmo25bQ3dk74ToZd4UDXk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YPxzopDhjFcuZIdaCamR5lMTxAHJyxcQf+8IQWC9FR2b1sDl3SpFdmqDlHw32rvGQegE/zkCIrzLbKDl5tsjYaEWSkqg6t5akZwW6ed2694gbdw3HN/Dyqi6R25OJxnRhLRQjZGFbzZfue14+6QLZ1+Pc0Nt2cjpf4S2Xbu6GnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zLBEZnL8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zLBEZnL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1551F00898;
	Tue,  9 Jun 2026 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1781028621;
	bh=gTxiinItA/M18gsL2pov1Gxb8jn8dEK6DGbUFosQnQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=zLBEZnL8a3T5c/z7U6Cj4ItzXNne0YkfEHRwKpnAz3vsg3C4GobBxMmrl/ZSci7aU
	 Q2zWXEr4eDoaFCZJm1Sg9eTHvVnOo6Zjxcb8wLu7iV4BrZixhfKBj7vaTI8CTiHBvg
	 n6zTywTsgpDeOOxzzmUZbqlsgwx0NwylIDGItyGc=
Date: Tue, 9 Jun 2026 11:10:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil
 Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan
 Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
 <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
 <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>, Christoph Lameter <cl@gentwo.org>, David
 Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Harry Yoo <harry.yoo@oracle.com>, Axel Rasmussen
 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
 <weixugc@google.com>, Chris Li <chrisl@kernel.org>, Kairui Song
 <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham
 <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 virtualization@lists.linux.dev, linux-mm@kvack.org, Andrea Arcangeli
 <aarcange@redhat.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>
Subject: Re: [PATCH splitout] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
Message-Id: <20260609111020.e88f51a7b6ebc37360d66fdc@linux-foundation.org>
In-Reply-To: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com>
References: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 06:12:49 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> TestSetPageHWPoison() is called without zone->lock, so its atomic
> update to page->flags can race with non-atomic flag operations
> that run under zone->lock in the buddy allocator.
> 
> In particular, __free_pages_prepare() does:
> 
>     page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
> 
> This non-atomic read-modify-write, while correctly excluding
> __PG_HWPOISON from the mask, can still lose a concurrent
> TestSetPageHWPoison if the read happens before the poison bit
> is set and the write happens after.  Will only get worse if/when
> we add more non-atomic flag operations.
> 
> Fix by acquiring zone->lock around TestSetPageHWPoison and
> around ClearPageHWPoison in the retry path.  This
> serializes with all buddy flag manipulation.  The cost is
> negligible: one lock/unlock in an extremely rare path
> (hardware memory errors).
> 
> Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
> in this file operate on pages already removed from the buddy
> allocator or on non-buddy pages (DAX, hugetlb), so they do not
> need zone->lock protection.

Sashiko is saying this doesn't do anything "Because
__free_pages_prepare() executes entirely locklessly".  Did it goof?

https://sashiko.dev/#/patchset/df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com


