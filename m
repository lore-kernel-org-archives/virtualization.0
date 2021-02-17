Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4239EC43381
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 12:32:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D5064E33
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 12:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D5064E33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CC986860CD;
	Wed, 17 Feb 2021 12:32:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oiTuAHD_eWjL; Wed, 17 Feb 2021 12:32:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 89B4D860D5;
	Wed, 17 Feb 2021 12:32:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FE58C0FA7;
	Wed, 17 Feb 2021 12:32:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B9C8C0174
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4B4A286031
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XfcKDqgJ6Vdt
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:32:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0C86C85F9B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613565145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cm+TgTCRLqgxuDXp60PtUWcfAhbPbVmCNZ6ALjZFNag=;
 b=NTZ5VFU4cg7ezuK55TKKmgqv4lggCBxdQGiKmPBeoNI98NoQ8mHEbN7fRtdJcKUHG1kEHc
 jF0tdAHOHZ/NPI/Z9asZeEv3VWrW3msveS5Zo6m91dPQRBQEDRJwc2p5eirkjR3AaW+K16
 3zv0oXo/3rzuU0yLF9TooJUCeUfKlWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-9MLNAtiMNKSfE7Uy6JwkGw-1; Wed, 17 Feb 2021 07:32:21 -0500
X-MC-Unique: 9MLNAtiMNKSfE7Uy6JwkGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1446F80196E;
 Wed, 17 Feb 2021 12:32:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-184.ams2.redhat.com
 [10.36.114.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A3AD5D9C0;
 Wed, 17 Feb 2021 12:32:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6A92918003B6; Wed, 17 Feb 2021 13:32:14 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v2 05/11] drm/qxl: rename qxl_bo_kmap -> qxl_bo_vmap_locked
Date: Wed, 17 Feb 2021 13:32:07 +0100
Message-Id: <20210217123213.2199186-6-kraxel@redhat.com>
In-Reply-To: <20210217123213.2199186-1-kraxel@redhat.com>
References: <20210217123213.2199186-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Append _locked to Make clear that these functions should be called with
reserved bo's only.  While being at it also rename kmap -> vmap.

No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_object.h  |  4 ++--
 drivers/gpu/drm/qxl/qxl_display.c | 14 +++++++-------
 drivers/gpu/drm/qxl/qxl_draw.c    |  8 ++++----
 drivers/gpu/drm/qxl/qxl_image.c   |  2 +-
 drivers/gpu/drm/qxl/qxl_object.c  |  8 ++++----
 drivers/gpu/drm/qxl/qxl_prime.c   |  4 ++--
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_object.h b/drivers/gpu/drm/qxl/qxl_object.h
index dc1659e717f1..2495e5cdf353 100644
--- a/drivers/gpu/drm/qxl/qxl_object.h
+++ b/drivers/gpu/drm/qxl/qxl_object.h
@@ -64,8 +64,8 @@ extern int qxl_bo_create(struct qxl_device *qdev,
 			 u32 priority,
 			 struct qxl_surface *surf,
 			 struct qxl_bo **bo_ptr);
