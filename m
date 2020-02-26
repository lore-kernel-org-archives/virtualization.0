From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v5 2/3] drm/virtio: fix mmap page attributes
Date: Wed, 26 Feb 2020 16:47:51 +0100
Message-ID: <20200226154752.24328-3-kraxel@redhat.com>
References: <20200226154752.24328-1-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200226154752.24328-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, gurchetansingh@chromium.org, olvaffe@gmail.com, Guillaume.Gardet@arm.com, Gerd Hoffmann <kraxel@redhat.com>, stable@vger.kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

virtio-gpu uses cached mappings, set
drm_gem_shmem_object.map_cached accordingly.

Cc: stable@vger.kernel.org
Fixes: c66df701e783 ("drm/virtio: switch from ttm to gem shmem helpers")
Reported-by: Gurchetan Singh <gurchetansingh@chromium.org>
Reported-by: Guillaume Gardet <Guillaume.Gardet@arm.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 3d2a6d489bfc..59319435218f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -119,6 +119,7 @@ struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
 		return NULL;
 
 	bo->base.base.funcs = &virtio_gpu_gem_funcs;
+	bo->base.map_cached = true;
 	return &bo->base.base;
 }
 
-- 
2.18.2
