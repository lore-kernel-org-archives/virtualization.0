From: Gustavo Padovan <gustavo@padovan.org>
Subject: [RFC 1/5] drm/virtio: add virtio_gpu_alloc_fence()
Date: Mon, 12 Dec 2016 18:48:25 -0200
Message-ID: <1481575710-12535-1-git-send-email-gustavo@padovan.org>
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
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, robdclark@gmail.com, Gustavo Padovan <gustavo.padovan@collabora.co.uk>
List-Id: virtualization@lists.linuxfoundation.org

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Refactor fence creation to remove the potential allocation failure from
the cmd_submit and atomic_commit paths. Now the fence should be allocated
first and just after we should proceed with the rest of the execution.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 17 +++++++------
 drivers/gpu/drm/virtio/virtgpu_fence.c | 36 +++++++++++++++++---------
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 32 ++++++++++++++++++++---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 46 ++++++++++++++++++++++++++++++----
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 16 ++++++------
 5 files changed, 111 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 08906c8..806c98b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -127,6 +127,7 @@ struct virtio_gpu_framebuffer {
 	int x1, y1, x2, y2; /* dirty rect */
 	spinlock_t dirty_lock;
 	uint32_t hw_res_handle;
+	struct virtio_gpu_fence *fence;
 };
 #define to_virtio_gpu_framebuffer(x) \
 	container_of(x, struct virtio_gpu_framebuffer, base)
@@ -268,7 +269,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 					uint32_t resource_id, uint64_t offset,
 					__le32 width, __le32 height,
 					__le32 x, __le32 y,
-					struct virtio_gpu_fence **fence);
+					struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_resource_flush(struct virtio_gpu_device *vgdev,
 				   uint32_t resource_id,
 				   uint32_t x, uint32_t y,
@@ -280,7 +281,7 @@ void virtio_gpu_cmd_set_scanout(struct virtio_gpu_device *vgdev,
 int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
 			     uint32_t resource_id,
-			     struct virtio_gpu_fence **fence);
+			     struct virtio_gpu_fence *fence);
 int virtio_gpu_attach_status_page(struct virtio_gpu_device *vgdev);
 int virtio_gpu_detach_status_page(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cursor_ping(struct virtio_gpu_device *vgdev,
@@ -304,21 +305,21 @@ void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
 					    uint32_t resource_id);
 void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 			   void *data, uint32_t data_size,
-			   uint32_t ctx_id, struct virtio_gpu_fence **fence);
+			   uint32_t ctx_id, struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 					  uint32_t resource_id, uint32_t ctx_id,
 					  uint64_t offset, uint32_t level,
 					  struct virtio_gpu_box *box,
-					  struct virtio_gpu_fence **fence);
+					  struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 					uint32_t resource_id, uint32_t ctx_id,
 					uint64_t offset, uint32_t level,
 					struct virtio_gpu_box *box,
-					struct virtio_gpu_fence **fence);
+					struct virtio_gpu_fence *fence);
 void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_resource_create_3d *rc_3d,
-				  struct virtio_gpu_fence **fence);
+				  struct virtio_gpu_fence *fence);
 void virtio_gpu_ctrl_ack(struct virtqueue *vq);
 void virtio_gpu_cursor_ack(struct virtqueue *vq);
 void virtio_gpu_fence_ack(struct virtqueue *vq);
@@ -345,9 +346,11 @@ void virtio_gpu_ttm_fini(struct virtio_gpu_device *vgdev);
 int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma);
 
 /* virtio_gpu_fence.c */
+struct virtio_gpu_fence *virtio_gpu_fence_alloc(
+					struct virtio_gpu_device *vgdev);
 int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
-			  struct virtio_gpu_fence **fence);
+			  struct virtio_gpu_fence *fence);
 void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
 				    u64 last_seq);
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
index 2335352..4dbfe44 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -74,28 +74,40 @@ static const struct dma_fence_ops virtio_fence_ops = {
 	.timeline_value_str  = virtio_timeline_value_str,
 };
 
+struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev)
+{
+	struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
+	struct virtio_gpu_fence *fence;
+	unsigned long irq_flags;
+
+	fence = kmalloc(sizeof(struct virtio_gpu_fence), GFP_ATOMIC);
+	if (!fence)
+		return NULL;
+
+	spin_lock_irqsave(&drv->lock, irq_flags);
+	fence->drv = drv;
+	fence->seq = ++drv->sync_seq;
+	dma_fence_init(&fence->f, &virtio_fence_ops, &drv->lock,
+		       drv->context, fence->seq);
+	spin_unlock_irqrestore(&drv->lock, irq_flags);
+
+	return fence;
+}
+
 int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
