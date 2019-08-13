From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/2] drm/virtio: cleanup queue functions
Date: Tue, 13 Aug 2019 10:25:08 +0200
Message-ID: <20190813082509.29324-2-kraxel__32097.4550837249$1565684733$gmane$org@redhat.com>
References: <20190813082509.29324-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190813082509.29324-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, olvaffe@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Make the queue functions return void, none of
the call sites checks the return value.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 41 ++++++++++-------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 7ac20490e1b4..ca91e83ffaef 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -252,8 +252,8 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
 	wake_up(&vgdev->cursorq.ack_queue);
 }
 
-static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
-					       struct virtio_gpu_vbuffer *vbuf)
+static void virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
+						struct virtio_gpu_vbuffer *vbuf)
 		__releases(&vgdev->ctrlq.qlock)
 		__acquires(&vgdev->ctrlq.qlock)
 {
@@ -263,7 +263,7 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 	int ret;
 
 	if (!vgdev->vqs_ready)
-		return -ENODEV;
+		return;
 
 	sg_init_one(&vcmd, vbuf->buf, vbuf->size);
 	sgs[outcnt + incnt] = &vcmd;
@@ -294,30 +294,22 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 
 		virtqueue_kick(vq);
 	}
-
-	if (!ret)
-		ret = vq->num_free;
-	return ret;
 }
 
-static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
-					struct virtio_gpu_vbuffer *vbuf)
+static void virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
+					 struct virtio_gpu_vbuffer *vbuf)
 {
-	int rc;
-
 	spin_lock(&vgdev->ctrlq.qlock);
-	rc = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
+	virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
 	spin_unlock(&vgdev->ctrlq.qlock);
-	return rc;
 }
 
-static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
-					       struct virtio_gpu_vbuffer *vbuf,
-					       struct virtio_gpu_ctrl_hdr *hdr,
-					       struct virtio_gpu_fence *fence)
+static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
+						struct virtio_gpu_vbuffer *vbuf,
+						struct virtio_gpu_ctrl_hdr *hdr,
+						struct virtio_gpu_fence *fence)
 {
 	struct virtqueue *vq = vgdev->ctrlq.vq;
-	int rc;
 
 again:
 	spin_lock(&vgdev->ctrlq.qlock);
@@ -338,13 +330,12 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 
 	if (fence)
 		virtio_gpu_fence_emit(vgdev, hdr, fence);
-	rc = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
+	virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
 	spin_unlock(&vgdev->ctrlq.qlock);
-	return rc;
 }
 
-static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
-				   struct virtio_gpu_vbuffer *vbuf)
+static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
+				    struct virtio_gpu_vbuffer *vbuf)
 {
 	struct virtqueue *vq = vgdev->cursorq.vq;
 	struct scatterlist *sgs[1], ccmd;
@@ -352,7 +343,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 	int outcnt;
 
 	if (!vgdev->vqs_ready)
-		return -ENODEV;
+		return;
 
 	sg_init_one(&ccmd, vbuf->buf, vbuf->size);
 	sgs[0] = &ccmd;
@@ -374,10 +365,6 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 	}
 
 	spin_unlock(&vgdev->cursorq.qlock);
-
-	if (!ret)
-		ret = vq->num_free;
-	return ret;
 }
 
 /* just create gem objects for userspace and long lived objects,
-- 
2.18.1
