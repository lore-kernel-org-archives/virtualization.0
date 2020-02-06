From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/virtio: fix ring free check
Date: Thu,  6 Feb 2020 12:14:16 +0100
Message-ID: <20200206111416.31269-1-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

If the virtio device supports indirect ring descriptors we need only one
ring entry for the whole command.  Take that into account when checking
whenever the virtqueue has enough free entries for our command.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 41e475fbd67b..a2ec09dba530 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -328,7 +328,8 @@ static void virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 {
 	struct virtqueue *vq = vgdev->ctrlq.vq;
 	bool notify = false;
-	int ret;
+	bool indirect;
+	int vqcnt, ret;
 
 again:
 	spin_lock(&vgdev->ctrlq.qlock);
@@ -341,9 +342,11 @@ static void virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 		return;
 	}
 
-	if (vq->num_free < elemcnt) {
+	indirect = virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC);
+	vqcnt = indirect ? 1 : elemcnt;
+	if (vq->num_free < vqcnt) {
 		spin_unlock(&vgdev->ctrlq.qlock);
-		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
+		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= vqcnt);
 		goto again;
 	}
 
-- 
2.18.1
