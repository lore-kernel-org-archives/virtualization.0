Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A19D25C6EE;
	Thu,  2 Jul 2026 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006839; cv=none; b=aXuZ1AvGL/SqfScg6yTXojcBsV2s4TYDl+iqGlYwnm/mMT5EUuX8/vb3bTaBtQNWta39LfMTU3SWsn4aHwxOTHY812Wyb6K5fpIAdg8oQHpnUGK9YH6qWH0+oC6moE+sNONS10gwh/Iaj1htd60s7FVz+oWWEf5VkOOjCkrbSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006839; c=relaxed/simple;
	bh=1KusJ3AQEr1aqQ3DLhLNitOF1kBax8nnylo9H5eGrBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqUuNVcEIEOXVr+yfo7Pr+eyP7gpA2e7R7wCC5tTxOf2C0UxAE66k/whYEbOZcwDavVevV4GhkWmeP5zwcOxXcrGF5JUWvNOXbJjxDbrQlv6TbWv5sGj/90o+rEheWXFPhKi4yyyxMfI9wyQ06KDcPddLiZc1raqHUv7F45PyoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8vOAtQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8vOAtQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8E41F00A3E;
	Thu,  2 Jul 2026 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006838;
	bh=gNLYS8EYE6bJ5KaXF7DR9fRu4urDF+a7laqqF8q0hcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z8vOAtQOT+iGTiy4xQ3GfxWy9CpR6iieY1qxm1fyBJSvxEFV2aEwGeTLwIZE4UbYF
	 sH6QvDHKQJHBXcc/JYlecYNDNZBJEw63vn2taYjOLxg3iNlePJRLcm76SDX3qcqqpf
	 OAzUHT+NRGQHyZOOfos5EJuVfaKEWfkdr4crDOBp2KFX/hKeIetGWLc1I64/oz6RHQ
	 NC8RA6ivq/IEW4DV1d+3Z0k229cWnviqo6Svky+UHUgnyeaFy3m0xyIovRQ1UfVX8n
	 wqqP9ts5FpBy46j7HS+G+te0/D/3BLeS388iQo+wLiLJCSDRdl7jDwGFy3vdpkllGJ
	 NUUDfmqseIbQg==
Date: Thu, 2 Jul 2026 16:40:15 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, tsbogend@alpha.franken.de, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	l.stach@pengutronix.de, inki.dae@samsung.com, sw0312.kim@samsung.com, 
	kyungmin.park@samsung.com, krzk@kernel.org, peter.griffin@linaro.org, 
	jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, 
	tursulin@ursulin.net, robin.clark@oss.qualcomm.com, lumag@kernel.org, lyude@redhat.com, 
	dakr@kernel.org, tomi.valkeinen@ideasonboard.com, hjc@rock-chips.com, 
	heiko@sntech.de, andy.yan@rock-chips.com, thierry.reding@kernel.org, 
	mperttunen@nvidia.com, jonathanh@nvidia.com, kraxel@redhat.com, 
	dmitry.osipenko@collabora.com, zack.rusin@broadcom.com, matthew.brost@intel.com, 
	thomas.hellstrom@linux.intel.com, oleksandr_andrushchenko@epam.com, deller@gmx.de, bcrl@kvack.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
	david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	liam@infradead.org, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, hughd@google.com, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, jannh@google.com, pfalcato@suse.de, 
	kees@kernel.org, perex@perex.cz, tiwai@suse.com, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, virtualization@lists.linux.dev, 
	intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org, 
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 08/13] mm: introduce vma_get_page_prot() and use it
Message-ID: <akaGOiLz-3Zx6kDs@lucifer>
References: <3bb8bdc4788230c33102166d56cbc5abfad9d4cb.1782760670.git.ljs@kernel.org>
 <20260702123845.95316-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702123845.95316-1-lance.yang@linux.dev>

On Thu, Jul 02, 2026 at 08:38:45PM +0800, Lance Yang wrote:
>
> On Mon, Jun 29, 2026 at 08:25:31PM +0100, Lorenzo Stoakes wrote:
> >There's a large number of vm_get_page_prot(vma->vm_flags) invocations. Make
> >life easier by introducing vma_get_page_prot() parameterised by the VMA.
> >
> >This also makes converting vm_get_page_prot() to vma_flags_t easier.
> >
> >Also update the userland VMA tests to reflect the change.
> >
> >No functional change intended.
> >
> >Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> >---
> > drivers/gpu/drm/drm_gem.c                   |  2 +-
> > drivers/gpu/drm/drm_gem_dma_helper.c        |  2 +-
> > drivers/gpu/drm/drm_gem_shmem_helper.c      |  2 +-
> > drivers/gpu/drm/etnaviv/etnaviv_gem.c       |  2 +-
> > drivers/gpu/drm/exynos/exynos_drm_gem.c     |  6 +++---
> > drivers/gpu/drm/i915/gem/i915_gem_mman.c    | 12 ++++++------
> > drivers/gpu/drm/msm/msm_gem.c               |  2 +-
> > drivers/gpu/drm/nouveau/nouveau_gem.c       |  2 +-
> > drivers/gpu/drm/omapdrm/omap_fbdev.c        |  2 +-
> > drivers/gpu/drm/omapdrm/omap_gem.c          |  6 +++---
> > drivers/gpu/drm/rockchip/rockchip_drm_gem.c |  2 +-
> > drivers/gpu/drm/tegra/gem.c                 |  2 +-
> > drivers/gpu/drm/virtio/virtgpu_vram.c       |  2 +-
> > drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c  |  2 +-
> > drivers/gpu/drm/xe/xe_device.c              |  2 +-
> > drivers/gpu/drm/xe/xe_mmio_gem.c            |  2 +-
> > drivers/gpu/drm/xen/xen_drm_front_gem.c     |  2 +-
> > drivers/video/fbdev/core/fb_io_fops.c       |  2 +-
>
> One missed?
>
> drivers/gpu/drm/panthor/panthor_gem.c still has:
>
> 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
>
> Can use vma_get_page_prot(vma) too.

Oops! Will respin and update. Good spot!

>
> [...]

Thanks, Lorenzo
