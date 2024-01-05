Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B8336AED
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AWeQh8Ef"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A61B84002
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:46:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A61B84002
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=AWeQh8Ef
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V6YBQbZBjVqR
	for <virtualization@lists.linux-foundation.org>;
	Fri,  5 Jan 2024 18:46:56 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C833C83FF4
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:46:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C833C83FF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480414;
	bh=ogKb7d41PScFLzJ54iuk6ZS0vpsAlBKn+e0Ym6lcvII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AWeQh8EfRh3NwZ17ZU18fulJX9TFyKsccd1mq/XyYbmkMluipimpxzcn7DicPPTwf
	 iCH66lPnhUorGMqu7uJIBWLlt9uL1JZqC+vVwQTuW+CRhhQ5MvjK6Eq3x9HGtEi2+X
	 CvPdXzYkpy+9ZGFL2OEZsmbniaaULZpZHc0o9vPhhYj1icOZYOqmkD9JjeVc15QyDM
	 avj1W+ipJQuYGqVOWbBCgmU5lWW+nBH8bQIlNqAOj70et0O7QmoS1SLvkcO0n7tQpG
	 12oiP0cPZ1baqzMsn/Io3ocw+5KNbv3Gw0T6mYmb58qiPpQ6gVJ3CA3rpmymk9tXRy
	 4plg+ejoTBT5A==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E692E3782041;
	Fri,  5 Jan 2024 18:46:52 +0000 (UTC)
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
Subject: [PATCH v19 06/30] drm/shmem-helper: Remove obsoleted is_iomem test
Date: Fri,  5 Jan 2024 21:46:00 +0300
Message-ID: <20240105184624.508603-7-dmitry.osipenko@collabora.com>
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

Everything that uses the mapped buffer should be agnostic to is_iomem.
The only reason for the is_iomem test is that we're setting shmem->vaddr
to the returned map->vaddr. Now that the shmem->vaddr code is gone, remove
the obsoleted is_iomem test to clean up the code.

Acked-by: Maxime Ripard <mripard@kernel.org>
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 043e8e3b129c..1f0a66386415 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -315,12 +315,6 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 
 	if (obj->import_attach) {
 		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
-		if (!ret) {
-			if (drm_WARN_ON(obj->dev, map->is_iomem)) {
-				dma_buf_vunmap(obj->import_attach->dmabuf, map);
-				return -EIO;
-			}
-		}
 	} else {
 		pgprot_t prot = PAGE_KERNEL;
 
-- 
2.43.0

