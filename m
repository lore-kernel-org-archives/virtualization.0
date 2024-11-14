Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61416EB4C
	for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598228; cv=none; b=VUhXwOq/RgaU7t3X63PfUoHrLPr84jI4yYFaFg6EIdnZSD50Tqkzkq1Swin16z85vmUlGyYIH/gmdfZoqbyGjIWBL7YdnFgJ+E+MRo8zsnp0JfEAgdtIQTbcfTbAzpc5ZOGo9MPR79W3Ch/+X2/HXFxsKgX30ANPocyaOccEZV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598228; c=relaxed/simple;
	bh=iCItKJgqCrAeMP2Ij3xeNSZPgWU6x5vaPyg7CpRdC/o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7/WPfawfI29Lsp4sNioHC20SQ0oB7sYxVnUL9XU9r1nYBozdxBFKJqxduwtb1tn0iIzaI2mO2/VqCiw7D28+6XA8G8TrJp/IxSA/1nsdvSsX/CeqlomzvTnNZUubLOcH50vJWK5AEy/gwFnhSHY5gwIVu7p9pWYIsPO5xi64f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTk37DcK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTk37DcK"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cf8593ca4bso441055a12.1
        for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 07:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731598225; x=1732203025; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjSRnW8Jbot+FYwZFGF/dqccGF8efL0UZHIw1iaZnvE=;
        b=lTk37DcKOQeP06sgqwNVivKkMednJKY+FBEgF6gcbAI+/V+XQUNFBLTTQ2DHr/b45r
         /cvKg8IPniSlA45NNycasEnK3+vQY6ou4deGDpzHtz2pk3uvff0fI6N40nv8MzwA9SuD
         IN0xWbfufgIIRnGJleHEnsfeWA03h+jT5/7d33rZhwm1rfFBr+A42LmTV6XrKimqyo5b
         n3NfkbodgPRenOEqzCH5WNym4gxoEUJTGGx3jaJx+seuijazi9rgxbLqcqcKLROVe+W8
         bhwlbhqF1gXUFi2kRfe8bjr1Xe4+SBlt768SIfA7k3/7TIEcB2vwGm81AVCQflRMKoE8
         VohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598225; x=1732203025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjSRnW8Jbot+FYwZFGF/dqccGF8efL0UZHIw1iaZnvE=;
        b=IRMMa56hBZGILQRiEcqSYoQgDoSji6EVdXGqV1j1GGYo0Jsdhdv3rYFxvMWsN2ZRDS
         9JBkw0vNY8uAHfTM6JgbeOfKhf+kxgKlhbkcoXfYZJeWmhoxlUWBYiICoUP0ay5RlBOm
         1U8OPeYvZFabF6Onf9oJYRMBYzNzdWSy81ATBHimfGhTyq02t9UhBYgGcDMMP4Etk9pT
         8R0FGIrC3R+VlOuw70NXwf15ACly5tqsW5L8LrijDbPJKbjAPRtZ00ZVm62FQ4/RuU/9
         cnAbxEPCvt58zADuoYViY6iJXsMTg/38PXhQr1S1r74mpS5zZt7XYQkcbw2z6pwibS52
         gCEw==
X-Forwarded-Encrypted: i=1; AJvYcCVt4FuPUEjkANncbhIZFFv15NETWg+cY+PPOM4yn6Jxf4y6ozFt4RAQ1wKaK7VdiZTV/BySorDR0OmEZy/oRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwW0HeHS2CjdtDZ+jRJdPEZA6j7eTLXY4P3I/AxA2nntMB65Wln
	L2dFK/lc5YfCY5rtsDT8IFjTpDOlk6a6wAXQmKDzfJhqyctOTdupHZTfi8+LRuc=
