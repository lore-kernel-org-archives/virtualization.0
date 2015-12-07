From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: [PATCH RFC 2/3] xen/virtio: allocate a contiguous region to be use as
	virtio queue
Date: Mon, 7 Dec 2015 16:19:42 +0000
Message-ID: <1449505183-29740-2-git-send-email-stefano.stabellini__37341.3873407573$1449505821$gmane$org@eu.citrix.com>
References: <alpine.DEB.2.02.1512071555590.24652@kaball.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.02.1512071555590.24652@kaball.uk.xensource.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

When running on Xen inside as virtual machine (nested virt scenario),
memory allocated by alloc_pages_exact might not actually be contiguous.
Call xen_swiotlb_alloc_coherent instead, which is going to take care of
making the buffer contiguous in machine memory.

No changes in behavior for the non-Xen case.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---

Alternatively we could call dma_alloc_coherent in all cases, but that
would make the non-Xen code path more complex.
---
 drivers/virtio/virtio_pci_legacy.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 48bc979..27359ac 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -18,6 +18,8 @@
  */
 
 #include "virtio_pci_common.h"
+#include <xen/xen.h>
+#include <xen/swiotlb-xen.h>
 
 /* virtio config->get_features() implementation */
 static u64 vp_get_features(struct virtio_device *vdev)
@@ -122,6 +124,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	unsigned long size;
 	u16 num;
 	int err;
+	dma_addr_t dma_addr;
 
 	/* Select the queue we're interested in */
 	iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
@@ -135,12 +138,20 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	info->msix_vector = msix_vec;
 
 	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_VRING_ALIGN));
-	info->queue = alloc_pages_exact(size, GFP_KERNEL|__GFP_ZERO);
+	/* activate the queue */
+	if (xen_domain()) {
+		info->queue = xen_swiotlb_alloc_coherent(NULL,
+				size,
+				&dma_addr,
+				GFP_KERNEL|__GFP_ZERO,
+				NULL);
+	} else {
+		info->queue = alloc_pages_exact(size, GFP_KERNEL|__GFP_ZERO);
+		dma_addr = virt_to_phys(info->queue);
+	}
 	if (info->queue == NULL)
 		return ERR_PTR(-ENOMEM);
-
-	/* activate the queue */
-	iowrite32(virt_to_phys(info->queue) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
+	iowrite32(dma_addr >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
 		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
 
 	/* create the vring */
-- 
1.7.10.4
