Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268018;
	b=pWoPVbKZ85J248TH6KppbjFzH9q8PkOpxl68WraeyGHQEYmFASR13DALC9weqFSBdnNq
	 5oEbcNLusuiv1EGruWfMVm4ggsLYPkPM/PWZX3WB/w/yCmG59phBGMGZzvPNZK8L+RiIu
	 BAAp9K7u02N76/M9no+jxB2vTsBA2nYAhWITFcby3gJ5U1dWKhH8UdWXUNqdhgrqgRMUx
	 eSO6yTreN/PD7AeJM/CTeIZAgnzxkXijwgUZqbCYu5sjcyqhiSHrxyzmCt9yTZAd2SXV6
	 CZFtno9hA7Mxst2bo/0iY+Dx1Bu78xWkYxsEqfR4ZyjXGFVpvSBI58WbEOiE7te7B9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268018;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WKgY4TxM7jCCTLKvPKBg2Os4gMDYJkQWtwa2sp51kDE=;
	b=WS5EjqiJMKgSJZ0gknNEhKfOMMqjviVA+hXfgCX5iqNunT37x+VLl60ro8I67cflnJOe
	 MJjl9EVo2oYLGMVm6DMUULnun602JGi6WiHClSWKtj709IpjLdbS/o0dl9diJaw2vrlMj
	 TGzAY8c93U7pa4Rzn0pFOofLT8nfwfS/BEv2caKMt9P3fmD+XblcKeJSHS+qS42UbjpNN
	 0EDAvSc0N+6yG3SrBySWiaNXbYlHeXM7muqqf0/LdwKyYmKTKvIdZN7TqkbuzgvDjpBU1
	 HdOXAAFA7tAM8JfbLUuQR0uGLCRucRh/hDUBZ3/50eL8VMQjBt8nSyYlYPlBi7haNAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baiCwMb4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B2606A31F;
	Thu, 29 Oct 2026 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baiCwMb4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63621F01828;
	Thu, 29 Oct 2026 09:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793268017;
	bh=WKgY4TxM7jCCTLKvPKBg2Os4gMDYJkQWtwa2sp51kDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=baiCwMb4N80s/wYScg8peqquVrnIxU2J0+kSJgvciGEDkhkeSpiwqOGZvHBxsi0LO
	 83Y8Qdm88haCAL7OoIhGJLG87zWYHs5Dmbw9wTTFSGXelkhBoV2CErv6UzJ7Og4oti
	 T/BlIXfNAzcPkiRRAdbPcHftzcmxj3jUyJP/Efe8cTASzdYwMmYT7MIowSXb20HqmD
	 4Eu057SH8gJa+Kr1lyQqyJjo2UVqDPsLEJ9DafJkgX0YOhLBedzCTZdexnprq3eQZf
	 xE5xJXUonpzifrxiXRXdhKtH7kYZwst6cnR32e28C4D93HOKnOLE0PwAxZQE0kj/Rl
	 XX8uiGMH5YNBg==
From: Philipp Stanner <phasta@kernel.org>
To: Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
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
	Philipp Stanner <phasta@kernel.org>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Kees Cook <kees@kernel.org>,
	Jesse Zhang <jesse.zhang@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	Prike Liang <Prike.Liang@amd.com>,
	David Rosca <david.rosca@amd.com>,
	Krzysztof Karas <krzysztof.karas@intel.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Neill Kapron <nkapron@google.com>,
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
	linux-usb@vger.kernel.org
Subject: [RFC PATCH 5/6] dma-buf: dma-fence: Close race in dma_fence_is_signaled() by default
Date: Thu, 29 Oct 2026 10:55:42 +0100
Message-ID: <20261029095542.1526750-8-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029095542.1526750-3-phasta@kernel.org>
References: <20261029095542.1526750-3-phasta@kernel.org>
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

dma_fence_is_signaled() contains a lockless check of the signaled-bit,
which is set under lock protection. This is a race condition which makes
the API fragile and has caused at least two bugs already, addressed in:

	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
	commit 7c703a7d3f2b ("drm/amdgpu: Fix one use-after-free of VM")

