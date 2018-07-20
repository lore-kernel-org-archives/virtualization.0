From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [RFC 3/4] virtio: Force virtio core to use DMA API callbacks for all
	virtio devices
Date: Fri, 20 Jul 2018 09:29:40 +0530
Message-ID: <20180720035941.6844-4-khandual__43737.3459725224$1532059262$gmane$org@linux.vnet.ibm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, mst@redhat.com, benh@kernel.crashing.org, linuxram@us.ibm.com, hch@infradead.org, paulus@samba.org, mpe@ellerman.id.au, joe@perches.com, khandual@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

Virtio core should use DMA API callbacks for all virtio devices which may
generate either GAP or IOVA depending on VIRTIO_F_IOMMU_PLATFORM flag and
resulting QEMU expectations. This implies that every virtio device needs
to have a DMA OPS structure. This removes previous GPA fallback code paths.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 drivers/virtio/virtio_ring.c | 65 ++------------------------------------------
 1 file changed, 2 insertions(+), 63 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 814b395..c265964 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -141,26 +141,6 @@ struct vring_virtqueue {
  * unconditionally on data path.
  */
 
-static bool vring_use_dma_api(struct virtio_device *vdev)
-{
-	if (!virtio_has_iommu_quirk(vdev))
-		return true;
-
-	/* Otherwise, we are left to guess. */
-	/*
-	 * In theory, it's possible to have a buggy QEMU-supposed
-	 * emulated Q35 IOMMU and Xen enabled at the same time.  On
-	 * such a configuration, virtio has never worked and will
-	 * not work without an even larger kludge.  Instead, enable
-	 * the DMA API if we're a Xen guest, which at least allows
-	 * all of the sensible Xen configurations to work correctly.
-	 */
-	if (xen_domain())
-		return true;
-
-	return false;
-}
-
 /*
  * The DMA ops on various arches are rather gnarly right now, and
  * making all of the arch DMA ops work on the vring device itself
@@ -176,9 +156,6 @@ static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
 				   struct scatterlist *sg,
 				   enum dma_data_direction direction)
 {
-	if (!vring_use_dma_api(vq->vq.vdev))
-		return (dma_addr_t)sg_phys(sg);
-
 	/*
 	 * We can't use dma_map_sg, because we don't use scatterlists in
 	 * the way it expects (we don't guarantee that the scatterlist
@@ -193,9 +170,6 @@ static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
 				   void *cpu_addr, size_t size,
 				   enum dma_data_direction direction)
 {
-	if (!vring_use_dma_api(vq->vq.vdev))
-		return (dma_addr_t)virt_to_phys(cpu_addr);
-
 	return dma_map_single(vring_dma_dev(vq),
 			      cpu_addr, size, direction);
 }
@@ -205,9 +179,6 @@ static void vring_unmap_one(const struct vring_virtqueue *vq,
 {
 	u16 flags;
 
-	if (!vring_use_dma_api(vq->vq.vdev))
-		return;
-
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
 
 	if (flags & VRING_DESC_F_INDIRECT) {
@@ -228,9 +199,6 @@ static void vring_unmap_one(const struct vring_virtqueue *vq,
 static int vring_mapping_error(const struct vring_virtqueue *vq,
 			       dma_addr_t addr)
 {
-	if (!vring_use_dma_api(vq->vq.vdev))
-		return 0;
-
 	return dma_mapping_error(vring_dma_dev(vq), addr);
 }
 
@@ -1016,43 +984,14 @@ EXPORT_SYMBOL_GPL(__vring_new_virtqueue);
 static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 			      dma_addr_t *dma_handle, gfp_t flag)
 {
-	if (vring_use_dma_api(vdev)) {
-		return dma_alloc_coherent(vdev->dev.parent, size,
+	return dma_alloc_coherent(vdev->dev.parent, size,
 					  dma_handle, flag);
-	} else {
-		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
-		if (queue) {
-			phys_addr_t phys_addr = virt_to_phys(queue);
-			*dma_handle = (dma_addr_t)phys_addr;
-
-			/*
-			 * Sanity check: make sure we dind't truncate
-			 * the address.  The only arches I can find that
-			 * have 64-bit phys_addr_t but 32-bit dma_addr_t
-			 * are certain non-highmem MIPS and x86
-			 * configurations, but these configurations
-			 * should never allocate physical pages above 32
-			 * bits, so this is fine.  Just in case, throw a
-			 * warning and abort if we end up with an
-			 * unrepresentable address.
-			 */
-			if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
-				free_pages_exact(queue, PAGE_ALIGN(size));
-				return NULL;
-			}
-		}
-		return queue;
-	}
 }
 
 static void vring_free_queue(struct virtio_device *vdev, size_t size,
 			     void *queue, dma_addr_t dma_handle)
 {
-	if (vring_use_dma_api(vdev)) {
-		dma_free_coherent(vdev->dev.parent, size, queue, dma_handle);
-	} else {
-		free_pages_exact(queue, PAGE_ALIGN(size));
-	}
+	dma_free_coherent(vdev->dev.parent, size, queue, dma_handle);
 }
 
 struct virtqueue *vring_create_virtqueue(
-- 
2.9.3
