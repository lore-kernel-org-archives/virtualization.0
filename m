Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD6E26ED40
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995999; cv=none; b=VSds1PX+XC3LkbvgdUF9qGswpKgLxBz5czzYJGBe64JqOE9mfd7ATmV4+rmck1sZ3Of2kKDOcWFRlXCzx8TAgx5FpHqRSBQHUjfCVeSPo5NQu9A9lECbw6dc1l25rCiu+/SxKzyN8uz9KHyT/WbYwjUv3z9wOcqObJiU/BbQ0x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995999; c=relaxed/simple;
	bh=kWlPB3bl2hFIoKRfAQQlliaKbL0nQpTVsDlwq9+KKyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csnlzfotrxdV8GADJh/+TpkO/0UQmduiKA1KLqq9VXhhlP+iKQMlHsSMpR6xtnDh8HmBFNKp1eZS61MZXlD4B6EyZgVa8XQxWvPDZu1YWbbJlcAIGsKIopi7v736Cto8Jkkw3sgJ7KJ04GwVbxiadInIHsC28CZ65/jtVkLqYL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F10EZD2M; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F10EZD2M"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782995985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSqvG6QTDeOE5qt8LI9tLb3iySB/2eramUM4HlZdPG8=;
	b=F10EZD2MKuMsgIZGg+Kv4CpsFBAqfutqUSZV+CnlSj4mTRO6SM+hx7IFnwTXi02n4W5ksq
	B3eV7EruPZaVg8GiZqN77RrtZjvlyRAPzkka+Z5kYwT5shcZ0occtt6vxWz8dsjkDZRJwI
	jZvjN/4FCRiAB3/YW0BqvRoNYnrlgRU=
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	tsbogend@alpha.franken.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	l.stach@pengutronix.de,
	inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	krzk@kernel.org,
	peter.griffin@linaro.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	robin.clark@oss.qualcomm.com,
	lumag@kernel.org,
	lyude@redhat.com,
	dakr@kernel.org,
	tomi.valkeinen@ideasonboard.com,
	hjc@rock-chips.com,
	heiko@sntech.de,
	andy.yan@rock-chips.com,
	thierry.reding@kernel.org,
	mperttunen@nvidia.com,
	jonathanh@nvidia.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	zack.rusin@broadcom.com,
	matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	oleksandr_andrushchenko@epam.com,
	deller@gmx.de,
	bcrl@kvack.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	hughd@google.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jannh@google.com,
	pfalcato@suse.de,
	kees@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org,
	xen-devel@lists.xenproject.org,
	linux-fbdev@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 08/13] mm: introduce vma_get_page_prot() and use it
Date: Thu,  2 Jul 2026 20:38:45 +0800
Message-Id: <20260702123845.95316-1-lance.yang@linux.dev>
In-Reply-To: <3bb8bdc4788230c33102166d56cbc5abfad9d4cb.1782760670.git.ljs@kernel.org>
References: <3bb8bdc4788230c33102166d56cbc5abfad9d4cb.1782760670.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Jun 29, 2026 at 08:25:31PM +0100, Lorenzo Stoakes wrote:
>There's a large number of vm_get_page_prot(vma->vm_flags) invocations. Make
>life easier by introducing vma_get_page_prot() parameterised by the VMA.
>
>This also makes converting vm_get_page_prot() to vma_flags_t easier.
>
>Also update the userland VMA tests to reflect the change.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>---
> drivers/gpu/drm/drm_gem.c                   |  2 +-
> drivers/gpu/drm/drm_gem_dma_helper.c        |  2 +-
> drivers/gpu/drm/drm_gem_shmem_helper.c      |  2 +-
> drivers/gpu/drm/etnaviv/etnaviv_gem.c       |  2 +-
> drivers/gpu/drm/exynos/exynos_drm_gem.c     |  6 +++---
> drivers/gpu/drm/i915/gem/i915_gem_mman.c    | 12 ++++++------
> drivers/gpu/drm/msm/msm_gem.c               |  2 +-
> drivers/gpu/drm/nouveau/nouveau_gem.c       |  2 +-
> drivers/gpu/drm/omapdrm/omap_fbdev.c        |  2 +-
> drivers/gpu/drm/omapdrm/omap_gem.c          |  6 +++---
> drivers/gpu/drm/rockchip/rockchip_drm_gem.c |  2 +-
> drivers/gpu/drm/tegra/gem.c                 |  2 +-
> drivers/gpu/drm/virtio/virtgpu_vram.c       |  2 +-
> drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c  |  2 +-
> drivers/gpu/drm/xe/xe_device.c              |  2 +-
> drivers/gpu/drm/xe/xe_mmio_gem.c            |  2 +-
> drivers/gpu/drm/xen/xen_drm_front_gem.c     |  2 +-
> drivers/video/fbdev/core/fb_io_fops.c       |  2 +-

One missed?

drivers/gpu/drm/panthor/panthor_gem.c still has:

	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);

Can use vma_get_page_prot(vma) too.

[...]
