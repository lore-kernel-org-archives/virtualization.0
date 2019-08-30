From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/virtio: add worker for object release
Date: Fri, 30 Aug 2019 08:01:16 +0200
Message-ID: <20190830060116.10476-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, olvaffe@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Move object release into a separate worker.  Releasing objects requires
sending commands to the host.  Doing that in the dequeue worker will
cause deadlocks in case the command queue gets filled up, because the
dequeue worker is also the one which will free up slots in the command
queue.

Reported-by: Chia-I Wu <olvaffe@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h |  8 ++++++++
 drivers/gpu/drm/virtio/virtgpu_gem.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c |  6 ++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c  |  2 +-
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index fb35831ed351..314e02f94d9c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -78,6 +78,7 @@ struct virtio_gpu_object {
 
 struct virtio_gpu_object_array {
 	struct ww_acquire_ctx ticket;
+	struct list_head next;
 	u32 nents, total;
 	struct drm_gem_object *objs[];
 };
@@ -197,6 +198,10 @@ struct virtio_gpu_device {
 
 	struct work_struct config_changed_work;
 
+	struct work_struct obj_free_work;
+	spinlock_t obj_free_lock;
+	struct list_head obj_free_list;
+
 	struct virtio_gpu_drv_capset *capsets;
 	uint32_t num_capsets;
 	struct list_head cap_cache;
@@ -246,6 +251,9 @@ void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
 				struct dma_fence *fence);
 void virtio_gpu_array_put_free(struct virtio_gpu_object_array *objs);
+void virtio_gpu_array_put_free_delayed(struct virtio_gpu_device *vgdev,
+				       struct virtio_gpu_object_array *objs);
+void virtio_gpu_array_put_free_work(struct work_struct *work);
 
 /* virtio vg */
 int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index b812094ae916..4c1f579edfb3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -239,3 +239,30 @@ void virtio_gpu_array_put_free(struct virtio_gpu_object_array *objs)
 		drm_gem_object_put_unlocked(objs->objs[i]);
 	virtio_gpu_array_free(objs);
 }
+
+void virtio_gpu_array_put_free_delayed(struct virtio_gpu_device *vgdev,
+				       struct virtio_gpu_object_array *objs)
+{
+	spin_lock(&vgdev->obj_free_lock);
+	list_add_tail(&objs->next, &vgdev->obj_free_list);
+	spin_unlock(&vgdev->obj_free_lock);
+	schedule_work(&vgdev->obj_free_work);
+}
+
+void virtio_gpu_array_put_free_work(struct work_struct *work)
+{
+	struct virtio_gpu_device *vgdev =
+		container_of(work, struct virtio_gpu_device, obj_free_work);
+	struct virtio_gpu_object_array *objs;
+
+	spin_lock(&vgdev->obj_free_lock);
+	while (!list_empty(&vgdev->obj_free_list)) {
+		objs = list_first_entry(&vgdev->obj_free_list,
+					struct virtio_gpu_object_array, next);
+		list_del(&objs->next);
+		spin_unlock(&vgdev->obj_free_lock);
+		virtio_gpu_array_put_free(objs);
+		spin_lock(&vgdev->obj_free_lock);
+	}
+	spin_unlock(&vgdev->obj_free_lock);
+}
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 231c4e27b3b3..0b3cdb0d83b0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -147,6 +147,11 @@ int virtio_gpu_init(struct drm_device *dev)
 	INIT_WORK(&vgdev->config_changed_work,
 		  virtio_gpu_config_changed_work_func);
 
+	INIT_WORK(&vgdev->obj_free_work,
+		  virtio_gpu_array_put_free_work);
+	INIT_LIST_HEAD(&vgdev->obj_free_list);
+	spin_lock_init(&vgdev->obj_free_lock);
+
 #ifdef __LITTLE_ENDIAN
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
 		vgdev->has_virgl_3d = true;
@@ -226,6 +231,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
 {
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 
+	flush_work(&vgdev->obj_free_work);
 	vgdev->vqs_ready = false;
 	flush_work(&vgdev->ctrlq.dequeue_work);
 	flush_work(&vgdev->cursorq.dequeue_work);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index ecf57df965b0..595fa6ec2d58 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -227,7 +227,7 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
 
 	list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
 		if (entry->objs)
-			virtio_gpu_array_put_free(entry->objs);
+			virtio_gpu_array_put_free_delayed(vgdev, entry->objs);
 		list_del(&entry->list);
 		free_vbuf(vgdev, entry);
 	}
-- 
2.18.1
