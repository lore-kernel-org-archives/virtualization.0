Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040F1AACA
	for <virtualization@lists.linux.dev>; Sat, 21 Sep 2024 04:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726893265; cv=none; b=sINZY0RzkKC98ZUZqUc2Yk1uai79Nu7o7AKJ+cFzmfrW7mEX7KU9DXAEP/2ZwklowEpVR58asV93aBGwZTQEd+BA6FAcv5VMVjrJId5Q6H2WIsT37fKk/mCa8tssTJoMx8Exm/QpD1dy84prZOY7oJY9H9oVe5p4AWo2wxkdGIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726893265; c=relaxed/simple;
	bh=bDTEvs8SsdpoLN8/0ClgovHb3RFG5NBpjV+h6caYg7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZONbcWSkX+y9dYOQl8QZIaTxFo5uIeWOqcoJBYfD3F5dTqza2M2/Lt8soXhBzk8+WP1fKDP1N8WW8rPozMn99V9DrvZpwl2tlAHgoI282/l9rTWf4IIZ0A2pdPZakM/wFgjgKq0kBHeLCCcxtZxi1gOlGwA1vbqIrjx0e5KRdMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUayT5iF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUayT5iF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726893260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C0z6Sb5fFur+ylNHIooBTsj9Bys2mwJimPVZZ/ZmZvk=;
	b=YUayT5iF79WHVaJE+hSrs4rzSmsyWywUr02kAhCxBlBmUiVC3c2bRnk/9mQyz/0UG15Epj
	7MUEeg1Roq2Os82cD7P2VYYTDTkC6+henYznObfxGEbkTpzUcx4aJlwYHeox4JSLqQFeYC
	w79oWMnUVjzCdDAYsg7qwQRWj2IaBA4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-5x6x8hBjN9q4g0udksKJFQ-1; Sat, 21 Sep 2024 00:34:19 -0400
X-MC-Unique: 5x6x8hBjN9q4g0udksKJFQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d9a2b8af50so3273529a91.0
        for <virtualization@lists.linux.dev>; Fri, 20 Sep 2024 21:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726893258; x=1727498058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0z6Sb5fFur+ylNHIooBTsj9Bys2mwJimPVZZ/ZmZvk=;
        b=IURmkYhflj8aH6ZYpDq+HOBqj8OHJlbWRgxKHSSLVuYpinMSudOhXWBgXC/zXvKR+U
         Bi12Xv+q2Kht882YaG26jIV98CW7VHdomefKI1kqNITMz6Oi27ZCdWfnEqDrGUQuDqOM
         pFEOXa8daIAkOaqF3wXrw5fhkosOw1XqclAuwbo1HrcJSPnmVg2t7jqg3h16arDDew7X
         DTr62fLVDU/Nyw5jzMmkNR5iGRYIM8rhgAKt1rkCDbrKpSdqvdcRqJ7Dked7WIdk8EWk
         KeMhJkelJLI1ihJlLvwm1p2TR5HuwNIG0B2ckPbwZJuHXXBu2OhsMtHrpavXgdswNY3g
         m0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzevZpPq8pgPMvBrtlXlv2WGvcWKgNkcjSpTqB+dR/kIiO47Qcns67XvTs0HM6dYY/pphl/5sBZL1ceNQCxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfVuQG1dknesNvzr+CBfD+lFObfCvlUgRF8MxYj8y+riO9e+cT
	ftONBZ80AZ0KKf6mdqI8/4+ikZhNhsBF95Og6TrNc/4lyE8jGue9XIK1xTRFRbJeGYw5a0UFFL1
	ko8KMj5/0AEW9Uxfo51dZBUnCtuHNvcnKfT/exiCGOBdHTq5sXq6zx+bz/N1LowLQ
X-Received: by 2002:a17:90b:4a92:b0:2d8:e5a3:f6a5 with SMTP id 98e67ed59e1d1-2dd7f3f8034mr6931368a91.13.1726893258077;
        Fri, 20 Sep 2024 21:34:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOHSimN8iyKxM6/7En92MqN7e90NOtY9w4nPYlL236F8TaZ2q/H4u5Y3LeNythQSMbQMYZQw==
