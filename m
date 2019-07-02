From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v6 07/18] drm/virtio: add virtio_gpu_object_array & helpers
Date: Tue,  2 Jul 2019 16:18:52 +0200
Message-ID: <20190702141903.1131-8-kraxel__26515.1126122632$1562077406$gmane$org@redhat.com>
References: <20190702141903.1131-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190702141903.1131-1-kraxel@redhat.com>
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

Some helper functions to manage an array of gem objects.

v6:
 - add ticket to struct virtio_gpu_object_array.
 - add virtio_gpu_array_{lock,unlock}_resv helpers.
 - add virtio_gpu_array_add_fence helper.
v5: some small optimizations (Chia-I Wu).
v4: make them virtio-private instead of generic helpers.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h | 17 ++++++
 drivers/gpu/drm/virtio/virtgpu_gem.c | 83 ++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 07f6001ea91e..abb078a5dedf 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -84,6 +84,12 @@ struct virtio_gpu_object {
 #define gem_to_virtio_gpu_obj(gobj) \
 	container_of((gobj), struct virtio_gpu_object, gem_base)
 
+struct virtio_gpu_object_array {
+	struct ww_acquire_ctx ticket;
+	u32 nents, total;
+	struct drm_gem_object *objs[];
+};
+
 struct virtio_gpu_vbuffer;
 struct virtio_gpu_device;
 
@@ -251,6 +257,17 @@ int virtio_gpu_mode_dumb_mmap(struct drm_file *file_priv,
 			      struct drm_device *dev,
 			      uint32_t handle, uint64_t *offset_p);
 
+struct virtio_gpu_object_array *virtio_gpu_array_alloc(u32 nents);
+struct virtio_gpu_object_array*
+virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents);
+void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
+			      struct drm_gem_object *obj);
+int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs);
+void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs);
+void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
+				struct dma_fence *fence);
+void virtio_gpu_array_put_free(struct virtio_gpu_object_array *objs);
+
 /* virtio vg */
 int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 9c9ad3b14080..e88df5e06d06 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -169,3 +169,86 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
 						qobj->hw_res_handle);
 	virtio_gpu_object_unreserve(qobj);
 }
+
+struct virtio_gpu_object_array *virtio_gpu_array_alloc(u32 nents)
+{
+	struct virtio_gpu_object_array *objs;
+	size_t size = sizeof(*objs) + sizeof(objs->objs[0]) * nents;
+
+	objs = kmalloc(size, GFP_KERNEL);
+	if (!objs)
+		return NULL;
+
+	objs->nents = 0;
+	objs->total = nents;
+	return objs;
+}
+
+static void virtio_gpu_array_free(struct virtio_gpu_object_array *objs)
+{
+	kfree(objs);
+}
+
+struct virtio_gpu_object_array*
+virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents)
+{
+	struct virtio_gpu_object_array *objs;
+	u32 i;
+
+	objs = virtio_gpu_array_alloc(nents);
+	if (!objs)
+		return NULL;
+
+	for (i = 0; i < nents; i++) {
+		objs->nents = i;
+		objs->objs[i] = drm_gem_object_lookup(drm_file, handles[i]);
+		if (!objs->objs[i]) {
+			virtio_gpu_array_put_free(objs);
+			return NULL;
+		}
+	}
+	objs->nents = i;
+	return objs;
+}
+
+void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
+			      struct drm_gem_object *obj)
+{
+	if (WARN_ON_ONCE(objs->nents == objs->total))
+		return;
+
+	drm_gem_object_get(obj);
+	objs->objs[objs->nents] = obj;
+	objs->nents++;
+}
+
+int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
+{
+	return drm_gem_lock_reservations(objs->objs, objs->nents,
+					 &objs->ticket);
+}
+
+void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs)
+{
+	drm_gem_unlock_reservations(objs->objs, objs->nents,
+				    &objs->ticket);
+}
+
+void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
+				struct dma_fence *fence)
+{
+	int i;
+
+	for (i = 0; i < objs->nents; i++)
+		reservation_object_add_excl_fence(objs->objs[i]->resv,
+						  fence);
+}
+
+void virtio_gpu_array_put_free(struct virtio_gpu_object_array *objs)
+{
+	u32 i;
+
+	for (i = 0; i < objs->nents; i++)
+		drm_gem_object_put_unlocked(objs->objs[i]);
+	virtio_gpu_array_free(objs);
+}
-- 
2.18.1
