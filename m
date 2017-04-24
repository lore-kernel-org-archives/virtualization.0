From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 5/6] drm: fourcc byteorder: adapt virtio to
	drm_mode_legacy_fb_format update
Date: Mon, 24 Apr 2017 08:25:31 +0200
Message-ID: <20170424062532.26722-6-kraxel__30075.4031319686$1493015165$gmane$org@redhat.com>
References: <20170424062532.26722-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170424062532.26722-1-kraxel@redhat.com>
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>, David Airlie <airlied@linux.ie>, =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>, open list <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Pekka Paalanen <ppaalanen@gmail.com>, Sean Paul <seanpaul@chromium.org>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Alex Deucher <alexdeucher@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Ilia Mirkin <imirkin@alum.mit.edu>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_gem.c   |  2 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c | 31 -------------------------------
 2 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index cc025d8fbe..4f2c2dc731 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -99,7 +99,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	if (ret)
 		goto fail;
 
-	format = virtio_gpu_translate_format(DRM_FORMAT_XRGB8888);
+	format = virtio_gpu_translate_format(DRM_FORMAT_CPU_XRGB8888);
 	virtio_gpu_resource_id_get(vgdev, &resid);
 	virtio_gpu_cmd_create_resource(vgdev, resid, format,
 				       args->width, args->height);
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index adcdbd0abe..f40ffc9a70 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -39,11 +39,7 @@ static const uint32_t virtio_gpu_formats[] = {
 };
 
 static const uint32_t virtio_gpu_cursor_formats[] = {
-#ifdef __BIG_ENDIAN
-	DRM_FORMAT_BGRA8888,
-#else
 	DRM_FORMAT_ARGB8888,
-#endif
 };
 
 uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
@@ -51,32 +47,6 @@ uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
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
@@ -101,7 +71,6 @@ uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
 	case DRM_FORMAT_ABGR8888:
 		format = VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM;
 		break;
-#endif
 	default:
 		/*
 		 * This should not happen, we handle everything listed
-- 
2.9.3
