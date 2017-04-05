From: Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] drm: virtio: fix virtio_gpu_cursor_formats
Date: Wed,  5 Apr 2017 10:09:15 +0200
Message-ID: <20170405080915.823-1-lvivier@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: David Airlie <airlied@linux.ie>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

When we use virtio-vga with a big-endian guest,
the mouse pointer disappears.

To fix that, on big-endian use DRM_FORMAT_BGRA8888
instead of DRM_FORMAT_ARGB8888.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 11288ff..3ed7174 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -39,7 +39,11 @@ static const uint32_t virtio_gpu_formats[] = {
 };
 
 static const uint32_t virtio_gpu_cursor_formats[] = {
+#ifdef __BIG_ENDIAN
+	DRM_FORMAT_BGRA8888,
+#else
 	DRM_FORMAT_ARGB8888,
+#endif
 };
 
 static void virtio_gpu_plane_destroy(struct drm_plane *plane)
-- 
2.9.3