It has been argued by some that this race cannot be closed for the
entire kernel through locking because this would lead to a cache line
invalidation for all parties reading that fence. While it remains
unclear why these parties don't simply let themselves be notified about
the fence being signaled instead of checking this repeatedly manually,
there is a way to preserve this behavior in any case:

This patch adds a new flag for dma_fence_init(),
DMA_FENCE_INIT_FLAG_RACY_SIGNALED_CHECK. If this flag is not set, the
spinlock is taken and dma_fence_is_signaled() becomes perfectly
synchronized: it can only return true once signaling of the fence is
completed.

Disable the racy check for everyone by default. Should some parties
really experience severe performance degredations because of this, they
can trivially re-enable the race condition for their driver by setting
the flag in dma_fence_init().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/dma-fence.c |  2 ++
 include/linux/dma-fence.h   | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index f7c084926ae6..1ae8c7aade39 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1119,6 +1119,8 @@ dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
 	/* Mapp the init_flags to the fence-internal flags. */
 	if (test_bit(DMA_FENCE_INIT_FLAG_SEQNO64, &init_flags))
 		set_bit(DMA_FENCE_FLAG_SEQNO64_BIT, &fence_flag_bits);
+	if (test_bit(DMA_FENCE_INIT_FLAG_RACY_SIGNALED_CHECK, &init_flags))
+		set_bit(DMA_FENCE_FLAG_RACY_SIGNALED_CHECK_BIT, &fence_flag_bits);
 
 	__dma_fence_init(fence, ops, lock, context, seqno, fence_flag_bits);
 }
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 52e7ddfd2d06..ee6e8de3ebc6 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -115,6 +115,7 @@ enum dma_fence_flag_bits {
 	DMA_FENCE_FLAG_SIGNALED_BIT,
 	DMA_FENCE_FLAG_TIMESTAMP_BIT,
 	DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
+	DMA_FENCE_FLAG_RACY_SIGNALED_CHECK_BIT,
 
 	DMA_FENCE_FLAG_USER_BITS, /* must always be last member */
 };
@@ -124,9 +125,12 @@ enum dma_fence_flag_bits {
  * These flags can be passed in dma_fence_init().
  *
  * @DMA_FENCE_INIT_FLAG_SEQNO64: Use 64-bit sequence numbers.
+ * @DMA_FENCE_INIT_FLAG_RACY_SIGNALED_CHECK:
+ * Legacy flag. Enables a race condition in dma_fence_is_signaled().
  */
 enum dma_fence_init_flags {
 	DMA_FENCE_INIT_FLAG_SEQNO64,
+	DMA_FENCE_INIT_FLAG_RACY_SIGNALED_CHECK,
 
 	/* Must always be last member. */
 	DMA_FENCE_INIT_FLAG_NR_OF_FLAGs,
@@ -568,9 +572,27 @@ dma_fence_is_signaled_locked(struct dma_fence *fence)
 static inline bool
 dma_fence_is_signaled(struct dma_fence *fence)
 {
+	const bool racy_check = test_bit(DMA_FENCE_FLAG_RACY_SIGNALED_CHECK_BIT,
+					 &fence->flags);
 	const struct dma_fence_ops *ops;
+	bool signaled = false;
+	unsigned long flags;
 
+	/*
+	 * For legacy reasons, there is a race window here against parties
+	 * signaling the fence. They might still be doing that right now.
+	 *
+	 * For most users, this window shall be closed, but there are parties
+	 * for whom the cache-line invalidation by taking the lock might be so
+	 * significant that they prefer to accept the race at their own risk.
+	 */
+	if (!racy_check)
+		dma_fence_lock_irqsave(fence, flags);
 	if (dma_fence_test_signaled_flag(fence))
+		signaled = true;
+	if (!racy_check)
+		dma_fence_unlock_irqrestore(fence, flags);
+	if (signaled)
 		return true;
 
 	rcu_read_lock();
-- 
2.56.0

