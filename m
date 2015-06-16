From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/3] drm/virtgpu: initialise fbdev after getting initial
	display info
Date: Tue, 16 Jun 2015 11:34:30 +0200
Message-ID: <1434447271-16461-3-git-send-email-kraxel__41805.2542176612$1434447306$gmane$org@redhat.com>
References: <1434447271-16461-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1434447271-16461-1-git-send-email-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Dave Airlie <airlied@redhat.com>

This should avoid issues with the fbdev path trying to render
before we've gotten the display info.

Signed-off-by: Dave Airlie <airlied@redhat.com>

[ kraxel: wait for display-info reply ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h | 1 +
 drivers/gpu/drm/virtio/virtgpu_kms.c | 4 +++-
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index e5a2c09..ff8de3d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -171,6 +171,7 @@ struct virtio_gpu_device {
 	wait_queue_head_t resp_wq;
 	/* current display info */
 	spinlock_t display_info_lock;
+	bool display_info_pending;
 
 	struct virtio_gpu_fence_driver fence_drv;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 132405f..782766c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -137,9 +137,11 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
 	virtio_device_ready(vgdev->vdev);
 	vgdev->vqs_ready = true;
 
+	virtio_gpu_cmd_get_display_info(vgdev);
+	wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
+			   5 * HZ);
 	if (virtio_gpu_fbdev)
 		virtio_gpu_fbdev_init(vgdev);
-	virtio_gpu_cmd_get_display_info(vgdev);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 8fa6513e..c506792 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -534,6 +534,7 @@ static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
 		}
 	}
 
+	vgdev->display_info_pending = false;
 	spin_unlock(&vgdev->display_info_lock);
 	wake_up(&vgdev->resp_wq);
 
@@ -558,6 +559,7 @@ int virtio_gpu_cmd_get_display_info(struct virtio_gpu_device *vgdev)
 		 resp_buf);
 	memset(cmd_p, 0, sizeof(*cmd_p));
 
+	vgdev->display_info_pending = true;
 	cmd_p->type = cpu_to_le32(VIRTIO_GPU_CMD_GET_DISPLAY_INFO);
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 	return 0;
-- 
1.8.3.1
