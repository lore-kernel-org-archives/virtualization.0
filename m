Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878813;
	b=ATcvSRSvlWcufUo6181s/BHZJqKOyoz8sEytM63Id8cMi1nI0X1cyjN5N9KtPRqRfkeu
	 Rkcev6USpEHTAqhgWJiOvGsgQhqH7PZ9wZ8jpWA6n5kCt9rq0PAchBfSye4WIavBiZ9+F
	 ODaSsCF9XBpEdZGDpzD/on/ZN/JwWPR7pLbXHx/azS5YnhUv6VbkKqBCKlQewLTchlcz2
	 Et2Uv47GKKowaPof3ug6ZW+7mhrUQYNaPgY88iCak+qisu4DymqoUt7uMzarbQR1RloZK
	 WMBmv58goA2oL93rydswDI+GZx1XymWN+HwEHSZnMSagTQJPi/hZngTd9z+8b8wBONw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878813;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SLxt8gL8S4bp8BkjrllqUrd84IP3TwVRmle+af4zaM8=;
	b=R8WogtDRgtl74K38DKqzLVH2gbgEckWu84L0g40PK2CX5tGsDmmJ8/0GWjOkGy5nmS5n
	 ULkbb9xVbY8zq7E+G3oOc65Pla7ndiN3xVmTyPUC6NWU/Y4nBFFCOjEBLdBc546oQu7Ob
	 l42lp5fDQVqHyztvteBMbKOF2CvABsHvkALV2pD7u/xKxu1r0p0/+CHHWA3k9BWLAQnJY
	 /3haYV3J/VygjIeQP8KU3hnoTvHdisVfo28pcLYTwSlgOw/jFeZZCyaMiSPUQh2wtnm5V
	 ORKTachgG7mdeMbz+ENyqJQiJGfWzkge3Qr6+1nRafynuEPfQJgXkPfpZ0el+TiWQUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmtvL6JN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AEC606D803;
	Thu,  5 Nov 2026 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmtvL6JN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C29F1F0093A;
	Thu,  5 Nov 2026 11:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878812;
	bh=SLxt8gL8S4bp8BkjrllqUrd84IP3TwVRmle+af4zaM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jmtvL6JNx/LTuU5nwvdXJgdkdF729H39y+/gluqMOWtETW4wth76UGatWMf0UpmSL
	 KuzZP3d+OGyMwi1JkopR8sxmOk3Of7u10D1WZWJ2gOKPPKj1RyEa2MC/4Hy7vvoFyj
	 a2/wjrUg34AP+eF7GWAGrFmiJQUG1dgczg8FplZYSUrmw5ZFTGiTSTdGP6iWFawN7A
	 dICAFcjP/fVxrJAphmIGwXXYfOZiZVekEOSwLEtuVkseGkon+tOf2YsFOB3FbuDvfh
	 Ha/+C+wCHrw8KUcj/EeY3Tyq3ICLi0hwsYwYVzTcFzdOVjdIx6DIsB9NFCuCX8O6j/
	 DvUI7nvwy0POA==
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
Subject: [PATCH 2/3] dma-buf: Port users of dma_fence_init64()
Date: Thu,  5 Nov 2026 12:35:29 +0100
Message-ID: <20261105113529.1989375-4-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105113529.1989375-2-phasta@kernel.org>
References: <20261105113529.1989375-2-phasta@kernel.org>
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

dma_fence_init() now natively allows for selecting 64-bit seqno support.
Port all users of dma_fence_init64() to this unified method.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
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
index c1257f530e9a..5329c13f4237 100644
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

