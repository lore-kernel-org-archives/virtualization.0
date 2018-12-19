From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 07/10] drm/virtio: params struct for
	virtio_gpu_cmd_create_resource_3d()
Date: Wed, 19 Dec 2018 13:27:05 +0100
Message-ID: <20181219122708.4586-8-kraxel__41966.0137886696$1545222341$gmane$org@redhat.com>
References: <20181219122708.4586-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181219122708.4586-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Add 3d resource parameters to virtio_gpu_object_params struct
and use it for virtio_gpu_cmd_resource_create_3d() calls.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 10 +++++++++-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 25 ++++++++++---------------
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 16 +++++++++++++---
 3 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 8c65deadd0..f9959306ae 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -59,6 +59,14 @@ struct virtio_gpu_object_params {
 	uint32_t height;
 	unsigned long size;
 	bool pinned;
+	/* 3d */
+	uint32_t target;
+	uint32_t bind;
+	uint32_t depth;
+	uint32_t array_size;
+	uint32_t last_level;
+	uint32_t nr_samples;
+	uint32_t flags;
 };
 
 struct virtio_gpu_object {
@@ -313,7 +321,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
-				  struct virtio_gpu_resource_create_3d *rc_3d);
+				  struct virtio_gpu_object_params *params);
 void virtio_gpu_ctrl_ack(struct virtqueue *vq);
 void virtio_gpu_cursor_ack(struct virtqueue *vq);
 void virtio_gpu_fence_ack(struct virtqueue *vq);
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 33112c8495..52d6ec2dde 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -283,7 +283,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	struct ttm_validate_buffer mainbuf;
 	struct virtio_gpu_fence *fence = NULL;
 	struct ww_acquire_ctx ticket;
-	struct virtio_gpu_resource_create_3d rc_3d;
 	struct virtio_gpu_object_params params = {
 		.pinned = false,
 	};
@@ -308,7 +307,15 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	params.width = rc->width;
 	params.height = rc->height;
 	params.size = rc->size;
-
+	if (vgdev->has_virgl_3d) {
+		params.target = rc->target;
+		params.bind = rc->bind;
+		params.depth = rc->depth;
+		params.array_size = rc->array_size;
+		params.last_level = rc->last_level;
+		params.nr_samples = rc->nr_samples;
+		params.flags = rc->flags;
+	}
 	/* allocate a single page size object */
 	if (params.size == 0)
 		params.size = PAGE_SIZE;
@@ -334,25 +341,13 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 			goto fail_unref;
 		}
 
-		rc_3d.resource_id = cpu_to_le32(qobj->hw_res_handle);
-		rc_3d.target = cpu_to_le32(rc->target);
-		rc_3d.format = cpu_to_le32(rc->format);
-		rc_3d.bind = cpu_to_le32(rc->bind);
-		rc_3d.width = cpu_to_le32(rc->width);
-		rc_3d.height = cpu_to_le32(rc->height);
-		rc_3d.depth = cpu_to_le32(rc->depth);
-		rc_3d.array_size = cpu_to_le32(rc->array_size);
-		rc_3d.last_level = cpu_to_le32(rc->last_level);
-		rc_3d.nr_samples = cpu_to_le32(rc->nr_samples);
-		rc_3d.flags = cpu_to_le32(rc->flags);
-
 		fence = virtio_gpu_fence_alloc(vgdev);
 		if (!fence) {
 			ret = -ENOMEM;
 			goto fail_backoff;
 		}
 
-		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &rc_3d);
+		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &params);
 		ret = virtio_gpu_object_attach(vgdev, qobj, fence);
 		if (ret) {
 			dma_fence_put(&fence->f);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 363b8b8577..ca93ec6ca3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -826,7 +826,7 @@ void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
 void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
-				  struct virtio_gpu_resource_create_3d *rc_3d)
+				  struct virtio_gpu_object_params *params)
 {
 	struct virtio_gpu_resource_create_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -834,9 +834,19 @@ virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
 
-	*cmd_p = *rc_3d;
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_3D);
-	cmd_p->hdr.flags = 0;
+	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
+	cmd_p->format = cpu_to_le32(params->format);
+	cmd_p->width = cpu_to_le32(params->width);
+	cmd_p->height = cpu_to_le32(params->height);
+
+	cmd_p->target = cpu_to_le32(params->target);
+	cmd_p->bind = cpu_to_le32(params->bind);
+	cmd_p->depth = cpu_to_le32(params->depth);
+	cmd_p->array_size = cpu_to_le32(params->array_size);
+	cmd_p->last_level = cpu_to_le32(params->last_level);
+	cmd_p->nr_samples = cpu_to_le32(params->nr_samples);
+	cmd_p->flags = cpu_to_le32(params->flags);
 
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 	bo->created = true;
-- 
2.9.3
