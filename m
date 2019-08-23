From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v8 09/18] drm/virtio: rework virtio_gpu_object_create fencing
Date: Fri, 23 Aug 2019 11:54:54 +0200
Message-ID: <20190823095503.2261-10-kraxel__3930.32096778683$1566554153$gmane$org@redhat.com>
References: <20190823095503.2261-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190823095503.2261-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, gurchetansingh@chromium.org, olvaffe@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Rework fencing workflow.  Stop using ttm helpers, use the
virtio_gpu_array_* helpers instead.

Due to using the gem reservation object it is initialized and ready for
use before calling ttm_bo_init.  So we can simply use the standard
fencing workflow and drop the tricky logic which checks whenever the
command is in flight still.

v6: rewrite most of the patch.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  2 +
 drivers/gpu/drm/virtio/virtgpu_object.c | 74 +++++++++++--------------
 drivers/gpu/drm/virtio/virtgpu_vq.c     |  4 ++
 3 files changed, 37 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f4f843aec18a..c6ea65f6507e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -274,6 +274,7 @@ void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
 				    struct virtio_gpu_object_params *params,
+				    struct virtio_gpu_object_array *objs,
 				    struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
 				   uint32_t resource_id);
@@ -336,6 +337,7 @@ void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
 				  struct virtio_gpu_object_params *params,
+				  struct virtio_gpu_object_array *objs,
 				  struct virtio_gpu_fence *fence);
 void virtio_gpu_ctrl_ack(struct virtqueue *vq);
 void virtio_gpu_cursor_ack(struct virtqueue *vq);
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 82bfbf983fd2..2902487f051a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -97,6 +97,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object **bo_ptr,
 			     struct virtio_gpu_fence *fence)
 {
+	struct virtio_gpu_object_array *objs = NULL;
 	struct virtio_gpu_object *bo;
 	size_t acc_size;
 	int ret;
@@ -110,23 +111,34 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 	if (bo == NULL)
 		return -ENOMEM;
 	ret = virtio_gpu_resource_id_get(vgdev, &bo->hw_res_handle);
-	if (ret < 0) {
-		kfree(bo);
-		return ret;
-	}
+	if (ret < 0)
+		goto err_free_gem;
+
 	params->size = roundup(params->size, PAGE_SIZE);
 	ret = drm_gem_object_init(vgdev->ddev, &bo->gem_base, params->size);
-	if (ret != 0) {
-		virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
-		kfree(bo);
-		return ret;
-	}
+	if (ret != 0)
+		goto err_put_id;
+
 	bo->dumb = params->dumb;
 
+	if (fence) {
+		ret = -ENOMEM;
+		objs = virtio_gpu_array_alloc(1);
+		if (!objs)
+			goto err_put_id;
+		virtio_gpu_array_add_obj(objs, &bo->gem_base);
+
+		ret = virtio_gpu_array_lock_resv(objs);
+		if (ret != 0)
+			goto err_put_objs;
+	}
+
 	if (params->virgl) {
-		virtio_gpu_cmd_resource_create_3d(vgdev, bo, params, fence);
+		virtio_gpu_cmd_resource_create_3d(vgdev, bo, params,
+						  objs, fence);
 	} else {
-		virtio_gpu_cmd_create_resource(vgdev, bo, params, fence);
+		virtio_gpu_cmd_create_resource(vgdev, bo, params,
+					       objs, fence);
 	}
 
 	virtio_gpu_init_ttm_placement(bo);
@@ -139,40 +151,16 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 	if (ret != 0)
 		return ret;
 
-	if (fence) {
-		struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
-		struct list_head validate_list;
-		struct ttm_validate_buffer mainbuf;
-		struct ww_acquire_ctx ticket;
-		unsigned long irq_flags;
-		bool signaled;
-
-		INIT_LIST_HEAD(&validate_list);
-		memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
-
-		/* use a gem reference since unref list undoes them */
-		drm_gem_object_get(&bo->gem_base);
-		mainbuf.bo = &bo->tbo;
-		list_add(&mainbuf.head, &validate_list);
-
-		ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
-		if (ret == 0) {
-			spin_lock_irqsave(&drv->lock, irq_flags);
-			signaled = virtio_fence_signaled(&fence->f);
-			if (!signaled)
-				/* virtio create command still in flight */
-				ttm_eu_fence_buffer_objects(&ticket, &validate_list,
-							    &fence->f);
-			spin_unlock_irqrestore(&drv->lock, irq_flags);
-			if (signaled)
-				/* virtio create command finished */
-				ttm_eu_backoff_reservation(&ticket, &validate_list);
-		}
-		virtio_gpu_unref_list(&validate_list);
-	}
-
 	*bo_ptr = bo;
 	return 0;
+
+err_put_objs:
+	virtio_gpu_array_put_free(objs);
+err_put_id:
+	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
+err_free_gem:
+	kfree(bo);
+	return ret;
 }
 
 void virtio_gpu_object_kunmap(struct virtio_gpu_object *bo)
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 24245c37d69f..079907e8a596 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -396,6 +396,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
 				    struct virtio_gpu_object_params *params,
+				    struct virtio_gpu_object_array *objs,
 				    struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_resource_create_2d *cmd_p;
@@ -403,6 +404,7 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
+	vbuf->objs = objs;
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_2D);
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
@@ -869,6 +871,7 @@ void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
 				  struct virtio_gpu_object_params *params,
+				  struct virtio_gpu_object_array *objs,
 				  struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_resource_create_3d *cmd_p;
@@ -876,6 +879,7 @@ virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
+	vbuf->objs = objs;
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_3D);
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
-- 
2.18.1
