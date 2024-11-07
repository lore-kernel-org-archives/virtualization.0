Received: from erminea.space (erminea.space [51.250.125.203])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6F1E820FA8F
	for <virtualization@lists.linux.dev>; Thu,  7 Nov 2024 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.125.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989125; cv=none; b=Xygt3fUH5PaHTcXAjicbOfudeo/h52wwZKbveIUac3/y2OLpWxiOv86jwFb2IwtGlZoANri3MbqmEhe/hL1p0Qn8CmcAsEdwxqfWn8SQvoBaTS/V5CbLmACVIdTwS3Ecub8HqOn2Dt2jlBSBl7NIgvDLkqzB1x9832KwT1imf5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989125; c=relaxed/simple;
	bh=fBOgAUdNDCZWG3KGA0hLFJBosJCirNqqo8lEj6awgt8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kFwZOAv0DwpCumdMxlO3wcfZvdUtWvMbfll7n69TX6ULU69DeKLyFTW3G1EX6Mv6Dp7Fz3a9u/8+bcyVR4HRVkPmVjVWd0ilH8z+5y7acSDkcMMwMsWZnawosidI1gbvbUDfKLFW3z/u4s2IHB52H/YL1yN7VDIzFvJ8sgojbls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=erminea.space; spf=pass smtp.mailfrom=erminea.space; arc=none smtp.client-ip=51.250.125.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=erminea.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=erminea.space
Received: (qmail 14816 invoked from network); 7 Nov 2024 14:12:00 -0000
Received: from localhost. (HELO erminea.space) (127.0.0.1)
  by 0.0.0.0 with SMTP; 7 Nov 2024 14:12:00 -0000
Received: from localhost.localdomain ([37.204.49.201])
	by erminea.space with ESMTPSA
	id aeT3M7DKLGfcOQAAH+dm7w
	(envelope-from <mustela@erminea.space>); Thu, 07 Nov 2024 17:12:00 +0300
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
Subject: [PATCH v2 RESEND] drm/virtio: use generic dumb_map_offset implementation
Date: Thu,  7 Nov 2024 17:10:05 +0300
Message-ID: <20241107141133.13624-1-mustela@erminea.space>
X-Mailer: git-send-email 2.47.0
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
Changes in v2:
  - Remove excessive include of drm_gem.h from virtgpu_ioctl.h
  - Remove obsoleted virtio_gpu_mode_dumb_mmap prototype from
    virtgpu_drv.h

 drivers/gpu/drm/virtio/virtgpu_drv.c   |  1 -
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 ---
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 15 ---------------
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  2 +-
 4 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index ffca6e2e1c9a..909808398d66 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -184,7 +184,6 @@ static const struct drm_driver driver = {
 	.postclose = virtio_gpu_driver_postclose,
 
 	.dumb_create = virtio_gpu_mode_dumb_create,
-	.dumb_map_offset = virtio_gpu_mode_dumb_mmap,
 
 	DRM_FBDEV_SHMEM_DRIVER_OPS,
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 64c236169db8..76f6f29f819a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -301,9 +301,6 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
 int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 				struct drm_device *dev,
 				struct drm_mode_create_dumb *args);
-int virtio_gpu_mode_dumb_mmap(struct drm_file *file_priv,
-			      struct drm_device *dev,
-			      uint32_t handle, uint64_t *offset_p);
 
 struct virtio_gpu_object_array *virtio_gpu_array_alloc(u32 nents);
 struct virtio_gpu_object_array*
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
index e4f76f315550..112142f4b618 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -80,7 +80,7 @@ static int virtio_gpu_map_ioctl(struct drm_device *dev, void *data,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct drm_virtgpu_map *virtio_gpu_map = data;
 
-	return virtio_gpu_mode_dumb_mmap(file, vgdev->ddev,
+	return drm_gem_dumb_map_offset(file, vgdev->ddev,
 					 virtio_gpu_map->handle,
 					 &virtio_gpu_map->offset);
 }
-- 
2.47.0

