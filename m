From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/virtio: do NOT reuse resource ids
Date: Fri,  8 Feb 2019 15:04:09 +0100
Message-ID: <20190208140409.15280-1-kraxel__40900.0875473552$1549716020$gmane$org@redhat.com>
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
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Bisected guest kernel changes crashing qemu.  Landed at
"6c1cd97bda drm/virtio: fix resource id handling".  Looked again, and
noticed we where not only leaking *some* ids, but *all* ids.  The old
code never ever called virtio_gpu_resource_id_put().

So, commit 6c1cd97bda effectively makes the linux kernel starting
re-using IDs after releasing them, and apparently virglrenderer can't
deal with that.  Oops.

This patch puts a temporary stopgap into place for the 5.0 release.

Cc: David Airlie <airlied@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---

Notes:
    Hi Dave, I'll be offline next week, so please commit to
    drm-next-fixes if you think this patch is acceptable.

 drivers/gpu/drm/virtio/virtgpu_object.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index f39a183d59..e7e9460350 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -28,10 +28,21 @@
 static int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 				       uint32_t *resid)
 {
+#if 0
 	int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
 
 	if (handle < 0)
 		return handle;
+#else
+	static int handle;
+
+	/*
+	 * FIXME: dirty hack to avoid re-using IDs, virglrenderer
+	 * can't deal with that.  Needs fixing in virglrenderer, also
+	 * should figure a better way to handle that in the guest.
+	 */
+	handle++;
+#endif
 
 	*resid = handle + 1;
 	return 0;
@@ -39,7 +50,9 @@ static int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 
 static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
 {
+#if 0
 	ida_free(&vgdev->resource_ida, id - 1);
+#endif
 }
 
 static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
-- 
2.9.3
