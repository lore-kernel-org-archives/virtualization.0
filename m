From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 2/6] drm/virtio: notify before waiting
Date: Fri, 14 Feb 2020 13:55:31 +0100
Message-ID: <20200214125535.26349-3-kraxel@redhat.com>
References: <20200214125535.26349-1-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214125535.26349-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Before we are going to wait for virtqueue entries becoming available
call virtio_gpu_notify() to make sure the host has seen everything
we've submitted.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 6cc259cfa517..653efb26bcd9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -346,6 +346,7 @@ static void virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 
 	if (vq->num_free < elemcnt) {
 		spin_unlock(&vgdev->ctrlq.qlock);
+		virtio_gpu_notify(vgdev);
 		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
 		goto again;
 	}
-- 
2.18.2