X-Received: by 2002:a17:90b:4a92:b0:2d8:e5a3:f6a5 with SMTP id 98e67ed59e1d1-2dd7f3f8034mr6931351a91.13.1726893257633;
        Fri, 20 Sep 2024 21:34:17 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f93b64fsm2861613a91.46.2024.09.20.21.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 21:34:17 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: airlied@redhat.com,
	kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	daniel@ffwll.ch,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3] drm/qxl: Add drm_panic support
Date: Sat, 21 Sep 2024 13:33:50 +0900
Message-ID: <20240921043352.917266-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

QXL supports the drm_panic module, which displays a message to the
screen when a kernel panic occurs.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
v3
Adjust function's arguments indentation. Discussion v2 patch is in [2]

[2] https://lore.kernel.org/lkml/20240919071230.840994-1-ryasuoka@redhat.com/T/

v2
In [1], Jocelyn gives me feedbacks and fix them.
1. Removing qxl_surface_evict(): It takes a mutex and it possibly
causes deadlock in panic handler. As the panic handler works
correctly without it and to make it simple, I remove it.
2. Update qxl_panic_ttm_bo_destory(): It deleted bo->list with taking
mutex but it does not need to call because this list is not updated in
panic handler.
3. Remove unnecessary args from panic functions: Some panic functions
always take same values as args (e.g. kernel, pinned, domain etc in
qxl_panic_bo_create()). So I remove them from panic functions and
define them in each function.

[1] https://lore.kernel.org/dri-devel/89b55f6f-f462-4e84-b2e2-7f2edc0f1cc4@redhat.com/T/#t

 drivers/gpu/drm/qxl/qxl_cmd.c     | 29 ++++++++++
 drivers/gpu/drm/qxl/qxl_display.c | 94 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/qxl/qxl_draw.c    | 61 +++++++++++++++++++-
 drivers/gpu/drm/qxl/qxl_drv.h     | 24 ++++++++
 drivers/gpu/drm/qxl/qxl_gem.c     |  9 +++
 drivers/gpu/drm/qxl/qxl_image.c   | 26 +++++++++
 drivers/gpu/drm/qxl/qxl_object.c  | 46 +++++++++++++++
 drivers/gpu/drm/qxl/qxl_object.h  |  1 +
 8 files changed, 287 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index d6ea01f3797b..a3dd2ed4d9c7 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -174,6 +174,35 @@ static bool qxl_ring_pop(struct qxl_ring *ring,
 	return true;
 }
 
+/* For drm panic */
+int
+qxl_push_command_ring_without_release(struct qxl_device *qdev,
+				      struct qxl_bo *bo, uint32_t offset)
+{
+	struct qxl_command cmd;
+	struct qxl_ring *ring = qdev->command_ring;
+	struct qxl_ring_header *header = &(ring->ring->header);
+	uint8_t *elt;
+	int idx;
+
+	cmd.type = QXL_CMD_DRAW;
+	cmd.data = qxl_bo_physical_address(qdev, bo, offset);
+
+	idx = header->prod & (ring->n_elements - 1);
+	elt = ring->ring->elements + idx * ring->element_size;
+
+	memcpy((void *)elt, &cmd, ring->element_size);
+
+	header->prod++;
+
+	mb();
+
+	if (header->prod == header->notify_on_prod)
+		outb(0, ring->prod_notify);
+
+	return 0;
+}
+
 int
 qxl_push_command_ring_release(struct qxl_device *qdev, struct qxl_release *release,
 			      uint32_t type, bool interruptible)
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index bc24af08dfcd..1380ef7c9ae8 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -37,6 +37,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_panic.h>
 
 #include "qxl_drv.h"
 #include "qxl_object.h"
@@ -889,6 +890,97 @@ static void qxl_plane_cleanup_fb(struct drm_plane *plane,
 	}
 }
 
