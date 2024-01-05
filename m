Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5035F17
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E7SWBKFy"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 655D9436A4
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:46:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 655D9436A4
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=E7SWBKFy
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nMQ5wkMebIyt
	for <virtualization@lists.linux-foundation.org>;
	Fri,  5 Jan 2024 18:46:49 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6D63D4015F
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:46:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D63D4015F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480407;
	bh=nR4jYVhSWCLMrjIGrNICVL5mLIA6VSkplrmpOfwke3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7SWBKFyyVHM9/BgPb2tO1ghBhNH/e/IaRwE45mMwxLbawQWEePrIhRbKeUMUYg0Z
	 lv2d5w7aWLCfOZpkuq5H8BTm926H4+sMuNOJ57GVVXhU76VJ3VS0+rSWE6P2Q7M+vL
	 9KVtAkUU2/5WjF7C3yb8GjGa7ofWnHJ1kh8QFQ5iYUuOinYATpUMrdKvEybZgHE12f
	 pr8JbUYAjwIEJDINNHx6Y3SeK12ZRCZndHykfZRHpdivONEeFy0osDfXjaPkwxaaH1
	 OE82Fe+qXZTvdpSvHW9brpx83hyQkz2/QzO2V3nP3VQttBcaTkqsLBYu4lLXHdoUzd
	 Hn0GZXQdalP2Q==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 469C2378203B;
	Fri,  5 Jan 2024 18:46:46 +0000 (UTC)
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
Subject: [PATCH v19 02/30] drm/gem: Add _locked postfix to functions that have unlocked counterpart
Date: Fri,  5 Jan 2024 21:45:56 +0300
Message-ID: <20240105184624.508603-3-dmitry.osipenko@collabora.com>
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

Add _locked postfix to drm_gem functions that have unlocked counterpart
functions to make GEM functions naming more consistent and intuitive in
regards to the locking requirements.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem.c | 6 +++---
 include/drm/drm_gem.h     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 95327b003692..4523cd40fb2f 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1490,10 +1490,10 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
 EXPORT_SYMBOL(drm_gem_lru_scan);
 
 /**
- * drm_gem_evict - helper to evict backing pages for a GEM object
+ * drm_gem_evict_locked - helper to evict backing pages for a GEM object
  * @obj: obj in question
  */
-int drm_gem_evict(struct drm_gem_object *obj)
+int drm_gem_evict_locked(struct drm_gem_object *obj)
 {
 	dma_resv_assert_held(obj->resv);
 
@@ -1505,4 +1505,4 @@ int drm_gem_evict(struct drm_gem_object *obj)
 
 	return 0;
 }
-EXPORT_SYMBOL(drm_gem_evict);
+EXPORT_SYMBOL(drm_gem_evict_locked);
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index decb19ffb2c8..f835fdee6a5e 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -551,7 +551,7 @@ unsigned long drm_gem_lru_scan(struct drm_gem_lru *lru,
 			       unsigned long *remaining,
 			       bool (*shrink)(struct drm_gem_object *obj));
 
-int drm_gem_evict(struct drm_gem_object *obj);
+int drm_gem_evict_locked(struct drm_gem_object *obj);
 
 #ifdef CONFIG_LOCKDEP
 /**
-- 
2.43.0

