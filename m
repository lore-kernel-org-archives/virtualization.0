Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09880374D2
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3FX6C1Gf"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8D23C436BC
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D23C436BC
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=3FX6C1Gf
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PHZLg7jAjYID
	for <virtualization@lists.linux-foundation.org>;
	Fri,  5 Jan 2024 18:47:00 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8CF9E4015F
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8CF9E4015F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480419;
	bh=hwlCMWKCwWq+FTlAozKtV1c6NXEsmQgXkAKTAl4/P/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=3FX6C1Gf+urqihuAHe188P3CvAOPc3Kru2MKDUDKN4uTIEgbX3lMfS9y7FyoeG8B9
	 Od2AE3+82Ow23PkbPb0rI9E8sEGsKmBlo0Rta6o7+qoFlficKQS7Od//ZdEIEYnbIz
	 fkaSUhuJpTba3VPNM9Y+RVgZ2hc+SDTVd3n8HrWGqMpJIknqswaqzG4ny49Ylf/Oxa
	 nu98Ylxpv2q+wUnZh7UVFWlzX3VrldN2MGRP1uCbBh/3ae9XsiqY1YX9FMx6V0yKjM
	 5mqniy6HoKmSITyLbrfdwGuzsoZnLq9AshXLBCSonPtVuc+7cxoqYJY4t+JsV7lpCO
	 DI4yKiNy9aRbw==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 934B33782047;
	Fri,  5 Jan 2024 18:46:57 +0000 (UTC)
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
Subject: [PATCH v19 09/30] drm/shmem-helper: Add and use lockless drm_gem_shmem_get_pages()
Date: Fri,  5 Jan 2024 21:46:03 +0300
Message-ID: <20240105184624.508603-10-dmitry.osipenko@collabora.com>
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

Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
lock if pages_use_count is non-zero, leveraging from atomicity of the
refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index cacf0f8c42e2..1c032513abf1 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -226,6 +226,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
 
+static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
+{
+	int ret;
+
+	if (refcount_inc_not_zero(&shmem->pages_use_count))
+		return 0;
+
+	dma_resv_lock(shmem->base.resv, NULL);
+	ret = drm_gem_shmem_get_pages_locked(shmem);
+	dma_resv_unlock(shmem->base.resv);
+
+	return ret;
+}
+
 static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
 {
 	int ret;
@@ -609,10 +623,7 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
 		return ret;
 	}
 
-	dma_resv_lock(shmem->base.resv, NULL);
-	ret = drm_gem_shmem_get_pages_locked(shmem);
-	dma_resv_unlock(shmem->base.resv);
-
+	ret = drm_gem_shmem_get_pages(shmem);
 	if (ret)
 		return ret;
 
-- 
2.43.0

