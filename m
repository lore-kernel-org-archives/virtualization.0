From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/2] drm: virtio: add virtio_gpu_translate_format
Date: Mon,  3 Apr 2017 09:08:44 +0200
Message-ID: <20170403070845.10793-2-kraxel@redhat.com>
References: <20170403070845.10793-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170403070845.10793-1-kraxel@redhat.com>
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
Cc: lvivier@redhat.com, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Factors out code, no functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  1 +
 drivers/gpu/drm/virtio/virtgpu_fb.c    | 58 +----------------------------
 drivers/gpu/drm/virtio/virtgpu_plane.c | 68 ++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 93900a8..1328185 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -334,6 +334,7 @@ int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev);
 void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
 
 /* virtio_gpu_plane.c */
+uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc);
 struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 					enum drm_plane_type type,
 					int index);
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index 9bfaef3..33df067 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -231,63 +231,9 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	mode_cmd.pitches[0] = mode_cmd.width * 4;
 	mode_cmd.pixel_format = drm_mode_legacy_fb_format(32, 24);
 
-	switch (mode_cmd.pixel_format) {
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
-	case DRM_FORMAT_XRGB8888:
-		format = VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM;
-		break;
-	case DRM_FORMAT_ARGB8888:
-		format = VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM;
-		break;
-	case DRM_FORMAT_BGRX8888:
-		format = VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM;
-		break;
-	case DRM_FORMAT_BGRA8888:
-		format = VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM;
-		break;
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
-	default:
-		DRM_ERROR("failed to find virtio gpu format for %d\n",
-			  mode_cmd.pixel_format);
+	format = virtio_gpu_translate_format(mode_cmd.pixel_format);
+	if (format == 0)
 		return -EINVAL;
-	}
 
 	size = mode_cmd.pitches[0] * mode_cmd.height;
 	obj = virtio_gpu_alloc_object(dev, size, false, true);
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 1ff9c64..372c91c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -42,6 +42,74 @@ static const uint32_t virtio_gpu_cursor_formats[] = {
 	DRM_FORMAT_ARGB8888,
 };
 
+uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
+{
+	uint32_t format;
+
+	switch (drm_fourcc) {
+#ifdef __BIG_ENDIAN
+	case DRM_FORMAT_XRGB8888:
+		format = VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM;
+		break;
+	case DRM_FORMAT_ARGB8888:
+		format = VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM;
+		break;
+	case DRM_FORMAT_BGRX8888:
+		format = VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM;
+		break;
+	case DRM_FORMAT_BGRA8888:
+		format = VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM;
+		break;
+	case DRM_FORMAT_RGBX8888:
+		format = VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM;
+		break;
+	case DRM_FORMAT_RGBA8888:
+		format = VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM;
+		break;
+	case DRM_FORMAT_XBGR8888:
+		format = VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM;
+		break;
+	case DRM_FORMAT_ABGR8888:
+		format = VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM;
+		break;
+#else
+	case DRM_FORMAT_XRGB8888:
+		format = VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM;
+		break;
+	case DRM_FORMAT_ARGB8888:
+		format = VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM;
+		break;
+	case DRM_FORMAT_BGRX8888:
+		format = VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM;
+		break;
+	case DRM_FORMAT_BGRA8888:
+		format = VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM;
+		break;
+	case DRM_FORMAT_RGBX8888:
+		format = VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM;
+		break;
+	case DRM_FORMAT_RGBA8888:
+		format = VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM;
+		break;
+	case DRM_FORMAT_XBGR8888:
+		format = VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM;
+		break;
+	case DRM_FORMAT_ABGR8888:
+		format = VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM;
+		break;
+#endif
+	default:
+		/*
+		 * This should not happen, we handle everything listed
+		 * in virtio_gpu_formats[].
+		 */
+		format = 0;
+		break;
+	}
+	WARN_ON(format == 0);
+	return format;
+}
+
 static void virtio_gpu_plane_destroy(struct drm_plane *plane)
 {
 	drm_plane_cleanup(plane);
-- 
2.9.3
