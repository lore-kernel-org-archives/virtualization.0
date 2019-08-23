From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v8 10/18] drm/virtio: rework
	virtio_gpu_transfer_from_host_ioctl fencing
Date: Fri, 23 Aug 2019 11:54:55 +0200
Message-ID: <20190823095503.2261-11-kraxel__3247.10442671261$1566554181$gmane$org@redhat.com>
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

Switch to the virtio_gpu_array_* helper workflow.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 40 ++++++++++----------------
 drivers/gpu/drm/virtio/virtgpu_vq.c    |  8 ++++--
 3 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index c6ea65f6507e..fa568cbfdddc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -323,9 +323,10 @@ void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 			   struct virtio_gpu_object_array *objs,
 			   struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
-					  uint32_t resource_id, uint32_t ctx_id,
+					  uint32_t ctx_id,
 					  uint64_t offset, uint32_t level,
 					  struct virtio_gpu_box *box,
+					  struct virtio_gpu_object_array *objs,
 					  struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 					struct virtio_gpu_object *bo,
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 6baf43148e01..444696f73e96 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -340,9 +340,7 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 	struct drm_virtgpu_3d_transfer_from_host *args = data;
-	struct ttm_operation_ctx ctx = { true, false };
-	struct drm_gem_object *gobj = NULL;
-	struct virtio_gpu_object *qobj = NULL;
+	struct virtio_gpu_object_array *objs;
 	struct virtio_gpu_fence *fence;
 	int ret;
 	u32 offset = args->offset;
@@ -351,39 +349,31 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
 	if (vgdev->has_virgl_3d == false)
 		return -ENOSYS;
 
-	gobj = drm_gem_object_lookup(file, args->bo_handle);
-	if (gobj == NULL)
+	objs = virtio_gpu_array_from_handles(file, &args->bo_handle, 1);
+	if (objs == NULL)
 		return -ENOENT;
 
-	qobj = gem_to_virtio_gpu_obj(gobj);
-
-	ret = virtio_gpu_object_reserve(qobj);
-	if (ret)
-		goto out;
-
-	ret = ttm_bo_validate(&qobj->tbo, &qobj->placement, &ctx);
-	if (unlikely(ret))
-		goto out_unres;
+	ret = virtio_gpu_array_lock_resv(objs);
+	if (ret != 0)
+		goto err_put_free;
 
 	convert_to_hw_box(&box, &args->box);
 
 	fence = virtio_gpu_fence_alloc(vgdev);
 	if (!fence) {
 		ret = -ENOMEM;
-		goto out_unres;
+		goto err_unlock;
 	}
 	virtio_gpu_cmd_transfer_from_host_3d
-		(vgdev, qobj->hw_res_handle,
-		 vfpriv->ctx_id, offset, args->level,
-		 &box, fence);
-	dma_resv_add_excl_fence(qobj->tbo.base.resv,
-					  &fence->f);
-
+		(vgdev, vfpriv->ctx_id, offset, args->level,
+		 &box, objs, fence);
 	dma_fence_put(&fence->f);
-out_unres:
-	virtio_gpu_object_unreserve(qobj);
-out:
-	drm_gem_object_put_unlocked(gobj);
+	return 0;
+
+err_unlock:
+	virtio_gpu_array_unlock_resv(objs);
+err_put_free:
+	virtio_gpu_array_put_free(objs);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 079907e8a596..59d32787944d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -929,20 +929,24 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 }
 
 void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
-					  uint32_t resource_id, uint32_t ctx_id,
+					  uint32_t ctx_id,
 					  uint64_t offset, uint32_t level,
 					  struct virtio_gpu_box *box,
+					  struct virtio_gpu_object_array *objs,
 					  struct virtio_gpu_fence *fence)
 {
+	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
 	struct virtio_gpu_transfer_host_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
 
+	vbuf->objs = objs;
+
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D);
 	cmd_p->hdr.ctx_id = cpu_to_le32(ctx_id);
-	cmd_p->resource_id = cpu_to_le32(resource_id);
+	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
 	cmd_p->box = *box;
 	cmd_p->offset = cpu_to_le64(offset);
 	cmd_p->level = cpu_to_le32(level);
-- 
2.18.1