-			  struct virtio_gpu_fence **fence)
+			  struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
 	unsigned long irq_flags;
 
-	*fence = kmalloc(sizeof(struct virtio_gpu_fence), GFP_ATOMIC);
-	if ((*fence) == NULL)
-		return -ENOMEM;
-
 	spin_lock_irqsave(&drv->lock, irq_flags);
-	(*fence)->drv = drv;
-	(*fence)->seq = ++drv->sync_seq;
-	dma_fence_init(&(*fence)->f, &virtio_fence_ops, &drv->lock,
-		       drv->context, (*fence)->seq);
-	dma_fence_get(&(*fence)->f);
-	list_add_tail(&(*fence)->node, &drv->fences);
+	dma_fence_get(&fence->f);
+	list_add_tail(&fence->node, &drv->fences);
 	spin_unlock_irqrestore(&drv->lock, irq_flags);
 
 	cmd_hdr->flags |= cpu_to_le32(VIRTIO_GPU_FLAG_FENCE);
-	cmd_hdr->fence_id = cpu_to_le64((*fence)->seq);
+	cmd_hdr->fence_id = cpu_to_le64(fence->seq);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 61f3a96..da281103 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -164,8 +164,15 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		ret = PTR_ERR(buf);
 		goto out_unresv;
 	}
+
+	fence = virtio_gpu_fence_alloc(vgdev);
+	if (!fence) {
+		kfree(buf);
+		ret = -ENOMEM;
+		goto out_unresv;
+	}
 	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
-			      vfpriv->ctx_id, &fence);
+			      vfpriv->ctx_id, fence);
 
 	ttm_eu_fence_buffer_objects(&ticket, &validate_list, &fence->f);
 
@@ -281,8 +288,14 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		rc_3d.nr_samples = cpu_to_le32(rc->nr_samples);
 		rc_3d.flags = cpu_to_le32(rc->flags);
 
+		fence = virtio_gpu_fence_alloc(vgdev);
+		if (!fence) {
+			ret = -ENOMEM;
+			goto fail_unref;
+		}
+
 		virtio_gpu_cmd_resource_create_3d(vgdev, &rc_3d, NULL);
-		ret = virtio_gpu_object_attach(vgdev, qobj, res_id, &fence);
+		ret = virtio_gpu_object_attach(vgdev, qobj, res_id, fence);
 		if (ret) {
 			ttm_eu_backoff_reservation(&ticket, &validate_list);
 			goto fail_unref;
@@ -376,10 +389,16 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
 		goto out_unres;
 
 	convert_to_hw_box(&box, &args->box);
+
+	fence = virtio_gpu_fence_alloc(vgdev);
+	if (!fence) {
+		ret = -ENOMEM;
+		goto out_unres;
+	}
 	virtio_gpu_cmd_transfer_from_host_3d
 		(vgdev, qobj->hw_res_handle,
 		 vfpriv->ctx_id, offset, args->level,
-		 &box, &fence);
+		 &box, fence);
 	reservation_object_add_excl_fence(qobj->tbo.resv,
 					  &fence->f);
 
@@ -425,10 +444,15 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
 			(vgdev, qobj->hw_res_handle, offset,
 			 box.w, box.h, box.x, box.y, NULL);
 	} else {
+		fence = virtio_gpu_fence_alloc(vgdev);
+		if (!fence) {
+			ret = -ENOMEM;
+			goto out_unres;
+		}
 		virtio_gpu_cmd_transfer_to_host_3d
 			(vgdev, qobj->hw_res_handle,
 			 vfpriv ? vfpriv->ctx_id : 0, offset,
-			 args->level, &box, &fence);
+			 args->level, &box, fence);
 		reservation_object_add_excl_fence(qobj->tbo.resv,
 						  &fence->f);
 		dma_fence_put(&fence->f);
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 05022ef..77415e5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -115,6 +115,41 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 				      plane->state->src_h >> 16);
 }
 
