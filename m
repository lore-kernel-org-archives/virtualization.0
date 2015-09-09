From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/5] virtio-gpu: add & use virtio_gpu_queue_fenced_ctrl_buffer
Date: Wed,  9 Sep 2015 13:42:22 +0200
Message-ID: <1441798946-26233-3-git-send-email-kraxel__16081.9151475609$1441823517$gmane$org@redhat.com>
References: <1441798946-26233-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1441798946-26233-1-git-send-email-kraxel@redhat.com>
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

Add helper function to handle the submission of fenced control requests.
Make sure we initialize the fence while holding the virtqueue lock, so
requests can't be reordered.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_fence.c |  2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 40 +++++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
index 1da6326..793ad9f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -81,7 +81,7 @@ int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
 	unsigned long irq_flags;
 
-	*fence = kmalloc(sizeof(struct virtio_gpu_fence), GFP_KERNEL);
+	*fence = kmalloc(sizeof(struct virtio_gpu_fence), GFP_ATOMIC);
 	if ((*fence) == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index b9275c7..111ab1a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -347,6 +347,38 @@ static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
 	return rc;
 }
 
+static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
+					       struct virtio_gpu_vbuffer *vbuf,
+					       struct virtio_gpu_ctrl_hdr *hdr,
+					       struct virtio_gpu_fence **fence)
+{
+	struct virtqueue *vq = vgdev->ctrlq.vq;
+	int rc;
+
+again:
+	spin_lock(&vgdev->ctrlq.qlock);
+
+	/*
+	 * Make sure we have enouth space in the virtqueue.  If not
+	 * wait here until we have.
+	 *
+	 * Without that virtio_gpu_queue_ctrl_buffer_nolock might have
+	 * to wait for free space, which can result in fence ids being
+	 * submitted out-of-order.
+	 */
+	if (vq->num_free < 3) {
+		spin_unlock(&vgdev->ctrlq.qlock);
+		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= 3);
+		goto again;
+	}
+
+	if (fence)
+		virtio_gpu_fence_emit(vgdev, hdr, fence);
+	rc = virtio_gpu_queue_ctrl_buffer_nolock(vgdev, vbuf);
+	spin_unlock(&vgdev->ctrlq.qlock);
+	return rc;
+}
+
 static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 				   struct virtio_gpu_vbuffer *vbuf)
 {
@@ -499,9 +531,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 	cmd_p->r.x = x;
 	cmd_p->r.y = y;
 
-	if (fence)
-		virtio_gpu_fence_emit(vgdev, &cmd_p->hdr, fence);
-	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
+	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, &cmd_p->hdr, fence);
 }
 
 static void
@@ -524,9 +554,7 @@ virtio_gpu_cmd_resource_attach_backing(struct virtio_gpu_device *vgdev,
 	vbuf->data_buf = ents;
 	vbuf->data_size = sizeof(*ents) * nents;
 
-	if (fence)
-		virtio_gpu_fence_emit(vgdev, &cmd_p->hdr, fence);
-	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
+	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, &cmd_p->hdr, fence);
 }
 
 static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
-- 
1.8.3.1
