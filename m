From: David Riley <davidriley@chromium.org>
Subject: [PATCH v4 1/2] drm/virtio: Rewrite virtio_gpu_queue_ctrl_buffer using
	fenced version.
Date: Wed, 11 Sep 2019 11:14:02 -0700
Message-ID: <20190911181403.40909-2-davidriley__40285.1855194726$1568225667$gmane$org@chromium.org>
References: <20190829212417.257397-1-davidriley@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190829212417.257397-1-davidriley@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

Factor function in preparation to generating scatterlist prior to locking.

Signed-off-by: David Riley <davidriley@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 7fd2851f7b97..5a64c776138d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -302,18 +302,6 @@ static bool virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 	return notify;
 }
 
-static void virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
-					 struct virtio_gpu_vbuffer *vbuf)
-{
-	bool notify;
-
-	spin_lock(&vgdev->ctrlq.qlock);
-	notify = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
-	spin_unlock(&vgdev->ctrlq.qlock);
-	if (notify)
-		virtqueue_notify(vgdev->ctrlq.vq);
-}
-
 static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 						struct virtio_gpu_vbuffer *vbuf,
 						struct virtio_gpu_ctrl_hdr *hdr,
@@ -339,7 +327,7 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 		goto again;
 	}
 
-	if (fence) {
+	if (hdr && fence) {
 		virtio_gpu_fence_emit(vgdev, hdr, fence);
 		if (vbuf->objs) {
 			virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
@@ -352,6 +340,12 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 		virtqueue_notify(vgdev->ctrlq.vq);
 }
 
+static void virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
+					 struct virtio_gpu_vbuffer *vbuf)
+{
+	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, NULL, NULL);
+}
+
 static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_vbuffer *vbuf)
 {
-- 
2.23.0.162.g0b9fbb3734-goog