X-Google-Smtp-Source: AGHT+IE7TXyLRVQqj0KhpJuttZv8/yoJzgvJc7AqQhU3Y4RfG9yyS/ho2z24xbF0lIYw/lSxzZUeog==
X-Received: by 2002:a17:907:60c8:b0:a9a:673f:4dcc with SMTP id a640c23a62f3a-aa20cd0589bmr217313866b.22.1731598224992;
        Thu, 14 Nov 2024 07:30:24 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15c9:2500:bb23:40f5:fe29:201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046919sm74063266b.156.2024.11.14.07.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:30:24 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: kraxel@redhat.com,
	airlied@redhat.com,
	alexander.deucher@amd.com,
	zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 2/7] drm/qxl: switch to using drm_exec v2
Date: Thu, 14 Nov 2024 16:30:15 +0100
Message-Id: <20241114153020.6209-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114153020.6209-1-christian.koenig@amd.com>
References: <20241114153020.6209-1-christian.koenig@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Just a straightforward conversion without any optimization.

Only compile tested for now.

v2: rebase

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/qxl/Kconfig       |  1 +
 drivers/gpu/drm/qxl/qxl_drv.h     |  7 ++--
 drivers/gpu/drm/qxl/qxl_release.c | 68 ++++++++++++++++---------------
 3 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/qxl/Kconfig b/drivers/gpu/drm/qxl/Kconfig
index 1992df4a82d2..ebf452aa1e80 100644
--- a/drivers/gpu/drm/qxl/Kconfig
+++ b/drivers/gpu/drm/qxl/Kconfig
@@ -6,6 +6,7 @@ config DRM_QXL
 	select DRM_KMS_HELPER
 	select DRM_TTM
 	select DRM_TTM_HELPER
+	select DRM_EXEC
 	select CRC32
 	help
 	  QXL virtual GPU for Spice virtualization desktop integration.
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 32069acd93f8..b5fc14c9525d 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -38,12 +38,12 @@
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_exec.h>
 #include <drm/drm_gem_ttm_helper.h>
 #include <drm/drm_ioctl.h>
 #include <drm/drm_gem.h>
 #include <drm/qxl_drm.h>
 #include <drm/ttm/ttm_bo.h>
-#include <drm/ttm/ttm_execbuf_util.h>
 #include <drm/ttm/ttm_placement.h>
 
 #include "qxl_dev.h"
