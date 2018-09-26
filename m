From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/4] drm/virtio: Replace IDRs with IDAs
Date: Wed, 26 Sep 2018 09:00:28 -0700
Message-ID: <20180926160031.15721-2-willy__9459.90545810691$1537977531$gmane$org@infradead.org>
References: <20180926160031.15721-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180926160031.15721-1-willy@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Matthew Wilcox <willy@infradead.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

These IDRs were only being used to allocate unique numbers, not to look
up pointers, so they can use the more space-efficient IDA instead.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h |  6 ++----
 drivers/gpu/drm/virtio/virtgpu_kms.c | 18 ++++--------------
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 12 ++----------
 3 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 65605e207bbe..c4468a4e454e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -180,8 +180,7 @@ struct virtio_gpu_device {
 	struct kmem_cache *vbufs;
 	bool vqs_ready;
 
-	struct idr	resource_idr;
-	spinlock_t resource_idr_lock;
+	struct ida	resource_ida;
 
 	wait_queue_head_t resp_wq;
 	/* current display info */
@@ -190,8 +189,7 @@ struct virtio_gpu_device {
 
 	struct virtio_gpu_fence_driver fence_drv;
 
-	struct idr	ctx_id_idr;
-	spinlock_t ctx_id_idr_lock;
+	struct ida	ctx_id_ida;
 
 	bool has_virgl_3d;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 65060c08522d..e2604fe1b4ae 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -55,21 +55,13 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 static void virtio_gpu_ctx_id_get(struct virtio_gpu_device *vgdev,
 				  uint32_t *resid)
 {
-	int handle;
-
-	idr_preload(GFP_KERNEL);
-	spin_lock(&vgdev->ctx_id_idr_lock);
-	handle = idr_alloc(&vgdev->ctx_id_idr, NULL, 1, 0, 0);
-	spin_unlock(&vgdev->ctx_id_idr_lock);
-	idr_preload_end();
+	int handle = ida_alloc_min(&vgdev->ctx_id_ida, 1, GFP_KERNEL);
 	*resid = handle;
 }
 
 static void virtio_gpu_ctx_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
 {
-	spin_lock(&vgdev->ctx_id_idr_lock);
-	idr_remove(&vgdev->ctx_id_idr, id);
-	spin_unlock(&vgdev->ctx_id_idr_lock);
+	ida_free(&vgdev->ctx_id_ida, id);
 }
 
 static void virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
@@ -151,10 +143,8 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
 	vgdev->dev = dev->dev;
 
 	spin_lock_init(&vgdev->display_info_lock);
-	spin_lock_init(&vgdev->ctx_id_idr_lock);
-	idr_init(&vgdev->ctx_id_idr);
-	spin_lock_init(&vgdev->resource_idr_lock);
-	idr_init(&vgdev->resource_idr);
+	ida_init(&vgdev->ctx_id_ida);
+	ida_init(&vgdev->resource_ida);
 	init_waitqueue_head(&vgdev->resp_wq);
 	virtio_gpu_init_vq(&vgdev->ctrlq, virtio_gpu_dequeue_ctrl_func);
 	virtio_gpu_init_vq(&vgdev->cursorq, virtio_gpu_dequeue_cursor_func);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 020070d483d3..58be09d2eed6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -41,21 +41,13 @@
 void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 				uint32_t *resid)
 {
-	int handle;
-
-	idr_preload(GFP_KERNEL);
-	spin_lock(&vgdev->resource_idr_lock);
-	handle = idr_alloc(&vgdev->resource_idr, NULL, 1, 0, GFP_NOWAIT);
-	spin_unlock(&vgdev->resource_idr_lock);
-	idr_preload_end();
+	int handle = ida_alloc_min(&vgdev->resource_ida, 1, GFP_KERNEL);
 	*resid = handle;
 }
 
 void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
 {
-	spin_lock(&vgdev->resource_idr_lock);
-	idr_remove(&vgdev->resource_idr, id);
-	spin_unlock(&vgdev->resource_idr_lock);
+	ida_free(&vgdev->resource_ida, id);
 }
 
 void virtio_gpu_ctrl_ack(struct virtqueue *vq)
-- 
2.19.0
