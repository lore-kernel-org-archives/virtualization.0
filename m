From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
Date: Thu,  5 Apr 2018 16:26:31 +0530
Message-ID: <20180405105631.9514-1-khandual__15978.8388679319$1522925707$gmane$org@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: robh@kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au, joe@perches.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

There are certian platforms which would like to use SWIOTLB based DMA API
for bouncing purpose without actually requiring an IOMMU back end. But the
virtio core does not allow such mechanism. Right now DMA MAP API is only
selected for devices which have an IOMMU and then the QEMU/host back end
will process all incoming SG buffer addresses as IOVA instead of simple
GPA which is the case for simple bounce buffers after being processed with
SWIOTLB API. To enable this usage, it introduces an architecture specific
function which will just make virtio core front end select DMA operations
structure.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
This RFC is just to get some feedback. Please ignore the function call
back into the architecture. It can be worked out properly later on. But
the question is can we have virtio devices in the guest which would like
to use SWIOTLB based (or any custom DMA API based) bounce buffering with
out actually being an IOMMU devices emulated by QEMU/host as been with
the current VIRTIO_F_IOMMU_PLATFORM virtio flag ?

 arch/powerpc/platforms/pseries/iommu.c | 6 ++++++
 drivers/virtio/virtio_ring.c           | 4 ++++
 include/linux/virtio.h                 | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 06f02960b439..dd15fbddbe89 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1396,3 +1396,9 @@ static int __init disable_multitce(char *str)
 __setup("multitce=", disable_multitce);
 
 machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
+
+bool is_virtio_dma_platform(void)
+{
+	return true;
+}
+EXPORT_SYMBOL(is_virtio_dma_platform);
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 71458f493cf8..9f205a79d378 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -144,6 +144,10 @@ struct vring_virtqueue {
 
 static bool vring_use_dma_api(struct virtio_device *vdev)
 {
+	/* Use DMA API even for virtio devices without an IOMMU */
+	if (is_virtio_dma_platform())
+		return true;
+
 	if (!virtio_has_iommu_quirk(vdev))
 		return true;
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 988c7355bc22..d8bb83d753ea 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -200,6 +200,8 @@ static inline struct virtio_driver *drv_to_virtio(struct device_driver *drv)
 int register_virtio_driver(struct virtio_driver *drv);
 void unregister_virtio_driver(struct virtio_driver *drv);
 
+extern bool is_virtio_dma_platform(void);
+
 /* module_virtio_driver() - Helper macro for drivers that don't do
  * anything special in module init/exit.  This eliminates a lot of
  * boilerplate.  Each module may only use this macro once, and
-- 
2.14.1
