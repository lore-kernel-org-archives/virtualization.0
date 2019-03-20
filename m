From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/virtio: make resource id workaround runtime switchable.
Date: Wed, 20 Mar 2019 09:51:33 +0100
Message-ID: <20190320085133.26632-1-kraxel__35205.4817880102$1553072034$gmane$org@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Also update the comment with a reference to the virglrenderer fix.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 44 ++++++++++++++-----------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index e7e946035027..a73dae4e5029 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -25,34 +25,38 @@
 
 #include "virtgpu_drv.h"
 
+static int virtio_gpu_virglrenderer_workaround = 1;
+module_param_named(virglhack, virtio_gpu_virglrenderer_workaround, int, 0400);
+
 static int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 				       uint32_t *resid)
 {
-#if 0
-	int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
-
-	if (handle < 0)
-		return handle;
-#else
-	static int handle;
-
-	/*
-	 * FIXME: dirty hack to avoid re-using IDs, virglrenderer
-	 * can't deal with that.  Needs fixing in virglrenderer, also
-	 * should figure a better way to handle that in the guest.
-	 */
-	handle++;
-#endif
-
-	*resid = handle + 1;
+	if (virtio_gpu_virglrenderer_workaround) {
+		/*
+		 * Hack to avoid re-using resource IDs.
+		 *
+		 * virglrenderer versions up to (and including) 0.7.0
+		 * can't deal with that.  virglrenderer commit
+		 * "f91a9dd35715 Fix unlinking resources from hash
+		 * table." (Feb 2019) fixes the bug.
+		 */
+		static int handle;
+		handle++;
+		*resid = handle + 1;
+	} else {
+		int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
+		if (handle < 0)
+			return handle;
+		*resid = handle + 1;
+	}
 	return 0;
 }
 
 static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
 {
-#if 0
-	ida_free(&vgdev->resource_ida, id - 1);
-#endif
+	if (!virtio_gpu_virglrenderer_workaround) {
+		ida_free(&vgdev->resource_ida, id - 1);
+	}
 }
 
 static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
-- 
2.18.1
