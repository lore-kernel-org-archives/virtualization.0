From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5/6] virtio_pci: support non-legacy balloon devices
Date: Mon, 30 Mar 2015 19:37:27 +0200
Message-ID: <1427737006-23191-6-git-send-email-mst@redhat.com>
References: <1427737006-23191-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1427737006-23191-1-git-send-email-mst@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio_device_is_legacy_only is always false now,
drop the test from virtio pci.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 2aa38e5..dfea17a 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -577,9 +577,6 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	}
 	vp_dev->vdev.id.vendor = pci_dev->subsystem_vendor;
 
-	if (virtio_device_is_legacy_only(vp_dev->vdev.id))
-		return -ENODEV;
-
 	/* check for a common config: if not, use legacy mode (bar 0). */
 	common = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_COMMON_CFG,
 					    IORESOURCE_IO | IORESOURCE_MEM);
-- 
MST
