From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v8 05/18] drm/virtio: drop no_wait argument from
	virtio_gpu_object_reserve
Date: Fri, 23 Aug 2019 11:54:50 +0200
Message-ID: <20190823095503.2261-6-kraxel__16506.1038498365$1566554134$gmane$org@redhat.com>
References: <20190823095503.2261-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190823095503.2261-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, gurchetansingh@chromium.org, olvaffe@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

All callers pass no_wait = false.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 5 ++---
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 4 ++--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 3e0a53309c5b..d886c0e3502a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -398,12 +398,11 @@ static inline u64 virtio_gpu_object_mmap_offset(struct virtio_gpu_object *bo)
 	return drm_vma_node_offset_addr(&bo->tbo.base.vma_node);
 }
 
-static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo,
-					 bool no_wait)
+static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
 {
 	int r;
 
-	r = ttm_bo_reserve(&bo->tbo, true, no_wait, NULL);
+	r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS) {
 			struct virtio_gpu_device *qdev =
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 292566146814..6fe6f72f64d1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -142,7 +142,7 @@ int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
 	if (!vgdev->has_virgl_3d)
 		return 0;
 
-	r = virtio_gpu_object_reserve(qobj, false);
+	r = virtio_gpu_object_reserve(qobj);
 	if (r)
 		return r;
 
@@ -163,7 +163,7 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
 	if (!vgdev->has_virgl_3d)
 		return;
 
-	r = virtio_gpu_object_reserve(qobj, false);
+	r = virtio_gpu_object_reserve(qobj);
 	if (r)
 		return;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 74b6bad01d7f..285824c42e19 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -377,7 +377,7 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
 
 	qobj = gem_to_virtio_gpu_obj(gobj);
 
-	ret = virtio_gpu_object_reserve(qobj, false);
+	ret = virtio_gpu_object_reserve(qobj);
 	if (ret)
 		goto out;
 
@@ -427,7 +427,7 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
 
 	qobj = gem_to_virtio_gpu_obj(gobj);
 
-	ret = virtio_gpu_object_reserve(qobj, false);
+	ret = virtio_gpu_object_reserve(qobj);
 	if (ret)
 		goto out;
 
-- 
2.18.1
