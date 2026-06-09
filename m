Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42333EFD28;
	Tue,  9 Jun 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999466; cv=none; b=jnZ4zKr7H0BS7abtXaFsdP2BY9rrvUkwHeaG7iSpLh2opkwAmEyEq+1ozt5ueCZHJuWhVs17anHJoGmEMt6Mm075Pcha7CBMmw+1v960wnXGxU73+8YND8c6nF9WLCKuLkHkWMQjAnK/lKHlEXGy7D3DFSA9933FVz4i9767H9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999466; c=relaxed/simple;
	bh=24LLS2IujXIsxqj/N2znkwF2LDRJBt9IcN4tpduhzAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1/NqYl4W85dv89ykpQ9C4q9242ElVV+rR3VZrueHazIJl8H6G0hwjQJ2KsUc17zIj4nJH/LX0RGhGN0MEE3vmIzJtcY1kU2eEnmwDdXYw+REHUteEfJnKEye2SJkDHwaWPxXSYWb5Qn0/QmP9Tg/SDGQsaq60bLpEywMTw0Rlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMqEQqfs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMqEQqfs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F0F1F00893;
	Tue,  9 Jun 2026 10:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780999464;
	bh=24LLS2IujXIsxqj/N2znkwF2LDRJBt9IcN4tpduhzAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PMqEQqfsqjHJVuhYQMqXBYsaeM5c11yAnSX6xVGwLIcYg5Yw3INpoCNKJskFiSK0j
	 QDyEmE5+nMlosFDj076ls0CDm5m7Wb6d0TTKmdbQ4Aksg4GCEjK6+r4Z3M7HLS6PCA
	 rgrUcoaWQXoGZ1cqNdEwg34FBd1FL51/1cKLXVFYirvtI7z04jfLVVF22jYrb5ELWc
	 OV71WWrFihbTS3XI1GQTka39+gd47rgXU/MpkDwvVgum/mFqzrkb+YFzV8mftijhv2
	 /GMNhKqLDCHwC/EXKK/UF6tj4yVrkG5u+9YPYsikuxP6ZDOsjXZu3/0Rf7v8yPgDVa
	 sqIOYM43j437w==
Date: Tue, 9 Jun 2026 11:04:10 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
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
Subject: Re: New design
Message-ID: <aifkpYCj3CuERL4q@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <aiePVsiV-w-IZ8A4@casper.infradead.org>
 <20260609033042-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609033042-mutt-send-email-mst@kernel.org>

On Tue, Jun 09, 2026 at 04:06:08AM -0400, Michael S. Tsirkin wrote:
> One other question: would people like to see it as a single patchset
> or multiple ones 1-4? Multiple ones would be easier to review but
> of course this means no actual perf gain until part 5 is merged. Is that
> acceptable?

Personally I'd like to see multiple patch sets, not all sent at once.

Rather - send the first, wait for review, and once people have given tags,
then send the next - rinse and repeat.

That makes life easier for review, allows forward progress, and avoids
noise on-list.

>
> --
> MST
>

Thanks, Lorenzo
