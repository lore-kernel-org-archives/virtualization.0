Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8013C06A
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="koD1jTYA"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF8B4436C1
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF8B4436C1
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=koD1jTYA
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JRJ-F2G3wquU
	for <virtualization@lists.linux-foundation.org>;
	Fri,  5 Jan 2024 18:47:27 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF10E436A4
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF10E436A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480446;
	bh=Xy26gJL0rfEIAQ3GTzMQ9EaB0QSmN8Rrgbq8+tRhsXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=koD1jTYASaaq0lH30DCRGwRlLF4icZe6o4RtGhMtxdBXY6SQHCj+AAoMWGtCV5jal
	 3o38uo19aKWom4br+OTJmNgxqtAXnvCQUYJjZ8hDcNButj0PQLLHni40YT501PCe6q
	 ErF+M+MYMwDfZlVE+2dFDViPRVojFs1vXPkPZ8WiG92SaZ7MSFVtT17Scs7uYMdJsy
	 HZalfvQSfjP9e4W+qiuVHBQZioyrxkCXK6FpqhTSHYXKdRKIxj01ioqjERVM7ygUfQ
	 hQGNr+u92vLMktYspBAr0AJKm4va1ejnViBWlDzvwRtDU+HLnQGiP3yS7a15I0yQuP
	 J7987sqBJRbVw==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E4CC2378206D;
	Fri,  5 Jan 2024 18:47:24 +0000 (UTC)
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
Subject: [PATCH v19 26/30] drm/shmem-helper: Turn warnings about imported GEM into errors
Date: Fri,  5 Jan 2024 21:46:20 +0300
Message-ID: <20240105184624.508603-27-dmitry.osipenko@collabora.com>
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

Turn sanity warnings about DRM-SHMEM API misuse into a error conditions
for cases where imported GEM is used when it shouldn't be used.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 0d95d723b90d..7d2fe12bd793 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -409,7 +409,8 @@ int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem)
 	struct drm_gem_object *obj = &shmem->base;
 	int ret;
 
-	drm_WARN_ON(obj->dev, obj->import_attach);
+	if (drm_WARN_ON(obj->dev, obj->import_attach))
+		return -EINVAL;
 
 	if (refcount_inc_not_zero(&shmem->pages_pin_count))
 		return 0;
@@ -872,7 +873,8 @@ struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem)
 {
 	struct drm_gem_object *obj = &shmem->base;
 
-	drm_WARN_ON(obj->dev, obj->import_attach);
+	if (drm_WARN_ON(obj->dev, obj->import_attach))
+		return ERR_PTR(-EINVAL);
 
 	if (drm_WARN_ON(obj->dev, !shmem->pages))
 		return ERR_PTR(-ENOMEM);
@@ -909,7 +911,8 @@ struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_object
 	if (shmem->sgt)
 		return shmem->sgt;
 
-	drm_WARN_ON(obj->dev, obj->import_attach);
+	if (drm_WARN_ON(obj->dev, obj->import_attach))
+		return ERR_PTR(-EINVAL);
 
 	sgt = drm_gem_shmem_get_sg_table(shmem);
 	if (IS_ERR(sgt))
-- 
2.43.0

