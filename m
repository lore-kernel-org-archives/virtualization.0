From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 5/5] drm/virtio: fix DRM_FORMAT_* handling
Date: Mon,  3 Sep 2018 12:57:56 +0200
Message-ID: <20180903105756.24912-6-kraxel__3190.76573146067$1535972183$gmane$org@redhat.com>
References: <20180903105756.24912-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180903105756.24912-1-kraxel@redhat.com>
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

Use DRM_FORMAT_HOST_XRGB8888, so we are using the correct format code
on bigendian machines.  Also add DRIVER_PREFER_HOST_BYTE_ORDER driver
feature flag so drm_mode_addfb() asks for the correct format code.

Both DRM_FORMAT_* and VIRTIO_GPU_FORMAT_* are defined to be little
endian, so using a different mapping on bigendian machines is wrong.
It's there because of broken drm_mode_addfb() behavior.  So with
drm_mode_addfb() being fixed we can fix this too.

While wading through the code I've noticed we have a little issue in
virtio:  We attach a format to the bo when it is created
(DRM_IOCTL_MODE_CREATE_DUMB), not when we map it as framebuffer
(DRM_IOCTL_MODE_ADDFB).  Easy way out:  Support a single format only.
Pick DRM_FORMAT_HOST_XRGB8888, it is the only one actually used in
practice.  Drop unused mappings in virtio_gpu_translate_format().

With this patch applied both ADDFB and ADDFB2 ioctls work correctly in
the virtio-gpu.ko driver on big endian machines.  Without the patch only
ADDFB (which still seems to be used by the majority of userspace) works
correctly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c |  4 +++
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  4 ++-
 drivers/gpu/drm/virtio/virtgpu_fb.c      |  2 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c     |  7 +++--
 drivers/gpu/drm/virtio/virtgpu_plane.c   | 54 ++------------------------------
 5 files changed, 15 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 25503b9335..f6c4af1db4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -306,6 +306,10 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 	struct virtio_gpu_framebuffer *virtio_gpu_fb;
 	int ret;
 
+	if (mode_cmd->pixel_format != DRM_FORMAT_HOST_XRGB8888 &&
+	    mode_cmd->pixel_format != DRM_FORMAT_HOST_ARGB8888)
+		return ERR_PTR(-ENOENT);
+
 	/* lookup object associated with res handle */
 	obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
 	if (!obj)
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index d9287c144f..4b28f41ac1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -114,7 +114,9 @@ static const struct file_operations virtio_gpu_driver_fops = {
 };
 
 static struct drm_driver driver = {
-	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME | DRIVER_RENDER | DRIVER_ATOMIC,
+	.driver_features = (DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME |
+			    DRIVER_RENDER | DRIVER_ATOMIC |
+			    DRIVER_PREFER_HOST_BYTE_ORDER),
 	.load = virtio_gpu_driver_load,
 	.unload = virtio_gpu_driver_unload,
 	.open = virtio_gpu_driver_open,
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index a121b1c795..9d87ebd645 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -233,7 +233,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	mode_cmd.width = sizes->surface_width;
 	mode_cmd.height = sizes->surface_height;
 	mode_cmd.pitches[0] = mode_cmd.width * 4;
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(32, 24);
+	mode_cmd.pixel_format = DRM_FORMAT_HOST_XRGB8888;
 
 	format = virtio_gpu_translate_format(mode_cmd.pixel_format);
 	if (format == 0)
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 0f2768eaca..82c817f37c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -90,7 +90,10 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	uint32_t resid;
 	uint32_t format;
 
-	pitch = args->width * ((args->bpp + 1) / 8);
+	if (args->bpp != 32)
+		return -EINVAL;
+
+	pitch = args->width * 4;
 	args->size = pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
 
@@ -99,7 +102,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	if (ret)
 		goto fail;
 
-	format = virtio_gpu_translate_format(DRM_FORMAT_XRGB8888);
+	format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
 	virtio_gpu_resource_id_get(vgdev, &resid);
 	virtio_gpu_cmd_create_resource(vgdev, resid, format,
 				       args->width, args->height);
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index dc5b5b2b7a..3221d50b9a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -28,22 +28,11 @@
 #include <drm/drm_atomic_helper.h>
 
 static const uint32_t virtio_gpu_formats[] = {
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_BGRX8888,
-	DRM_FORMAT_BGRA8888,
-	DRM_FORMAT_RGBX8888,
-	DRM_FORMAT_RGBA8888,
-	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_HOST_XRGB8888,
 };
 
 static const uint32_t virtio_gpu_cursor_formats[] = {
-#ifdef __BIG_ENDIAN
-	DRM_FORMAT_BGRA8888,
-#else
-	DRM_FORMAT_ARGB8888,
-#endif
+	DRM_FORMAT_HOST_ARGB8888,
 };
 
 uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
@@ -51,32 +40,6 @@ uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
 	uint32_t format;
 
 	switch (drm_fourcc) {
-#ifdef __BIG_ENDIAN
-	case DRM_FORMAT_XRGB8888:
-		format = VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM;
-		break;
-	case DRM_FORMAT_ARGB8888:
-		format = VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM;
-		break;
-	case DRM_FORMAT_BGRX8888:
-		format = VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM;
-		break;
-	case DRM_FORMAT_BGRA8888:
-		format = VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM;
-		break;
-	case DRM_FORMAT_RGBX8888:
-		format = VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM;
-		break;
-	case DRM_FORMAT_RGBA8888:
-		format = VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM;
-		break;
-	case DRM_FORMAT_XBGR8888:
-		format = VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM;
-		break;
-	case DRM_FORMAT_ABGR8888:
-		format = VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM;
-		break;
-#else
 	case DRM_FORMAT_XRGB8888:
 		format = VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM;
 		break;
@@ -89,19 +52,6 @@ uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
 	case DRM_FORMAT_BGRA8888:
 		format = VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM;
 		break;
-	case DRM_FORMAT_RGBX8888:
-		format = VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM;
-		break;
-	case DRM_FORMAT_RGBA8888:
-		format = VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM;
-		break;
-	case DRM_FORMAT_XBGR8888:
-		format = VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM;
-		break;
-	case DRM_FORMAT_ABGR8888:
-		format = VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM;
-		break;
-#endif
 	default:
 		/*
 		 * This should not happen, we handle everything listed
-- 
2.9.3
