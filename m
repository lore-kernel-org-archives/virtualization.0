From: Xin He <hexin.op@bytedance.com>
Subject: [PATCH v3] drm/virtio: fix missing dma_fence_put() in virtio_gpu_execbuffer_ioctl()
Date: Tue, 21 Jul 2020 18:16:47 +0800
Message-ID: <20200721101647.42653-1-hexin.op@bytedance.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel@ffwll.ch, airlied@linux.ie, kraxel@redhat.com, sumit.semwal@linaro.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Qi Liu <liuqi.16@bytedance.com>, Xin He <hexin.op@bytedance.com>, Muchun Song <songmuchun@bytedance.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Qi Liu <liuqi.16@bytedance.com>

We should put the reference count of the fence after calling
virtio_gpu_cmd_submit(). So add the missing dma_fence_put().

Fixes: 2cd7b6f08bc4 ("drm/virtio: add in/out fence support for explicit synchronization")
Co-developed-by: Xin He <hexin.op@bytedance.com>
Signed-off-by: Xin He <hexin.op@bytedance.com>
Signed-off-by: Qi Liu <liuqi.16@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---

changelog in v3:
1) Change the subject from "drm/virtio: fixed memory leak in virtio_gpu_execbuffer_ioctl()" to 
   "drm/virtio: fix missing dma_fence_put() in virtio_gpu_execbuffer_ioctl()"
2) Rework the commit log

changelog in v2:
1) Add a change description 

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
