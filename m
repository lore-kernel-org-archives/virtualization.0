Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009564;
	b=AnVzQgMR32JKSHMD5QrtmoLEan+/JnmnghPxdUZVkBXVildTzBdXWW5ZXcpY0ur/o0Mo
	 maBMhNbdpXKvyM9SlFbyL8a3AdE4X0v7rxDM+RA8gvoCQgr2voipiFoLcs62HqY49/MTG
	 utNLinpxGK6UXeDxMyojFKbHOAwXQVIfDKl/Dk+nZOBtYYQLlzyHUbVyfceFm0pVEVCdG
	 RqsIMYejoHKxD75JtHLtZbiJuN+Q+gg1JXdi/eWN69iaZYazOURaeMzTkhbQONK6E96Px
	 JW7k7uWmNoxdNdU7pBkZj9T6iKh0NCjvg/d6uiTvSzy4YZzEuhv5xAuihUCf2L3xQ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009564;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pPXr6ZCubONThIoJKyV+i68TlUC5jfmFsiJb4vkRMA4=;
	b=0vrtW7FrWfl88eIHuFk/AzvX0qNyUcv+x+hGHpO5M5QcQfXZChFIRZUhtq952OPP/FLi
	 /2Jpq1hIWtKgVvKsn03DAtnYaV0K3K5ZSwP1B0vWgc3vrYu5tJ1WBPwxKLL07wwitzhwr
	 4RQTatUcK7WfYsF2ffPKddQBDzO7TBFDmP2y+95LnD1fuv1KNFKUDaB+6BqyvrYEYloYh
	 p8kg1EqsHVBIDplFSKw8WjuVoOnTjU/wZ/wfObNtnN4VDiHrPc9oHevsSNQUpVhQUt3Cy
	 jWdI2ZX98W4MsAR6uKv9jbNf4fp4A598vYuJzHoere1f1JYmFL1T0hHZmPR744H5Dng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BF630q41;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CCA606A31C;
	Wed, 18 Nov 2026 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BF630q41
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CE41F000C4;
	Wed, 18 Nov 2026 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795009564;
	bh=pPXr6ZCubONThIoJKyV+i68TlUC5jfmFsiJb4vkRMA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BF630q41fDa0YTryLkmikWFt8M8IFNVoUeiLZYloRM6NAJ3Pn5aNB+eNloqvaSTSD
	 LQEdO8aC8IUEJ/VmNAArMxv688r95lZa0iRbq3jwpwnvovy3vM7Jc7eAlXtRIlJCFq
	 rkpYDcTPCzc2hUQL33mpsZx5kmYtKzWUuuu8ODyqQJ2MuUspad+nr94OAb8ZGk5ivp
	 GaV3+Hp/MxM1E4Vj+W7nLqapxJ0/69KoAXXq+93yVeoqBmIuaWTbLGZCo0JcB7HE+a
	 /K0s3iM91e/rMBeJJ86bgZUDHMWI7j/UA0wkRT01IYBZyoTKnNsJLfK5FLv5ci2jG4
	 BMqkf3rqFznVQ==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Prike Liang <Prike.Liang@amd.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	David Rosca <david.rosca@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
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
Subject: [PATCH v2 2/3] dma-buf: Port users of dma_fence_init64()
Date: Wed, 18 Nov 2026 14:45:22 +0100
Message-ID: <20261118134522.1646892-4-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118134522.1646892-2-phasta@kernel.org>
References: <20261118134522.1646892-2-phasta@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

dma_fence_init() now natively allows for selecting 64-bit seqno support.
Port all users of dma_fence_init64() to this unified method.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence-chain.c                  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c   | 5 +++--
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-chain.c b/drivers/dma-buf/dma-fence-chain.c
index a588f55ea4d3..7d1495235577 100644
--- a/drivers/dma-buf/dma-fence-chain.c
+++ b/drivers/dma-buf/dma-fence-chain.c
@@ -261,8 +261,8 @@ void dma_fence_chain_init(struct dma_fence_chain *chain,
 			seqno = max(prev->seqno, seqno);
 	}
 
-	dma_fence_init64(&chain->base, &dma_fence_chain_ops, NULL,
-			 context, seqno);
+	dma_fence_init(&chain->base, &dma_fence_chain_ops, NULL,
+		       context, seqno, BIT(DMA_FENCE_FLAG_SEQNO64_BIT));
 
 	/*
 	 * dma_fence_chain_enable_signaling() is invoked while holding
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index f8652fd0525d..2924f34da316 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -133,9 +133,10 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	ev_fence->evf_mgr = evf_mgr;
 	get_task_comm(ev_fence->timeline_name, current);
 	spin_lock_init(&ev_fence->lock);
-	dma_fence_init64(&ev_fence->base, &amdgpu_eviction_fence_ops,
-			 &ev_fence->lock, evf_mgr->ev_fence_ctx,
-			 atomic_inc_return(&evf_mgr->ev_fence_seq));
+	dma_fence_init(&ev_fence->base, &amdgpu_eviction_fence_ops,
+		       &ev_fence->lock, evf_mgr->ev_fence_ctx,
+		       atomic_inc_return(&evf_mgr->ev_fence_seq),
+		       BIT(DMA_FENCE_FLAG_SEQNO64_BIT));
 
 	/* Remember it for newly added BOs */
 	dma_fence_put(evf_mgr->ev_fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index b7cebe392108..ac66b831daf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -274,8 +274,9 @@ static void amdgpu_userq_fence_init(struct amdgpu_usermode_queue *userq,
 	bool signaled = false;
 
 	spin_lock_init(&fence->lock);
-	dma_fence_init64(&fence->base, &amdgpu_userq_fence_ops, &fence->lock,
-			 fence_drv->context, seq);
+	dma_fence_init(&fence->base, &amdgpu_userq_fence_ops, &fence->lock,
+		       fence_drv->context, seq,
+		       BIT(DMA_FENCE_FLAG_SEQNO64_BIT));
 
 	/* Make sure the fence is visible to the hang detect worker */
 	dma_fence_put(userq->last_fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
index b0002c898386..f8cc258dcdef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -100,8 +100,9 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
 	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
 	spin_lock_init(&f->lock);
 
-	dma_fence_init64(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
-			 vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
+	dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
+		       vm->tlb_fence_context, atomic64_read(&vm->tlb_seq),
+		       BIT(DMA_FENCE_FLAG_SEQNO64_BIT));
 
 	/* TODO: We probably need a separate wq here */
 	dma_fence_get(&f->base);
-- 
2.56.0

