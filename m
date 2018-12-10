From: Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH v2 1/1] virtio: remove deprecated VIRTIO_PCI_CONFIG()
Date: Mon, 10 Dec 2018 08:54:34 +0800
Message-ID: <1544403274-9238-1-git-send-email-dongli.zhang@oracle.com>
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
Cc: mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

VIRTIO_PCI_CONFIG() is deprecated. Use VIRTIO_PCI_CONFIG_OFF() instead.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Changed since v1:
  * leave the definition of VIRTIO_PCI_CONFIG() in header file to make userspace build happy

 drivers/virtio/virtio_pci_legacy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index de062fb..eff9ddc 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -52,7 +52,8 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	void __iomem *ioaddr = vp_dev->ioaddr +
-				VIRTIO_PCI_CONFIG(vp_dev) + offset;
+			VIRTIO_PCI_CONFIG_OFF(vp_dev->msix_enabled) +
+			offset;
 	u8 *ptr = buf;
 	int i;
 
@@ -67,7 +68,8 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	void __iomem *ioaddr = vp_dev->ioaddr +
-				VIRTIO_PCI_CONFIG(vp_dev) + offset;
+			VIRTIO_PCI_CONFIG_OFF(vp_dev->msix_enabled) +
+			offset;
 	const u8 *ptr = buf;
 	int i;
 
-- 
2.7.4