+static int qxl_primary_plane_helper_get_scanout_buffer(struct drm_plane *plane,
+						       struct drm_scanout_buffer *sb)
+{
+	struct qxl_bo *bo;
+
+	if (!plane->state || !plane->state->fb)
+		return -ENODEV;
+
+	bo = gem_to_qxl_bo(plane->state->fb->obj[0]);
+
+	if (!bo->map.vaddr) {
+		int ret;
+
+		ret = qxl_bo_pin_and_vmap(bo, &sb->map[0]);
+		if (ret)
+			return ret;
+	} else {
+		iosys_map_set_vaddr(&sb->map[0], bo->map.vaddr);
+	}
+
+	sb->format = plane->state->fb->format;
+	sb->height = plane->state->fb->height;
+	sb->width = plane->state->fb->width;
+	sb->pitch[0] = plane->state->fb->pitches[0];
+	return 0;
+}
+
+static void qxl_panic_flush(struct drm_plane *plane)
+{
+	struct qxl_device *qdev = to_qxl(plane->dev);
+	struct qxl_bo *_bo = gem_to_qxl_bo(plane->state->fb->obj[0]);
+	uint8_t *surface_base = _bo->map.vaddr;
+	struct drm_clip_rect rect = {
+		.x1 = 0,
+		.y1 = 0,
+		.x2 = plane->state->fb->width,
+		.y2 = plane->state->fb->height
+	};
+	unsigned int num_clips = 1;
+	struct qxl_bo clips_bo = {};
+	struct qxl_bo image_bo = {};
+	struct qxl_bo chunk_bo = {};
+	struct qxl_drm_image dimage;
+	struct qxl_drm_chunk chunk;
+	int width = rect.x2;
+	int height = rect.y2;
+	int stride = plane->state->fb->pitches[0];
+	int depth = plane->state->fb->format->cpp[0] * 8;
+	struct qxl_rect *rects;
+	struct qxl_rect drawable_rect = {
+		.left = 0,
+		.right = width,
+		.top = 0,
+		.bottom = height,
+	};
+	int cur_idx = 0;
+	int size = 256;
+	struct qxl_bo *bo = qxl_bo_ref(qdev->current_release_bo[cur_idx]);
+	uint32_t offset = qdev->current_release_bo_offset[cur_idx] * size;
+	int ret;
+
+	qxl_panic_bo_create(qdev, sizeof(struct qxl_clip_rects) + sizeof(struct qxl_rect),
+			    &clips_bo);
+
+	ret = qxl_image_alloc_objects_without_release(qdev, &dimage, &chunk, &image_bo, &chunk_bo,
+						      surface_base, width, height, depth, stride);
+	if (ret)
+		return;
+
+	ret = make_drawable_without_release(qdev, &drawable_rect, bo, &clips_bo,
+					    &dimage, offset, height, width);
+	if (ret)
+		return;
+
+	rects = drawable_set_clipping(qdev, num_clips, &clips_bo);
+	if (!rects)
+		return;
+	rects[0].left = 0;
+	rects[0].right = width;
+	rects[0].top = 0;
+	rects[0].bottom = height;
+
+	qxl_push_command_ring_without_release(qdev, bo, offset);
+
+	qxl_panic_gem_object_free(&chunk_bo.tbo.base);
+	qxl_panic_gem_object_free(&image_bo.tbo.base);
+
+	qxl_bo_vunmap_locked(&clips_bo);
+	qxl_panic_gem_object_free(&clips_bo.tbo.base);
+}
+
 static const uint32_t qxl_cursor_plane_formats[] = {
 	DRM_FORMAT_ARGB8888,
 };
