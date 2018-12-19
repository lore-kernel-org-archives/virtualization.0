From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 10/10] drm/virtio: ditch virtio_gpu_object_attach() calls
Date: Wed, 19 Dec 2018 13:27:08 +0100
Message-ID: <20181219122708.4586-11-kraxel__11800.427203025$1545222370$gmane$org@redhat.com>
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

With virtio_gpu_object_create() being called earlier ttm_bo_init() will
handle the virtio_gpu_object_attach() (via backend binding), so we can
drop the extra calls now.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 9 ---------
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 --
 2 files changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index ca84990382..4b01e5655c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -82,9 +82,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 				struct drm_device *dev,
 				struct drm_mode_create_dumb *args)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct drm_gem_object *gobj;
-	struct virtio_gpu_object *obj;
 	struct virtio_gpu_object_params params = {
 		.pinned = false,
 	};
@@ -108,13 +106,6 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	if (ret)
 		goto fail;
 
-	obj = gem_to_virtio_gpu_obj(gobj);
-
-	/* attach the object to the resource */
-	ret = virtio_gpu_object_attach(vgdev, obj, NULL);
-	if (ret)
-		goto fail;
-
 	args->pitch = pitch;
 	return ret;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index e5bd1fed56..90b3955b6f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -319,8 +319,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		return PTR_ERR(qobj);
 	obj = &qobj->gem_base;
 
-	ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
-
 	ret = drm_gem_handle_create(file_priv, obj, &handle);
 	if (ret) {
 		drm_gem_object_release(obj);
-- 
2.9.3
