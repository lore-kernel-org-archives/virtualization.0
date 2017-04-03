From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_pci: request irq error handling
Date: Mon, 3 Apr 2017 21:09:23 +0300
Message-ID: <1491242932-29700-1-git-send-email-mst__15168.7756566846$1491242973$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, Mike Galbraith <efault@gmx.de>, Thorsten Leemhuis <linux@leemhuis.info>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On failure to request msix vectors virtio frees the vector map but fails
to reset it.  It will then attempt to use that map in vp_remove_vqs on
device removal and hybernation, resulting in memory corruption
manifesting as warnings in PCI core, hangs etc.

Reported-by: Mike Galbraith <efault@gmx.de>
Fixes: 07ec51480b5e ("virtio_pci: use shared interrupts for virtqueues")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 2a353ab..2b1ea9b 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -266,6 +266,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 out_remove_vqs:
 	vp_remove_vqs(vdev);
 	kfree(vp_dev->msix_vector_map);
+	vp_dev->msix_vector_map = NULL;
 out_disable_config_irq:
 	vp_dev->config_vector(vp_dev, VIRTIO_MSI_NO_VECTOR);
 out_free_config_irq:
-- 
MST
