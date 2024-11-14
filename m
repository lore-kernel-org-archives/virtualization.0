Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F48374C4
	for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598228; cv=none; b=LZhRAUP1+2nvmhf1haD98AnUeNlhQyn2Xet+31INAk5Wr8ZQIzz0nSr1HAZfFOY+KbFmYG0HM/tJZCimNBOwzwLPEpyTjgpJPOLfwTpTTK5C9JhLryEecPAWZNZwZQ3x3vFkudBXMfZrq8kNJyQM4kG+MwsVRn6No44zT2SJ3K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598228; c=relaxed/simple;
	bh=AN0ZfwGI4EkUyaukDEGoEZUAeCpaVdt3d/eAka9jkOg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rt0AtBTb3Iw0sAVttdrHkuKcMbYzq0KQ2Eqafh0cEEm8EDxKIj9GUaW/xfyWMm7y2qwkm2oG6b80Kt3rlqxU5+G4C3UdM+rcko4AEyPND3LDxxZ6VfzDAmfnLp35oAT1tMuScqM3N5iHd0WVeItLwE2YCGcexWoaBx20ZCO+1bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1UQAqzI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1UQAqzI"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa2099efdc3so168556366b.1
        for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 07:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731598224; x=1732203024; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5gUunTk+fi0xEBeUGvsU/lF64TxrCQn5ATGQpWTQDU=;
        b=A1UQAqzIIynb6ntKBQgOVeF8cGiQOournN6iYgflGXJqvOhdn+N6tbbsyS1eSAV7FR
         ZbAWh/74mcoqYwayalf8beeZTIl2tNPoLpdxmiBjs8qg7ApMiwgadgn3yopaR8f1kQ/t
         PW6SzSHWlRqmhd9RJfcgaM71cq/PyNgJHRoN8u5ylJ0jBQd3uGLWv3JlnZKOUyKDmRBa
         2VLtOT6T1OFIJeb2R16XeEuyIopdgtz+SqM3c4koDO8wtinthgUPfsw+exLKWGqBENOP
         qo8VS/+oECmSJwgyL917tIy20MPVUu4hqI449roqnargivOjuMo4z1CwKpCFtQYwpbvF
         FLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598224; x=1732203024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5gUunTk+fi0xEBeUGvsU/lF64TxrCQn5ATGQpWTQDU=;
        b=u7HKgiWTsFctT01uNnUppufaAK24BKFE4xJ8asGMGhY9BykaH0LTQJO2bAA7XYidvA
         2BqVHmSZfz3F7dZzwb2ns6zTiI34+6BuPLjJQ0YU00ChUzjI0uGvZ7tRTx7/sJwlJE0F
         A/tB0Lh5uD/XcErQ4Tq+JbI0mwTdAv0AOV4WptpetEoxQ1wMifa1wWWPB7iMESYdPfyu
         aFl1KbJzhIAlaVaVaZld+qVH0NZiQaroNxzRETCgKYlExsLAMkTzF5K48YAyo+MuADUF
         s6uKIO96bU3RP8LPOGvTOj1y1jPDkSiqFGkdOXroXDSP86i53VMjaEQ9Jzo6Pr6Io6oW
         s4Ig==
X-Forwarded-Encrypted: i=1; AJvYcCW1QH6hITB8BfMlwEm9DlkM17ERbEfhzyB0JzgxorFVqs9S0KAfGDWVMrIdBHvc8uZCyIup/3m8i2955nBYfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUavP8gJnyIJD656ieB04fSWvxWQfSTsFT9iufkmeZad8M25iI
	DVKjpLq+HrLcNQZcvpzKl9zVV99gKOdczlm7OS/2IkdEXpCjCWtJ