@@ -920,6 +1012,8 @@ static const struct drm_plane_helper_funcs primary_helper_funcs = {
 	.atomic_disable = qxl_primary_atomic_disable,
 	.prepare_fb = qxl_plane_prepare_fb,
 	.cleanup_fb = qxl_plane_cleanup_fb,
+	.get_scanout_buffer = qxl_primary_plane_helper_get_scanout_buffer,
+	.panic_flush = qxl_panic_flush,
 };
 
 static const struct drm_plane_funcs qxl_primary_plane_funcs = {
diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index 3a3e127ce297..cf64db196101 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -41,9 +41,10 @@ static int alloc_clips(struct qxl_device *qdev,
 /* returns a pointer to the already allocated qxl_rect array inside
  * the qxl_clip_rects. This is *not* the same as the memory allocated
  * on the device, it is offset to qxl_clip_rects.chunk.data */
-static struct qxl_rect *drawable_set_clipping(struct qxl_device *qdev,
-					      unsigned int num_clips,
-					      struct qxl_bo *clips_bo)
+
+struct qxl_rect *drawable_set_clipping(struct qxl_device *qdev,
+				       unsigned int num_clips,
+				       struct qxl_bo *clips_bo)
 {
 	struct iosys_map map;
 	struct qxl_clip_rects *dev_clips;
@@ -74,6 +75,60 @@ free_drawable(struct qxl_device *qdev, struct qxl_release *release)
 	qxl_release_free(qdev, release);
 }
 
+/* For drm panic */
+int
+make_drawable_without_release(struct qxl_device *qdev,
+			      struct qxl_rect *drawable_rect,
+			      struct qxl_bo *bo,
+			      struct qxl_bo *clips_bo,
+			      struct qxl_drm_image *dimage,
+			      uint32_t offset, int height, int width)
+{
+	struct qxl_drawable *drawable;
+	union qxl_release_info *info;
+	void *ptr;
+	int i;
+
+	ptr = qxl_bo_kmap_atomic_page(qdev, bo, offset & PAGE_MASK);
+	if (!ptr)
+		return -ENOMEM;
+	drawable = ptr + (offset & ~PAGE_MASK);
+
+	drawable->type = QXL_DRAW_COPY;
+	drawable->surface_id = 0;
+	drawable->effect = QXL_EFFECT_OPAQUE;
+	drawable->self_bitmap = 0;
+	drawable->self_bitmap_area.top = 0;
+	drawable->self_bitmap_area.left = 0;
+	drawable->self_bitmap_area.bottom = 0;
+	drawable->self_bitmap_area.right = 0;
+
+	for (i = 0; i < 3; ++i)
+		drawable->surfaces_dest[i] = -1;
+
+	drawable->bbox = *drawable_rect;
+	drawable->mm_time = qdev->rom->mm_clock;
+	drawable->clip.type = SPICE_CLIP_TYPE_RECTS;
+	drawable->clip.data = qxl_bo_physical_address(qdev, clips_bo, 0);
+	drawable->u.copy.src_area.top = 0;
+	drawable->u.copy.src_area.bottom = height;
+	drawable->u.copy.src_area.left = 0;
+	drawable->u.copy.src_area.right = width;
+	drawable->u.copy.rop_descriptor = SPICE_ROPD_OP_PUT;
+	drawable->u.copy.scale_mode = 0;
+	drawable->u.copy.mask.flags = 0;
+	drawable->u.copy.mask.pos.x = 0;
+	drawable->u.copy.mask.pos.y = 0;
+	drawable->u.copy.mask.bitmap = 0;
+	drawable->u.copy.src_bitmap = qxl_bo_physical_address(qdev, dimage->bo, 0);
+
+	info = &drawable->release_info;
+	ptr = ((void *)info) - (offset & ~PAGE_MASK);
+	qxl_bo_kunmap_atomic_page(qdev, bo, ptr);
+
+	return 0;
+}
+
 /* release needs to be reserved at this point */
 static int
 make_drawable(struct qxl_device *qdev, int surface, uint8_t type,
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 32069acd93f8..33b1100c8035 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -309,6 +309,7 @@ int qxl_gem_object_create_with_handle(struct qxl_device *qdev,
 				      struct qxl_surface *surf,
 				      struct drm_gem_object **gobj,
 				      uint32_t *handle);
+void qxl_panic_gem_object_free(struct drm_gem_object *gobj);
 void qxl_gem_object_free(struct drm_gem_object *gobj);
 int qxl_gem_object_open(struct drm_gem_object *obj, struct drm_file *file_priv);
 void qxl_gem_object_close(struct drm_gem_object *obj,
@@ -334,6 +335,14 @@ int qxl_image_init(struct qxl_device *qdev,
 		   const uint8_t *data,
 		   int x, int y, int width, int height,
 		   int depth, int stride);
+
+int qxl_image_alloc_objects_without_release(struct qxl_device *qdev,
+					    struct qxl_drm_image *image,
+					    struct qxl_drm_chunk *chunk,
+					    struct qxl_bo *image_bo, struct qxl_bo *chunk_bo,
+					    uint8_t *surface_base, int width,
+					    int height, int depth, int stride);
+
 int
 qxl_image_alloc_objects(struct qxl_device *qdev,
 			struct qxl_release *release,
@@ -376,6 +385,10 @@ int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
 			       int type, struct qxl_release **release,
 			       struct qxl_bo **rbo);
 
+int qxl_push_command_ring_without_release(struct qxl_device *qdev,
+					  struct qxl_bo *bo, uint32_t offset);
+
+
 int
 qxl_push_command_ring_release(struct qxl_device *qdev, struct qxl_release *release,
 			      uint32_t type, bool interruptible);
@@ -387,6 +400,9 @@ int qxl_alloc_bo_reserved(struct qxl_device *qdev,
 			  unsigned long size,
 			  struct qxl_bo **_bo);
 /* qxl drawing commands */
+struct qxl_rect *drawable_set_clipping(struct qxl_device *qdev,
+				       unsigned int num_clips,
+				       struct qxl_bo *clips_bo);
 
 void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		       struct drm_framebuffer *fb,
@@ -399,6 +415,14 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 void qxl_release_free(struct qxl_device *qdev,
 		      struct qxl_release *release);
 
+int
+make_drawable_without_release(struct qxl_device *qdev,
+			      struct qxl_rect *drawable_rect,
+			      struct qxl_bo *bo,
+			      struct qxl_bo *clips_bo,
+			      struct qxl_drm_image *dimage,
+			      uint32_t offset, int height, int width);
+
 /* used by qxl_debugfs_release */
 struct qxl_release *qxl_release_from_id_locked(struct qxl_device *qdev,
 						   uint64_t id);
diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.c
index fc5e3763c359..f140439c640a 100644
--- a/drivers/gpu/drm/qxl/qxl_gem.c
+++ b/drivers/gpu/drm/qxl/qxl_gem.c
@@ -28,6 +28,15 @@
 #include "qxl_drv.h"
 #include "qxl_object.h"
 
+void qxl_panic_gem_object_free(struct drm_gem_object *gobj)
+{
+	struct qxl_bo *qobj = gem_to_qxl_bo(gobj);
+	struct ttm_buffer_object *tbo;
+
+	tbo = &qobj->tbo;
+	ttm_bo_put(tbo);
+}
+
 void qxl_gem_object_free(struct drm_gem_object *gobj)
 {
 	struct qxl_bo *qobj = gem_to_qxl_bo(gobj);
diff --git a/drivers/gpu/drm/qxl/qxl_image.c b/drivers/gpu/drm/qxl/qxl_image.c
index ffff54e5fb31..370dc0bae48c 100644
--- a/drivers/gpu/drm/qxl/qxl_image.c
+++ b/drivers/gpu/drm/qxl/qxl_image.c
@@ -52,6 +52,32 @@ qxl_allocate_chunk(struct qxl_device *qdev,
 	return 0;
 }
 
+/* For drm panic */
+int
+qxl_image_alloc_objects_without_release(struct qxl_device *qdev,
+					struct qxl_drm_image *image,
+					struct qxl_drm_chunk *chunk,
+					struct qxl_bo *image_bo, struct qxl_bo *chunk_bo,
+					uint8_t *surface_base, int width, int height,
+					int depth, int stride)
+{
+	int ret;
+	unsigned int chunk_size = sizeof(struct qxl_data_chunk) + stride * height;
+
+	INIT_LIST_HEAD(&image->chunk_list);
+	qxl_panic_bo_create(qdev, sizeof(struct qxl_image), image_bo);
+	image->bo = image_bo;
+
+	qxl_panic_bo_create(qdev, chunk_size, chunk_bo);
+	chunk->bo = chunk_bo;
+	list_add_tail(&chunk->head, &image->chunk_list);
+
+	ret = qxl_image_init(qdev, NULL, image, surface_base,
+			     0, 0, width, height, depth, stride);
+	return ret;
+
+}
+
 int
 qxl_image_alloc_objects(struct qxl_device *qdev,
 			struct qxl_release *release,
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 66635c55cf85..cdba20718674 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -29,6 +29,16 @@
 #include "qxl_drv.h"
 #include "qxl_object.h"
 
+/* For drm panic */
+static void qxl_panic_ttm_bo_destroy(struct ttm_buffer_object *tbo)
+{
+	struct qxl_bo *bo;
+
+	bo = to_qxl_bo(tbo);
+	WARN_ON_ONCE(bo->map_count > 0);
+	drm_gem_object_release(&bo->tbo.base);
+}
+
 static void qxl_ttm_bo_destroy(struct ttm_buffer_object *tbo)
 {
 	struct qxl_bo *bo;
@@ -101,6 +111,42 @@ static const struct drm_gem_object_funcs qxl_object_funcs = {
 	.print_info = drm_gem_ttm_print_info,
 };
 
+/* For drm panic */
+int qxl_panic_bo_create(struct qxl_device *qdev, unsigned long size, struct qxl_bo *bo)
+{
+	u32 domain = QXL_GEM_DOMAIN_VRAM;
+	struct ttm_operation_ctx ctx = { true, false };
+	enum ttm_bo_type type;
+	int r;
+
+	type = ttm_bo_type_device;
+
+	size = roundup(size, PAGE_SIZE);
+	r = drm_gem_object_init(&qdev->ddev, &bo->tbo.base, size);
+	if (unlikely(r))
+		return r;
+	bo->tbo.base.funcs = &qxl_object_funcs;
+	bo->type = domain;
+	bo->surface_id = 0;
+	INIT_LIST_HEAD(&bo->list);
+
+	qxl_ttm_placement_from_domain(bo, domain);
+
+	bo->tbo.priority = 0;
+	r = ttm_bo_init_reserved(&qdev->mman.bdev, &bo->tbo, type,
+				 &bo->placement, 0, &ctx, NULL, NULL,
+				 &qxl_panic_ttm_bo_destroy);
+	if (unlikely(r != 0)) {
+		if (r != -ERESTARTSYS)
+			dev_err(qdev->ddev.dev,
+				"object_init failed for (%lu, 0x%08X)\n",
+				size, domain);
+		return r;
+	}
+	ttm_bo_unreserve(&bo->tbo);
+	return 0;
+}
+
 int qxl_bo_create(struct qxl_device *qdev, unsigned long size,
 		  bool kernel, bool pinned, u32 domain, u32 priority,
 		  struct qxl_surface *surf,
diff --git a/drivers/gpu/drm/qxl/qxl_object.h b/drivers/gpu/drm/qxl/qxl_object.h
index 875f63221074..d1dbf7a3dd5b 100644
--- a/drivers/gpu/drm/qxl/qxl_object.h
+++ b/drivers/gpu/drm/qxl/qxl_object.h
@@ -53,6 +53,7 @@ static inline unsigned long qxl_bo_size(struct qxl_bo *bo)
 	return bo->tbo.base.size;
 }
 
+extern int qxl_panic_bo_create(struct qxl_device *qdev, unsigned long size, struct qxl_bo *bo);
 extern int qxl_bo_create(struct qxl_device *qdev,
 			 unsigned long size,
 			 bool kernel, bool pinned, u32 domain,
-- 
2.46.0

