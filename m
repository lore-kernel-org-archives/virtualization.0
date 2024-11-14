Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C8757EA
	for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598229; cv=none; b=ghmL7KUgIuX4iV10EAwPT2XzquxLIrjHDv/gEF+9qmbENB6LaliHH7iixxVXxgaOh4TkDFjQYxdrIKKaWACKexWjVHiIw0MGFXSLEDBRGRpuAljMWhFD1jtPSoEF7lR9pwi1yZflmVzKLnu7g720nkaH9OKZK8n4kQqPsvnm8lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598229; c=relaxed/simple;
	bh=+WOS15RcPTil0M6bvEgoU+gBFbdmiKQSavQ8VItez8Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=My5ISJSgADFAQDowy9JPofgEriNZIQOM1N03rPHDqyR6rRuDnW2XsXkGZVIF10yXM8QwqUyGZ84YKKZJ3scnnEVEYMUVLXXEnz1sSDH4XAKIaQBy81s8Pf1/l7S2sTKB1iWq+APg7tSjjjBA8sh9OSpauKrvMP6Gy7DQBIw7laE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcaryyKa; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcaryyKa"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso104566866b.3
        for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 07:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731598226; x=1732203026; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErkItQWaM7N0kJs1XM7K7VUauKrmuIWKKvWHFPQ8Fxo=;
        b=VcaryyKaVQo+4M3oHk1DCQ7uvhfinmJE9UK+0Urv1n1ngcFbSHHvK0naSd6SOU0vAb
         ue4a6MsFR/QXptvGCZejztxWhjQAbbUl9R+b4v/HXCAgOyjwaWCirA5oBru2G2aekzfQ
         5nuqKC5k6TMVXg28+NRyU7uvU0/BGYoV979Wv4zlxnsC3qBERNSbb9bLyGfg7k+9xO/Z
         ZYg9UthcG0srJl2W4VWjFeVYr308lrdVQubpPw/r8KnnXOswtGXAtdVou3yEmgW6wnWs
         kr5MFYj98FcZr4OS4xZlv44e0xI84G25jf6lB3epufO3oGakOKtc2SAyEue1j3jNb6H9
         DPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598226; x=1732203026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErkItQWaM7N0kJs1XM7K7VUauKrmuIWKKvWHFPQ8Fxo=;
        b=tFOt/9hgqCGCzU2wLq84fVyH1+o1LRVEK3bHX56Ct6x5Bz2jCyLafr6d8nE5xmqFPx
         BbJmKwpRqhZzKub5TGdV28+KPPSBsCH9FVfgTY76SmT1GljWYVPMdAW5zk4pjbqG0mjl
         q5nW8I/ALJX03gHIt6ZlZDwMONPQ5Hi5jR7IXgeL8HNfrZPVTGTT2RZJ3FTIR67aOrVN
         KBOAlSNOs6O4L5/555MYfyM3UwrD7htdasYllkTJyZvz1DOuIuV+MrfwalJgNWMPuvij
         H5OTr1tnd/a28FnsLd+5WASyuz+hFZaz6vlzj34Qm9JXJia6Qldixr7cBlvtKJWlWVY/
         yW2A==
X-Forwarded-Encrypted: i=1; AJvYcCUN1neScyWM546PgMbzZJ5FBeTWg6nnYtyXD5ClpkRTzsMCD9V8KWxvJLWTSLRYivt+gNqmMCvRVsk9J35IMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGSNXXKVuFkjiYxDEktbmSCysLFwJOGDkuSQmRqbGJGjMmWkyQ
	aTXjDKPwy/n515/UkvbKNcZ/h5qlufzbeyIP3tZmLXpRlLHNrBmE
X-Google-Smtp-Source: AGHT+IGKBHvOM3gtxZsaJmGYhSp9T6ZeHIjigD32WAn1nmdVm1JMzdHnWbyDWVbKR4ezf9kLUGd1BQ==
X-Received: by 2002:a17:907:5cb:b0:a9a:1792:f1a with SMTP id a640c23a62f3a-aa1f8043f6amr652788066b.7.1731598226120;
        Thu, 14 Nov 2024 07:30:26 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15c9:2500:bb23:40f5:fe29:201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046919sm74063266b.156.2024.11.14.07.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:30:25 -0800 (PST)
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
Subject: [PATCH 3/7] drm/vmwgfx: start to phase out ttm_exec
Date: Thu, 14 Nov 2024 16:30:16 +0100
Message-Id: <20241114153020.6209-4-christian.koenig@amd.com>
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

