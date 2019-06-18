From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 11/12] drm/virtio: rework virtio_gpu_object_create fencing
	even more.
Date: Tue, 18 Jun 2019 15:58:19 +0200
Message-ID: <20190618135821.8644-12-kraxel__35504.1466931411$1560866396$gmane$org@redhat.com>
References: <20190618135821.8644-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190618135821.8644-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Now with ttm initialization being out of the way we can simplify
virtio_gpu_object_create fencing even more.  No need to check whenever
the command is still running after ttm_bo_init() returned.  We have a
fully initialized gem bo before we kick off the resource creation
command, so we can simply add the fence to the bo's reservation object
beforehand.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 27 +++++++++----------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index d0e328db0a55..4301456f087f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -120,30 +120,21 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 	}
 	bo->dumb = params->dumb;
 
-	if (params->virgl) {
-		virtio_gpu_cmd_resource_create_3d(vgdev, bo, params, fence);
-	} else {
-		virtio_gpu_cmd_create_resource(vgdev, bo, params, fence);
-	}
-
 	if (fence) {
-		struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
 		struct drm_gem_object *obj = &bo->base.base;
 		struct ww_acquire_ctx ticket;
-		unsigned long irq_flags;
 
-		drm_gem_object_get(obj);
 		ret = drm_gem_lock_reservations(&obj, 1, &ticket);
-		if (ret == 0) {
-			spin_lock_irqsave(&drv->lock, irq_flags);
-			if (!virtio_fence_signaled(&fence->f))
-				/* virtio create command still in flight */
-				reservation_object_add_excl_fence(obj->resv,
-								  &fence->f);
-			spin_unlock_irqrestore(&drv->lock, irq_flags);
-		}
+		if (ret == 0)
+			reservation_object_add_excl_fence(obj->resv,
+							  &fence->f);
 		drm_gem_unlock_reservations(&obj, 1, &ticket);
-		drm_gem_object_put_unlocked(obj);
+	}
+
+	if (params->virgl) {
+		virtio_gpu_cmd_resource_create_3d(vgdev, bo, params, fence);
+	} else {
+		virtio_gpu_cmd_create_resource(vgdev, bo, params, fence);
 	}
 
 	ret = virtio_gpu_object_attach(vgdev, bo, NULL);
-- 
2.18.1
