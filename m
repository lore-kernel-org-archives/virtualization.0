Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793269421;
	b=abKBemHlANO8dL6z8DNuYUMHYtrW5W0+u7xdzXBGEW/nG8Rh5ZpSM8GKumr+iwjm47YQ
	 J5SbXUkSpITWRT9JtV0Vos6jwZEME2glujbL5v1QVRQzJBkMzbFOrMwncA4nkz60GrQDL
	 GJClcOi+kr0qXkQk2MobdT1VaPMqjtbp4Xz4M7ynYlB8fcy/yZb+zTO6zJ9+sJzY1RK+l
	 bDrYhlYgrA+C/24c7CRy3MkvbwwbW/owhl0BrMdYUuoXn+1IE0xoNfgBu8YX7puFp8o/u
	 0eZ3nwfO0/3jH2S5BB4ayy9chzWB7mRlRxzCFNziZ6A9mZ24ZthtDVvsxcP6zXWLAqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269421;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=h/NTq1WLBMPSLF6XFZgbhvzXQ8oYuf+0ZqChn7K5Lhk=;
	b=iU6i381Je7thIeirnRZ7CsOqyhHkeZhLZ7njsrGRZWuxMRs5y+f6LMYDHTikQCD+Nu6t
	 LvrgdHogS7ML77X9UhY56LM0nFzofUYLVifUs+nrDkerX5SflWYdwz66EmvGbJ3WAcmxg
	 Z2618MApJMMnnxLZMwm5Yf7D3lhvv5adVC+ILW9Z2YH5KxMgwB4AWa50ym3U/LD0EsO/O
	 QkcZW3y8phu4Jn6I2GZ27ezfqccSNui+iDL/LBIc5q3DmQBSx1yX2GVcZa845CULYLkGk
	 Nzodlie7Kl2Y3EY4j6Ns8xBRXJPCPvBaN/85fW8asQBcFN+WZFIxQwkCkZkJmMOCsIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Ql2h6Chx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA58606A31F
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 10:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DA58606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Ql2h6Chx
Received: from [IPv6:::1] (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: lst@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9E169200AD7;
	Thu, 29 Oct 2026 11:23:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793269416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/NTq1WLBMPSLF6XFZgbhvzXQ8oYuf+0ZqChn7K5Lhk=;
	b=Ql2h6ChxMtOcGZatguhKGOuEC+rmEILtn+if2SqEYCCbxsuZJ6Ru1gYHv8VOZp6Mh4UHgD
	nqC+Abc2a38Cwsw0drk11FIo/o24C4d78/xhRP3/VTW8wljjZU8itJ+/kl8dIca91QxHTe
	zvq2X5SIBOfNysNtdZi59WpQkG7l62333eKKoo1mxhb7lKFl0mbo4G2Zx6icW/xkO4bTTE
	YLTxcS/jNobwPebe1QvNnKjEU9FWzz23p1+A9z4qKfS4d3UnGFoteuJK8i4EG/TbM+kgZm
	36EtXeEIB1VKZmg46ZE6J8JvC49oxRtIkz9PpvGhCuexji4WQBw+w9KH7UeaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793269416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/NTq1WLBMPSLF6XFZgbhvzXQ8oYuf+0ZqChn7K5Lhk=;
	b=GGV5mVLTXHW8P1GM8MYEEw2sQLTe4MwdizvhP5Gb/W/2fDooOaBhx/Sa6fBxsgpigJrLiU
	igwFXfs2zGARcG6oRLe3YbfOnTu/2cJUh7LRJrnnkQS9jz/1Y3UBwkh5VQ/POkNwIuxIT0
	KQqycJPkCqfr8Rb3w+LWfxdHK9tZOIFSmALUHySLhH2nMw1ohIN5PV6epE7MfW9GnTgZiP
	aB1o7tlQphCTr3i/eUUYsp9+VzsQAbIi7aed/Fs9CWQwqWGP3mh0SmpkOiff1MJ5KuNFqQ
	/B16Le4NHB27ysqZuAH84XpNo3HERRJf+Gjr9xim0+G/tMzPUQcCR7egGl6w6w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=lst@pengutronix.de smtp.mailfrom=l.stach@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793269416; a=rsa-sha256;
	cv=none;
	b=WpN8WUnDHqz9Mc+CuO1qqQ2s1JkX/YAqSIeMD64lYoC6u7e/Mf6zaDQORC81p8qVmhEOlB
	Qyk2Tu3F5ZFoPi+6o3G5P8XatkbqSpZqIMxTmNYjN7iZ9PyGZF+UJ9ECFfr5xTsdvve48U
	DwjbkCL6Gqu4fpyQEmvvgJ4MB8/2UNwQB3y97Tn6pks8uSBKkJNnVRBHkLNA79FYLoF/UQ
	/Fka7A7sY843ZzZCE560WkHfHGLJkmQ0WFB126J4qtxaMZHhGGerIFlt07dEmX36MJuoaj
	+Fi5x3cZiGZ8NviUZwVGZyTDLNtqw6kmMNQeZKWIuGV0RSo3ygqYDO8hsPjmKA==
Message-ID: <abca3f0039b07999e29558690c27fef23292bea3.camel@pengutronix.de>
Subject: Re: [RFC PATCH 0/6] dma-buf: Phase out is_signaled() race
From: Lucas Stach <l.stach@pengutronix.de>
To: Philipp Stanner <phasta@kernel.org>, Min Ma <mamin506@gmail.com>, Lizhi
 Hou	 <lizhi.hou@amd.com>, Oded Gabbay <ogabbay@kernel.org>, "Rob Herring
 (Arm)"	 <robh@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Karol
 Wachowski	 <karol.wachowski@linux.intel.com>, Andrzej Kacprowski	
 <andrzej.kacprowski@linux.intel.com>, Sumit Semwal
 <sumit.semwal@linaro.org>,  Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter	 <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Russell King	
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,  Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Alessio
 Belle	 <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>,  Qiang Yu <yuq825@gmail.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov	 <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang	
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten	
 <marijn.suijten@somainline.org>, Lyude Paul <lyude@redhat.com>, Danilo
 Krummrich <dakr@kernel.org>, Boris Brezillon
 <boris.brezillon@collabora.com>, Steven Price	 <steven.price@arm.com>,
 =?ISO-8859-1?Q?Adri=E1n?= Larumbe	 <adrian.larumbe@collabora.com>, Liviu
 Dudau <liviu.dudau@arm.com>, Dave Airlie	 <airlied@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>, Matthew Brost	 <matthew.brost@intel.com>,
 Natalie Vock <nat@pixelcluster.dev>, Arun Pravin	
 <arunpravin.paneerselvam@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 Thomas =?ISO-8859-1?Q?Hellstr=F6m?=	 <thomas.hellstrom@linux.intel.com>,
 Melissa Wen <mwen@igalia.com>,  =?ISO-8859-1?Q?Ma=EDra?= Canal	
 <mcanal@igalia.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance	 <kernel-list@raspberrypi.com>, Dmitry
 Osipenko <dmitry.osipenko@collabora.com>,  Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Zack Rusin
 <zack.rusin@broadcom.com>,  Broadcom internal kernel review list	
 <bcm-kernel-feedback-list@broadcom.com>, Thierry Reding	
 <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Sunil Khatri <sunil.khatri@amd.com>, Kees
 Cook	 <kees@kernel.org>, Jesse Zhang <jesse.zhang@amd.com>, Timur
 =?ISO-8859-1?Q?Krist=F3f?=	 <timur.kristof@gmail.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>,  Kexin Sun <kexinsun@smail.nju.edu.cn>,
 Prike Liang <Prike.Liang@amd.com>, David Rosca	 <david.rosca@amd.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>, Marco Crivellari
 <marco.crivellari@suse.com>, Shixiong Ou <oushixiong@kylinos.cn>, Jouni
 =?ISO-8859-1?Q?H=F6gander?=	 <jouni.hogander@intel.com>, Thadeu Lima de
 Souza Cascardo <cascardo@igalia.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,  Neill Kapron
 <nkapron@google.com>, Michael Bommarito <michael.bommarito@gmail.com>, Sam
 Day <me@samcday.com>,  Gabriel Prostitis <prostitisgabriel@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	imagination@lists.freedesktop.org, lima@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-usb@vger.kernel.org
Date: Thu, 29 Oct 2026 11:23:34 +0100
In-Reply-To: <20261029095542.1526750-3-phasta@kernel.org>
References: <20261029095542.1526750-3-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi Philipp, hi Christian,

Am Donnerstag, dem 29.10.2026 um 10:55 +0100 schrieb Philipp Stanner:
> dma_fence_is_signaled() can return true *while* the fence is signaling.
> This has caused explosions before and I guess we can agree that it's
> just not ideal.
>=20
> The fundamental issue is that the fence-signaled-bit is set under lock
> protection but read without it.
>=20
> So ideally, we would read it with the lock. This would not change the
> relative order, i.e. the bit would still be true in the fence callbacks.
>=20
> Christian informs us that taking the lock causes people to complain
> about performance regressions because the lock-taking shoots down copied
> cache-lines. (which is weird since it would mean that someone is
> repeatedly polling on fences instead of just registering a callback to
> notify himself once it signals)
>=20
I think we would all be interested in the actual use-case that's
sensitive to this kind of latency.

However, I wonder if this is even an issue anymore with the lock
inlined into the fence structure. With the deprecated external lock you
would potentially get two cacheline bounces/remote invalidations for
the exclusive access: once for the lock and one for the
test_and_set_bit atomic op on the flags field.
Now with the inlined lock, the lock operation will bring the cacheline
into exclusive state on the local CPU and the flag check would then
operate on that same cacheline, so there should be only a very minimal
penalty compared to the sole atomic op.

Regards,
Lucas

> Let's accept the potential for regressions as true for now.
> Nevertheless, I think I can propose a path towards removing the race:
>=20
> This series suggests taking the lock in dma_fence_is_signaled() *unless*
> the driver explicitly asks for a check with a race-condition.
>=20
> As a preparation, I allow drivers to set flags when initializing fences.
> Then, we add a flag with which the driver can switch locking off for
> that particular function.
>=20
> By default, we let all drivers take the lock.
>=20
> Should we then, in the kernel release process get reports about
> regressions, we can set the race-flag for the affected driver and
> restore the old behavior.
>=20
> Should there be no reports, we could phase the flag out again after a
> few releases, always taking the lock.
>=20
> New users would always see the lock.
>=20
> I put all potentially affected parties on Cc. Please point out if you
> can already foresee your driver being negatively affected by this.
>=20
> P.
>=20
>=20
> Philipp Stanner (6):
>   dma-buf: dma-fence: Add flags parameter to dma_fence_init()
>   dma-buf: dma-fence: Add flag for using 64-bit seqnos
>   dma-buf: Port users of dma_fence_init64()
>   dma-buf: dma-fence: remove dma_fence_init64()
>   dma-buf: dma-fence: Close race in dma_fence_is_signaled() by default
>   drm/nouveau: Remove hacky fence check
>=20
>  drivers/accel/amdxdna/amdxdna_ctx.c           |  2 +-
>  drivers/accel/ethosu/ethosu_job.c             |  2 +-
>  drivers/accel/ivpu/ivpu_job.c                 |  2 +-
>  drivers/accel/rocket/rocket_job.c             |  2 +-
>  drivers/dma-buf/dma-fence-array.c             |  2 +-
>  drivers/dma-buf/dma-fence-chain.c             |  4 +-
>  drivers/dma-buf/dma-fence.c                   | 44 +++++------------
>  drivers/dma-buf/st-dma-fence-chain.c          |  2 +-
>  drivers/dma-buf/st-dma-fence-unwrap.c         |  2 +-
>  drivers/dma-buf/st-dma-fence.c                |  2 +-
>  drivers/dma-buf/st-dma-resv.c                 |  2 +-
>  drivers/dma-buf/sw_sync.c                     |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |  2 +-
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  7 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  5 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  |  5 +-
>  drivers/gpu/drm/drm_crtc.c                    |  2 +-
>  drivers/gpu/drm/drm_writeback.c               |  2 +-
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |  2 +-
>  drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c  |  2 +-
>  drivers/gpu/drm/i915/i915_request.c           |  2 +-
>  drivers/gpu/drm/i915/i915_sw_fence_work.c     |  2 +-
>  drivers/gpu/drm/i915/i915_vma_resource.c      |  2 +-
>  .../gpu/drm/i915/selftests/i915_sw_fence.c    |  2 +-
>  drivers/gpu/drm/imagination/pvr_ccb.c         |  2 +-
>  drivers/gpu/drm/imagination/pvr_queue.c       |  2 +-
>  drivers/gpu/drm/lima/lima_sched.c             |  2 +-
>  drivers/gpu/drm/msm/msm_fence.c               |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_drm.c         | 13 -----
>  drivers/gpu/drm/nouveau/nouveau_fence.c       |  4 +-
>  drivers/gpu/drm/panfrost/panfrost_job.c       |  2 +-
>  drivers/gpu/drm/panthor/panthor_sched.c       |  2 +-
>  drivers/gpu/drm/qxl/qxl_release.c             |  2 +-
>  drivers/gpu/drm/radeon/radeon_fence.c         |  2 +-
>  drivers/gpu/drm/scheduler/sched_fence.c       |  4 +-
>  .../gpu/drm/scheduler/tests/mock_scheduler.c  |  2 +-
>  drivers/gpu/drm/ttm/tests/ttm_bo_test.c       |  2 +-
>  .../gpu/drm/ttm/tests/ttm_bo_validate_test.c  |  2 +-
>  drivers/gpu/drm/v3d/v3d_fence.c               |  2 +-
>  drivers/gpu/drm/vc4/vc4_gem.c                 |  2 +-
>  drivers/gpu/drm/vgem/vgem_fence.c             |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_fence.c        |  2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_fence.c         |  2 +-
>  drivers/gpu/drm/xe/xe_hw_fence.c              |  2 +-
>  drivers/gpu/drm/xe/xe_oa.c                    |  2 +-
>  drivers/gpu/drm/xe/xe_preempt_fence.c         |  2 +-
>  drivers/gpu/drm/xe/xe_tlb_inval.c             |  2 +-
>  drivers/gpu/host1x/fence.c                    |  2 +-
>  drivers/iio/industrialio-buffer.c             |  2 +-
>  drivers/usb/gadget/function/f_fs.c            |  2 +-
>  include/linux/dma-fence.h                     | 48 +++++++++++++++++--
>  52 files changed, 115 insertions(+), 105 deletions(-)
