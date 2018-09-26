From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/4] drm/virtio: Handle context ID allocation errors
Date: Wed, 26 Sep 2018 09:00:29 -0700
Message-ID: <20180926160031.15721-3-willy__14998.0926806622$1537977541$gmane$org@infradead.org>
References: <20180926160031.15721-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180926160031.15721-1-willy@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Matthew Wilcox <willy@infradead.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

It is possible to run out of memory while allocating IDs.  The current
code would create a context with an invalid ID; change it to return
-ENOMEM to userspace.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 29 +++++++++++-----------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index e2604fe1b4ae..bf609dcae224 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -52,31 +52,22 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 		      events_clear, &events_clear);
 }
 
-static void virtio_gpu_ctx_id_get(struct virtio_gpu_device *vgdev,
-				  uint32_t *resid)
+static int virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
+				      uint32_t nlen, const char *name)
 {
 	int handle = ida_alloc_min(&vgdev->ctx_id_ida, 1, GFP_KERNEL);
-	*resid = handle;
-}
 
-static void virtio_gpu_ctx_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
-{
-	ida_free(&vgdev->ctx_id_ida, id);
-}
-
-static void virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
-				      uint32_t nlen, const char *name,
-				      uint32_t *ctx_id)
-{
-	virtio_gpu_ctx_id_get(vgdev, ctx_id);
-	virtio_gpu_cmd_context_create(vgdev, *ctx_id, nlen, name);
+	if (handle < 0)
+		return handle;
+	virtio_gpu_cmd_context_create(vgdev, handle, nlen, name);
+	return handle;
 }
 
 static void virtio_gpu_context_destroy(struct virtio_gpu_device *vgdev,
 				      uint32_t ctx_id)
 {
 	virtio_gpu_cmd_context_destroy(vgdev, ctx_id);
-	virtio_gpu_ctx_id_put(vgdev, ctx_id);
+	ida_free(&vgdev->ctx_id_ida, ctx_id);
 }
 
 static void virtio_gpu_init_vq(struct virtio_gpu_queue *vgvq,
@@ -261,7 +252,7 @@ int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file)
 {
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_fpriv *vfpriv;
-	uint32_t id;
+	int id;
 	char dbgname[TASK_COMM_LEN];
 
 	/* can't create contexts without 3d renderer */
@@ -274,7 +265,9 @@ int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file)
 		return -ENOMEM;
 
 	get_task_comm(dbgname, current);
-	virtio_gpu_context_create(vgdev, strlen(dbgname), dbgname, &id);
+	id = virtio_gpu_context_create(vgdev, strlen(dbgname), dbgname);
+	if (id < 0)
+		return id;
 
 	vfpriv->ctx_id = id;
 	file->driver_priv = vfpriv;
-- 
2.19.0
