Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267956;
	b=qC+DeaQWe8KgPlAP+xLri4uyNlILqRHfmDcZ98GSVrmyvuOLG5ltow5AXlKyBYDXXAgS
	 juEXp6z1Ee+cH+TE/JgqBV97E/lzxpdI4kZyif8RzhGLiKjUMaiABXCvEFcHLJRVak/SO
	 NMnHI75TZrnNtTdfd4lQ+8G4VSM3Feq2h30YmOkd79PZYLyKWgBgxGyDfW+ViU0MTl0JP
	 Xehqdn6YmYNeHXLrjD/vm3Y2xeKonssVF4s+hX5znXBGzlNH/MZ9+ZdOdl/D+uDmxToU4
	 4B24dfSOPXhgjxG15HDaNSyJnsJrSWlrqmW4jO5Xp90okzH01PfZ7HXfNmZtWlTQwXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267956;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TzR0iS7QHEr3XjS3VyvSCg4YGglik9yLN4DV8S4aDGQ=;
	b=MTcuQz7z6BxvRa31Bi96GmR9NQr5ImZpkCM0eM85K90ka3+ZJdpfR+zavFTnX48MBv1S
	 Ci8C59r1308vDQukdgkaESAm+f8xsr3y3G7wgFYVVeLGefACpP1m1EWiA+E/GH+F70arj
	 W+kalYrtflk1fexNbYak+pQNrWLNn7l04dK7gebV3gmaMBRnifbshuVLfpzHI0AXl846u
	 E66XbcQ7G/pUu/fCUmnzhcguFuIrgVdjwXO7s+RPg4JltQzWhTSQHLqMPD1VA0cbTxdr7
	 7sEnqNAi6EK5vUGoKrmRLbq9d1QLu03AkSyuLZ22+URtfm45OJll0g5cW5Om0/SQDXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkHYOsCT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619B606A31D;
	Thu, 29 Oct 2026 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkHYOsCT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4570B1F01829;
	Thu, 29 Oct 2026 09:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793267955;
	bh=TzR0iS7QHEr3XjS3VyvSCg4YGglik9yLN4DV8S4aDGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lkHYOsCTkFVL1U8yRfvPJ5LQM5O66jziEjdl0fS4qhg5XrAwQZiZAIcO+FkL8Uee6
	 LEF1qMxPTYsF45eiNTGuIRhd1orc6LRJa2TrGpcx/oqhyiZ8UrhWHcoE5O230LvGwU
	 Z8m5FBeVHmK3RzUCBBmTRRYUtwLYKwiaMwWTyAzFIqRZmCwnXZcS/AnXFvVUNSN/52
	 oIG3H2hmGhCVc7oxGv/JEbteBqLgLY97KfSXyuemp5dfN8ZO25PCwQbXNBAIuoYfbD
	 cIRTgtWLTo1n5pVfgUc9hwVpoSrHgSsAkrVRczOUN+dLo4bmpH3m140Y7raMV9s1sY
	 7Ola2pOJMfgHw==
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
Subject: [RFC PATCH 2/6] dma-buf: dma-fence: Add flag for using 64-bit seqnos
Date: Thu, 29 Oct 2026 10:55:39 +0100
Message-ID: <20261029095542.1526750-5-phasta@kernel.org>
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

dma_fence_init() now has its own flag field for user options. Use this
field to enable 64-bit seqno support through a dedicated field.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/dma-fence.c | 8 +++++++-
 include/linux/dma-fence.h   | 4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index a640fb99f942..b11ee52a40d8 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1114,7 +1114,13 @@ dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
 	       spinlock_t *lock, u64 context, u64 seqno,
 	       unsigned long init_flags)
 {
-	__dma_fence_init(fence, ops, lock, context, seqno, 0);
+	unsigned long fence_flag_bits = 0;
+
+	/* Mapp the init_flags to the fence-internal flags. */
+	if (test_bit(DMA_FENCE_INIT_FLAG_SEQNO64, &init_flags))
+		set_bit(DMA_FENCE_FLAG_SEQNO64_BIT, &fence_flag_bits);
+
+	__dma_fence_init(fence, ops, lock, context, seqno, fence_flag_bits);
 }
 EXPORT_SYMBOL(dma_fence_init);
 
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 0cb425f7d5e9..6654bcc2441f 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -123,9 +123,11 @@ enum dma_fence_flag_bits {
  *
  * These flags can be passed in dma_fence_init().
  *
- * DMA_FENCE_FLAG_SEQNO64_BIT - use 64-bit sequence numbers
+ * @DMA_FENCE_INIT_FLAG_SEQNO64: Use 64-bit sequence numbers.
  */
 enum dma_fence_init_flags {
+	DMA_FENCE_INIT_FLAG_SEQNO64,
+
 	/* Must always be last member. */
 	DMA_FENCE_INIT_FLAG_NR_OF_FLAGs,
 };
-- 
2.56.0

