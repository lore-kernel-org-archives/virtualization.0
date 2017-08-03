From: Cihangir Akturk <cakturk@gmail.com>
Subject: [PATCH 27/29] drm/virtio: switch to drm_*{get,put} helpers
Date: Thu,  3 Aug 2017 14:58:42 +0300
Message-ID: <1501761585-11757-28-git-send-email-cakturk__2932.90465274385$1509078930$gmane$org@gmail.com>
References: <1501761585-11757-1-git-send-email-cakturk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1501761585-11757-1-git-send-email-cakturk@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Cihangir Akturk <cakturk@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

drm_*_reference() and drm_*_unreference() functions are just
compatibility alias for drm_*_get() and drm_*_put() adn should not be
used by new code. So convert all users of compatibility functions to use
the new APIs.

Signed-off-by: Cihangir Akturk <cakturk@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_gem.c     |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index d51bd45..ef2d450 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -53,7 +53,7 @@ static void virtio_gpu_user_framebuffer_destroy(struct drm_framebuffer *fb)
 	struct virtio_gpu_framebuffer *virtio_gpu_fb
 		= to_virtio_gpu_framebuffer(fb);
 
-	drm_gem_object_unreference_unlocked(virtio_gpu_fb->obj);
+	drm_gem_object_put_unlocked(virtio_gpu_fb->obj);
 	drm_framebuffer_cleanup(fb);
 	kfree(virtio_gpu_fb);
 }
@@ -326,7 +326,7 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 	ret = virtio_gpu_framebuffer_init(dev, virtio_gpu_fb, mode_cmd, obj);
 	if (ret) {
 		kfree(virtio_gpu_fb);
-		drm_gem_object_unreference_unlocked(obj);
+		drm_gem_object_put_unlocked(obj);
 		return NULL;
 	}
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index cc025d8..78da210 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -72,7 +72,7 @@ int virtio_gpu_gem_create(struct drm_file *file,
 	*obj_p = &obj->gem_base;
 
 	/* drop reference from allocate - handle holds it now */
-	drm_gem_object_unreference_unlocked(&obj->gem_base);
+	drm_gem_object_put_unlocked(&obj->gem_base);
 
 	*handle_p = handle;
 	return 0;
@@ -137,7 +137,7 @@ int virtio_gpu_mode_dumb_mmap(struct drm_file *file_priv,
 		return -ENOENT;
 	obj = gem_to_virtio_gpu_obj(gobj);
 	*offset_p = virtio_gpu_object_mmap_offset(obj);
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index b94bd54..461f81a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -86,7 +86,7 @@ static void virtio_gpu_unref_list(struct list_head *head)
 		bo = buf->bo;
 		qobj = container_of(bo, struct virtio_gpu_object, tbo);
 
-		drm_gem_object_unreference_unlocked(&qobj->gem_base);
+		drm_gem_object_put_unlocked(&qobj->gem_base);
 	}
 }
 
@@ -261,7 +261,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		ret = virtio_gpu_object_attach(vgdev, qobj, res_id, NULL);
 	} else {
 		/* use a gem reference since unref list undoes them */
-		drm_gem_object_reference(&qobj->gem_base);
+		drm_gem_object_get(&qobj->gem_base);
 		mainbuf.bo = &qobj->tbo;
 		list_add(&mainbuf.head, &validate_list);
 
@@ -304,7 +304,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		}
 		return ret;
 	}
-	drm_gem_object_unreference_unlocked(obj);
+	drm_gem_object_put_unlocked(obj);
 
 	rc->res_handle = res_id; /* similiar to a VM address */
 	rc->bo_handle = handle;
@@ -341,7 +341,7 @@ static int virtio_gpu_resource_info_ioctl(struct drm_device *dev, void *data,
 
 	ri->size = qobj->gem_base.size;
 	ri->res_handle = qobj->hw_res_handle;
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	return 0;
 }
 
@@ -389,7 +389,7 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
 out_unres:
 	virtio_gpu_object_unreserve(qobj);
 out:
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	return ret;
 }
 
@@ -439,7 +439,7 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
 out_unres:
 	virtio_gpu_object_unreserve(qobj);
 out:
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	return ret;
 }
 
@@ -462,7 +462,7 @@ static int virtio_gpu_wait_ioctl(struct drm_device *dev, void *data,
 		nowait = true;
 	ret = virtio_gpu_object_wait(qobj, nowait);
 
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	return ret;
 }
 
-- 
2.7.4
