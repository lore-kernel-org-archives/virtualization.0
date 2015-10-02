From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 1/7] virtio-gpu: add virtio_gpu_queue_ctrl_buffer_locked
Date: Fri,  2 Oct 2015 13:58:18 +0200
Message-ID: <1443787104-24243-2-git-send-email-kraxel__6007.0168030963$1443787139$gmane$org@redhat.com>
References: <1443787104-24243-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1443787104-24243-1-git-send-email-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Add virtio_gpu_queue_ctrl_buffer_locked function, which does the same as
virtio_gpu_queue_ctrl_buffer but does not take the virtqueue lock.  The
caller must hold the lock instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 1698669f..5b9bc24 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -293,8 +293,8 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
 	wake_up(&vgdev->cursorq.ack_queue);
 }
 
-static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
-					struct virtio_gpu_vbuffer *vbuf)
+static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
+					       struct virtio_gpu_vbuffer *vbuf)
 {
 	struct virtqueue *vq = vgdev->ctrlq.vq;
 	struct scatterlist *sgs[3], vcmd, vout, vresp;
@@ -320,7 +320,6 @@ static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
 		incnt++;
 	}
 
-	spin_lock(&vgdev->ctrlq.qlock);
 retry:
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
 	if (ret == -ENOSPC) {
@@ -331,13 +330,23 @@ retry:
 	} else {
 		virtqueue_kick(vq);
 	}
-	spin_unlock(&vgdev->ctrlq.qlock);
 
 	if (!ret)
 		ret = vq->num_free;
 	return ret;
 }
 
+static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
+					struct virtio_gpu_vbuffer *vbuf)
+{
+	int rc;
+
+	spin_lock(&vgdev->ctrlq.qlock);
+	rc = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
+	spin_unlock(&vgdev->ctrlq.qlock);
+	return rc;
+}
+
 static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 				   struct virtio_gpu_vbuffer *vbuf)
 {
-- 
1.8.3.1
