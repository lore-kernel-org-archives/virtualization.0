Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9253DD504;
	Tue,  7 Jul 2026 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419328; cv=none; b=eB9+R/HCOzOr0ZGaj65BTk+wSOIRluxYb3jTZnWadgkV66rtmD/4egceGbq1DvtxWbc942NdFjTXr5mqKOuzlwcxbGzk66nq+6sLXUmGbj/kMps72+kcC7JNmRaZxKVv0Gewf/RRsgi7FGQ5RYZ6WcPQk9SnQa2wQB1DM4nIJZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419328; c=relaxed/simple;
	bh=8lt2sVofaybpU6Pf7XUgVnI/rV2AbbnENR18ng/RjYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bh+YxBkg+Ce85kTjaVevQI69BHa58O+6KtflOi/krt4+y9i/6gtaknodm8T+iMts72PzZnt9vZwWIs6ZIDByeTnT4zBwfFCHmVB7UGeQX34Dl0znBdwzIxy43+UQq9+UJifU6c+yb5J6siN1VUpfoI8DDFScA6FlgxbavJ5HdgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HluYhwOW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HluYhwOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAC81F00A3D;
	Tue,  7 Jul 2026 10:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783419327;
	bh=mNSla9Czr4vFeuTIzrP/cHDzh+yx/IrTUvaJ5OnP34U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HluYhwOWRqwjbw9mnNEjPVnyh7tR+UBSnSv/otgjpUQBigWOwZUJOYkpU0LnGQPOd
	 9JWuafQR68ncbIWqn0jW8jTfwPafpmeDnt2Wvr8VLfjDqTgkyFdLwQrzBX5aGYlPBy
	 bdDr9uov5pNq61DLoYMBBHIrYLPaluS9cGGvVLuwrNNgpnc0PxTOy1Y4Jv6WgqJLPU
	 g8L2HsabDqHedwwaZisYTmwsI8Liu2LIO7hoQNV8VhXPReqA934JiUn5O3mwQK8rxr
	 zZFBy1M3lH7Q7XggDkvTulkUo1eG7DFZ7mTqdd75PKoMBF8VkjG7TCZVSFf+WpnFzU
	 vO+QqUik5Cd9A==
Date: Tue, 7 Jul 2026 11:15:02 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Lucas Stach <l.stach@pengutronix.de>, Inki Dae <inki.dae@samsung.com>, 
	Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Zack Rusin <zack.rusin@broadcom.com>, 
	Matthew Brost <matthew.brost@intel.com>, Thomas Hellstrom <thomas.hellstrom@linux.intel.com>, 
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Helge Deller <deller@gmx.de>, Benjamin LaHaise <bcrl@kvack.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, 
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org, 
	linux-fbdev@vger.kernel.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 02/13] mm/vma: update do_mmap() to use vma_flags_t
Message-ID: <akzRdIS8ZotxIOFR@lucifer>
References: <cover.1782760670.git.ljs@kernel.org>
 <e0ac58ad2b88ff7e2f0024e3286b2e786f79ca32.1782760670.git.ljs@kernel.org>
 <DJRZ2QCEIVA6.1AZF5S891NKS4@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJRZ2QCEIVA6.1AZF5S891NKS4@nvidia.com>

