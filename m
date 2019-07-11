From: Chia-I Wu <olvaffe@gmail.com>
Subject: [PATCH] drm/virtio: kick vq outside of the vq lock
Date: Wed, 10 Jul 2019 19:29:37 -0700
Message-ID: <20190711022937.166015-1-olvaffe__40216.4605840639$1562812710$gmane$org@gmail.com>
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Replace virtqueue_kick by virtqueue_kick_prepare, which requires
serialization, and virtqueue_notify, which does not.  Repurpose the
return values to indicate whether the vq should be notified.

This fixes a lock contention with qemu host.  When the guest calls
vibad rtqueue_notify, the qemu vcpu thread exits the guest and waits
for the qemu iothread to perform the MMIO.  If the qemu iothread is
still processing the prior buffer, and if the prior buffer is cheap
to GPU, the iothread will go ahead and generate an IRQ for the
guest.  A worker thread in the guest will call
virtio_gpu_dequeue_ctrl_func.  If virtqueue_notify was called with
the vq lock held, the worker thread would busy wait inside
virtio_gpu_dequeue_ctrl_func.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 6c1a90717535..e96f88fe5c83 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -291,11 +291,9 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 		trace_virtio_gpu_cmd_queue(vq,
 			(struct virtio_gpu_ctrl_hdr *)vbuf->buf);
 
-		virtqueue_kick(vq);
+		ret = virtqueue_kick_prepare(vq);
 	}
 
-	if (!ret)
-		ret = vq->num_free;
 	return ret;
 }
 
@@ -307,6 +305,10 @@ static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
 	spin_lock(&vgdev->ctrlq.qlock);
 	rc = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
 	spin_unlock(&vgdev->ctrlq.qlock);
+
+	if (rc > 0)
+		virtqueue_notify(vgdev->ctrlq.vq);
+
 	return rc;
 }
 
@@ -339,6 +341,10 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 		virtio_gpu_fence_emit(vgdev, hdr, fence);
 	rc = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
 	spin_unlock(&vgdev->ctrlq.qlock);
+
+	if (rc > 0)
+		virtqueue_notify(vgdev->ctrlq.vq);
+
 	return rc;
 }
 
@@ -369,13 +375,14 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 		trace_virtio_gpu_cmd_queue(vq,
 			(struct virtio_gpu_ctrl_hdr *)vbuf->buf);
 
-		virtqueue_kick(vq);
+		ret = virtqueue_kick_prepare(vq);
 	}
 
 	spin_unlock(&vgdev->cursorq.qlock);
 
-	if (!ret)
-		ret = vq->num_free;
+	if (ret > 0)
+		virtqueue_notify(vq);
+
 	return ret;
 }
 
-- 
2.22.0.410.gd8fdbe21b5-goog
