From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH] virtio_pci: Limit DMA mask to 44 bits for legacy virtio
	devices
Date: Mon, 12 Sep 2016 13:10:41 +0100
Message-ID: <1473682241-21984-1-git-send-email-will.deacon@arm.com>
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
To: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Legacy virtio defines the virtqueue base using a 32-bit PFN field, with
a read-only register indicating a fixed page size of 4k.

This can cause problems for DMA allocators that allocate top down from
the DMA mask, which is set to 64 bits. In this case, the addresses are
silently truncated to 44-bit, leading to IOMMU faults, failure to read
from the queue or data corruption.

This patch restricts the DMA mask for legacy PCI virtio devices to
44 bits, which matches the specification.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/virtio/virtio_pci_legacy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 8c4e61783441..f4852febd40c 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -212,12 +212,12 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
 		return -ENODEV;
 	}
 
-	rc = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
+	rc = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(44));
 	if (rc)
 		rc = dma_set_mask_and_coherent(&pci_dev->dev,
 						DMA_BIT_MASK(32));
 	if (rc)
-		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
+		dev_warn(&pci_dev->dev, "Failed to enable 44-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
 
 	rc = pci_request_region(pci_dev, 0, "virtio-pci-legacy");
 	if (rc)
-- 
2.1.4
