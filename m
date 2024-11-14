Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23169183098
	for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598230; cv=none; b=EiUp5oXtn48nipRcooJHzCqE06J4Qi/E3GqijqC0dVFQxVjlVwjyOMHJ1qrK3kdIJCGdVBa59YFQP3au4HV8B+z9PU6vJ/KmHLHuqBtHgouqL9vZZwS1lC5Rgq7vJnA42AeYgnVmorvG55H2ovb+MyALYu5FTT+OH8moCRAOPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598230; c=relaxed/simple;
	bh=k4jaY5oYGU8tJr96VYzqBQKPaJLMgxKOxguLSKBtHFM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHjlWg4QBbV7H9NunEMUeGKHAP+nXUz5fqrfD7WEQEj8cblpUIFbYU7oeaBXyeMVWJ3FUfH8yfYF/qUzyoI/QOkf+El3FeOZbEUWB7JNztK/X357k8jfqH40G/bZ1ipjTH2lYZAkPxAUclX3cPJ/oo1cP3AqBvDVMRnjCH4Wbd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVrA58Pe; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVrA58Pe"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cf7b79c6a6so881597a12.0
        for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 07:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731598227; x=1732203027; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FnZ9AMjiL+5LBp0zOTics7Ga5/djcimKqH32qBiMpo=;
        b=cVrA58PeVgdmYbLMWAbf1F3XCl953PYgN8p/DIomB3zRtM4KuslOfAwZYNRJolPoZZ
         FOPBiRplg09fdqoQWrElPTSiBcveOKj8LYjgyGp3fv1Kooi/zP06SZHocBD7gr2dYBLr
         2liHcGPak8J2dbjGjc+ySAYtpv5m4oRxpmASQTuYQDRUDLyDZ3qYi1u0BqXxEs7MEBTd
         MyYyvFoCtf5f9ApoIVyI//nKifvTGpxtwW+ds5U70Hd+qRAklXUyrY+NKMzPA8zXgAsx
         qEQlzmltaJDCTSUdg97puLdiR+pOwFS5iOoUJQMkDL5Jdhn/CK/TANrVo77qmQ3UILLf
         IEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598227; x=1732203027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FnZ9AMjiL+5LBp0zOTics7Ga5/djcimKqH32qBiMpo=;
        b=wLZdvyBfZF4wzsA06gAfBLs3D18OxvrwkSZfktDlPLoel+WS+ktkgHkjHoWEaMg7hR
         IHZa11Yf16/RyivnOVO3QXtevSRcVMioGpwbPl6WuBj3+x6j+2Zs8PS6KfNwG9mU9bbH
         PQlIC5ARfoD76uPFz5YXurkI6zzIj5bQRz325XUlP5t7UUareGUm+eRD0auSMA1QIRwg
         nbVE0ckpA4mTIVxqBG30rZovlVD0hUcBTc1cir0GncdHlKapkYRZgSr9+d4tlzuBaYD+
         32r7C9bdoy/+t3srn3AdXkEZIvM4cTS4A6XtshW5L/wTR8znRHP+FSbOgAsyuSXytFtM
         +iZA==
X-Forwarded-Encrypted: i=1; AJvYcCXUAjisJpyiycEuji0QW4WNQ+wjYnilIX2SKfnnf9LzccIAqJgW9A7l69y0KfEDIMeGwWaTE/J8tSwV9CagwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YytmNIgA8x1e4CDHR5QeZBP5EdJlxhOCaWeExPQ7wmJ9+7DrbIz
	F1qmXuCVakNKF9YB+mSSX5wvXl3PT8ynpEeBlbMHvsebeIjrjLdAUweScyVt6g8=
X-Google-Smtp-Source: AGHT+IG0MhpL2bfsjO7oFhiu1DPNn8UYJ1U5jKc9Ladp8n5xy/VQpNkMetFUYhpz4NXL0lkdlF24CQ==
X-Received: by 2002:a17:906:c9ce:b0:a99:facf:cfc with SMTP id a640c23a62f3a-aa20775759bmr308768466b.17.1731598227138;
        Thu, 14 Nov 2024 07:30:27 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15c9:2500:bb23:40f5:fe29:201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046919sm74063266b.156.2024.11.14.07.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:30:26 -0800 (PST)
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
Subject: [PATCH 4/7] drm/vmwgfx: use the new drm_exec object
Date: Thu, 14 Nov 2024 16:30:17 +0100
Message-Id: <20241114153020.6209-5-christian.koenig@amd.com>
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

Basically just switching over to the new infrastructure like we did for
other drivers as well.

No intentional functional change, but only compile tested.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c | 56 +++++++++++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h | 41 ++--------------
 2 files changed, 59 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
index e7625b3f71e0..34436504fcdb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
@@ -817,6 +817,59 @@ int vmw_validation_preload_res(struct vmw_validation_context *ctx,
 	return 0;
 }
 
