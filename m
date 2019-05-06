From: Robert Foss <robert.foss@collabora.com>
Subject: [PATCH v2] drm/virtio: Remove redundant return type
Date: Mon,  6 May 2019 11:10:34 +0200
Message-ID: <20190506091034.30289-1-robert.foss__16575.0207657524$1557133926$gmane$org@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: airlied@linux.ie, kraxel@redhat.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Chia-I Wu <olvaffe@gmail.com>
Cc: Robert Foss <robert.foss@collabora.com>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

virtio_gpu_fence_emit() always returns 0, since it
has no error paths.

Consequently no calls for virtio_gpu_fence_emit()
use the return value, and it can be removed.

Signed-off-by: Robert Foss <robert.foss@collabora.com>
Suggested-by: Emil Velikov <emil.velikov@collabora.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
---

This patch was suggested in this email thread:

[PATCH] drm/virtio: allocate fences with GFP_KERNEL
https://www.spinics.net/lists/dri-devel/msg208536.html

Changes since v1:
 - Rebased on drm-misc-next
 - Added r-b from Chia-I Wu


 drivers/gpu/drm/virtio/virtgpu_drv.h   | 2 +-
 drivers/gpu/drm/virtio/virtgpu_fence.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 90461feeafdb..2d3e5b1debb3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -355,7 +355,7 @@ int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma);
 bool virtio_fence_signaled(struct dma_fence *f);
 struct virtio_gpu_fence *virtio_gpu_fence_alloc(
 	struct virtio_gpu_device *vgdev);
-int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
+void virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
 			  struct virtio_gpu_fence *fence);
 void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
index 8aecc36a0417..70d6c4329778 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -85,7 +85,7 @@ struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev)
 	return fence;
 }
 
-int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
+void virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
 			  struct virtio_gpu_fence *fence)
 {
@@ -102,7 +102,6 @@ int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 
 	cmd_hdr->flags |= cpu_to_le32(VIRTIO_GPU_FLAG_FENCE);
 	cmd_hdr->fence_id = cpu_to_le64(fence->f.seqno);
-	return 0;
 }
 
 void virtio_gpu_fence_event_process(struct virtio_gpu_device *vgdev,
-- 
2.20.1
