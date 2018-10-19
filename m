From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 4/6] drm/virtio: use virtio_gpu_object->hw_res_handle in
	virtio_gpu_resource_create_ioctl()
Date: Fri, 19 Oct 2018 08:18:45 +0200
Message-ID: <20181019061847.18958-5-kraxel__27202.0349781544$1539929822$gmane$org@redhat.com>
References: <20181019061847.18958-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181019061847.18958-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Drop pointless res_id variable in virtio_gpu_resource_create_ioctl(),
just use the hw_res_handle field in virtio_gpu_object directly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 98bb238e91..ebb0920411 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -217,7 +217,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct drm_virtgpu_resource_create *rc = data;
 	int ret;
-	uint32_t res_id;
 	struct virtio_gpu_object *qobj;
 	struct drm_gem_object *obj;
 	uint32_t handle = 0;
@@ -244,8 +243,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	INIT_LIST_HEAD(&validate_list);
 	memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
 
-	virtio_gpu_resource_id_get(vgdev, &res_id);
-
 	size = rc->size;
 
 	/* allocate a single page size object */
@@ -253,17 +250,16 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		size = PAGE_SIZE;
 
 	qobj = virtio_gpu_alloc_object(dev, size, false, false);
-	if (IS_ERR(qobj)) {
-		ret = PTR_ERR(qobj);
-		goto fail_id;
-	}
+	if (IS_ERR(qobj))
+		return PTR_ERR(qobj);
 	obj = &qobj->gem_base;
+	virtio_gpu_resource_id_get(vgdev, &qobj->hw_res_handle);
 
 	if (!vgdev->has_virgl_3d) {
-		virtio_gpu_cmd_create_resource(vgdev, qobj, res_id, rc->format,
+		virtio_gpu_cmd_create_resource(vgdev, qobj, qobj->hw_res_handle, rc->format,
 					       rc->width, rc->height);
 
-		ret = virtio_gpu_object_attach(vgdev, qobj, res_id, NULL);
+		ret = virtio_gpu_object_attach(vgdev, qobj, qobj->hw_res_handle, NULL);
 	} else {
 		/* use a gem reference since unref list undoes them */
 		drm_gem_object_get(&qobj->gem_base);
@@ -276,7 +272,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 			goto fail_unref;
 		}
 
-		rc_3d.resource_id = cpu_to_le32(res_id);
+		rc_3d.resource_id = cpu_to_le32(qobj->hw_res_handle);
 		rc_3d.target = cpu_to_le32(rc->target);
 		rc_3d.format = cpu_to_le32(rc->format);
 		rc_3d.bind = cpu_to_le32(rc->bind);
@@ -289,7 +285,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		rc_3d.flags = cpu_to_le32(rc->flags);
 
 		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &rc_3d, NULL);
-		ret = virtio_gpu_object_attach(vgdev, qobj, res_id, &fence);
+		ret = virtio_gpu_object_attach(vgdev, qobj, qobj->hw_res_handle, &fence);
 		if (ret) {
 			ttm_eu_backoff_reservation(&ticket, &validate_list);
 			goto fail_unref;
@@ -297,8 +293,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		ttm_eu_fence_buffer_objects(&ticket, &validate_list, &fence->f);
 	}
 
-	qobj->hw_res_handle = res_id;
-
 	ret = drm_gem_handle_create(file_priv, obj, &handle);
 	if (ret) {
 
@@ -311,7 +305,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	}
 	drm_gem_object_put_unlocked(obj);
 
-	rc->res_handle = res_id; /* similiar to a VM address */
+	rc->res_handle = qobj->hw_res_handle; /* similiar to a VM address */
 	rc->bo_handle = handle;
 
 	if (vgdev->has_virgl_3d) {
@@ -326,8 +320,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	}
 //fail_obj:
 //	drm_gem_object_handle_unreference_unlocked(obj);
-fail_id:
-	virtio_gpu_resource_id_put(vgdev, res_id);
 	return ret;
 }
 
-- 
2.9.3
