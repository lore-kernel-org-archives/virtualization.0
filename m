From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] virtio_pci: fix cpu affinity support
Date: Thu, 24 Aug 2017 18:07:02 +0200
Message-ID: <20170824160702.31615-1-hch__21109.5541053966$1503590835$gmane$org@lst.de>
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
To: mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org, stable@vger.kernel.org, yasu.isimatu@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Commit 0b0f9dc5 ("Revert "virtio_pci: use shared interrupts for
virtqueues"") removed the adjustment of the pre_vectors for the virtio
MSI-X vector allocation which was added in commit fb5e31d9 ("virtio:
allow drivers to request IRQ affinity when creating VQs"). This will
lead to an incorrect assignment of MSI-X vectors, and potential
deadlocks when offlining cpus.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Fixes: 0b0f9dc5 ("Revert "virtio_pci: use shared interrupts for virtqueues")
Reported-by: YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/virtio/virtio_pci_common.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 007a4f366086..1c4797e53f68 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -107,6 +107,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	const char *name = dev_name(&vp_dev->vdev.dev);
+	unsigned flags = PCI_IRQ_MSIX;
 	unsigned i, v;
 	int err = -ENOMEM;
 
@@ -126,10 +127,13 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 					GFP_KERNEL))
 			goto error;
 
+	if (desc) {
+		flags |= PCI_IRQ_AFFINITY;
+		desc->pre_vectors++; /* virtio config vector */
+	}
+
 	err = pci_alloc_irq_vectors_affinity(vp_dev->pci_dev, nvectors,
-					     nvectors, PCI_IRQ_MSIX |
-					     (desc ? PCI_IRQ_AFFINITY : 0),
-					     desc);
+					     nvectors, flags, desc);
 	if (err < 0)
 		goto error;
 	vp_dev->msix_enabled = 1;
-- 
2.11.0
