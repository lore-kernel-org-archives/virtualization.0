Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878765;
	b=A9LtQ4Ktwt2EGvE3xsxl5agqQ3u4iIwf5+xawugwZiqN8Ll5bldYPuiDPotqKG2ddfyU
	 Hhsi1OnGyU5pAZu9UZIwiv5yl9JWEdwXdAtjbLMMcl8KG3cefmcOGIzbbtmyhH7rlluIs
	 FdKO03LmXxuUU5BD8tSUTbHO8ghhUsrbRZtV88Qs4sXYZ1x2YDxkHDrSIs7DFvANdNy36
	 6g4VN6zw2aQOf9bGU5dB85tN0lg18bIR/p8k+N95bitwjU1o7I+5cGem7JsdrmPTodd2A
	 RItnVJWJDUDUHs3kxuhhJdEwMBOyy12tYw7d3rnL8t9b6jsk4QfXvGI3ctOCstnq4ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878765;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nBYw1ywhOZ/qkhjAQYbGVUhl6PlTBeWYLHkpD07E2JA=;
	b=ZflwMk+sdBPrF63QOORw7QYqKoYK1lzgosYKRwdHfKpDLfEDdY64kz5fZLIiPi7P/9Vb
	 w3g49sPoea6+4ret6++MnrQZRQ85w3a8Xx9BSh8jvJjWkhI7gps8aKkFW0mwPFEQ26NPN
	 YJifX0gW7YMi4Ot73YEdbITChlOvLxpePri6z4LvfB2IQMlkU8uZBXW/u7BLtE7j+V3vw
	 vmher1z3G9k9sY+RZtVDrrZjc6XEafTiMDGvhLjM3DTHYTMVD09B1ck8Umu0jV9nva5kN
	 8GjZ0UGp6dlLhEuz31FI4EFrejyXUvweLTFUuqIloRxt19DNbjaGoJHe+m0eRlzh2vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zg+N9Od5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F13606A326;
	Thu,  5 Nov 2026 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zg+N9Od5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511611F000C1;
	Thu,  5 Nov 2026 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878764;
	bh=nBYw1ywhOZ/qkhjAQYbGVUhl6PlTBeWYLHkpD07E2JA=;
	h=From:To:Cc:Subject:Date;
	b=Zg+N9Od5zSsBpPaBLRFCUpb24UpOsG40XB2g0jmYK6PIQt6/NgQ6o2D2xIuTzZ/Yk
	 n6qi1h1mcFVesVxnhwbMsmTUH1QB6RESQX4KKKY9qM5V5a1Qt34ympeOCATm10u+Qb
	 KsD8LoDt+yYWFple6BRBYHS00aQXSP21UQIPEWU+iZu0aTrXsVViG1oSfnzN4lbid7
	 +NtTSPHgZdaPtu4vtc2CGV3LS2PrgEkos8Ndw3PblxkRKOpgx3J0ri4gsEugrTYfHe
	 7DmN1Y0bubaFVVlSZVlcXHAXCWDlBUlRQw5uW10GtWu6zcyakaDEKVloKzQiGJGquJ
	 mxbW2ns2oLR1g==
From: Philipp Stanner <phasta@kernel.org>
To: Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Alessio Belle <alessio.belle@imgtec.com>,
	Luigi Santivetti <luigi.santivetti@imgtec.com>,
	Qiang Yu <yuq825@gmail.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Natalie Vock <nat@pixelcluster.dev>,
	Arun Pravin <arunpravin.paneerselvam@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Prike Liang <Prike.Liang@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	David Rosca <david.rosca@amd.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Krzysztof Karas <krzysztof.karas@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Sam Day <me@samcday.com>,
	Gabriel Prostitis <prostitisgabriel@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	imagination@lists.freedesktop.org,
	lima@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-usb@vger.kernel.org,
	rust-for-linux@vger.kernel.or
Subject: [PATCH 0/3] dma-buf: dma-fence: Remove dma_fence_init64()
Date: Thu,  5 Nov 2026 12:35:27 +0100
Message-ID: <20261105113529.1989375-2-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently had a discussion about reworking dma_fence init to close a
race-window [1].

The community agreement seems to have been that we can get rid of
dma_fence_init64(), so let's do that already. In the meantime we can
continue our discussions regarding the race in [1].

