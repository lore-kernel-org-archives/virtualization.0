Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93124C9F
	for <virtualization@lists.linux.dev>; Mon, 14 Apr 2025 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636696; cv=none; b=JWcQu2cmwSiViBvGOyU2uRn5/b6KF7gIp8RGmvp+y0YzWq8CewlZXQOoiDA3ouHSmtYjHFLMGIpl2r0TAeaB4KWDnHyUwnXEPa/VDcGpc1YW27FNGZj9ozRmpbac6cCO8vOV4N4qvEN1EXpQJPGFoAjIu2ZAZ2scWYBGO7Dv7mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636696; c=relaxed/simple;
	bh=tsL1hA6t3vqIkzHH4/nzEcW0W9JVXpPvY0nBLFx625U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPAyHWmZZeXSzcm8J5xvNQiKOQ0QN+ca/XhcDeqB7oHho/rypXs2XmtMbfBHDd8tVSvpsHo9fdQi9WO6HZ1GKYqhTK4Cp6Vcdce5uMgqXng5kjHjPguQ+LP00dPK2rmqSTiNtLqtZjEKDF+RHi9vODl/WTQmBmfaV2h0dV7xIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 553AE1F814;
	Mon, 14 Apr 2025 13:18:06 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2112213A84;
	Mon, 14 Apr 2025 13:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mHXhBg4L/WfYeQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 14 Apr 2025 13:18:06 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/2] drm/virtio: Test for imported buffers with drm_gem_is_imported()
Date: Mon, 14 Apr 2025 15:12:00 +0200
Message-ID: <20250414131507.566072-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414131507.566072-1-tzimmermann@suse.de>
References: <20250414131507.566072-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 553AE1F814
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Instead of testing import_attach for imported GEM buffers, invoke
drm_gem_is_imported() to do the test. The helper tests the dma_buf
itself while import_attach is just an artifact of the import. Prepares
to make import_attach optional.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 8 ++++----
 drivers/gpu/drm/virtio/virtgpu_prime.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 87e584add042..43e755248977 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -366,7 +366,7 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 		return 0;
 
 	obj = new_state->fb->obj[0];
-	if (bo->dumb || obj->import_attach) {
+	if (bo->dumb || drm_gem_is_imported(obj)) {
 		vgplane_st->fence = virtio_gpu_fence_alloc(vgdev,
 						     vgdev->fence_drv.context,
 						     0);
@@ -374,7 +374,7 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 			return -ENOMEM;
 	}
 
-	if (obj->import_attach) {
+	if (drm_gem_is_imported(obj)) {
 		ret = virtio_gpu_prepare_imported_obj(plane, new_state, obj);
 		if (ret)
 			goto err_fence;
@@ -417,7 +417,7 @@ static void virtio_gpu_plane_cleanup_fb(struct drm_plane *plane,
 	}
 
 	obj = state->fb->obj[0];
-	if (obj->import_attach)
+	if (drm_gem_is_imported(obj))
 		virtio_gpu_cleanup_imported_obj(obj);
 }
 
@@ -509,7 +509,7 @@ static int virtio_drm_get_scanout_buffer(struct drm_plane *plane,
 	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
 
 	/* Only support mapped shmem bo */
-	if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach || !bo->base.vaddr)
+	if (virtio_gpu_is_vram(bo) || drm_gem_is_imported(&bo->base.base) || !bo->base.vaddr)
 		return -ENODEV;
 
 	iosys_map_set_vaddr(&sb->map[0], bo->base.vaddr);
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index 9b4bde3fda18..ce49282198cb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -206,7 +206,7 @@ static void virtgpu_dma_buf_free_obj(struct drm_gem_object *obj)
 	struct virtio_gpu_device *vgdev = obj->dev->dev_private;
 	struct dma_buf_attachment *attach = obj->import_attach;
 
-	if (attach) {
+	if (drm_gem_is_imported(obj)) {
 		struct dma_buf *dmabuf = attach->dmabuf;
 
 		dma_resv_lock(dmabuf->resv, NULL);
-- 
2.49.0

