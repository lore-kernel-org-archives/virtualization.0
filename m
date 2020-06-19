From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm/virtio: Fix an IS_ERR() vs NULL check in
 virtio_gpu_object_shmem_init()
Date: Fri, 19 Jun 2020 17:29:40 +0300
Message-ID: <20200619142940.GB267142@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The drm_gem_shmem_get_pages_sgt() function returns error pointers on
error, it never returns NULL.

Fixes: d323bb44e4d2 ("drm/virtio: Call the right shmem helpers")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 346cef5ce251..0cd5ecf4b3c0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -151,9 +151,9 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
 		return -EINVAL;
 
 	shmem->pages = drm_gem_shmem_get_pages_sgt(&bo->base.base);
-	if (!shmem->pages) {
+	if (IS_ERR(shmem->pages)) {
 		drm_gem_shmem_unpin(&bo->base.base);
-		return -EINVAL;
+		return PTR_ERR(shmem->pages);
 	}
 
 	if (use_dma_api) {
-- 
2.27.0
