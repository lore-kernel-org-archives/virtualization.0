From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/2] drm/virtio: virtio_gpu_cmd_resource_create_3d: drop
	unused fence arg
Date: Wed, 28 Nov 2018 16:10:21 +0100
Message-ID: <20181128151021.29565-3-kraxel__24230.2765058868$1543417706$gmane$org@redhat.com>
References: <20181128151021.29565-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181128151021.29565-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org
Cc: robert.foss@collabora.com, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 3 +--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 5 ++---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index d6cc1a92ca..4e522e0b59 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -324,8 +324,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
-				  struct virtio_gpu_resource_create_3d *rc_3d,
-				  struct virtio_gpu_fence *fence);
+				  struct virtio_gpu_resource_create_3d *rc_3d);
 void virtio_gpu_ctrl_ack(struct virtqueue *vq);
 void virtio_gpu_cursor_ack(struct virtqueue *vq);
 void virtio_gpu_fence_ack(struct virtqueue *vq);
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index e9cdb4c7f6..161b80fee4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -348,7 +348,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 			goto fail_backoff;
 		}
 
-		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &rc_3d, NULL);
+		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &rc_3d);
 		ret = virtio_gpu_object_attach(vgdev, qobj, fence);
 		if (ret) {
 			virtio_gpu_fence_cleanup(fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 97038662b9..e27c4aedb8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -820,8 +820,7 @@ void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
 void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
-				  struct virtio_gpu_resource_create_3d *rc_3d,
-				  struct virtio_gpu_fence *fence)
+				  struct virtio_gpu_resource_create_3d *rc_3d)
 {
 	struct virtio_gpu_resource_create_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -833,7 +832,7 @@ virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_3D);
 	cmd_p->hdr.flags = 0;
 
-	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, &cmd_p->hdr, fence);
+	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 	bo->created = true;
 }
 
-- 
2.9.3