Start switching over vmwgfx to drm_exec as well. Replacing some
unnecessary complex calls with just just single BO dma_resv locking.

No intentional functional change, but only compile tested for now.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 49 ++++++++----------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index a73af8a355fb..793293b59d43 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -517,7 +517,7 @@ static int
 vmw_resource_check_buffer(struct ww_acquire_ctx *ticket,
 			  struct vmw_resource *res,
 			  bool interruptible,
-			  struct ttm_validate_buffer *val_buf)
+			  struct ttm_buffer_object **bo)
 {
 	struct ttm_operation_ctx ctx = { true, false };
 	struct list_head val_list;
@@ -532,10 +532,12 @@ vmw_resource_check_buffer(struct ww_acquire_ctx *ticket,
 
 	INIT_LIST_HEAD(&val_list);
 	ttm_bo_get(&res->guest_memory_bo->tbo);
-	val_buf->bo = &res->guest_memory_bo->tbo;
-	val_buf->num_shared = 0;
-	list_add_tail(&val_buf->head, &val_list);
-	ret = ttm_eu_reserve_buffers(ticket, &val_list, interruptible, NULL);
+
+	*bo = &res->guest_memory_bo->tbo;
+	if (ticket)
+		ww_acquire_init(ticket, &reservation_ww_class);
+
+	ret = ttm_bo_reserve(*bo, interruptible, (ticket == NULL), ticket);
 	if (unlikely(ret != 0))
 		goto out_no_reserve;
 
@@ -555,10 +557,11 @@ vmw_resource_check_buffer(struct ww_acquire_ctx *ticket,
 	return 0;
 
 out_no_validate:
-	ttm_eu_backoff_reservation(ticket, &val_list);
+	dma_resv_unlock((*bo)->base.resv);
+	if (ticket)
+		ww_acquire_fini(ticket);
 out_no_reserve:
-	ttm_bo_put(val_buf->bo);
-	val_buf->bo = NULL;
+	ttm_bo_put(*bo);
 	if (guest_memory_dirty)
 		vmw_user_bo_unref(&res->guest_memory_bo);
 
@@ -600,29 +603,6 @@ int vmw_resource_reserve(struct vmw_resource *res, bool interruptible,
 	return 0;
 }
 
-/**
- * vmw_resource_backoff_reservation - Unreserve and unreference a
- *                                    guest memory buffer
- *.
- * @ticket:         The ww acquire ctx used for reservation.
- * @val_buf:        Guest memory buffer information.
- */
-static void
-vmw_resource_backoff_reservation(struct ww_acquire_ctx *ticket,
-				 struct ttm_validate_buffer *val_buf)
-{
-	struct list_head val_list;
-
-	if (likely(val_buf->bo == NULL))
-		return;
-
-	INIT_LIST_HEAD(&val_list);
-	list_add_tail(&val_buf->head, &val_list);
-	ttm_eu_backoff_reservation(ticket, &val_list);
-	ttm_bo_put(val_buf->bo);
-	val_buf->bo = NULL;
-}
-
 /**
  * vmw_resource_do_evict - Evict a resource, and transfer its data
  *                         to a backup buffer.
@@ -642,7 +622,7 @@ static int vmw_resource_do_evict(struct ww_acquire_ctx *ticket,
 
 	val_buf.bo = NULL;
 	val_buf.num_shared = 0;
-	ret = vmw_resource_check_buffer(ticket, res, interruptible, &val_buf);
+	ret = vmw_resource_check_buffer(ticket, res, interruptible, &val_buf.bo);
 	if (unlikely(ret != 0))
 		return ret;
 
@@ -657,7 +637,10 @@ static int vmw_resource_do_evict(struct ww_acquire_ctx *ticket,
 	res->guest_memory_dirty = true;
 	res->res_dirty = false;
 out_no_unbind:
-	vmw_resource_backoff_reservation(ticket, &val_buf);
+	dma_resv_unlock(val_buf.bo->base.resv);
+	if (ticket)
+		ww_acquire_fini(ticket);
+	ttm_bo_put(val_buf.bo);
 
 	return ret;
 }
-- 
2.34.1

