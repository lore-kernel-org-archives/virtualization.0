From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 3/4] drm/virtio: Handle object ID allocation errors
Date: Wed, 26 Sep 2018 09:00:30 -0700
Message-ID: <20180926160031.15721-4-willy__24604.0051257753$1537977554$gmane$org@infradead.org>
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

It is possible to run out of memory while allocating IDs.  The current
code would create an object with an invalid ID; change it to return
-ENOMEM to the caller.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 +--
 drivers/gpu/drm/virtio/virtgpu_fb.c    | 10 ++++++++--
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 10 ++++++++--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 ++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c    |  6 ++----
 5 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index c4468a4e454e..0a3392f2cda3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -247,8 +247,7 @@ int virtio_gpu_surface_dirty(struct virtio_gpu_framebuffer *qfb,
 /* virtio vg */
 int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
-void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
-			       uint32_t *resid);
+int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev);
 void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    uint32_t resource_id,
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index a121b1c79522..74d815483487 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -244,14 +244,17 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
 
-	virtio_gpu_resource_id_get(vgdev, &resid);
+	ret = virtio_gpu_resource_id_get(vgdev);
+	if (ret < 0)
+		goto err_obj_vmap;
+	resid = ret;
 	virtio_gpu_cmd_create_resource(vgdev, resid, format,
 				       mode_cmd.width, mode_cmd.height);
 
 	ret = virtio_gpu_vmap_fb(vgdev, obj);
 	if (ret) {
 		DRM_ERROR("failed to vmap fb %d\n", ret);
-		goto err_obj_vmap;
+		goto err_obj_id;
 	}
 
 	/* attach the object to the resource */
@@ -293,8 +296,11 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 err_fb_alloc:
 	virtio_gpu_cmd_resource_inval_backing(vgdev, resid);
 err_obj_attach:
+err_obj_id:
+	virtio_gpu_resource_id_put(vgdev, resid);
 err_obj_vmap:
 	virtio_gpu_gem_free_object(&obj->gem_base);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 0f2768eacaee..9e3af1ec26db 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -100,7 +100,10 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 		goto fail;
 
 	format = virtio_gpu_translate_format(DRM_FORMAT_XRGB8888);
-	virtio_gpu_resource_id_get(vgdev, &resid);
+	ret = virtio_gpu_resource_id_get(vgdev);
+	if (ret < 0)
+		goto fail;
+	resid = ret;
 	virtio_gpu_cmd_create_resource(vgdev, resid, format,
 				       args->width, args->height);
 
@@ -108,13 +111,16 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	obj = gem_to_virtio_gpu_obj(gobj);
 	ret = virtio_gpu_object_attach(vgdev, obj, resid, NULL);
 	if (ret)
-		goto fail;
+		goto fail_id;
 
 	obj->dumb = true;
 	args->pitch = pitch;
 	return ret;
 
+fail_id:
+	virtio_gpu_resource_id_put(vgdev, resid);
 fail:
+	/* Shouldn't we undo virtio_gpu_gem_create()? */
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 7bdf6f0e58a5..eec9f09f01f0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -244,7 +244,10 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	INIT_LIST_HEAD(&validate_list);
 	memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
 
-	virtio_gpu_resource_id_get(vgdev, &res_id);
+	ret = virtio_gpu_resource_id_get(vgdev);
+	if (ret < 0)
+		return ret;
+	res_id = ret;
 
 	size = rc->size;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 58be09d2eed6..387951c971d4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -38,11 +38,9 @@
 			       + MAX_INLINE_CMD_SIZE		 \
 			       + MAX_INLINE_RESP_SIZE)
 
-void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
-				uint32_t *resid)
+int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev)
 {
-	int handle = ida_alloc_min(&vgdev->resource_ida, 1, GFP_KERNEL);
-	*resid = handle;
+	return ida_alloc_min(&vgdev->resource_ida, 1, GFP_KERNEL);
 }
 
 void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
-- 
2.19.0