+/**
+ * vmw_validation_bo_reserve - Reserve buffer objects registered with a
+ * validation context
+ * @ctx: The validation context
+ * @intr: Perform waits interruptible
+ *
+ * Return: Zero on success, -ERESTARTSYS when interrupted, negative error
+ * code on failure
+ */
+int vmw_validation_bo_reserve(struct vmw_validation_context *ctx, bool intr)
+{
+	struct vmw_validation_bo_node *entry;
+	int ret;
+
+	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT : 0, 0);
+	drm_exec_until_all_locked(&ctx->exec) {
+		list_for_each_entry(entry, &ctx->bo_list, base.head) {
+			ret = drm_exec_prepare_obj(&ctx->exec,
+						   &entry->base.bo->base, 1);
+			drm_exec_retry_on_contention(&ctx->exec);
+			if (ret)
+				goto error;
+		}
+	}
+	return 0;
+
+error:
+	drm_exec_fini(&ctx->exec);
+	return ret;
+}
+
+/**
+ * vmw_validation_bo_fence - Unreserve and fence buffer objects registered
+ * with a validation context
+ * @ctx: The validation context
+ *
+ * This function unreserves the buffer objects previously reserved using
+ * vmw_validation_bo_reserve, and fences them with a fence object.
+ */
+void vmw_validation_bo_fence(struct vmw_validation_context *ctx,
+			     struct vmw_fence_obj *fence)
+{
+	struct vmw_validation_bo_node *entry;
+
+	list_for_each_entry(entry, &ctx->bo_list, base.head) {
+		dma_resv_add_fence(entry->base.bo->base.resv, &fence->base,
+				   DMA_RESV_USAGE_READ);
+	}
+	drm_exec_fini(&ctx->exec);
+}
+
+
+
 /**
  * vmw_validation_bo_backoff - Unreserve buffer objects registered with a
  * validation context
@@ -842,6 +895,5 @@ void vmw_validation_bo_backoff(struct vmw_validation_context *ctx)
 				vmw_bo_dirty_release(vbo);
 		}
 	}
-
-	ttm_eu_backoff_reservation(&ctx->ticket, &ctx->bo_list);
+	drm_exec_fini(&ctx->exec);
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
index 353d837907d8..55a7d8b68d5c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
@@ -31,8 +31,7 @@
 #include <linux/list.h>
 #include <linux/hashtable.h>
 #include <linux/ww_mutex.h>
-
-#include <drm/ttm/ttm_execbuf_util.h>
+#include <drm/drm_exec.h>
 
 #define VMW_RES_DIRTY_NONE 0
 #define VMW_RES_DIRTY_SET BIT(0)
@@ -59,7 +58,7 @@ struct vmw_validation_context {
 	struct list_head resource_ctx_list;
 	struct list_head bo_list;
 	struct list_head page_list;
-	struct ww_acquire_ctx ticket;
+	struct drm_exec exec;
 	struct mutex *res_mutex;
 	unsigned int merge_dups;
 	unsigned int mem_size_left;
@@ -106,39 +105,6 @@ vmw_validation_has_bos(struct vmw_validation_context *ctx)
 	return !list_empty(&ctx->bo_list);
 }
 
-/**
- * vmw_validation_bo_reserve - Reserve buffer objects registered with a
- * validation context
- * @ctx: The validation context
- * @intr: Perform waits interruptible
- *
- * Return: Zero on success, -ERESTARTSYS when interrupted, negative error
- * code on failure
- */
-static inline int
-vmw_validation_bo_reserve(struct vmw_validation_context *ctx,
-			  bool intr)
-{
-	return ttm_eu_reserve_buffers(&ctx->ticket, &ctx->bo_list, intr,
-				      NULL);
-}
-
-/**
- * vmw_validation_bo_fence - Unreserve and fence buffer objects registered
- * with a validation context
- * @ctx: The validation context
- *
- * This function unreserves the buffer objects previously reserved using
- * vmw_validation_bo_reserve, and fences them with a fence object.
- */
-static inline void
-vmw_validation_bo_fence(struct vmw_validation_context *ctx,
-			struct vmw_fence_obj *fence)
-{
-	ttm_eu_fence_buffer_objects(&ctx->ticket, &ctx->bo_list,
-				    (void *) fence);
-}
-
 /**
  * vmw_validation_align - Align a validation memory allocation
  * @val: The size to be aligned
@@ -185,6 +151,9 @@ int vmw_validation_preload_res(struct vmw_validation_context *ctx,
 			       unsigned int size);
 void vmw_validation_res_set_dirty(struct vmw_validation_context *ctx,
 				  void *val_private, u32 dirty);
+int vmw_validation_bo_reserve(struct vmw_validation_context *ctx, bool intr);
+void vmw_validation_bo_fence(struct vmw_validation_context *ctx,
+			     struct vmw_fence_obj *fence);
 void vmw_validation_bo_backoff(struct vmw_validation_context *ctx);
 
 #endif
-- 
2.34.1

