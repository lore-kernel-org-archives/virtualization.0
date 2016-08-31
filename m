From: Gustavo Padovan <gustavo@padovan.org>
Subject: [PATCH 2/2] drm/virtio: add real fence context and seqno
Date: Wed, 31 Aug 2016 12:26:53 -0400
Message-ID: <1472660813-28219-2-git-send-email-gustavo@padovan.org>
References: <1472660813-28219-1-git-send-email-gustavo@padovan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1472660813-28219-1-git-send-email-gustavo@padovan.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Airlie <airlied@linux.ie>
Cc: open list <linux-kernel@vger.kernel.org>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>, "open list:VIRTIO GPU DRIVER" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

virtio fences were created with no fence context, which would make then
clash with an allocated fence context.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 1 +
 drivers/gpu/drm/virtio/virtgpu_fence.c | 2 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c   | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index b18ef31..06ad923 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -75,6 +75,7 @@ typedef void (*virtio_gpu_resp_cb)(struct virtio_gpu_device *vgdev,
 struct virtio_gpu_fence_driver {
 	atomic64_t       last_seq;
 	uint64_t         sync_seq;
+	uint64_t         context;
 	struct list_head fences;
 	spinlock_t       lock;
 };
diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
index cf44187..f3f70fa 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -89,7 +89,7 @@ int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 	(*fence)->drv = drv;
 	(*fence)->seq = ++drv->sync_seq;
 	fence_init(&(*fence)->f, &virtio_fence_ops, &drv->lock,
-		   0, (*fence)->seq);
+		   drv->context, (*fence)->seq);
 	fence_get(&(*fence)->f);
 	list_add_tail(&(*fence)->node, &drv->fences);
 	spin_unlock_irqrestore(&drv->lock, irq_flags);
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 4150873..036b0fb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -159,6 +159,7 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
 	virtio_gpu_init_vq(&vgdev->ctrlq, virtio_gpu_dequeue_ctrl_func);
 	virtio_gpu_init_vq(&vgdev->cursorq, virtio_gpu_dequeue_cursor_func);
 
+	vgdev->fence_drv.context = fence_context_alloc(1);
 	spin_lock_init(&vgdev->fence_drv.lock);
 	INIT_LIST_HEAD(&vgdev->fence_drv.fences);
 	INIT_LIST_HEAD(&vgdev->cap_cache);
-- 
2.5.5
