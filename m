From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 6/6] drm: fourcc byteorder: virtio restrict to XRGB8888
Date: Mon, 24 Apr 2017 08:25:32 +0200
Message-ID: <20170424062532.26722-7-kraxel@redhat.com>
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

While wading through the code I've noticed we have a little issue in
virtio:  We attach a format to the bo when it is created
(DRM_IOCTL_MODE_CREATE_DUMB), not when we map it as framebuffer
(DRM_IOCTL_MODE_ADDFB).

Easy way out:  support a single format only.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 5 ++++-
 drivers/gpu/drm/virtio/virtgpu_plane.c | 9 +--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 4f2c2dc731..b09e5e5ae4 100644
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
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index f40ffc9a70..3a4498a223 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -28,14 +28,7 @@
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
+	DRM_FORMAT_CPU_XRGB8888,
 };
 
 static const uint32_t virtio_gpu_cursor_formats[] = {
-- 
2.9.3
