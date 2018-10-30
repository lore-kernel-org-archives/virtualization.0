From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 2/2] drm/virtio: Use IDAs more efficiently
Date: Tue, 30 Oct 2018 09:53:52 -0700
Message-ID: <20181030165352.13065-2-willy__14122.6008338437$1540918362$gmane$org@infradead.org>
References: <20181029215339.aywdmehccrwwls2n@sirius.home.kraxel.org>
	<20181030165352.13065-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181030165352.13065-1-willy@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

0-based IDAs are more efficient than any other base.  Convert the
1-based IDAs to be 0-based.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c    | 5 +++--
 drivers/gpu/drm/virtio/virtgpu_object.c | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index bf609dcae224..8118f10fde4a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -55,10 +55,11 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 static int virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
 				      uint32_t nlen, const char *name)
 {
-	int handle = ida_alloc_min(&vgdev->ctx_id_ida, 1, GFP_KERNEL);
+	int handle = ida_alloc(&vgdev->ctx_id_ida, GFP_KERNEL);
 
 	if (handle < 0)
 		return handle;
+	handle += 1;
 	virtio_gpu_cmd_context_create(vgdev, handle, nlen, name);
 	return handle;
 }
@@ -67,7 +68,7 @@ static void virtio_gpu_context_destroy(struct virtio_gpu_device *vgdev,
 				      uint32_t ctx_id)
 {
 	virtio_gpu_cmd_context_destroy(vgdev, ctx_id);
-	ida_free(&vgdev->ctx_id_ida, ctx_id);
+	ida_free(&vgdev->ctx_id_ida, ctx_id - 1);
 }
 
 static void virtio_gpu_init_vq(struct virtio_gpu_queue *vgvq,
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 5ac42dded217..f39a183d59c2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -28,18 +28,18 @@
 static int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 				       uint32_t *resid)
 {
-	int handle = ida_alloc_min(&vgdev->resource_ida, 1, GFP_KERNEL);
+	int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
 
 	if (handle < 0)
 		return handle;
 
-	*resid = handle;
+	*resid = handle + 1;
 	return 0;
 }
 
 static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
 {
-	ida_free(&vgdev->resource_ida, id);
+	ida_free(&vgdev->resource_ida, id - 1);
 }
 
 static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
-- 
2.19.1
