From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/3] virtio-gpu: batch display update commands.
Date: Thu, 12 Dec 2019 13:53:45 +0100
Message-ID: <20191212125346.8334-3-kraxel@redhat.com>
References: <20191212125346.8334-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191212125346.8334-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, gurchetansingh@chromium.org, olvaffe@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

When the driver submits multiple commands in a row it makes sense to
notify the host only after submitting the last one, so the host can
process them all at once, with a single vmexit.

Add functions to enable/disable notifications to allow that.  Use the
new functions for primary plane updates.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  6 ++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c |  4 ++++
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 23 +++++++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index eedae2a7b532..29cf005ed6b9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -183,6 +183,9 @@ struct virtio_gpu_device {
 	struct kmem_cache *vbufs;
 	bool vqs_ready;
 
+	bool disable_notify;
+	bool pending_notify;
+
 	struct ida	resource_ida;
 
 	wait_queue_head_t resp_wq;
@@ -335,6 +338,9 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work);
 void virtio_gpu_dequeue_cursor_func(struct work_struct *work);
 void virtio_gpu_dequeue_fence_func(struct work_struct *work);
 
+void virtio_gpu_disable_notify(struct virtio_gpu_device *vgdev);
+void virtio_gpu_enable_notify(struct virtio_gpu_device *vgdev);
+
 /* virtio_gpu_display.c */
 int virtio_gpu_framebuffer_init(struct drm_device *dev,
 				struct virtio_gpu_framebuffer *vgfb,
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 59bf76d4a333..2fb068cd680e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -146,6 +146,8 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 		return;
 	}
 
+	virtio_gpu_disable_notify(vgdev);
+
 	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
 	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
 	if (bo->dumb)
@@ -177,6 +179,8 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 				      plane->state->src_y >> 16,
 				      plane->state->src_w >> 16,
 				      plane->state->src_h >> 16);
+
+	virtio_gpu_enable_notify(vgdev);
 }
 
 static int virtio_gpu_cursor_prepare_fb(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 9274c4063c70..5914e79d3429 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -404,8 +404,12 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 	}
 	notify = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf, vout);
 	spin_unlock(&vgdev->ctrlq.qlock);
-	if (notify)
-		virtqueue_notify(vgdev->ctrlq.vq);
+	if (notify) {
+		if (vgdev->disable_notify)
+			vgdev->pending_notify = true;
+		else
+			virtqueue_notify(vgdev->ctrlq.vq);
+	}
 
 	if (sgt) {
 		sg_free_table(sgt);
@@ -413,6 +417,21 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 	}
 }
 
+void virtio_gpu_disable_notify(struct virtio_gpu_device *vgdev)
+{
+	vgdev->disable_notify = true;
+}
+
+void virtio_gpu_enable_notify(struct virtio_gpu_device *vgdev)
+{
+	vgdev->disable_notify = false;
+
+	if (!vgdev->pending_notify)
+		return;
+	vgdev->pending_notify = false;
+	virtqueue_notify(vgdev->ctrlq.vq);
+}
+
 static void virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
 					 struct virtio_gpu_vbuffer *vbuf)
 {
-- 
2.18.1
