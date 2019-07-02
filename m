From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v6 13/18] drm/virtio: drop virtio_gpu_object_{ref,unref}
Date: Tue,  2 Jul 2019 16:18:58 +0200
Message-ID: <20190702141903.1131-14-kraxel__10427.4177736201$1562077386$gmane$org@redhat.com>
References: <20190702141903.1131-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190702141903.1131-1-kraxel@redhat.com>
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

No users left.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 577a8103670e..78dc5a19a358 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -362,21 +362,6 @@ struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
 	struct drm_device *dev, struct dma_buf_attachment *attach,
 	struct sg_table *sgt);
 
-static inline struct virtio_gpu_object*
-virtio_gpu_object_ref(struct virtio_gpu_object *bo)
-{
-	drm_gem_object_get(&bo->base.base);
-	return bo;
-}
-
-static inline void virtio_gpu_object_unref(struct virtio_gpu_object **bo)
-{
-	if ((*bo) == NULL)
-		return;
-	drm_gem_object_put(&(*bo)->base.base);
-	*bo = NULL;
-}
-
 static inline u64 virtio_gpu_object_mmap_offset(struct virtio_gpu_object *bo)
 {
 	return drm_vma_node_offset_addr(&bo->base.base.vma_node);
-- 
2.18.1
