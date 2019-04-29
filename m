From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 15/19] drm/mgag200: Replace mapping code with
	drm_gem_vram_{kmap/kunmap}()
Date: Mon, 29 Apr 2019 16:43:37 +0200
Message-ID: <20190429144341.12615-16-tzimmermann__42295.2819078759$1556549463$gmane$org@suse.de>
References: <20190429144341.12615-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190429144341.12615-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: daniel@ffwll.ch, airlied@linux.ie, kraxel@redhat.com, christian.koenig@amd.com, ray.huang@amd.com, Jerry.Zhang@amd.com, hdegoede@redhat.com, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The mgag200 driver establishes several memory mappings for frame buffers
and cursors. This patch converts the driver to use the equivalent
drm_gem_vram_kmap() functions. It removes the dependencies on TTM
and cleans up the code.
---
 drivers/gpu/drm/mgag200/mgag200_cursor.c | 35 +++++++++++-------------
 drivers/gpu/drm/mgag200/mgag200_drv.h    |  1 -
 drivers/gpu/drm/mgag200/mgag200_fb.c     | 22 +++++++++------
 drivers/gpu/drm/mgag200/mgag200_mode.c   |  9 ++++--
 4 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_cursor.c b/drivers/gpu/drm/mgag200/mgag200_cursor.c
