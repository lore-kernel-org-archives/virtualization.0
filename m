From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v5 06/12] drm/virtio: remove ttm calls from in
	virtio_gpu_object_{reserve, unreserve}
Date: Fri, 28 Jun 2019 14:13:32 +0200
Message-ID: <20190628121338.24398-7-kraxel__31809.6185730369$1561724601$gmane$org@redhat.com>
References: <20190628121338.24398-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190628121338.24398-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Call reservation_object_* directly instead
of using ttm_bo_{reserve,unreserve}.

v4: check for EINTR only.
v3: check for EINTR too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 06cc0e961df6..07f6001ea91e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -402,9 +402,9 @@ static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
 {
 	int r;
 
-	r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
+	r = reservation_object_lock_interruptible(bo->gem_base.resv, NULL);
 	if (unlikely(r != 0)) {
-		if (r != -ERESTARTSYS) {
+		if (r != -EINTR) {
 			struct virtio_gpu_device *qdev =
 				bo->gem_base.dev->dev_private;
 			dev_err(qdev->dev, "%p reserve failed\n", bo);
@@ -416,7 +416,7 @@ static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
 
 static inline void virtio_gpu_object_unreserve(struct virtio_gpu_object *bo)
 {
-	ttm_bo_unreserve(&bo->tbo);
+	reservation_object_unlock(bo->gem_base.resv);
 }
 
 /* virgl debufs */
-- 
2.18.1
