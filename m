Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C15B39AF1
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2vsXtcPc"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F14F342089
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F14F342089
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=2vsXtcPc
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uixWkUoMRh_G
	for <virtualization@lists.linux-foundation.org>;
	Fri,  5 Jan 2024 18:47:13 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3BDCC42087
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BDCC42087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480431;
	bh=IRLl1Wz/kpPQ7d9mzb5RwhkejAZITB4j+h1FXgfgdUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2vsXtcPcm3BWlv5C+uaLudrnm+3UJx8YA4C7ZABgtllA53LRJMuTZm2sxLxJsuKBD
	 jgHxkTl5bd0rX9nFsYW//zapPr0kIwbDjgGAhfMSgUVHAgyhTD3npKgNU3VFTvxUsS
	 PC0C0xNTQ3uolrB7a74019xftcIF+r+JMuufT6E2Q1g9ePkYsoS5RVkQZstDCAytHA
	 xVmUQ72Lm5V+t0zb5uJdTaGcx5Rba2+UBiUpHMgPjYrPFfLvKtcr4Co4sKzIyc3hDn
	 4yXb50OrDD87hvSm0Vu20L6HrilolAD485afUeUdB3tSx3GGt5lVk9uEyoyLYnyFdZ
	 En259qSP7150Q==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 674583782054;
	Fri,  5 Jan 2024 18:47:10 +0000 (UTC)
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
Subject: [PATCH v19 17/30] drm/panfrost: Fix the error path in panfrost_mmu_map_fault_addr()
Date: Fri,  5 Jan 2024 21:46:11 +0300
Message-ID: <20240105184624.508603-18-dmitry.osipenko@collabora.com>
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

From: Boris Brezillon <boris.brezillon@collabora.com>

If some the pages or sgt allocation failed, we shouldn't release the
pages ref we got earlier, otherwise we will end up with unbalanced
get/put_pages() calls. We should instead leave everything in place
and let the BO release function deal with extra cleanup when the object
is destroyed, or let the fault handler try again next time it's called.

Fixes: 187d2929206e ("drm/panfrost: Add support for GPU heap allocations")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index bd5a0073009d..4a0b4bf03f1a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -502,11 +502,18 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	mapping_set_unevictable(mapping);
 
 	for (i = page_offset; i < page_offset + NUM_FAULT_PAGES; i++) {
+		/* Can happen if the last fault only partially filled this
+		 * section of the pages array before failing. In that case
+		 * we skip already filled pages.
+		 */
+		if (pages[i])
+			continue;
+
 		pages[i] = shmem_read_mapping_page(mapping, i);
 		if (IS_ERR(pages[i])) {
 			ret = PTR_ERR(pages[i]);
 			pages[i] = NULL;
-			goto err_pages;
+			goto err_unlock;
 		}
 	}
 
@@ -514,7 +521,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	ret = sg_alloc_table_from_pages(sgt, pages + page_offset,
 					NUM_FAULT_PAGES, 0, SZ_2M, GFP_KERNEL);
 	if (ret)
-		goto err_pages;
+		goto err_unlock;
 
 	ret = dma_map_sgtable(pfdev->dev, sgt, DMA_BIDIRECTIONAL, 0);
 	if (ret)
@@ -537,8 +544,6 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 
 err_map:
 	sg_free_table(sgt);
-err_pages:
-	drm_gem_shmem_put_pages_locked(&bo->base);
 err_unlock:
 	dma_resv_unlock(obj->resv);
 err_bo:
-- 
2.43.0

