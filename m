From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] drm/virtio: fix OOB in virtio_gpu_object_create
Date: Thu, 19 Mar 2020 11:04:21 +0100
Message-ID: <20200319100421.16267-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kraxel@redhat.com
Cc: airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Gurchetan Singh <gurchetansingh@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

After commit f651c8b05542, virtio_gpu_create_object allocates too small
space to fit everything in. It is because it allocates struct
virtio_gpu_object, but should allocate a newly added struct
virtio_gpu_object_shmem which has 2 more members.

So fix that by using correct type in virtio_gpu_create_object.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Fixes: f651c8b05542 ("drm/virtio: factor out the sg_table from virtio_gpu_object")
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 2bfb13d1932e..d9039bb7c5e3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -123,15 +123,17 @@ bool virtio_gpu_is_shmem(struct virtio_gpu_object *bo)
 struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
 						size_t size)
 {
-	struct virtio_gpu_object *bo;
+	struct virtio_gpu_object_shmem *shmem;
+	struct drm_gem_shmem_object *dshmem;
 
-	bo = kzalloc(sizeof(*bo), GFP_KERNEL);
-	if (!bo)
+	shmem = kzalloc(sizeof(*shmem), GFP_KERNEL);
+	if (!shmem)
 		return NULL;
 
-	bo->base.base.funcs = &virtio_gpu_shmem_funcs;
-	bo->base.map_cached = true;
-	return &bo->base.base;
+	dshmem = &shmem->base.base;
+	dshmem->base.funcs = &virtio_gpu_shmem_funcs;
+	dshmem->map_cached = true;
+	return &dshmem->base;
 }
 
 static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
-- 
2.25.1
