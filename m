From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 08/10] drm/virtio: drop fencing in
	virtio_gpu_resource_create_ioctl
Date: Wed, 19 Dec 2018 13:27:06 +0100
Message-ID: <20181219122708.4586-9-kraxel__33075.5551498898$1545222394$gmane$org@redhat.com>
References: <20181219122708.4586-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181219122708.4586-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

There is no need to wait for completion here.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 51 +---------------------------------
 1 file changed, 1 insertion(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 52d6ec2dde..65ac61f86a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -279,10 +279,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	struct virtio_gpu_object *qobj;
 	struct drm_gem_object *obj;
 	uint32_t handle = 0;
-	struct list_head validate_list;
-	struct ttm_validate_buffer mainbuf;
-	struct virtio_gpu_fence *fence = NULL;
-	struct ww_acquire_ctx ticket;
 	struct virtio_gpu_object_params params = {
 		.pinned = false,
 	};
@@ -300,9 +296,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 			return -EINVAL;
 	}
 
-	INIT_LIST_HEAD(&validate_list);
-	memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
-
 	params.format = rc->format;
 	params.width = rc->width;
 	params.height = rc->height;
@@ -330,62 +323,20 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 
 		ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
 	} else {
-		/* use a gem reference since unref list undoes them */
-		drm_gem_object_get(&qobj->gem_base);
-		mainbuf.bo = &qobj->tbo;
-		list_add(&mainbuf.head, &validate_list);
-
-		ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
-		if (ret) {
-			DRM_DEBUG("failed to validate\n");
-			goto fail_unref;
-		}
-
-		fence = virtio_gpu_fence_alloc(vgdev);
-		if (!fence) {
-			ret = -ENOMEM;
-			goto fail_backoff;
-		}
-
 		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &params);
-		ret = virtio_gpu_object_attach(vgdev, qobj, fence);
-		if (ret) {
-			dma_fence_put(&fence->f);
-			goto fail_backoff;
-		}
-		ttm_eu_fence_buffer_objects(&ticket, &validate_list, &fence->f);
+		ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
 	}
 
 	ret = drm_gem_handle_create(file_priv, obj, &handle);
 	if (ret) {
-
 		drm_gem_object_release(obj);
-		if (vgdev->has_virgl_3d) {
-			virtio_gpu_unref_list(&validate_list);
-			dma_fence_put(&fence->f);
-		}
 		return ret;
 	}
 	drm_gem_object_put_unlocked(obj);
 
 	rc->res_handle = qobj->hw_res_handle; /* similiar to a VM address */
 	rc->bo_handle = handle;
-
-	if (vgdev->has_virgl_3d) {
-		virtio_gpu_unref_list(&validate_list);
-		dma_fence_put(&fence->f);
-	}
 	return 0;
-fail_backoff:
-	ttm_eu_backoff_reservation(&ticket, &validate_list);
-fail_unref:
-	if (vgdev->has_virgl_3d) {
-		virtio_gpu_unref_list(&validate_list);
-		dma_fence_put(&fence->f);
-	}
-//fail_obj:
-//	drm_gem_object_handle_unreference_unlocked(obj);
-	return ret;
 }
 
 static int virtio_gpu_resource_info_ioctl(struct drm_device *dev, void *data,
-- 
2.9.3
