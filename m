Return-Path: <SRS0=YToA=IC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F37C433E9
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 15:14:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1697B64F8C
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 15:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1697B64F8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E26126F543;
	Thu,  4 Mar 2021 15:14:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PTPgC5PN7AZW; Thu,  4 Mar 2021 15:14:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 586296F558;
	Thu,  4 Mar 2021 15:14:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42015C000B;
	Thu,  4 Mar 2021 15:14:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6F9DC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 15:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4A754325D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 15:14:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="SVWS5Bol";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="cLdq3aFs"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id djUhmPUlu5VC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 15:14:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 91DCD43257
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 15:14:11 +0000 (UTC)
Message-Id: <20210303132711.754979779@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1614870849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=9faHMiVNywi4bTvkQWsVt6JBdbgbuuop7i9PAkb1cms=;
 b=SVWS5Bolf5CbdytCwu1g8bpTWgjuGONk/1VvoNwioM0r2jP2mzpDCzTlalsnz/mJOYDNoU
 xsnVCuWb4XBOyyhedwfgM9RWywj9Qax2o4rQIMUDt7LVMcTIP3DxHFTwB1p3GEy6oSxI0T
 V9KMagRFL9ukycpqQxG6d8PG1LKrYj5FW3Ev5X62zBdF/X5ssjfOYcqasHBYGAXOqfM5YT
 Q9Ojyqx4JFIJC0D6MvFxaZMFkLnEiuINYcJqf19B38N6zPs1TW96JJOPlgn7JTmx7/8BwV
 qTkwfWwuNLCCX6aZ+R/X6D1CZVdX1+TrzufT4hq34parLO/hrcR+iAvR+21XKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1614870849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=9faHMiVNywi4bTvkQWsVt6JBdbgbuuop7i9PAkb1cms=;
 b=cLdq3aFswHqDjXNn0aTKV7h/d8u13KzZkkxyaFKX8IT3A45rlMfbQ+7AzSIcaXaIQEwr/m
 FoS0nqDw2VyG2qCw==
Date: Wed, 03 Mar 2021 14:20:27 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 4/7] drm/qxl: Replace io_mapping_map_atomic_wc()
References: <20210303132023.077167457@linutronix.de>
MIME-Version: 1.0
Cc: Jani Nikula <jani.nikula@linux.intel.com>, David Airlie <airlied@linux.ie>,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Roland Scheidegger <sroland@vmware.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Huang Rui <ray.huang@amd.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 spice-devel@lists.freedesktop.org, Andrew Morton <akpm@linux-foundation.org>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Christian Koenig <christian.koenig@amd.com>, Zack Rusin <zackr@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>
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

From: Thomas Gleixner <tglx@linutronix.de>

None of these mapping requires the side effect of disabling pagefaults and
preemption.

Use io_mapping_map_local_wc() instead, rename the related functions
accordingly and clean up qxl_process_single_command() to use a plain
copy_from_user() as the local maps are not disabling pagefaults.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: virtualization@lists.linux-foundation.org
Cc: spice-devel@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/qxl/qxl_image.c   |   18 +++++++++---------
 drivers/gpu/drm/qxl/qxl_ioctl.c   |   27 +++++++++++++--------------
 drivers/gpu/drm/qxl/qxl_object.c  |   12 ++++++------
 drivers/gpu/drm/qxl/qxl_object.h  |    4 ++--
 drivers/gpu/drm/qxl/qxl_release.c |    4 ++--
 5 files changed, 32 insertions(+), 33 deletions(-)

