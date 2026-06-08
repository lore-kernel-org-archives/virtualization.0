Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F2367B6A;
	Mon,  8 Jun 2026 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941060; cv=none; b=gIXBQynZIKYfbyUeczOXMV3N4SKW/gqTCAND3G0eDspFX6A2u4re3RFNU9N39t4FiKUaJfxkPhqaq0pyGw3IWe/7fxUlePHtBk+16fOofLHP21a+R+02Z8yisI9tZYFNEZ5UByFzeYPf4vi6KmtOCOe9n48UhlwdvUl2+v+4UrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941060; c=relaxed/simple;
	bh=U9wyANSYdY3qQUTOynYoX6e0eez4BXm5RkIg4Fl2PEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7YzH6pG6wsGdLtfo9MmWFG9eryLu5sAsAPVC37QtCnE28INY83MiKFNLtu7gfeUtBj4uufL0yYRyNZGo9I2rEkR3jt7TTKD2mAGtU8rQiRoHSc7iPpj5ZDjOUmwDSe2RvSD3V/FD7vDj5bE/gZU39AmVFasd7qRUAF5qyLHAEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqXdrUY7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqXdrUY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24281F00893;
	Mon,  8 Jun 2026 17:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780941059;
	bh=aHDkkZM0LDnjg910cSwEzql9JdvUeeXv0ZHTIK7GDLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FqXdrUY7MnZgXjGyS34UzEp+k9mBFwy1XPyfvBzqH9M5+Rrj97WZggA524whLavtU
	 fex1sh7aoVw9IMLuHbqG0bK53P45PgKGPHUWWGnuSTW9bgc0GPSFWZWjJ5vXQvYnm6
	 jK3z3oPOO/9d8708nmY88nJxhryP72whFMVt1KqHlIeWHOf9gOvgtu09nP9cF9fTIK
	 NZvYXB/YeKY2j/gbsgK46F08vVHhDMqb/hdaRrs1gnoNECKz8Y7N866XxI2YSKkbTY
	 G82BRdrb2Nid29WdnkhJpE0VI5yr5LASvGW6ohHaH4bsJi3Jr2Wv2m4U+XIdkZsAwh
	 GkNZa8J2v58QQ==
Date: Mon, 8 Jun 2026 18:50:46 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v10 00/37] mm/virtio: skip redundant zeroing of
 host-zeroed pages
Message-ID: <aib9QIGIn8f4W6RM@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <8d5d2fa3-a60c-4d04-b3bf-7a8fe89cb1a0@kernel.org>
 <e54f9b79-b6b4-4911-86ac-48b61889765a@kernel.org>
 <aibjjsoeEcvXobCw@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aibjjsoeEcvXobCw@gourry-fedora-PF4VCD3F>

On Mon, Jun 08, 2026 at 11:45:18AM -0400, Gregory Price wrote:
> On Mon, Jun 08, 2026 at 01:13:42PM +0200, Vlastimil Babka (SUSE) wrote:
> > On 6/8/26 13:02, Vlastimil Babka (SUSE) wrote:
> > > On 6/8/26 10:33, Michael S. Tsirkin wrote:
> > >> Further, on architectures with aliasing caches, upstream with init_on_alloc
> > >
> > > It seems those are niche architectures so we can ignore that part for perf
> > > purposes; the other reason why user_alloc_needs_zeroing() would be true is
> > > booting with init_on_alloc.
> >
> > OK I misread how user_alloc_needs_zeroing() works wrt init_on_alloc, as it's
> > negated. But you're changing that anyway to skip that user zeroing, right?
> >
> > "
> > This series eliminates that double-zeroing by moving the zeroing
> > into the post_alloc_hook + propagating the "host
> > already zeroed this page" information through the buddy allocator.
> > "
> >
> > So relying on "everything in buddy is zeroed" would still work I'd think.
> >
>
> This regresses for anything that previously didn't zero on free or
> alloc, which is most kernel allocations.
>
> I think the scope of this set has increased too much based on early
> feedback to fix the userland-initiated allocations piece along with the
> balloon/reporting/double-zero piece.  That's making all of this
> difficult to continue following.

Yeah I feel this is 3, 4 or 5 series put together, and there's a lot to
discuss in each :) so it's pretty difficult to work with them all put
together.

These need to be deferred/separated.

>
> ~Gregory

Thanks, Lorenzo