+static int virtio_gpu_cursor_prepare_fb(struct drm_plane *plane,
+					struct drm_plane_state *new_state)
+{
+	struct drm_device *dev = plane->dev;
+	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_object *bo;
+
+	if (!new_state->fb)
+		return 0;
+
+	vgfb = to_virtio_gpu_framebuffer(new_state->fb);
+	bo = gem_to_virtio_gpu_obj(vgfb->obj);
+	if (bo && bo->dumb && (plane->state->fb != new_state->fb)) {
+		vgfb->fence = virtio_gpu_fence_alloc(vgdev);
+		if (!vgfb->fence)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void virtio_gpu_cursor_cleanup_fb(struct drm_plane *plane,
+					 struct drm_plane_state *old_state)
+{
+	struct virtio_gpu_framebuffer *vgfb;
+
+	if (!plane->state->fb)
+		return;
+
+	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
+	if (vgfb->fence)
+		dma_fence_put(&vgfb->fence->f);
+}
+
 static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 					   struct drm_plane_state *old_state)
 {
@@ -122,7 +157,6 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_output *output = NULL;
 	struct virtio_gpu_framebuffer *vgfb;
-	struct virtio_gpu_fence *fence = NULL;
 	struct virtio_gpu_object *bo = NULL;
 	uint32_t handle;
 	int ret = 0;
@@ -148,13 +182,13 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 			(vgdev, handle, 0,
 			 cpu_to_le32(plane->state->crtc_w),
 			 cpu_to_le32(plane->state->crtc_h),
-			 0, 0, &fence);
+			 0, 0, vgfb->fence);
 		ret = virtio_gpu_object_reserve(bo, false);
 		if (!ret) {
 			reservation_object_add_excl_fence(bo->tbo.resv,
-							  &fence->f);
-			dma_fence_put(&fence->f);
-			fence = NULL;
+							  &vgfb->fence->f);
+			dma_fence_put(&vgfb->fence->f);
+			vgfb->fence = NULL;
 			virtio_gpu_object_unreserve(bo);
 			virtio_gpu_object_wait(bo, false);
 		}
@@ -196,6 +230,8 @@ static const struct drm_plane_helper_funcs virtio_gpu_primary_helper_funcs = {
 };
 
 static const struct drm_plane_helper_funcs virtio_gpu_cursor_helper_funcs = {
+	.prepare_fb		= virtio_gpu_cursor_prepare_fb,
+	.cleanup_fb		= virtio_gpu_cursor_cleanup_fb,
 	.atomic_check		= virtio_gpu_plane_atomic_check,
 	.atomic_update		= virtio_gpu_cursor_plane_update,
 };
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 974f941..e7c3e8d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -350,7 +350,7 @@ static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
 static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 					       struct virtio_gpu_vbuffer *vbuf,
 					       struct virtio_gpu_ctrl_hdr *hdr,
-					       struct virtio_gpu_fence **fence)
+					       struct virtio_gpu_fence *fence)
 {
 	struct virtqueue *vq = vgdev->ctrlq.vq;
 	int rc;
@@ -515,7 +515,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 					uint32_t resource_id, uint64_t offset,
 					__le32 width, __le32 height,
 					__le32 x, __le32 y,
-					struct virtio_gpu_fence **fence)
+					struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_transfer_to_host_2d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -539,7 +539,7 @@ virtio_gpu_cmd_resource_attach_backing(struct virtio_gpu_device *vgdev,
 				       uint32_t resource_id,
 				       struct virtio_gpu_mem_entry *ents,
 				       uint32_t nents,
-				       struct virtio_gpu_fence **fence)
+				       struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_resource_attach_backing *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -795,7 +795,7 @@ void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
 void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_resource_create_3d *rc_3d,
-				  struct virtio_gpu_fence **fence)
+				  struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_resource_create_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -814,7 +814,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 					uint32_t resource_id, uint32_t ctx_id,
 					uint64_t offset, uint32_t level,
 					struct virtio_gpu_box *box,
-					struct virtio_gpu_fence **fence)
+					struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_transfer_host_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -836,7 +836,7 @@ void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 					  uint32_t resource_id, uint32_t ctx_id,
 					  uint64_t offset, uint32_t level,
 					  struct virtio_gpu_box *box,
-					  struct virtio_gpu_fence **fence)
+					  struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_transfer_host_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -856,7 +856,7 @@ void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 
 void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 			   void *data, uint32_t data_size,
-			   uint32_t ctx_id, struct virtio_gpu_fence **fence)
+			   uint32_t ctx_id, struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_cmd_submit *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -877,7 +877,7 @@ void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
 			     uint32_t resource_id,
-			     struct virtio_gpu_fence **fence)
+			     struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_mem_entry *ents;
 	struct scatterlist *sg;
-- 
2.5.5
