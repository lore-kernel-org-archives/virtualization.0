From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/virtio: fix command submission with objects but without
	fence.
Date: Wed,  4 Sep 2019 09:48:28 +0200
Message-ID: <20190904074828.32502-1-kraxel__44324.5043906913$1567583339$gmane$org@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, olvaffe@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Only call virtio_gpu_array_add_fence if we actually have a fence.

Fixes: da758d51968a ("drm/virtio: rework virtio_gpu_execbuffer_ioctl fencing")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 595fa6ec2d58..7fd2851f7b97 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -339,11 +339,12 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 		goto again;
 	}
 
-	if (fence)
+	if (fence) {
 		virtio_gpu_fence_emit(vgdev, hdr, fence);
-	if (vbuf->objs) {
-		virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
-		virtio_gpu_array_unlock_resv(vbuf->objs);
+		if (vbuf->objs) {
+			virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
+			virtio_gpu_array_unlock_resv(vbuf->objs);
+		}
 	}
 	notify = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
 	spin_unlock(&vgdev->ctrlq.qlock);
-- 
2.18.1
