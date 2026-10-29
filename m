Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268038;
	b=g2QFQCL144PmHJmbZQy40u5ExsADUlHoGq1QzwBNpBIHmVIaNBgHBn1aSGobK91xU1k+
	 efUkOm+jsRglhrieVkzO7KQ+x7ztwqgj6RPyR3KRFt5QSPLrXUP9wDny3E3EaZE+oz4Z+
	 3xgBWuT8/9sD6HMMMJZL4T3UV5FsYuD2j3LxxhWHho+3XMej8gvv/hPsUk+5GHyK1m5zz
	 zvDILl93s2BNeHcvK7DN4wgoGZwxQ3ZvW0zmf8zSi4G+rt/p3vBZ6OYVGFy9yFoRmU0jq
	 02ChY7agMWvuu7tHOodXEVtzlOYmRsy60C0/bQggxyddoUCTVKW2f2rD3wH7q/QD5Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268038;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o9F+8U/pYwzcZNAGQzHna6ktO5krumv1cnerGWMGoFQ=;
	b=U7LhvaVc1aiHOtab/s3758NgxqMcZChwrlEFPA0gOBEekejr3D1toRelTox/S8PzMC2T
	 TvxvJ8VbOWfOy++0AnYhfnA6gDlSz3BcI5pU3Dyhn7iz1njXHy6slIPy/A2ozMyK9uuLL
	 VmL8gH5WIP9hXvEuyie8zDzhGW8eS7F2uxbbouCITW5VTHVZkCHaso+BHTR1/BxD2xB51
	 RZrSHsYXUw/RzgKRrvRgbn9C6jXdHkkDe9wM9QHLqJSYLeh0TyirpDaqxnmxRbWQDjTJq
	 rmgtRauVCZNyPy419z2fkFSEMxfwAJ/Eemb75DUIMGYcpa2FzclZngzRPvQYK750T4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXa+hDCU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C13960A2611;
	Thu, 29 Oct 2026 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXa+hDCU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007CA1F01829;
	Thu, 29 Oct 2026 10:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793268038;
	bh=o9F+8U/pYwzcZNAGQzHna6ktO5krumv1cnerGWMGoFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LXa+hDCUk4TM0mWNpE3iuZljtU2J4GwCtcoSXlnis19mUHexAmBC5ycNYFl7ULPuE
	 V5MUmVkEHO/2F7bMQebbozfATjnM3H/bwM0WriN+6CeoVQEwHlEpPp1+xJNJ+x2jey
	 p6sj4w1olF8OhWpsAtxs+UAFgN1AitB7cWiZxDlhV4ViXZaHs40ISGu//KgICScLnx
	 v3fR5o58AlOu6dFIn6haSV1JykkqJNoVUaIWo8k3jdXE3OPfFtIkn48ZML7ljiDpv5
	 M5pu+Fjq4sCw9rDAC3gCa1lKopChmjAz/ghtF4FgZj4Xqe3nHaLIphuX/VvNW3n+vm
	 Tz+ge83o+kz4w==
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
Subject: [RFC PATCH 6/6] drm/nouveau: Remove hacky fence check
Date: Thu, 29 Oct 2026 10:55:43 +0100
Message-ID: <20261029095542.1526750-9-phasta@kernel.org>
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

nouveau_cli_work() contains a section where a dma_fence lock is manually
taken and immediately released afterwards. This was added in

	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")

as a bugfix because the function dma_fence_is_signaled() could return
true while the fence was still signaling.

The fix was later modified in

	commit a80d12eafad1 ("drm/nouveau: Simplify nouveau_cli_work")

Luckily, the dma_fence backend now fully synchronizes
dma_fence_is_signaled() with the spinlock. Thus, the check in nouveau is
not necessary anymore.

Remove the manual lock-unlock section.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index b0f9fb10a74d..74632bb29f2f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -163,19 +163,6 @@ nouveau_cli_work(struct work_struct *w)
 		struct dma_fence *fence = work->fence;
 
 		if (!fence || dma_fence_is_signaled(fence)) {
-			if (fence) {
-				unsigned long flags;
-
-				/*
-				 * Because fence can still be in the process of
-				 * processing the callback list, and the
-				 * callback references the work we are about to
-				 * free, we need to sync with the callback
-				 * processing before freeing the work.
-				 */
-				dma_fence_lock_irqsave(fence, flags);
-				dma_fence_unlock_irqrestore(fence, flags);
-			}
 			list_del(&work->head);
 			work->func(work);
 			dma_fence_put(fence);
-- 
2.56.0