@@ -101,7 +101,8 @@ struct qxl_gem {
 };
 
 struct qxl_bo_list {
-	struct ttm_validate_buffer tv;
+	struct qxl_bo		*bo;
+	struct list_head	list;
 };
 
 struct qxl_crtc {
@@ -150,7 +151,7 @@ struct qxl_release {
 	struct qxl_bo *release_bo;
 	uint32_t release_offset;
 	uint32_t surface_release_id;
-	struct ww_acquire_ctx ticket;
+	struct drm_exec	exec;
 	struct list_head bos;
 };
 
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 368d26da0d6a..05204a6a3fa8 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -121,13 +121,11 @@ qxl_release_free_list(struct qxl_release *release)
 {
 	while (!list_empty(&release->bos)) {
 		struct qxl_bo_list *entry;
-		struct qxl_bo *bo;
 
 		entry = container_of(release->bos.next,
-				     struct qxl_bo_list, tv.head);
-		bo = to_qxl_bo(entry->tv.bo);
-		qxl_bo_unref(&bo);
-		list_del(&entry->tv.head);
+				     struct qxl_bo_list, list);
+		qxl_bo_unref(&entry->bo);
+		list_del(&entry->list);
 		kfree(entry);
 	}
 	release->release_bo = NULL;
@@ -172,8 +170,8 @@ int qxl_release_list_add(struct qxl_release *release, struct qxl_bo *bo)
 {
 	struct qxl_bo_list *entry;
 
-	list_for_each_entry(entry, &release->bos, tv.head) {
-		if (entry->tv.bo == &bo->tbo)
+	list_for_each_entry(entry, &release->bos, list) {
+		if (entry->bo == bo)
 			return 0;
 	}
 
@@ -182,9 +180,8 @@ int qxl_release_list_add(struct qxl_release *release, struct qxl_bo *bo)
 		return -ENOMEM;
 
 	qxl_bo_ref(bo);
-	entry->tv.bo = &bo->tbo;
-	entry->tv.num_shared = 0;
-	list_add_tail(&entry->tv.head, &release->bos);
+	entry->bo = bo;
+	list_add_tail(&entry->list, &release->bos);
 	return 0;
 }
 
@@ -221,21 +218,28 @@ int qxl_release_reserve_list(struct qxl_release *release, bool no_intr)
 	if (list_is_singular(&release->bos))
 		return 0;
 
-	ret = ttm_eu_reserve_buffers(&release->ticket, &release->bos,
-				     !no_intr, NULL);
-	if (ret)
-		return ret;
-
-	list_for_each_entry(entry, &release->bos, tv.head) {
-		struct qxl_bo *bo = to_qxl_bo(entry->tv.bo);
-
-		ret = qxl_release_validate_bo(bo);
-		if (ret) {
-			ttm_eu_backoff_reservation(&release->ticket, &release->bos);
-			return ret;
+	drm_exec_init(&release->exec, no_intr ? 0 :
+		      DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_until_all_locked(&release->exec) {
+		list_for_each_entry(entry, &release->bos, list) {
+			ret = drm_exec_prepare_obj(&release->exec,
+						   &entry->bo->tbo.base,
+						   1);
+			drm_exec_retry_on_contention(&release->exec);
+			if (ret)
+				goto error;
 		}
 	}
+
+	list_for_each_entry(entry, &release->bos, list) {
+		ret = qxl_release_validate_bo(entry->bo);
+		if (ret)
+			goto error;
+	}
 	return 0;
+error:
+	drm_exec_fini(&release->exec);
+	return ret;
 }
 
 void qxl_release_backoff_reserve_list(struct qxl_release *release)
@@ -245,7 +249,7 @@ void qxl_release_backoff_reserve_list(struct qxl_release *release)
 	if (list_is_singular(&release->bos))
 		return;
 
-	ttm_eu_backoff_reservation(&release->ticket, &release->bos);
+	drm_exec_fini(&release->exec);
 }
 
 int qxl_alloc_surface_release_reserved(struct qxl_device *qdev,
@@ -404,18 +408,18 @@ void qxl_release_unmap(struct qxl_device *qdev,
 
 void qxl_release_fence_buffer_objects(struct qxl_release *release)
 {
-	struct ttm_buffer_object *bo;
 	struct ttm_device *bdev;
-	struct ttm_validate_buffer *entry;
+	struct qxl_bo_list *entry;
 	struct qxl_device *qdev;
+	struct qxl_bo *bo;
 
 	/* if only one object on the release its the release itself
 	   since these objects are pinned no need to reserve */
 	if (list_is_singular(&release->bos) || list_empty(&release->bos))
 		return;
 
-	bo = list_first_entry(&release->bos, struct ttm_validate_buffer, head)->bo;
-	bdev = bo->bdev;
+	bo = list_first_entry(&release->bos, struct qxl_bo_list, list)->bo;
+	bdev = bo->tbo.bdev;
 	qdev = container_of(bdev, struct qxl_device, mman.bdev);
 
 	/*
@@ -426,14 +430,12 @@ void qxl_release_fence_buffer_objects(struct qxl_release *release)
 		       release->id | 0xf0000000, release->base.seqno);
 	trace_dma_fence_emit(&release->base);
 
-	list_for_each_entry(entry, &release->bos, head) {
+	list_for_each_entry(entry, &release->bos, list) {
 		bo = entry->bo;
 
-		dma_resv_add_fence(bo->base.resv, &release->base,
+		dma_resv_add_fence(bo->tbo.base.resv, &release->base,
 				   DMA_RESV_USAGE_READ);
-		ttm_bo_move_to_lru_tail_unlocked(bo);
-		dma_resv_unlock(bo->base.resv);
+		ttm_bo_move_to_lru_tail_unlocked(&bo->tbo);
 	}
-	ww_acquire_fini(&release->ticket);
+	drm_exec_fini(&release->exec);
 }
-
-- 
2.34.1