--- a/drivers/gpu/drm/qxl/qxl_image.c
+++ b/drivers/gpu/drm/qxl/qxl_image.c
@@ -124,12 +124,12 @@ qxl_image_init_helper(struct qxl_device
 				  wrong (check the bitmaps are sent correctly
 				  first) */
 
-	ptr = qxl_bo_kmap_atomic_page(qdev, chunk_bo, 0);
+	ptr = qxl_bo_kmap_local_page(qdev, chunk_bo, 0);
 	chunk = ptr;
 	chunk->data_size = height * chunk_stride;
 	chunk->prev_chunk = 0;
 	chunk->next_chunk = 0;
-	qxl_bo_kunmap_atomic_page(qdev, chunk_bo, ptr);
+	qxl_bo_kunmap_local_page(qdev, chunk_bo, ptr);
 
 	{
 		void *k_data, *i_data;
@@ -143,7 +143,7 @@ qxl_image_init_helper(struct qxl_device
 			i_data = (void *)data;
 
 			while (remain > 0) {
-				ptr = qxl_bo_kmap_atomic_page(qdev, chunk_bo, page << PAGE_SHIFT);
+				ptr = qxl_bo_kmap_local_page(qdev, chunk_bo, page << PAGE_SHIFT);
 
 				if (page == 0) {
 					chunk = ptr;
@@ -157,7 +157,7 @@ qxl_image_init_helper(struct qxl_device
 
 				memcpy(k_data, i_data, size);
 
-				qxl_bo_kunmap_atomic_page(qdev, chunk_bo, ptr);
+				qxl_bo_kunmap_local_page(qdev, chunk_bo, ptr);
 				i_data += size;
 				remain -= size;
 				page++;
@@ -175,10 +175,10 @@ qxl_image_init_helper(struct qxl_device
 					page_offset = offset_in_page(out_offset);
 					size = min((int)(PAGE_SIZE - page_offset), remain);
 
-					ptr = qxl_bo_kmap_atomic_page(qdev, chunk_bo, page_base);
+					ptr = qxl_bo_kmap_local_page(qdev, chunk_bo, page_base);
 					k_data = ptr + page_offset;
 					memcpy(k_data, i_data, size);
-					qxl_bo_kunmap_atomic_page(qdev, chunk_bo, ptr);
+					qxl_bo_kunmap_local_page(qdev, chunk_bo, ptr);
 					remain -= size;
 					i_data += size;
 					out_offset += size;
@@ -189,7 +189,7 @@ qxl_image_init_helper(struct qxl_device
 	qxl_bo_kunmap(chunk_bo);
 
 	image_bo = dimage->bo;
-	ptr = qxl_bo_kmap_atomic_page(qdev, image_bo, 0);
+	ptr = qxl_bo_kmap_local_page(qdev, image_bo, 0);
 	image = ptr;
 
 	image->descriptor.id = 0;
@@ -212,7 +212,7 @@ qxl_image_init_helper(struct qxl_device
 		break;
 	default:
 		DRM_ERROR("unsupported image bit depth\n");
-		qxl_bo_kunmap_atomic_page(qdev, image_bo, ptr);
+		qxl_bo_kunmap_local_page(qdev, image_bo, ptr);
 		return -EINVAL;
 	}
 	image->u.bitmap.flags = QXL_BITMAP_TOP_DOWN;
@@ -222,7 +222,7 @@ qxl_image_init_helper(struct qxl_device
 	image->u.bitmap.palette = 0;
 	image->u.bitmap.data = qxl_bo_physical_address(qdev, chunk_bo, 0);
 
-	qxl_bo_kunmap_atomic_page(qdev, image_bo, ptr);
+	qxl_bo_kunmap_local_page(qdev, image_bo, ptr);
 
 	return 0;
 }
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -89,11 +89,11 @@ apply_reloc(struct qxl_device *qdev, str
 {
 	void *reloc_page;
 
-	reloc_page = qxl_bo_kmap_atomic_page(qdev, info->dst_bo, info->dst_offset & PAGE_MASK);
+	reloc_page = qxl_bo_kmap_local_page(qdev, info->dst_bo, info->dst_offset & PAGE_MASK);
 	*(uint64_t *)(reloc_page + (info->dst_offset & ~PAGE_MASK)) = qxl_bo_physical_address(qdev,
 											      info->src_bo,
 											      info->src_offset);
-	qxl_bo_kunmap_atomic_page(qdev, info->dst_bo, reloc_page);
+	qxl_bo_kunmap_local_page(qdev, info->dst_bo, reloc_page);
 }
 
 static void
@@ -105,9 +105,9 @@ apply_surf_reloc(struct qxl_device *qdev
 	if (info->src_bo && !info->src_bo->is_primary)
 		id = info->src_bo->surface_id;
 
-	reloc_page = qxl_bo_kmap_atomic_page(qdev, info->dst_bo, info->dst_offset & PAGE_MASK);
+	reloc_page = qxl_bo_kmap_local_page(qdev, info->dst_bo, info->dst_offset & PAGE_MASK);
 	*(uint32_t *)(reloc_page + (info->dst_offset & ~PAGE_MASK)) = id;
-	qxl_bo_kunmap_atomic_page(qdev, info->dst_bo, reloc_page);
+	qxl_bo_kunmap_local_page(qdev, info->dst_bo, reloc_page);
 }
 
 /* return holding the reference to this object */
@@ -149,7 +149,6 @@ static int qxl_process_single_command(st
 	struct qxl_bo *cmd_bo;
 	void *fb_cmd;
 	int i, ret, num_relocs;
-	int unwritten;
 
 	switch (cmd->type) {
 	case QXL_CMD_DRAW:
@@ -184,21 +183,21 @@ static int qxl_process_single_command(st
 		goto out_free_reloc;
 
 	/* TODO copy slow path code from i915 */
-	fb_cmd = qxl_bo_kmap_atomic_page(qdev, cmd_bo, (release->release_offset & PAGE_MASK));
-	unwritten = __copy_from_user_inatomic_nocache
-		(fb_cmd + sizeof(union qxl_release_info) + (release->release_offset & ~PAGE_MASK),
-		 u64_to_user_ptr(cmd->command), cmd->command_size);
+	fb_cmd = qxl_bo_kmap_local_page(qdev, cmd_bo, (release->release_offset & PAGE_MASK));
 
-	{
+	if (copy_from_user(fb_cmd + sizeof(union qxl_release_info) +
+			   (release->release_offset & ~PAGE_MASK),
+			   u64_to_user_ptr(cmd->command), cmd->command_size)) {
+		ret = -EFAULT;
+	} else {
 		struct qxl_drawable *draw = fb_cmd;
 
 		draw->mm_time = qdev->rom->mm_clock;
 	}
 
-	qxl_bo_kunmap_atomic_page(qdev, cmd_bo, fb_cmd);
-	if (unwritten) {
-		DRM_ERROR("got unwritten %d\n", unwritten);
-		ret = -EFAULT;
+	qxl_bo_kunmap_local_page(qdev, cmd_bo, fb_cmd);
+	if (ret) {
+		DRM_ERROR("copy from user failed %d\n", ret);
 		goto out_free_release;
 	}
 
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -178,8 +178,8 @@ int qxl_bo_kmap(struct qxl_bo *bo, struc
 	return 0;
 }
 
-void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
-			      struct qxl_bo *bo, int page_offset)
+void *qxl_bo_kmap_local_page(struct qxl_device *qdev,
+			     struct qxl_bo *bo, int page_offset)
 {
 	unsigned long offset;
 	void *rptr;
@@ -195,7 +195,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl
 		goto fallback;
 
 	offset = bo->tbo.mem.start << PAGE_SHIFT;
-	return io_mapping_map_atomic_wc(map, offset + page_offset);
+	return io_mapping_map_local_wc(map, offset + page_offset);
 fallback:
 	if (bo->kptr) {
 		rptr = bo->kptr + (page_offset * PAGE_SIZE);
@@ -222,14 +222,14 @@ void qxl_bo_kunmap(struct qxl_bo *bo)
 	ttm_bo_vunmap(&bo->tbo, &bo->map);
 }
 
-void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev,
-			       struct qxl_bo *bo, void *pmap)
+void qxl_bo_kunmap_local_page(struct qxl_device *qdev,
+			      struct qxl_bo *bo, void *pmap)
 {
 	if ((bo->tbo.mem.mem_type != TTM_PL_VRAM) &&
 	    (bo->tbo.mem.mem_type != TTM_PL_PRIV))
 		goto fallback;
 
-	io_mapping_unmap_atomic(pmap);
+	io_mapping_unmap_local(pmap);
 	return;
  fallback:
 	qxl_bo_kunmap(bo);
--- a/drivers/gpu/drm/qxl/qxl_object.h
+++ b/drivers/gpu/drm/qxl/qxl_object.h
@@ -65,8 +65,8 @@ extern int qxl_bo_create(struct qxl_devi
 			 struct qxl_bo **bo_ptr);
 extern int qxl_bo_kmap(struct qxl_bo *bo, struct dma_buf_map *map);
 extern void qxl_bo_kunmap(struct qxl_bo *bo);
-void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, int page_offset);
-void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, void *map);
+void *qxl_bo_kmap_local_page(struct qxl_device *qdev, struct qxl_bo *bo, int page_offset);
+void qxl_bo_kunmap_local_page(struct qxl_device *qdev, struct qxl_bo *bo, void *map);
 extern struct qxl_bo *qxl_bo_ref(struct qxl_bo *bo);
 extern void qxl_bo_unref(struct qxl_bo **bo);
 extern int qxl_bo_pin(struct qxl_bo *bo);
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -408,7 +408,7 @@ union qxl_release_info *qxl_release_map(
 	union qxl_release_info *info;
 	struct qxl_bo *bo = release->release_bo;
 
-	ptr = qxl_bo_kmap_atomic_page(qdev, bo, release->release_offset & PAGE_MASK);
+	ptr = qxl_bo_kmap_local_page(qdev, bo, release->release_offset & PAGE_MASK);
 	if (!ptr)
 		return NULL;
 	info = ptr + (release->release_offset & ~PAGE_MASK);
@@ -423,7 +423,7 @@ void qxl_release_unmap(struct qxl_device
 	void *ptr;
 
 	ptr = ((void *)info) - (release->release_offset & ~PAGE_MASK);
-	qxl_bo_kunmap_atomic_page(qdev, bo, ptr);
+	qxl_bo_kunmap_local_page(qdev, bo, ptr);
 }
 
 void qxl_release_fence_buffer_objects(struct qxl_release *release)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