X-Google-Smtp-Source: AGHT+IFv2EXUftXiHfEra+V5C7isNy2EHptzBjJnU85zwKMHGlhmcs44uSG0Ldp50mgkHCwxYPUjtg==
X-Received: by 2002:a17:907:d29:b0:a9e:d532:4cc7 with SMTP id a640c23a62f3a-aa2076cc161mr358920566b.8.1731598223989;
        Thu, 14 Nov 2024 07:30:23 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15c9:2500:bb23:40f5:fe29:201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046919sm74063266b.156.2024.11.14.07.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:30:23 -0800 (PST)
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
Subject: [PATCH 1/7] drm/radeon: switch over to drm_exec v2
Date: Thu, 14 Nov 2024 16:30:14 +0100
Message-Id: <20241114153020.6209-2-christian.koenig@amd.com>
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

Smoke tested on actual hardware.

v2: rebase

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/radeon/Kconfig         |  1 +
 drivers/gpu/drm/radeon/radeon.h        |  7 ++--
 drivers/gpu/drm/radeon/radeon_cs.c     | 45 +++++++++++++-------------
 drivers/gpu/drm/radeon/radeon_gem.c    | 39 ++++++++++++----------
 drivers/gpu/drm/radeon/radeon_object.c | 25 +++++++-------
 drivers/gpu/drm/radeon/radeon_object.h |  2 +-
 drivers/gpu/drm/radeon/radeon_vm.c     | 10 +++---
 7 files changed, 66 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kconfig
index 9c6c74a75778..f51bace9555d 100644
--- a/drivers/gpu/drm/radeon/Kconfig
+++ b/drivers/gpu/drm/radeon/Kconfig
@@ -13,6 +13,7 @@ config DRM_RADEON
         select DRM_TTM
 	select DRM_TTM_HELPER
 	select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
+	select DRM_EXEC
 	select SND_HDA_COMPONENT if SND_HDA_CORE
 	select POWER_SUPPLY
 	select HWMON
diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index fd8a4513025f..8605c074d9f7 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -75,8 +75,8 @@
 
 #include <drm/ttm/ttm_bo.h>
 #include <drm/ttm/ttm_placement.h>
-#include <drm/ttm/ttm_execbuf_util.h>
 
+#include <drm/drm_exec.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_audio_component.h>
 #include <drm/drm_suballoc.h>
@@ -457,7 +457,8 @@ struct radeon_mman {
 
 struct radeon_bo_list {
 	struct radeon_bo		*robj;
-	struct ttm_validate_buffer	tv;
+	struct list_head		list;
+	bool				shared;
 	uint64_t			gpu_offset;
 	unsigned			preferred_domains;
 	unsigned			allowed_domains;
@@ -1030,6 +1031,7 @@ struct radeon_cs_parser {
 	struct radeon_bo_list	*vm_bos;
 	struct list_head	validated;
 	unsigned		dma_reloc_idx;
+	struct drm_exec		exec;
 	/* indices of various chunks */
 	struct radeon_cs_chunk  *chunk_ib;
 	struct radeon_cs_chunk  *chunk_relocs;
@@ -1043,7 +1045,6 @@ struct radeon_cs_parser {
 	u32			cs_flags;
 	u32			ring;
 	s32			priority;
-	struct ww_acquire_ctx	ticket;
 };
 
 static inline u32 radeon_get_ib_value(struct radeon_cs_parser *p, int idx)
diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
index a6700d7278bf..64b26bfeafc9 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -182,11 +182,8 @@ static int radeon_cs_parser_relocs(struct radeon_cs_parser *p)
 			}
 		}
 
-		p->relocs[i].tv.bo = &p->relocs[i].robj->tbo;
-		p->relocs[i].tv.num_shared = !r->write_domain;
-
-		radeon_cs_buckets_add(&buckets, &p->relocs[i].tv.head,
-				      priority);
+		p->relocs[i].shared = !r->write_domain;
+		radeon_cs_buckets_add(&buckets, &p->relocs[i].list, priority);
 	}
 
 	radeon_cs_buckets_get_list(&buckets, &p->validated);
@@ -197,7 +194,7 @@ static int radeon_cs_parser_relocs(struct radeon_cs_parser *p)
 	if (need_mmap_lock)
 		mmap_read_lock(current->mm);
 
