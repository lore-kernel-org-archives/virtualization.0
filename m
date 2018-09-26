From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 4/4] drm/virtio: Use IDAs more efficiently
Date: Wed, 26 Sep 2018 09:00:31 -0700
Message-ID: <20180926160031.15721-5-willy__21539.1540121802$1537977565$gmane$org@infradead.org>
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

0-based IDAs are more efficient than any other base.  Convert the
1-based IDAs to be 0-based.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 3 ++-
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index bf609dcae224..b576c9ef6323 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -59,6 +59,7 @@ static int virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
 
 	if (handle < 0)
 		return handle;
+	handle++;
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
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 387951c971d4..81297fe0147d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -40,12 +40,15 @@
 
 int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev)
 {
-	return ida_alloc_min(&vgdev->resource_ida, 1, GFP_KERNEL);
+	int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
+	if (handle < 0)
+		return handle;
+	return handle + 1;
 }
 
 void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
 {
-	ida_free(&vgdev->resource_ida, id);
+	ida_free(&vgdev->resource_ida, id - 1);
 }
 
 void virtio_gpu_ctrl_ack(struct virtqueue *vq)
-- 
2.19.0
