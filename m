Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA49139ACC
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2u20bBo2"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CF2042089
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CF2042089
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=2u20bBo2
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5NQHLIjjo1RG
	for <virtualization@lists.linux-foundation.org>;
	Fri,  5 Jan 2024 18:47:11 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A5ADC42087
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5ADC42087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480430;
	bh=QuYX1ZbeqzzlgphkIZfy751IRqx3iZbH6NUvd1ayS2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2u20bBo2hSpc1THMfYB6JNEoJgDpKys+lBggfjoSpFj7t7nm01B0QgElOM1/8apZk
	 heSFvZSGfDyeK4oBTragO5Jjg+1pj8WfjyW8MoP37fsgqcday1bN7HTIiNY4yMWiGU
	 ZmyV2Nse5W+lS1k8OnULetaokn82kfZ5YFD+TOPSmeglq/8xrE3F/PKfT5kOSQ7c/R
	 Lp9LXu9NfDcabVPGgHe2KFeTjP2Xhp90zai1qmWDVmRzsSY5VSLj4QWduFvGDSviGB
	 kgj6RFK7hUo+V22r6Mo/tJ0FaVHmWQjXa5AYICEd+hCH+vl1ksPleUzeqf7Bg33VrR
	 3mrt5q4QwCrFg==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C4A6F3782046;
	Fri,  5 Jan 2024 18:47:08 +0000 (UTC)
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
Subject: [PATCH v19 16/30] drm/lima: Explicitly get and put drm-shmem pages
Date: Fri,  5 Jan 2024 21:46:10 +0300
Message-ID: <20240105184624.508603-17-dmitry.osipenko@collabora.com>
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

To simplify the drm-shmem refcnt handling, we're moving away from
the implicit get_pages() that is used by get_pages_sgt(). From now on
drivers will have to pin pages while they use sgt. Lima driver doesn't
have shrinker, hence pages are pinned and sgt is valid as long as pages'
use-count > 0.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/lima/lima_gem.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 2a97aa85416b..9c3e34a7fbed 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -115,6 +115,7 @@ int lima_gem_create_handle(struct drm_device *dev, struct drm_file *file,
 		return PTR_ERR(shmem);
 
 	obj = &shmem->base;
+	bo = to_lima_bo(obj);
 
 	/* Mali Utgard GPU can only support 32bit address space */
 	mask = mapping_gfp_mask(obj->filp->f_mapping);
@@ -123,13 +124,17 @@ int lima_gem_create_handle(struct drm_device *dev, struct drm_file *file,
 	mapping_set_gfp_mask(obj->filp->f_mapping, mask);
 
 	if (is_heap) {
-		bo = to_lima_bo(obj);
 		err = lima_heap_alloc(bo, NULL);
 		if (err)
 			goto out;
 	} else {
-		struct sg_table *sgt = drm_gem_shmem_get_pages_sgt(shmem);
+		struct sg_table *sgt;
 
+		err = drm_gem_shmem_get_pages(shmem);
+		if (err)
+			goto out;
+
+		sgt = drm_gem_shmem_get_pages_sgt(shmem);
 		if (IS_ERR(sgt)) {
 			err = PTR_ERR(sgt);
 			goto out;
@@ -139,6 +144,9 @@ int lima_gem_create_handle(struct drm_device *dev, struct drm_file *file,
 	err = drm_gem_handle_create(file, obj, handle);
 
 out:
+	if (err && refcount_read(&bo->base.pages_use_count))
+		drm_gem_shmem_put_pages(shmem);
+
 	/* drop reference from allocate - handle holds it now */
 	drm_gem_object_put(obj);
 
@@ -152,6 +160,9 @@ static void lima_gem_free_object(struct drm_gem_object *obj)
 	if (!list_empty(&bo->va))
 		dev_err(obj->dev->dev, "lima gem free bo still has va\n");
 
+	if (refcount_read(&bo->base.pages_use_count))
+		drm_gem_shmem_put_pages(&bo->base);
+
 	drm_gem_shmem_free(&bo->base);
 }
 
-- 
2.43.0

