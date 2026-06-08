Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C137DE9F;
	Mon,  8 Jun 2026 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928500; cv=none; b=MY6ii+9RaPLSNygZEL1ObEyd0QkcLeGDU2lyGcwMcfh3o5+qk6+8B6kJ2B+HkHHL3/pNVgXTv2LSrZ3hAQWioLYEM+d5Ds558hapJMVf9WQb6CLdCea+uST+iiRkJ8zCevo0m3b0djAUh4XCXdI8qSxeKRxJBmDoUhiwW4Rw3Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928500; c=relaxed/simple;
	bh=dIp8OncR/N6+Msx6ebEIl2OPdEwxVMr5YeI9woh/zqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZ7WLEy7hHvX7573Sze7V9ByTw2NpCVhUBXUSYHUHo4qgP11lNOzBuf/v0ElSc60VPZBQR4rytqsVS5qo+n9B8Bm3/zSZj/hZ/gmGqUb0os35waOBJRnixhFDED4pncGzNyJgxoEyqNTdKowQ1blmj7mkXdjwbp4VRdX1AZK/m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zi/4pEzk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zi/4pEzk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h/FvwH7hiTUiSgXuBMQJZGeWVoT1jQU76udfTFE9sNg=; b=Zi/4pEzkbmp3eNe66ZAaDUYa1O
	fOc32vjLemygMfE9A3RkrAkbdgVmPv/sqfT6ysqFHPFFrBfvD55DXejRYaI6bCgYNF53/hH8jGHky
	zu2L5HVQnDcF4il0hThRMP3dfpVqmxdx9TRI2bb5Noz1rvTR4R4oY0DzWWRkWvgbefONG6Wum3uXx
	ESRmzCTd/xhw0qjCIGcHESk4G6UK3OP0GHqjxvOzNqPWEBaFFVOKjXCAQTlEY8XE7253MSrvrWYdh
	0isoec0vPjBh+/2uObNe0TStQX2gRd9NiZgD76bHAaeXhFt6O9yU/He8xxcMDaqHrYmp14YU0336T
	4kFGef8A==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWaqz-0000000DqUd-1gvI;
	Mon, 08 Jun 2026 14:21:25 +0000
Date: Mon, 8 Jun 2026 15:21:25 +0100
From: Matthew Wilcox <willy@infradead.org>
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
Subject: Re: [PATCH v10 00/37] mm/virtio: skip redundant zeroing of
 host-zeroed pages
Message-ID: <aibP5W-fGcyPp9e4@casper.infradead.org>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:33:46AM -0400, Michael S. Tsirkin wrote:
> Further, on architectures with aliasing caches, upstream with init_on_alloc

Further to what?  Did you leave out some paragraphs here?

As far as I can tell, this patch series decides to trust that the
hypervisor has zeroed pages that it allocates to the guest.  But
as far as I can tell, the trend is towards less trust in the hypervisor
from the guest, not more.
