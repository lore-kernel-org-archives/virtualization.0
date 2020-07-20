From: hexin <hexin.op@bytedance.com>
Subject: [PATCH v2] drm/virtio: fixed memory leak in virtio_gpu_execbuffer_ioctl()
Date: Mon, 20 Jul 2020 22:44:07 +0800
Message-ID: <20200720144407.13706-1-hexin.op@bytedance.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, christian.koenig@amd.com, daniel@ffwll.ch, airlied@linux.ie, kraxel@redhat.com, Markus.Elfring@web.de, sumit.semwal@linaro.org
Cc: linux-kernel@vger.kernel.org, hexin <hexin.op@bytedance.com>, Liu Qi <liuqi.16@bytedance.com>
List-Id: virtualization@lists.linuxfoundation.org

commit 2cd7b6f08bc4 ("drm/virtio: add in/out fence support
for explicit synchronization") deleted dma_fence_put(),
which will cause the memory leak. To balance the reference
count initialized when allocating fence, dma_fence_put()
should not be deleted.

Fixes: 2cd7b6f08bc4 ("drm/virtio: add in/out fence support for explicit synchronization")
Signed-off-by: Liu Qi <liuqi.16@bytedance.com>
Signed-off-by: hexin <hexin.op@bytedance.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 5df722072ba0..19c5bc01eb79 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -179,6 +179,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 
 	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
 			      vfpriv->ctx_id, buflist, out_fence);
+	dma_fence_put(&out_fence->f);
 	virtio_gpu_notify(vgdev);
 	return 0;
 
-- 
2.21.1 (Apple Git-122.3)