index cca3922f9f67..6c1a9d724d85 100644
--- a/drivers/gpu/drm/mgag200/mgag200_cursor.c
+++ b/drivers/gpu/drm/mgag200/mgag200_cursor.c
@@ -43,6 +43,7 @@ int mga_crtc_cursor_set(struct drm_crtc *crtc,
 	struct drm_gem_object *obj;
 	struct drm_gem_vram_object *gbo = NULL;
 	int ret = 0;
+	u8 *src, *dst;
 	unsigned int i, row, col;
 	uint32_t colour_set[16];
 	uint32_t *next_space = &colour_set[0];
@@ -126,18 +127,17 @@ int mga_crtc_cursor_set(struct drm_crtc *crtc,
 		dev_err(&dev->pdev->dev, "failed to reserve user bo\n");
 		goto out1;
 	}
-	if (!gbo->kmap.virtual) {
-		ret = ttm_bo_kmap(&gbo->bo, 0, gbo->bo.num_pages, &gbo->kmap);
-		if (ret) {
-			dev_err(&dev->pdev->dev, "failed to kmap user buffer updates\n");
-			goto out2;
-		}
+	src = drm_gem_vram_kmap(gbo, true, NULL);
+	if (IS_ERR(src)) {
+		ret = PTR_ERR(src);
+		dev_err(&dev->pdev->dev, "failed to kmap user buffer updates\n");
+		goto out2;
 	}
 
 	memset(&colour_set[0], 0, sizeof(uint32_t)*16);
 	/* width*height*4 = 16384 */
 	for (i = 0; i < 16384; i += 4) {
-		this_colour = ioread32(gbo->kmap.virtual + i);
+		this_colour = ioread32(src + i);
 		/* No transparency */
 		if (this_colour>>24 != 0xff &&
 			this_colour>>24 != 0x0) {
@@ -189,21 +189,18 @@ int mga_crtc_cursor_set(struct drm_crtc *crtc,
 	}
 
 	/* Map up-coming buffer to write colour indices */
-	if (!pixels_prev->kmap.virtual) {
-		ret = ttm_bo_kmap(&pixels_prev->bo, 0,
-				  pixels_prev->bo.num_pages,
-				  &pixels_prev->kmap);
-		if (ret) {
-			dev_err(&dev->pdev->dev, "failed to kmap cursor updates\n");
-			goto out3;
-		}
+	dst = drm_gem_vram_kmap(pixels_prev, true, NULL);
+	if (IS_ERR(dst)) {
+		ret = PTR_ERR(dst);
+		dev_err(&dev->pdev->dev, "failed to kmap cursor updates\n");
+		goto out3;
 	}
 
 	/* now write colour indices into hardware cursor buffer */
 	for (row = 0; row < 64; row++) {
 		memset(&this_row[0], 0, 48);
 		for (col = 0; col < 64; col++) {
-			this_colour = ioread32(gbo->kmap.virtual + 4*(col + 64*row));
+			this_colour = ioread32(src + 4*(col + 64*row));
 			/* write transparent pixels */
 			if (this_colour>>24 == 0x0) {
 				this_row[47 - col/8] |= 0x80>>(col%8);
@@ -221,7 +218,7 @@ int mga_crtc_cursor_set(struct drm_crtc *crtc,
 				}
 			}
 		}
-		memcpy_toio(pixels_prev->kmap.virtual + row*48, &this_row[0], 48);
+		memcpy_toio(dst + row*48, &this_row[0], 48);
 	}
 
 	/* Program gpu address of cursor buffer */
@@ -247,9 +244,9 @@ int mga_crtc_cursor_set(struct drm_crtc *crtc,
 	}
 	ret = 0;
 
-	ttm_bo_kunmap(&pixels_prev->kmap);
+	drm_gem_vram_kunmap(pixels_prev);
  out3:
-	ttm_bo_kunmap(&gbo->kmap);
+	drm_gem_vram_kunmap(gbo);
  out2:
 	drm_gem_vram_unreserve(gbo);
  out1:
diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mgag200/mgag200_drv.h
index 16ce6b338dce..6180acbca7ca 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.h
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
@@ -115,7 +115,6 @@ struct mga_fbdev {
 	struct mga_framebuffer mfb;
 	void *sysram;
 	int size;
-	struct ttm_bo_kmap_obj mapping;
 	int x1, y1, x2, y2; /* dirty rect */
 	spinlock_t dirty_lock;
 };
diff --git a/drivers/gpu/drm/mgag200/mgag200_fb.c b/drivers/gpu/drm/mgag200/mgag200_fb.c
index 508ec2dddbba..7c457dad5d9e 100644
--- a/drivers/gpu/drm/mgag200/mgag200_fb.c
+++ b/drivers/gpu/drm/mgag200/mgag200_fb.c
@@ -27,6 +27,7 @@ static void mga_dirty_update(struct mga_fbdev *mfbdev,
 	int src_offset, dst_offset;
 	int bpp = mfbdev->mfb.base.format->cpp[0];
 	int ret = -EBUSY;
+	u8 *dst;
 	bool unmap = false;
 	bool store_for_later = false;
 	int x2, y2;
@@ -75,24 +76,29 @@ static void mga_dirty_update(struct mga_fbdev *mfbdev,
 	mfbdev->x2 = mfbdev->y2 = 0;
 	spin_unlock_irqrestore(&mfbdev->dirty_lock, flags);
 
-	if (!gbo->kmap.virtual) {
-		ret = ttm_bo_kmap(&gbo->bo, 0, gbo->bo.num_pages, &gbo->kmap);
-		if (ret) {
+	dst = drm_gem_vram_kmap(gbo, false, NULL);
+	if (IS_ERR(dst)) {
+		DRM_ERROR("failed to kmap fb updates\n");
+		goto out;
+	} else if (!dst) {
+		dst = drm_gem_vram_kmap(gbo, true, NULL);
+		if (IS_ERR(dst)) {
 			DRM_ERROR("failed to kmap fb updates\n");
-			drm_gem_vram_unreserve(gbo);
-			return;
+			goto out;
 		}
 		unmap = true;
 	}
+
 	for (i = y; i <= y2; i++) {
 		/* assume equal stride for now */
 		src_offset = dst_offset = i * mfbdev->mfb.base.pitches[0] + (x * bpp);
-		memcpy_toio(gbo->kmap.virtual + src_offset, mfbdev->sysram + src_offset, (x2 - x + 1) * bpp);
-
+		memcpy_toio(dst + dst_offset, mfbdev->sysram + src_offset, (x2 - x + 1) * bpp);
 	}
+
 	if (unmap)
-		ttm_bo_kunmap(&gbo->kmap);
+		drm_gem_vram_kunmap(gbo);
 
+out:
 	drm_gem_vram_unreserve(gbo);
 }
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index ddec2c485381..769ace139377 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -870,6 +870,7 @@ static int mga_crtc_do_set_base(struct drm_crtc *crtc,
 	struct drm_gem_vram_object *gbo;
 	int ret;
 	s64 gpu_addr;
+	void* base;
 
 	/* push the previous fb to system ram */
 	if (!atomic && fb) {
@@ -902,11 +903,13 @@ static int mga_crtc_do_set_base(struct drm_crtc *crtc,
 
 	if (&mdev->mfbdev->mfb == mga_fb) {
 		/* if pushing console in kmap it */
-		ret = ttm_bo_kmap(&gbo->bo, 0, gbo->bo.num_pages, &gbo->kmap);
-		if (ret)
+		base = drm_gem_vram_kmap(gbo, true, NULL);
+		if (IS_ERR(base)) {
+			ret = PTR_ERR(base);
 			DRM_ERROR("failed to kmap fbcon\n");
-
+		}
 	}
+
 	drm_gem_vram_unreserve(gbo);
 
 	mga_set_start_address(crtc, (u32)gpu_addr);
-- 
2.21.0
