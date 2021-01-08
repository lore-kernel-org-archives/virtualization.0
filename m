Return-Path: <SRS0=LX6v=GL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156BDC4332D
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 09:44:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9403A23383
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 09:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9403A23383
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5FE8E86D2C;
	Fri,  8 Jan 2021 09:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HnA1bpSInPAz; Fri,  8 Jan 2021 09:43:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 64ADC86D4C;
	Fri,  8 Jan 2021 09:43:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C201C088B;
	Fri,  8 Jan 2021 09:43:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 011A4C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F1F2787315
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lyo5f-CdTntp
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2459D870F7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:52 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AFFABAFEF;
 Fri,  8 Jan 2021 09:43:50 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, airlied@redhat.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 kraxel@redhat.com, hdegoede@redhat.com, sean@poorly.run, eric@anholt.net,
 sam@ravnborg.org
Subject: [PATCH v4 10/13] drm/ast: Use drm_gem_vram_vmap_local() in cursor
 update
Date: Fri,  8 Jan 2021 10:43:37 +0100
Message-Id: <20210108094340.15290-11-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108094340.15290-1-tzimmermann@suse.de>
References: <20210108094340.15290-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: linaro-mm-sig@lists.linaro.org, virtualization@lists.linux-foundation.org,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org
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

Cursor updates in ast require a short-term mapping of the source and
destination BO. Use drm_gem_vram_vmap_local() and avoid the pinning
operations.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_cursor.c | 37 +++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_cursor.c
index fac1ee79c372..c38f435bcde2 100644
--- a/drivers/gpu/drm/ast/ast_cursor.c
+++ b/drivers/gpu/drm/ast/ast_cursor.c
@@ -159,6 +159,8 @@ int ast_cursor_blit(struct ast_private *ast, struct drm_framebuffer *fb)
 	struct drm_device *dev = &ast->base;
 	struct drm_gem_vram_object *dst_gbo = ast->cursor.gbo[ast->cursor.next_index];
 	struct drm_gem_vram_object *src_gbo = drm_gem_vram_of_gem(fb->obj[0]);
+	struct drm_gem_object *objs[] = {&src_gbo->bo.base, &dst_gbo->bo.base};
+	struct ww_acquire_ctx ctx;
 	struct dma_buf_map src_map, dst_map;
 	void __iomem *dst;
 	void *src;
@@ -168,26 +170,34 @@ int ast_cursor_blit(struct ast_private *ast, struct drm_framebuffer *fb)
 	    drm_WARN_ON_ONCE(dev, fb->height > AST_MAX_HWC_HEIGHT))
 		return -EINVAL;
 
-	ret = drm_gem_vram_vmap(src_gbo, &src_map);
+	ret = drm_gem_lock_reservations(objs, ARRAY_SIZE(objs), &ctx);
 	if (ret)
 		return ret;
+
+	ret = drm_gem_vram_vmap_local(src_gbo, &src_map);
+	if (ret)
+		goto err_drm_gem_unlock_reservations;
 	src = src_map.vaddr; /* TODO: Use mapping abstraction properly */
 
-	ret = drm_gem_vram_vmap(dst_gbo, &dst_map);
+	ret = drm_gem_vram_vmap_local(dst_gbo, &dst_map);
 	if (ret)
-		goto err_drm_gem_vram_vunmap;
+		goto err_drm_gem_vram_vunmap_local;
 	dst = dst_map.vaddr_iomem; /* TODO: Use mapping abstraction properly */
 
 	/* do data transfer to cursor BO */
 	update_cursor_image(dst, src, fb->width, fb->height);
 
-	drm_gem_vram_vunmap(dst_gbo, &dst_map);
-	drm_gem_vram_vunmap(src_gbo, &src_map);
+	drm_gem_vram_vunmap_local(dst_gbo, &dst_map);
+	drm_gem_vram_vunmap_local(src_gbo, &src_map);
+
+	drm_gem_unlock_reservations(objs, ARRAY_SIZE(objs), &ctx);
 
 	return 0;
 
-err_drm_gem_vram_vunmap:
-	drm_gem_vram_vunmap(src_gbo, &src_map);
+err_drm_gem_vram_vunmap_local:
+	drm_gem_vram_vunmap_local(src_gbo, &src_map);
+err_drm_gem_unlock_reservations:
+	drm_gem_unlock_reservations(objs, ARRAY_SIZE(objs), &ctx);
 	return ret;
 }
 
@@ -241,6 +251,7 @@ void ast_cursor_show(struct ast_private *ast, int x, int y,
 {
 	struct drm_device *dev = &ast->base;
 	struct drm_gem_vram_object *gbo = ast->cursor.gbo[ast->cursor.next_index];
+	struct drm_gem_object *obj = &gbo->bo.base;
 	struct dma_buf_map map;
 	u8 x_offset, y_offset;
 	u8 __iomem *dst;
@@ -248,16 +259,22 @@ void ast_cursor_show(struct ast_private *ast, int x, int y,
 	u8 jreg;
 	int ret;
 
-	ret = drm_gem_vram_vmap(gbo, &map);
-	if (drm_WARN_ONCE(dev, ret, "drm_gem_vram_vmap() failed, ret=%d\n", ret))
+	ret = dma_resv_lock(obj->resv, NULL);
+	if (ret)
+		return;
+	ret = drm_gem_vram_vmap_local(gbo, &map);
+	if (drm_WARN_ONCE(dev, ret, "drm_gem_vram_vmap_local() failed, ret=%d\n", ret)) {
+		dma_resv_unlock(obj->resv);
 		return;
+	}
 	dst = map.vaddr_iomem; /* TODO: Use mapping abstraction properly */
 
 	sig = dst + AST_HWC_SIZE;
 	writel(x, sig + AST_HWC_SIGNATURE_X);
 	writel(y, sig + AST_HWC_SIGNATURE_Y);
 
-	drm_gem_vram_vunmap(gbo, &map);
+	drm_gem_vram_vunmap_local(gbo, &map);
+	dma_resv_unlock(obj->resv);
 
 	if (x < 0) {
 		x_offset = (-x) + offset_x;
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
