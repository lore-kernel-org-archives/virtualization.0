Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001453B190
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RGppGiad"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 995AB436BC
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 995AB436BC
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=RGppGiad
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7-9G5jIdj6V6
	for <virtualization@lists.linux-foundation.org>;
	Fri,  5 Jan 2024 18:47:24 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD28F436A4
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD28F436A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480443;
	bh=0EkorB7mGPNDlGWHg99Nm8EGClX4jIfjE4CRLhc0fAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGppGiadlpknVJqbMhfDp1lvlPAp9TkSEX0q/EJ0Huh2rNnWwCelriirktxoBJab+
	 OBxtKcS0p3Gl7+D9rSBxsnCAe3o6FuTyICpXTIEOkx7RYZbo27iW3nR4ciLz1gbbef
	 yt1/BSGQKTWNuZj88DDNbTo8LgaJ8kcv3Mdy57S/d5EAy423YIjpE8ow69Ha9dj3kE
	 VfBSnwK7CzGE6GJEf8pQV1/EGfsRtvGrn+n7VEa3M/oGgM7bJZwmmEIGSaoFFDXN34
	 j1dBqf20ce5nEqbVS2CcL7gU4BhHY1s65YTl1XCXZ26RAK5t7JVQt8egKqT6kHj6kZ
	 20zdOgB7Zt3BQ==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AA0D53782067;
	Fri,  5 Jan 2024 18:47:21 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Qiang Yu <yuq825@gmail.com>,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Emma Anholt <emma@anholt.net>,
	Melissa Wen <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v19 24/30] drm/shmem-helper: Optimize unlocked get_pages_sgt()
Date: Fri,  5 Jan 2024 21:46:18 +0300
Message-ID: <20240105184624.508603-25-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SGT isn't refcounted. Once SGT pointer has been obtained, it remains the
same for both locked and unlocked get_pages_sgt(). Return cached SGT
directly without taking a potentially expensive lock.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 8fd7851c088b..e6e6e693ab95 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -962,6 +962,18 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem)
 	    drm_WARN_ON(obj->dev, drm_gem_shmem_is_purgeable(shmem)))
 		return ERR_PTR(-EBUSY);
 
+	/*
+	 * Drivers that use shrinker should take into account that shrinker
+	 * may relocate BO, thus invalidating the returned SGT pointer.
+	 * Such drivers should pin GEM while they use SGT.
+	 *
+	 * Drivers that don't use shrinker should take into account that
+	 * SGT is released together with the GEM pages. Pages should be kept
+	 * alive while SGT is used.
+	 */
+	if (shmem->sgt)
+		return shmem->sgt;
+
 	ret = dma_resv_lock_interruptible(shmem->base.resv, NULL);
 	if (ret)
 		return ERR_PTR(ret);
-- 
2.43.0

