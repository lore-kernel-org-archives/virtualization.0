From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4/4] drm/virtio: move virtio_gpu_mem_entry initialization to new function
Date: Wed,  5 Feb 2020 11:59:55 +0100
Message-ID: <20200205105955.28143-5-kraxel@redhat.com>
References: <20200205105955.28143-1-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200205105955.28143-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Introduce new virtio_gpu_object_shmem_init() helper function which will
create the virtio_gpu_mem_entry array, containing the backing storage
information for the host.  For the most path this just moves code from
virtio_gpu_object_attach().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  4 ++
 drivers/gpu/drm/virtio/virtgpu_object.c | 49 +++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 49 ++-----------------------
 3 files changed, 56 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 15fb3c12f22f..be62a7469b04 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -71,6 +71,10 @@ struct virtio_gpu_object {
 
 	struct sg_table *pages;
 	uint32_t mapped;
+
+	struct virtio_gpu_mem_entry *ents;
+	unsigned int nents;
+
 	bool dumb;
 	bool created;
 };
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index bce2b3d843fe..4e82e269a1f4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -121,6 +121,49 @@ struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
 	return &bo->base.base;
 }
 
+static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
+					struct virtio_gpu_object *bo)
+{
+	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
+	struct scatterlist *sg;
+	int si, ret;
+
+	ret = drm_gem_shmem_pin(&bo->base.base);
+	if (ret < 0)
+		return -EINVAL;
+
+	bo->pages = drm_gem_shmem_get_sg_table(&bo->base.base);
+	if (bo->pages == NULL) {
+		drm_gem_shmem_unpin(&bo->base.base);
+		return -EINVAL;
+	}
+
+	if (use_dma_api) {
+		bo->mapped = dma_map_sg(vgdev->vdev->dev.parent,
+					 bo->pages->sgl, bo->pages->nents,
+					 DMA_TO_DEVICE);
+		bo->nents = bo->mapped;
+	} else {
+		bo->nents = bo->pages->nents;
+	}
+
+	bo->ents = kmalloc_array(bo->nents, sizeof(struct virtio_gpu_mem_entry),
+				 GFP_KERNEL);
+	if (!bo->ents) {
+		DRM_ERROR("failed to allocate ent list\n");
+		return -ENOMEM;
+	}
+
+	for_each_sg(bo->pages->sgl, sg, bo->nents, si) {
+		bo->ents[si].addr = cpu_to_le64(use_dma_api
+						? sg_dma_address(sg)
+						: sg_phys(sg));
+		bo->ents[si].length = cpu_to_le32(sg->length);
+		bo->ents[si].padding = 0;
+	}
+	return 0;
+}
+
 int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object_params *params,
 			     struct virtio_gpu_object **bo_ptr,
@@ -165,6 +208,12 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 					       objs, fence);
 	}
 
+	ret = virtio_gpu_object_shmem_init(vgdev, bo);
+	if (ret != 0) {
+		virtio_gpu_free_object(&shmem_obj->base);
+		return ret;
+	}
+
 	ret = virtio_gpu_object_attach(vgdev, bo, NULL);
 	if (ret != 0) {
 		virtio_gpu_free_object(&shmem_obj->base);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index e258186bedb2..7db91376f2f2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -1081,54 +1081,11 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
 			     struct virtio_gpu_fence *fence)
 {
-	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
-	struct virtio_gpu_mem_entry *ents;
-	struct scatterlist *sg;
-	int si, nents, ret;
-
-	if (WARN_ON_ONCE(!obj->created))
-		return -EINVAL;
-	if (WARN_ON_ONCE(obj->pages))
-		return -EINVAL;
-
-	ret = drm_gem_shmem_pin(&obj->base.base);
-	if (ret < 0)
-		return -EINVAL;
-
-	obj->pages = drm_gem_shmem_get_sg_table(&obj->base.base);
-	if (obj->pages == NULL) {
-		drm_gem_shmem_unpin(&obj->base.base);
-		return -EINVAL;
-	}
-
-	if (use_dma_api) {
-		obj->mapped = dma_map_sg(vgdev->vdev->dev.parent,
-					 obj->pages->sgl, obj->pages->nents,
-					 DMA_TO_DEVICE);
-		nents = obj->mapped;
-	} else {
-		nents = obj->pages->nents;
-	}
-
-	/* gets freed when the ring has consumed it */
-	ents = kmalloc_array(nents, sizeof(struct virtio_gpu_mem_entry),
-			     GFP_KERNEL);
-	if (!ents) {
-		DRM_ERROR("failed to allocate ent list\n");
-		return -ENOMEM;
-	}
-
-	for_each_sg(obj->pages->sgl, sg, nents, si) {
-		ents[si].addr = cpu_to_le64(use_dma_api
-					    ? sg_dma_address(sg)
-					    : sg_phys(sg));
-		ents[si].length = cpu_to_le32(sg->length);
-		ents[si].padding = 0;
-	}
-
 	virtio_gpu_cmd_resource_attach_backing(vgdev, obj->hw_res_handle,
-					       ents, nents,
+					       obj->ents, obj->nents,
 					       fence);
+	obj->ents = NULL;
+	obj->nents = 0;
 	return 0;
 }
 
-- 
2.18.1