-	r = radeon_bo_list_validate(p->rdev, &p->ticket, &p->validated, p->ring);
+	r = radeon_bo_list_validate(p->rdev, &p->exec, &p->validated, p->ring);
 
 	if (need_mmap_lock)
 		mmap_read_unlock(current->mm);
@@ -253,12 +250,11 @@ static int radeon_cs_sync_rings(struct radeon_cs_parser *p)
 	struct radeon_bo_list *reloc;
 	int r;
 
-	list_for_each_entry(reloc, &p->validated, tv.head) {
+	list_for_each_entry(reloc, &p->validated, list) {
 		struct dma_resv *resv;
 
 		resv = reloc->robj->tbo.base.resv;
-		r = radeon_sync_resv(p->rdev, &p->ib.sync, resv,
-				     reloc->tv.num_shared);
+		r = radeon_sync_resv(p->rdev, &p->ib.sync, resv, reloc->shared);
 		if (r)
 			return r;
 	}
@@ -276,6 +272,7 @@ int radeon_cs_parser_init(struct radeon_cs_parser *p, void *data)
 	s32 priority = 0;
 
 	INIT_LIST_HEAD(&p->validated);
+	drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 
 	if (!cs->num_chunks) {
 		return 0;
@@ -397,8 +394,8 @@ int radeon_cs_parser_init(struct radeon_cs_parser *p, void *data)
 static int cmp_size_smaller_first(void *priv, const struct list_head *a,
 				  const struct list_head *b)
 {
-	struct radeon_bo_list *la = list_entry(a, struct radeon_bo_list, tv.head);
-	struct radeon_bo_list *lb = list_entry(b, struct radeon_bo_list, tv.head);
+	struct radeon_bo_list *la = list_entry(a, struct radeon_bo_list, list);
+	struct radeon_bo_list *lb = list_entry(b, struct radeon_bo_list, list);
 
 	/* Sort A before B if A is smaller. */
 	if (la->robj->tbo.base.size > lb->robj->tbo.base.size)
@@ -417,11 +414,13 @@ static int cmp_size_smaller_first(void *priv, const struct list_head *a,
  * If error is set than unvalidate buffer, otherwise just free memory
  * used by parsing context.
  **/
-static void radeon_cs_parser_fini(struct radeon_cs_parser *parser, int error, bool backoff)
+static void radeon_cs_parser_fini(struct radeon_cs_parser *parser, int error)
 {
 	unsigned i;
 
 	if (!error) {
+		struct radeon_bo_list *reloc;
+
 		/* Sort the buffer list from the smallest to largest buffer,
 		 * which affects the order of buffers in the LRU list.
 		 * This assures that the smallest buffers are added first
@@ -433,15 +432,17 @@ static void radeon_cs_parser_fini(struct radeon_cs_parser *parser, int error, bo
 		 * per frame under memory pressure.
 		 */
 		list_sort(NULL, &parser->validated, cmp_size_smaller_first);
-
-		ttm_eu_fence_buffer_objects(&parser->ticket,
-					    &parser->validated,
-					    &parser->ib.fence->base);
-	} else if (backoff) {
-		ttm_eu_backoff_reservation(&parser->ticket,
-					   &parser->validated);
+		list_for_each_entry(reloc, &parser->validated, list) {
+			dma_resv_add_fence(reloc->robj->tbo.base.resv,
+					   &parser->ib.fence->base,
+					   reloc->shared ?
+					   DMA_RESV_USAGE_READ :
+					   DMA_RESV_USAGE_WRITE);
+		}
 	}
 
+	drm_exec_fini(&parser->exec);
+
 	if (parser->relocs != NULL) {
 		for (i = 0; i < parser->nrelocs; i++) {
 			struct radeon_bo *bo = parser->relocs[i].robj;
@@ -693,7 +694,7 @@ int radeon_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	r = radeon_cs_parser_init(&parser, data);
 	if (r) {
 		DRM_ERROR("Failed to initialize parser !\n");
-		radeon_cs_parser_fini(&parser, r, false);
+		radeon_cs_parser_fini(&parser, r);
 		up_read(&rdev->exclusive_lock);
 		r = radeon_cs_handle_lockup(rdev, r);
 		return r;
@@ -707,7 +708,7 @@ int radeon_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	}
 
 	if (r) {
-		radeon_cs_parser_fini(&parser, r, false);
+		radeon_cs_parser_fini(&parser, r);
 		up_read(&rdev->exclusive_lock);
 		r = radeon_cs_handle_lockup(rdev, r);
 		return r;
@@ -724,7 +725,7 @@ int radeon_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		goto out;
 	}
 out:
-	radeon_cs_parser_fini(&parser, r, true);
+	radeon_cs_parser_fini(&parser, r);
 	up_read(&rdev->exclusive_lock);
 	r = radeon_cs_handle_lockup(rdev, r);
 	return r;
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index bf2d4b16dc2a..f86773f3db20 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -605,33 +605,40 @@ int radeon_gem_get_tiling_ioctl(struct drm_device *dev, void *data,
 static void radeon_gem_va_update_vm(struct radeon_device *rdev,
 				    struct radeon_bo_va *bo_va)
 {
-	struct ttm_validate_buffer tv, *entry;
-	struct radeon_bo_list *vm_bos;
-	struct ww_acquire_ctx ticket;
+	struct radeon_bo_list *vm_bos, *entry;
 	struct list_head list;
+	struct drm_exec exec;
 	unsigned domain;
 	int r;
 
 	INIT_LIST_HEAD(&list);
 
-	tv.bo = &bo_va->bo->tbo;
-	tv.num_shared = 1;
-	list_add(&tv.head, &list);
-
 	vm_bos = radeon_vm_get_bos(rdev, bo_va->vm, &list);
 	if (!vm_bos)
 		return;
 
-	r = ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
-	if (r)
-		goto error_free;
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_until_all_locked(&exec) {
+		list_for_each_entry(entry, &list, list) {
+			r = drm_exec_prepare_obj(&exec, &entry->robj->tbo.base,
+						 1);
+			drm_exec_retry_on_contention(&exec);
+			if (unlikely(r))
+				goto error_cleanup;
+		}
 
-	list_for_each_entry(entry, &list, head) {
-		domain = radeon_mem_type_to_domain(entry->bo->resource->mem_type);
+		r = drm_exec_prepare_obj(&exec, &bo_va->bo->tbo.base, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r))
+			goto error_cleanup;
+	}
+
+	list_for_each_entry(entry, &list, list) {
+		domain = radeon_mem_type_to_domain(entry->robj->tbo.resource->mem_type);
 		/* if anything is swapped out don't swap it in here,
 		   just abort and wait for the next CS */
 		if (domain == RADEON_GEM_DOMAIN_CPU)
-			goto error_unreserve;
+			goto error_cleanup;
 	}
 
 	mutex_lock(&bo_va->vm->mutex);
@@ -645,10 +652,8 @@ static void radeon_gem_va_update_vm(struct radeon_device *rdev,
 error_unlock:
 	mutex_unlock(&bo_va->vm->mutex);
 
-error_unreserve:
-	ttm_eu_backoff_reservation(&ticket, &list);
-
-error_free:
+error_cleanup:
+	drm_exec_fini(&exec);
 	kvfree(vm_bos);
 
 	if (r && r != -ERESTARTSYS)
diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index 7672404fdb29..a0fc0801abb0 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -464,23 +464,26 @@ static u64 radeon_bo_get_threshold_for_moves(struct radeon_device *rdev)
 }
 
 int radeon_bo_list_validate(struct radeon_device *rdev,
-			    struct ww_acquire_ctx *ticket,
+			    struct drm_exec *exec,
 			    struct list_head *head, int ring)
 {
 	struct ttm_operation_ctx ctx = { true, false };
 	struct radeon_bo_list *lobj;
-	struct list_head duplicates;
-	int r;
 	u64 bytes_moved = 0, initial_bytes_moved;
 	u64 bytes_moved_threshold = radeon_bo_get_threshold_for_moves(rdev);
+	int r;
 
-	INIT_LIST_HEAD(&duplicates);
-	r = ttm_eu_reserve_buffers(ticket, head, true, &duplicates);
-	if (unlikely(r != 0)) {
-		return r;
+	drm_exec_until_all_locked(exec) {
+		list_for_each_entry(lobj, head, list) {
+			r = drm_exec_prepare_obj(exec, &lobj->robj->tbo.base,
+						 1);
+			drm_exec_retry_on_contention(exec);
+			if (unlikely(r && r != -EALREADY))
+				return r;
+		}
 	}
 
-	list_for_each_entry(lobj, head, tv.head) {
+	list_for_each_entry(lobj, head, list) {
 		struct radeon_bo *bo = lobj->robj;
 		if (!bo->tbo.pin_count) {
 			u32 domain = lobj->preferred_domains;
@@ -519,7 +522,6 @@ int radeon_bo_list_validate(struct radeon_device *rdev,
 					domain = lobj->allowed_domains;
 					goto retry;
 				}
-				ttm_eu_backoff_reservation(ticket, head);
 				return r;
 			}
 		}
@@ -527,11 +529,6 @@ int radeon_bo_list_validate(struct radeon_device *rdev,
 		lobj->tiling_flags = bo->tiling_flags;
 	}
 
-	list_for_each_entry(lobj, &duplicates, tv.head) {
-		lobj->gpu_offset = radeon_bo_gpu_offset(lobj->robj);
-		lobj->tiling_flags = lobj->robj->tiling_flags;
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/radeon/radeon_object.h b/drivers/gpu/drm/radeon/radeon_object.h
index 39cc87a59a9a..d7bbb52db546 100644
--- a/drivers/gpu/drm/radeon/radeon_object.h
+++ b/drivers/gpu/drm/radeon/radeon_object.h
@@ -152,7 +152,7 @@ extern void radeon_bo_force_delete(struct radeon_device *rdev);
 extern int radeon_bo_init(struct radeon_device *rdev);
 extern void radeon_bo_fini(struct radeon_device *rdev);
 extern int radeon_bo_list_validate(struct radeon_device *rdev,
-				   struct ww_acquire_ctx *ticket,
+				   struct drm_exec *exec,
 				   struct list_head *head, int ring);
 extern int radeon_bo_set_tiling_flags(struct radeon_bo *bo,
 				u32 tiling_flags, u32 pitch);
diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index c38b4d5d6a14..21a5340aefdf 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -142,10 +142,9 @@ struct radeon_bo_list *radeon_vm_get_bos(struct radeon_device *rdev,
 	list[0].robj = vm->page_directory;
 	list[0].preferred_domains = RADEON_GEM_DOMAIN_VRAM;
 	list[0].allowed_domains = RADEON_GEM_DOMAIN_VRAM;
-	list[0].tv.bo = &vm->page_directory->tbo;
-	list[0].tv.num_shared = 1;
+	list[0].shared = true;
 	list[0].tiling_flags = 0;
-	list_add(&list[0].tv.head, head);
+	list_add(&list[0].list, head);
 
 	for (i = 0, idx = 1; i <= vm->max_pde_used; i++) {
 		if (!vm->page_tables[i].bo)
@@ -154,10 +153,9 @@ struct radeon_bo_list *radeon_vm_get_bos(struct radeon_device *rdev,
 		list[idx].robj = vm->page_tables[i].bo;
 		list[idx].preferred_domains = RADEON_GEM_DOMAIN_VRAM;
 		list[idx].allowed_domains = RADEON_GEM_DOMAIN_VRAM;
-		list[idx].tv.bo = &list[idx].robj->tbo;
-		list[idx].tv.num_shared = 1;
+		list[idx].shared = true;
 		list[idx].tiling_flags = 0;
-		list_add(&list[idx++].tv.head, head);
+		list_add(&list[idx++].list, head);
 	}
 
 	return list;
-- 
2.34.1

