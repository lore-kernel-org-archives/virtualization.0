Received: from erminea.space (erminea.space [51.250.125.203])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 176FB1BFE10
	for <virtualization@lists.linux.dev>; Mon, 14 Oct 2024 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.125.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926101; cv=none; b=rjFKahTTKVUNdcXDDw+KVAWc8fjSK0iX990KZqLREUzk/t+CcOstNFlgjOeOYGj0+cmn2IKU2BSy9Arfd5Pw44j4Sn44Q3eMPuK2cIHctIRoE7c3Nxie4D8qcMOjpH2t7j0jwpIfAwV2jxYHcrjL4gRMiZWezprgOcIIIHLOPJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926101; c=relaxed/simple;
	bh=O8OGoWMGZ2OnMDIalxJe5SyY6FwRPz7uMByJnZiyGJg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=W07dmloBss+38jzGKFpOhG9g7q9ypzN8QvHwJYf1RgwJJca8lIuBw8XVoaUtcGTmSbfZ80YiiFErd0KX7Njee6eonrfkZNoXtr69FR8/L2U8t+DFcRXhXe4NwwNPkOpr06uByMf0JImRQImac4nmKBqvAuPT5qEG3zr9ZNdb5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=erminea.space; spf=pass smtp.mailfrom=erminea.space; arc=none smtp.client-ip=51.250.125.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=erminea.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=erminea.space
Received: (qmail 16812 invoked from network); 14 Oct 2024 17:08:16 -0000
Received: from localhost. (HELO erminea.space) (127.0.0.1)
  by 0.0.0.0 with SMTP; 14 Oct 2024 17:08:16 -0000
Received: from localhost.localdomain ([37.204.49.201])
	by erminea.space with ESMTPSA
	id YP79JwBQDWeoQQAAH+dm7w
	(envelope-from <mustela@erminea.space>); Mon, 14 Oct 2024 20:08:16 +0300
From: Peter Shkenev <mustela@erminea.space>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/virtio: use generic dumb_map_offset implementation
Date: Mon, 14 Oct 2024 20:07:58 +0300
Message-ID: <20241014170801.71231-1-mustela@erminea.space>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, virtio uses its own dumb_map_offset implementation,
virtio_gpu_mode_dumb_mmap. It works similarly to generic implementation,
drm_gem_dumb_map_offset, and using the generic implementation is
preferable (and making drivers to do so is a task stated on the DRM
subsystem's TODO list).

Thus, make driver use the generic implementation. This includes
VIRTGPU_MAP ioctl so it cannot be used to circumvent rules imposed by
drm_gem_dumb_map_offset (imported objects cannot be mapped).

Signed-off-by: Peter Shkenev <mustela@erminea.space>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c   |  1 -
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 15 ---------------
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  3 ++-
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index ffca6e2e1c9a..909808398d66 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -184,7 +184,6 @@ static const struct drm_driver driver = {
 	.postclose = virtio_gpu_driver_postclose,
 
 	.dumb_create = virtio_gpu_mode_dumb_create,
-	.dumb_map_offset = virtio_gpu_mode_dumb_mmap,
 
 	DRM_FBDEV_SHMEM_DRIVER_OPS,
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 7db48d17ee3a..aefbb49481f1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -99,21 +99,6 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	return ret;
 }
 
-int virtio_gpu_mode_dumb_mmap(struct drm_file *file_priv,
-			      struct drm_device *dev,
-			      uint32_t handle, uint64_t *offset_p)
-{
-	struct drm_gem_object *gobj;
-
-	BUG_ON(!offset_p);
-	gobj = drm_gem_object_lookup(file_priv, handle);
-	if (gobj == NULL)
-		return -ENOENT;
-	*offset_p = drm_vma_node_offset_addr(&gobj->vma_node);
-	drm_gem_object_put(gobj);
-	return 0;
-}
-
 int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
 			       struct drm_file *file)
 {
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index e4f76f315550..13f3ed60a0e5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -30,6 +30,7 @@
 #include <linux/uaccess.h>
 
 #include <drm/drm_file.h>
+#include <drm/drm_gem.h>
 #include <drm/virtgpu_drm.h>
 
 #include "virtgpu_drv.h"
@@ -80,7 +81,7 @@ static int virtio_gpu_map_ioctl(struct drm_device *dev, void *data,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct drm_virtgpu_map *virtio_gpu_map = data;
 
-	return virtio_gpu_mode_dumb_mmap(file, vgdev->ddev,
+	return drm_gem_dumb_map_offset(file, vgdev->ddev,
 					 virtio_gpu_map->handle,
 					 &virtio_gpu_map->offset);
 }
-- 
2.46.2

