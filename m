Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB7F26ED3C;
	Mon,  8 Jun 2026 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923134; cv=none; b=mnMCCXloFjKMGrs0GWl/+NuwZ+8yHJHE3bGwH/fiP5bKFme0XqRZhDU+rCVzTKW9H5UEX1GeJ/ReqZFXGloyrfMbfc+PWaOyDFBielkKIIq8fb5fCHip8C4Y4jzaoXf0dCUyZaJXhKFbQO6vf4v6Wwa402Kx2LyO3E4sxA5Zc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923134; c=relaxed/simple;
	bh=urDI07j5ieAYcLqfJCjQgA0jquxFOU5HpkgEvJtrwCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EE425A3ZJ9JWJMArAVg9P978mNIi3w5z6r0ChBozxEuUhUgO3W59X8BdeFwCG7/nMR7jk7Bx+kEZ7W+SUEuP7XK4gxYU2FW34rkPIKFx7OBW6jrmbUprNGHCluwp3DBKQlaMMUIZwgtbkykrRRvc9+HdMe2M4fOHWjnfCsJI5oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGt1SmTQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGt1SmTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F4E1F00893;
	Mon,  8 Jun 2026 12:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780923133;
	bh=gmVe8ku3CY5kinxGUaPpQUp63b+9qm/CHLoW2Y5uqCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AGt1SmTQgIucQ1ZtlRcS2Py3s4ECdl94z2/YN90I7SjGfvkcn+zQpRanBTE+QkzpA
	 igmMjICG+puOyd9F6z7V86Rwz8l0PcYfX2zlxUZ0QZwtRhyu9Gvn7lbuu7hW9/DPFl
	 19FyvqCbwuq06TfhnINGGwoKK60uJNcaioY8v6BVwOmfa3NnsVpgdWJ/yKnNcoLzBo
	 uL8X5yzJZ0A4aiNM1H5imsW+Uad5zwiU80LQ9eAOZeQyHVvXwcoEehfxXvhrvec1Zv
	 kxqHgJ6nPvELaGUeqFzv1eJbKuQX5BoN4F7Wue6ncQUU4P7lWmKawDI7czyGTF/OrB
	 I1qEc1ZiCG4mw==
Date: Mon, 8 Jun 2026 13:52:00 +0100
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
Subject: Re: [PATCH v10 00/37] mm/virtio: skip redundant zeroing of
 host-zeroed pages
Message-ID: <aia6Xi-zyb1N-y_I@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <aiaHd3T42XyB3UBn@lucifer>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiaHd3T42XyB3UBn@lucifer>

On Mon, Jun 08, 2026 at 10:17:47AM +0100, Lorenzo Stoakes wrote:
> On Mon, Jun 08, 2026 at 04:33:46AM -0400, Michael S. Tsirkin wrote:
> > Further, on architectures with aliasing caches, upstream with init_on_alloc
> > double-zeros user pages: once via kernel_init_pages() in
> > post_alloc_hook, and again via clear_user_highpage() at the
> > callsite (because user_alloc_needs_zeroing() returns true).
> > This series eliminates that double-zeroing by moving the zeroing
> > into the post_alloc_hook + propagating the "host
> > already zeroed this page" information through the buddy allocator.
> >
> > For page reporting, VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED (bit 6)
> > is used. For the inflate/deflate path,
> > VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE (bit 7) is used.
> >
> > Virtio spec: https://lore.kernel.org/all/cover.1778140241.git.mst@redhat.com
> >
> > Based on v7.1-rc6.  When applying on mm-unstable, two conflicts
> > are expected:
> > - kernel_init_pages() was renamed to clear_highpages_kasan_tagged()
> >   in mm-unstable.  Use clear_highpages_kasan_tagged() in the
> >   post_alloc_hook else branch.
> > - FPI_PREPARED uses BIT(3) in mm-unstable.  Bump FPI_ZEROED to
> >   BIT(4).
> > Build-tested on mm-unstable at e9dd96806dbc:
> > https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git zero-mm-unstable
> >
> > Patches 1-5: fixes/cleanups, dependencies of the zeroing patches.
> > Patches 6-9: thread user_addr through page allocator, contig API,
> >   and gigantic hugetlb allocation.
> > Patches 10-16: folio_zero_user in post_alloc_hook, vma_alloc_zeroed
> >   conversion, raw fault address threading.
> > Patches 17-24: PG_zeroed flag, aliasing guard, buddy merge/split
> >   tracking, FPI_ZEROED optimization, folio_put_zeroed.
> > Patches 25-27: __GFP_ZERO callsite conversions (alloc_anon_folio,
> >   vma_alloc_anon_folio_pmd) with memcg charge failure mitigation.
> > Patches 28-29: hugetlb __GFP_ZERO + HPG_zeroed.
> > Patches 30-35: page reporting zeroing (DEVICE_INIT_REPORTED),
> >   disable indirect descriptors.
> > Patches 36-37: inflate/deflate zeroing (DEVICE_INIT_ON_INFLATE).
>
> This seems far too much for one series.
>
> YOu're doing a bunch of mm stuff that seems relatively independent, then
> putting the virtio stuff on top.
>
> I think this should be broken out into separate series laying foundations
> rather than doing it all in one go, which is also difficult for review
> purposes.
>
> Adding a new folio flag is contentious also for instance, we maybe want to
> go bit-by-bit and ensure that each foundational element is acceptable
> before doing the next bit rather than having it as part of a big series.
>
> Looking through the changelog only adds to this feeling! Huge numbers of
> changes, even relatively recently and I'm not sure all relevant maintainers
> in mm have had a look through either.
>
> Thanks, Lorenzo

Additionally, it seems you've missed/ignored (I hope not) a bunch of
pre-existing feedback, so it'd be helpful if you'd carefully go through
what people have previously asked!

Keeping track of that, especially on a big series, is a lot of work.

Thanks, Lorenzo