On Mon, Jul 06, 2026 at 10:10:32PM -0400, Zi Yan wrote:
> On Mon Jun 29, 2026 at 3:25 PM EDT, Lorenzo Stoakes wrote:
> > The core do_mmap() function accepts a vm_flags_t parameter which it then
> > manipulates before passing to mmap_region() to do the heavy lifting of the
> > memory mapping.
> >
> > Update do_mmap() to instead accept a vma_flags_t parameter, and adjust all
> > the logic within do_mmap() to manipulate this instead.
> >
> > This is as part of the ongoing effort to convert VMA flags from a system
> > word size to a bitmap type which allows us to unrestrict the number of VMA
> > flags, as well as gain control over how VMA flag manipulation occurs.
> >
> > We do not cascade these changes to all functions which accept vm_flags_t,
> > but rather use vma_flags_to_legacy() where necessary, specifically
> > deferring converting calc_vm_prot_bits(), calc_vm_flag_bits() and
> > __get_unmapped_area() to vma_flags_t.
> >
> > Also utilise the new vma_flags_can_grow() predicate which correctly handles
> > the case of architectures without upward growing stacks.
> >
> > As part of this change, introduce VMA_SHADOW_STACK so we can correctly
> > handle the case of the shadow stack not being defined.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> > ---
> >  arch/mips/kernel/vdso.c |  4 +--
> >  fs/aio.c                |  2 +-
> >  include/linux/memfd.h   |  6 ++--
> >  include/linux/mm.h      |  6 ++--
> >  ipc/shm.c               |  3 +-
> >  mm/memfd.c              | 15 ++++-----
> >  mm/mmap.c               | 67 ++++++++++++++++++++++++-----------------
> >  mm/nommu.c              |  3 +-
> >  mm/util.c               | 10 +++---
> >  mm/vma.c                |  7 ++---
> >  mm/vma.h                |  2 +-
> >  11 files changed, 69 insertions(+), 56 deletions(-)
> >
>
> <snip>
>
> >
> > -static int check_write_seal(vm_flags_t *vm_flags_ptr)
> > +static int check_write_seal(vma_flags_t *vma_flags_ptr)
> >  {
> > -	vm_flags_t vm_flags = *vm_flags_ptr;
> > -	vm_flags_t mask = vm_flags & (VM_SHARED | VM_WRITE);
> > -
> >  	/* If a private mapping then writability is irrelevant. */
> > -	if (!(mask & VM_SHARED))
> > +	if (!vma_flags_test(vma_flags_ptr, VMA_SHARED_BIT))
> >  		return 0;
> >
> >  	/*
> >  	 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
> >  	 * write seals are active.
> >  	 */
> > -	if (mask & VM_WRITE)
> > +	if (vma_flags_test(vma_flags_ptr, VMA_WRITE_BIT))
> >  		return -EPERM;
> >
> >  	/*
> >  	 * This is a read-only mapping, disallow mprotect() from making a
> >  	 * write-sealed mapping writable in future.
> >  	 */
> > -	*vm_flags_ptr &= ~VM_MAYWRITE;
> > +	vma_flags_clear(vma_flags_ptr, VMA_MAYWRITE_BIT);
> >
> >  	return 0;
> >  }
>
> This function alone changed its original behavior, since vm_flags is a
> snapshot of *vm_flags_ptr, but after the change this snapshot is gone.
> But its only caller memfd_check_seals_mmap() gets vm_flags_ptr from the
> input parameter of do_mmap(), so the overall behavior does not change.

Right yeah, the snapshot was always just a convenience thing :)

>
> <snip>
>
> > +		case MAP_DROPPABLE: {
> > +			vma_flags_t droppable = VMA_DROPPABLE;
> > +
> > +			if (vma_flags_empty(&droppable))
> >  				return -EOPNOTSUPP;
> > +			vma_flags_set_mask(&vma_flags, droppable);
> > +
> >  			/*
> >  			 * A locked or stack area makes no sense to be droppable.
> >  			 *
> > @@ -515,23 +527,24 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> >  			 */
> >  			if (flags & (MAP_LOCKED | MAP_HUGETLB))
> >  			        return -EINVAL;
> > -			if (vm_flags & (VM_GROWSDOWN | VM_GROWSUP))
> > +			if (vma_flags_can_grow(&vma_flags))
> >  			        return -EINVAL;
> >
> > -			vm_flags |= VM_DROPPABLE;
> > -
>
> Lance pointed out the reordering of setting VMA_DROPPABLE and checking
> of can_grow, but these flags are not overlapped and there is no parallel
> writer to vma_flags. So it is still no functional change, just not
> mechanical changes. :)

Right yes exactly :)

>
> Otherwise, LGTM.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks!

>
> --
> Best Regards,
> Yan, Zi
>

Cheers, Lorenzo