-extern int qxl_bo_kmap(struct qxl_bo *bo, struct dma_buf_map *map);
-extern void qxl_bo_kunmap(struct qxl_bo *bo);
+int qxl_bo_vmap_locked(struct qxl_bo *bo, struct dma_buf_map *map);
+void qxl_bo_vunmap_locked(struct qxl_bo *bo);
 void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, int page_offset);
 void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, void *map);
 extern struct qxl_bo *qxl_bo_ref(struct qxl_bo *bo);
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index a1b5cc5918bc..bfcc93089a94 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -600,7 +600,7 @@ static void qxl_cursor_atomic_update(struct drm_plane *plane,
 		user_bo = gem_to_qxl_bo(obj);
 
 		/* pinning is done in the prepare/cleanup framevbuffer */
-		ret = qxl_bo_kmap(user_bo, &user_map);
+		ret = qxl_bo_vmap_locked(user_bo, &user_map);
 		if (ret)
 			goto out_free_release;
 		user_ptr = user_map.vaddr; /* TODO: Use mapping abstraction properly */
@@ -619,7 +619,7 @@ static void qxl_cursor_atomic_update(struct drm_plane *plane,
 		if (ret)
 			goto out_unpin;
 
-		ret = qxl_bo_kmap(cursor_bo, &cursor_map);
+		ret = qxl_bo_vmap_locked(cursor_bo, &cursor_map);
 		if (ret)
 			goto out_backoff;
 		if (cursor_map.is_iomem) /* TODO: Use mapping abstraction properly */
@@ -638,8 +638,8 @@ static void qxl_cursor_atomic_update(struct drm_plane *plane,
 		cursor->chunk.prev_chunk = 0;
 		cursor->chunk.data_size = size;
 		memcpy(cursor->chunk.data, user_ptr, size);
-		qxl_bo_kunmap(cursor_bo);
-		qxl_bo_kunmap(user_bo);
+		qxl_bo_vunmap_locked(cursor_bo);
+		qxl_bo_vunmap_locked(user_bo);
 
 		cmd = (struct qxl_cursor_cmd *) qxl_release_map(qdev, release);
 		cmd->u.set.visible = 1;
@@ -681,7 +681,7 @@ static void qxl_cursor_atomic_update(struct drm_plane *plane,
 out_free_bo:
 	qxl_bo_unref(&cursor_bo);
 out_kunmap:
-	qxl_bo_kunmap(user_bo);
+	qxl_bo_vunmap_locked(user_bo);
 out_free_release:
 	qxl_release_free(qdev, release);
 	return;
@@ -1163,7 +1163,7 @@ int qxl_create_monitors_object(struct qxl_device *qdev)
 	if (ret)
 		return ret;
 
-	qxl_bo_kmap(qdev->monitors_config_bo, &map);
+	qxl_bo_vmap_locked(qdev->monitors_config_bo, &map);
 
 	qdev->monitors_config = qdev->monitors_config_bo->kptr;
 	qdev->ram_header->monitors_config =
@@ -1189,7 +1189,7 @@ int qxl_destroy_monitors_object(struct qxl_device *qdev)
 	qdev->monitors_config = NULL;
 	qdev->ram_header->monitors_config = 0;
 
-	qxl_bo_kunmap(qdev->monitors_config_bo);
+	qxl_bo_vunmap_locked(qdev->monitors_config_bo);
 	ret = qxl_bo_unpin(qdev->monitors_config_bo);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index 7b7acb910780..7d27891e87fa 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -48,7 +48,7 @@ static struct qxl_rect *drawable_set_clipping(struct qxl_device *qdev,
 	struct qxl_clip_rects *dev_clips;
 	int ret;
 
-	ret = qxl_bo_kmap(clips_bo, &map);
+	ret = qxl_bo_vmap_locked(clips_bo, &map);
 	if (ret)
 		return NULL;
 	dev_clips = map.vaddr; /* TODO: Use mapping abstraction properly */
@@ -202,7 +202,7 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 	if (ret)
 		goto out_release_backoff;
 
-	ret = qxl_bo_kmap(bo, &surface_map);
+	ret = qxl_bo_vmap_locked(bo, &surface_map);
 	if (ret)
 		goto out_release_backoff;
 	surface_base = surface_map.vaddr; /* TODO: Use mapping abstraction properly */
@@ -210,7 +210,7 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 	ret = qxl_image_init(qdev, release, dimage, surface_base,
 			     left - dumb_shadow_offset,
 			     top, width, height, depth, stride);
-	qxl_bo_kunmap(bo);
+	qxl_bo_vunmap_locked(bo);
 	if (ret)
 		goto out_release_backoff;
 
@@ -247,7 +247,7 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		rects[i].top    = clips_ptr->y1;
 		rects[i].bottom = clips_ptr->y2;
 	}
-	qxl_bo_kunmap(clips_bo);
+	qxl_bo_vunmap_locked(clips_bo);
 
 	qxl_release_fence_buffer_objects(release);
 	qxl_push_command_ring_release(qdev, release, QXL_CMD_DRAW, false);
diff --git a/drivers/gpu/drm/qxl/qxl_image.c b/drivers/gpu/drm/qxl/qxl_image.c
index 60ab7151b84d..ffff54e5fb31 100644
--- a/drivers/gpu/drm/qxl/qxl_image.c
+++ b/drivers/gpu/drm/qxl/qxl_image.c
@@ -186,7 +186,7 @@ qxl_image_init_helper(struct qxl_device *qdev,
 			}
 		}
 	}
-	qxl_bo_kunmap(chunk_bo);
+	qxl_bo_vunmap_locked(chunk_bo);
 
 	image_bo = dimage->bo;
 	ptr = qxl_bo_kmap_atomic_page(qdev, image_bo, 0);
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 7eada4ad217b..f4a015381a7f 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -155,7 +155,7 @@ int qxl_bo_create(struct qxl_device *qdev, unsigned long size,
 	return 0;
 }
 
-int qxl_bo_kmap(struct qxl_bo *bo, struct dma_buf_map *map)
+int qxl_bo_vmap_locked(struct qxl_bo *bo, struct dma_buf_map *map)
 {
 	int r;
 
@@ -203,7 +203,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
 		return rptr;
 	}
 
-	ret = qxl_bo_kmap(bo, &bo_map);
+	ret = qxl_bo_vmap_locked(bo, &bo_map);
 	if (ret)
 		return NULL;
 	rptr = bo_map.vaddr; /* TODO: Use mapping abstraction properly */
@@ -212,7 +212,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
 	return rptr;
 }
 
-void qxl_bo_kunmap(struct qxl_bo *bo)
+void qxl_bo_vunmap_locked(struct qxl_bo *bo)
 {
 	if (bo->kptr == NULL)
 		return;
@@ -233,7 +233,7 @@ void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev,
 	io_mapping_unmap_atomic(pmap);
 	return;
  fallback:
-	qxl_bo_kunmap(bo);
+	qxl_bo_vunmap_locked(bo);
 }
 
 void qxl_bo_unref(struct qxl_bo **bo)
diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
index 4aa949799446..2bebe662516f 100644
--- a/drivers/gpu/drm/qxl/qxl_prime.c
+++ b/drivers/gpu/drm/qxl/qxl_prime.c
@@ -59,7 +59,7 @@ int qxl_gem_prime_vmap(struct drm_gem_object *obj, struct dma_buf_map *map)
 	struct qxl_bo *bo = gem_to_qxl_bo(obj);
 	int ret;
 
-	ret = qxl_bo_kmap(bo, map);
+	ret = qxl_bo_vmap_locked(bo, map);
 	if (ret < 0)
 		return ret;
 
@@ -71,7 +71,7 @@ void qxl_gem_prime_vunmap(struct drm_gem_object *obj,
 {
 	struct qxl_bo *bo = gem_to_qxl_bo(obj);
 
-	qxl_bo_kunmap(bo);
+	qxl_bo_vunmap_locked(bo);
 }
 
 int qxl_gem_prime_mmap(struct drm_gem_object *obj,
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
