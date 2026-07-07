Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3A830D403;
	Tue,  7 Jul 2026 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419443; cv=none; b=iFd30XJHRb4+HAQ2gBYV0vfBmIhkaGoNPkKsq4hENdld5xPen3Q3ROiujeem/lRJb9NGQf/nND9JtXgz1FbLdRmThq59pTmOMEiXtZ4090UcHozBg4zAnl17N4agyJ3i1iQuLokiiF5O44j9w0A2pliSmlwDYR9+9wJLc74NvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419443; c=relaxed/simple;
	bh=otIkrJ34PwtSzdRkCKl+4UR6U9X1i0nmtukZH91G9+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddDxQwLTl5LjZ533n9UswvuEJu4ExJa7TIWsZuzn3lg5rq8ELphr7y5l3ScoulaLoF8BDfeYIt1I794JwiKgy0THpg/6YLvEwD791I9dXmADynqBtzgEer83+/aZaAlbw6TdQMysiMnBpqa/xLw3ddnsg9c6jy1kAoslQKsUo9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGH+4V3q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGH+4V3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122461F000E9;
	Tue,  7 Jul 2026 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783419441;
	bh=mnyEnVNjUbkl63yjftBd6ZAUslZHuhLMLE5i1q1dbiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cGH+4V3qnWn/h2ntR4JOMP1MeFASTJyb/ukIFIKga6vmMPs4hWnZeyozgnP8o9zcj
	 4aOepXlE5yG0XgvATIbejO38So9984JOSQXxfemV7MrbXTQdbQqJryZ7by0rmLtk6g
	 KbyecrBlOO6RxZhZHoEJHQvN3lfQ+IRVIfllVkFrcFe5jzAzy0lAaGw02N38CG8Xem
	 bIuNc24pIIBeQZLitf75XKOixE/v2BoAd9XaTV+y7NflJFaBKiVOSfh8s3qL1kjbV3
	 QtnOkHzUZcffKxdXoostqrwbOmOdDgDEYFoMQefdIk5SYi6OuZQQ8BSF6bkbad2igD
	 ZZ2I4X8hc6i0g==
Date: Tue, 7 Jul 2026 11:16:56 +0100
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
Subject: Re: [PATCH 03/13] mm: convert __get_unmapped_area() to use
 vma_flags_t
Message-ID: <akzR7JQuaKEQpH5Y@lucifer>
References: <cover.1782760670.git.ljs@kernel.org>
 <b1ad7c4443f5cba622e4c48c5a9ef15427001a93.1782760670.git.ljs@kernel.org>
 <DJRZGEZU5ESV.3IP5LEAUQJCBK@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJRZGEZU5ESV.3IP5LEAUQJCBK@nvidia.com>

On Mon, Jul 06, 2026 at 10:28:24PM -0400, Zi Yan wrote:
> On Mon Jun 29, 2026 at 3:25 PM EDT, Lorenzo Stoakes wrote:
> > Update __get_unmapped_area() to be parameterised by vma_flags_t rather than
> > vm_flags_t as part of the effort to move VMA flags from a system word to a
> > bitmap.
> >
> > We cascade the changes up to arch_get_unmapped_area_topdown() and
> > arch_get_unmapped_area(), where, for now, we use vma_flags_to_legacy() in
> > order to propagate the VMA flags.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> > ---
> >  fs/hugetlbfs/inode.c     |  3 ++-
> >  include/linux/huge_mm.h  | 10 +++++-----
> >  include/linux/mm.h       |  6 ++++--
> >  include/linux/sched/mm.h | 12 ++++++------
> >  mm/huge_memory.c         | 21 ++++++++++++---------
> >  mm/mmap.c                | 27 ++++++++++++++-------------
> >  6 files changed, 43 insertions(+), 36 deletions(-)
> >
> <snip>
>
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index 95d0040df584..b301ec90740a 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -193,12 +193,12 @@ unsigned long mm_get_unmapped_area(struct file *filp, unsigned long addr,
> >  				   unsigned long len, unsigned long pgoff,
> >  				   unsigned long flags);
> >
> > -unsigned long mm_get_unmapped_area_vmflags(struct file *filp,
> > -					   unsigned long addr,
> > -					   unsigned long len,
> > -					   unsigned long pgoff,
> > -					   unsigned long flags,
> > -					   vm_flags_t vm_flags);
> > +unsigned long mm_get_unmapped_area_vmaflags(struct file *filp,
> > +					    unsigned long addr,
> > +					    unsigned long len,
> > +					    unsigned long pgoff,
> > +					    unsigned long flags,
> > +					    vma_flags_t vma_flags);
>
> Want to use two-tab indentation while at it?

Yeah sure will fix on respin!

>
> <snip>
>
> > @@ -812,19 +811,20 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
> >  }
> >  #endif
> >
> > -unsigned long mm_get_unmapped_area_vmflags(struct file *filp, unsigned long addr,
> > -					   unsigned long len, unsigned long pgoff,
> > -					   unsigned long flags, vm_flags_t vm_flags)
> > +unsigned long mm_get_unmapped_area_vmaflags(struct file *filp, unsigned long addr,
> > +					    unsigned long len, unsigned long pgoff,
> > +					    unsigned long flags, vma_flags_t vma_flags)
>
> Ditto.

Ack will fix!

>
> LGTM.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks!

>
>
> --
> Best Regards,
> Yan, Zi
>

Cheers, Lorenzo
