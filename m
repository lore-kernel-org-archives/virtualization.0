From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 25/38] drm: virtio: fix common struct sg_table related
 issues
Date: Wed, 13 May 2020 15:32:32 +0200
Message-ID: <20200513133245.6408-25-m.szyprowski@samsung.com>
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
        <20200513133245.6408-1-m.szyprowski@samsung.com>
        <CGME20200513133314eucas1p2f04e32d65e71c613a2a9aacb29064a7d@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
returns the number of the created entries in the DMA address space.
However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
dma_unmap_sg must be called with the original number of the entries
passed to the dma_map_sg().

struct sg_table is a common structure used for describing a non-contiguous
memory buffer, used commonly in the DRM and graphics subsystems. It
consists of a scatterlist with memory pages and DMA addresses (sgl entry),
as well as the number of scatterlist entries: CPU pages (orig_nents entry)
and DMA mapped pages (nents entry).

It turned out that it was a common mistake to misuse nents and orig_nents
entries, calling DMA-mapping functions with a wrong number of entries or
ignoring the number of mapped entries returned by the dma_map_sg()
function.

To avoid such issues, lets use a common dma-mapping wrappers operating
directly on the struct sg_table objects and use scatterlist page
iterators where possible. This, almost always, hides references to the
nents and orig_nents entries, making the code robust, easier to follow
and copy/paste safe.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 36 +++++++++++++++++++--------------
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 12 +++++------
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 6ccbd01..399556f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -72,9 +72,8 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
 
 		if (shmem->pages) {
 			if (shmem->mapped) {
-				dma_unmap_sg(vgdev->vdev->dev.parent,
-					     shmem->pages->sgl, shmem->mapped,
-					     DMA_TO_DEVICE);
+				dma_unmap_sgtable(vgdev->vdev->dev.parent,
+					     shmem->pages, DMA_TO_DEVICE, 0);
 				shmem->mapped = 0;
 			}
 
@@ -157,13 +156,13 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
 	}
 
 	if (use_dma_api) {
-		shmem->mapped = dma_map_sg(vgdev->vdev->dev.parent,
-					   shmem->pages->sgl,
-					   shmem->pages->nents,
-					   DMA_TO_DEVICE);
-		*nents = shmem->mapped;
+		ret = dma_map_sgtable(vgdev->vdev->dev.parent,
+				      shmem->pages, DMA_TO_DEVICE, 0);
+		if (ret)
+			return ret;
+		*nents = shmem->mapped = shmem->pages->nents;
 	} else {
-		*nents = shmem->pages->nents;
+		*nents = shmem->pages->orig_nents;
 	}
 
 	*ents = kmalloc_array(*nents, sizeof(struct virtio_gpu_mem_entry),
@@ -173,13 +172,20 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
 		return -ENOMEM;
 	}
 
-	for_each_sg(shmem->pages->sgl, sg, *nents, si) {
-		(*ents)[si].addr = cpu_to_le64(use_dma_api
-					       ? sg_dma_address(sg)
-					       : sg_phys(sg));
-		(*ents)[si].length = cpu_to_le32(sg->length);
-		(*ents)[si].padding = 0;
+	if (use_dma_api) {
+		for_each_sgtable_dma_sg(shmem->pages, sg, si) {
+			(*ents)[si].addr = cpu_to_le64(sg_dma_address(sg));
+			(*ents)[si].length = cpu_to_le32(sg_dma_len(sg));
+			(*ents)[si].padding = 0;
+		}
+	} else {
+		for_each_sgtable_sg(shmem->pages, sg, si) {
+			(*ents)[si].addr = cpu_to_le64(sg_phys(sg));
+			(*ents)[si].length = cpu_to_le32(sg->length);
+			(*ents)[si].padding = 0;
+		}
 	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 9e663a5..e5765db 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -302,7 +302,7 @@ static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size, int *sg_ents)
 		return NULL;
 	}
 
-	for_each_sg(sgt->sgl, sg, *sg_ents, i) {
+	for_each_sgtable_sg(sgt, sg, i) {
 		pg = vmalloc_to_page(data);
 		if (!pg) {
 			sg_free_table(sgt);
@@ -603,9 +603,8 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
 
 	if (use_dma_api)
-		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
-				       shmem->pages->sgl, shmem->pages->nents,
-				       DMA_TO_DEVICE);
+		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
+					    shmem->pages, DMA_TO_DEVICE);
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
@@ -1019,9 +1018,8 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
 
 	if (use_dma_api)
-		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
-				       shmem->pages->sgl, shmem->pages->nents,
-				       DMA_TO_DEVICE);
+		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
+					    shmem->pages, DMA_TO_DEVICE);
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
-- 
1.9.1