This also touches the Rust dma_fence, which actually should use 64-bit
seqnos (was forgotten so far). Rust fence has no users currently, so
needs no backporting, so I would like to address that in a distinct
patch.

Tested on Nouveau with and without the SEQNO64 flag. Nouveau also uses
the USER flag, so I hope we're fine.


P.

[1] https://lore.kernel.org/dri-devel/20261029095542.1526750-3-phasta@kernel.org/


Philipp Stanner (3):
  dma-buf: dma-fence: Add flags parameter to dma_fence_init()
  dma-buf: Port users of dma_fence_init64()
  dma-buf: dma-fence: Remove dma_fence_init64()

 drivers/accel/amdxdna/amdxdna_ctx.c           |  2 +-
 drivers/accel/ethosu/ethosu_job.c             |  2 +-
 drivers/accel/ivpu/ivpu_job.c                 |  2 +-
 drivers/accel/rocket/rocket_job.c             |  2 +-
 drivers/dma-buf/dma-fence-array.c             |  2 +-
 drivers/dma-buf/dma-fence-chain.c             |  4 +-
 drivers/dma-buf/dma-fence.c                   | 58 +++++++++----------
 drivers/dma-buf/st-dma-fence-chain.c          |  2 +-
 drivers/dma-buf/st-dma-fence-unwrap.c         |  2 +-
 drivers/dma-buf/st-dma-fence.c                |  2 +-
 drivers/dma-buf/st-dma-resv.c                 |  2 +-
 drivers/dma-buf/sw_sync.c                     |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |  2 +-
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  7 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  |  5 +-
 drivers/gpu/drm/drm_crtc.c                    |  2 +-
 drivers/gpu/drm/drm_writeback.c               |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c  |  2 +-
 drivers/gpu/drm/i915/i915_request.c           |  2 +-
 drivers/gpu/drm/i915/i915_sw_fence_work.c     |  2 +-
 drivers/gpu/drm/i915/i915_vma_resource.c      |  2 +-
 .../gpu/drm/i915/selftests/i915_sw_fence.c    |  2 +-
 drivers/gpu/drm/imagination/pvr_ccb.c         |  2 +-
 drivers/gpu/drm/imagination/pvr_queue.c       |  2 +-
 drivers/gpu/drm/lima/lima_sched.c             |  2 +-
 drivers/gpu/drm/msm/msm_fence.c               |  2 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c       |  4 +-
 drivers/gpu/drm/panfrost/panfrost_job.c       |  2 +-
 drivers/gpu/drm/panthor/panthor_sched.c       |  2 +-
 drivers/gpu/drm/qxl/qxl_release.c             |  2 +-
 drivers/gpu/drm/radeon/radeon_fence.c         |  2 +-
 drivers/gpu/drm/scheduler/sched_fence.c       |  4 +-
 .../gpu/drm/scheduler/tests/mock_scheduler.c  |  2 +-
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c       |  2 +-
 .../gpu/drm/ttm/tests/ttm_bo_validate_test.c  |  2 +-
 drivers/gpu/drm/v3d/v3d_fence.c               |  2 +-
 drivers/gpu/drm/vc4/vc4_gem.c                 |  2 +-
 drivers/gpu/drm/vgem/vgem_fence.c             |  2 +-
 drivers/gpu/drm/virtio/virtgpu_fence.c        |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c         |  2 +-
 drivers/gpu/drm/xe/xe_hw_fence.c              |  2 +-
 drivers/gpu/drm/xe/xe_oa.c                    |  2 +-
 drivers/gpu/drm/xe/xe_preempt_fence.c         |  2 +-
 drivers/gpu/drm/xe/xe_tlb_inval.c             |  2 +-
 drivers/gpu/host1x/fence.c                    |  2 +-
 drivers/iio/industrialio-buffer.c             |  2 +-
 drivers/usb/gadget/function/f_fs.c            |  2 +-
 include/linux/dma-fence.h                     | 14 +++--
 rust/kernel/dma_buf/dma_fence.rs              |  2 +-
 52 files changed, 95 insertions(+), 94 deletions(-)


base-commit: 8258a37702b9b9cf27f5c0ea07625e3e6bd74f5a
-- 
2.56.0

